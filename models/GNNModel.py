import argparse
import numpy as np
# import 
from tqdm import tqdm
import torch
import dgl
from dgl.nn.pytorch.conv import SAGEConv
from sklearn.metrics import r2_score

import time
import pickle
import os

device='cpu'

parser = argparse.ArgumentParser()
parser.add_argument("dataset", type=str)
parser.add_argument("--load-ckpt", action="store_true")
args = parser.parse_args()

class Node(object):
    def __init__(self, name, succ, feat):
        self.name = name
        self.succ = succ
        self.feat = feat

class FunctionGraph(object):
    def __init__(self):
        self.nodes = []
        self.node_names = []
        self.warnings = 0
        self.n_labels = 0

    def add_node(self, name, successor):
        node = Node(name, successor, None)
        self.node_names.append(node.name)
        self.nodes.append(node)
    
    def to_numpy(self):
        edge_list = []
        feats = []
        labeled_nodes = []
        for node in self.nodes:
            uid = self.node_names.index(node.name)
            for succ in node.succ:
                if not succ in self.node_names:
                    self.node_names.append(succ)
                vid = self.node_names.index(succ)
                edge_list.append([uid, vid])
            
            if node.feat is None:
                feat = np.zeros(24 + 1)
            elif node.feat.shape[0] < 24: 
                feat = np.concatenate([np.ones(1), node.feat, np.zeros(2)])
            else:
                feat = np.concatenate([np.ones(1), node.feat])
                labeled_nodes.append(uid)
            feats.append(feat)
        return np.array(edge_list), np.array(feats), np.array(labeled_nodes)
    
    def to_dgl(self):
        edge_list, node_feats, labeled_nodes = self.to_numpy()
        # print(node_feats.shape)
        g = dgl.graph((edge_list[:, 0], edge_list[:, 1]), num_nodes=node_feats.shape[0])
        g = dgl.to_bidirected(g)
        # print(g.num_nodes())
        g.ndata['feat'] = torch.tensor(node_feats[:, :23], dtype=torch.float32)
        g.ndata['label'] = torch.tensor(node_feats[:, 23], dtype=torch.float32)
        mask = torch.zeros(node_feats.shape[0], dtype=torch.int64)
        mask[labeled_nodes] = 1
        g.ndata['mask'] = mask
        return g
    
    def attach_feat(self, feat):
        if len(self.nodes) == 0:
            print("warning: cannot attach feature to an empty graph")
            self.warnings += 1
            return
        self.nodes[-1].feat = feat
        if feat.shape[0] == 24:
            self.n_labels += 1

    def has_labels(self):
        return self.n_labels > 0

class GraphDataset(object):
    def __init__(self, filename):
        print("Start loading data")
        t0 = time.time()
        if filename is None:
            with open('graphdata.tmp', 'rb') as f:
                self.graphs = pickle.load(f)
        else:
            self.graphs = []
            self._load_data(filename)
        print(f"Dataset Loaded, cost {time.time() - t0}s")
        print(f"Number of graphs: {len(self.graphs)}")
    

    def _load_data(self, filename):
        warnings = 0
        with open(filename) as file:
            cnt = 0
            func = FunctionGraph()
            for line in file:
                tokens = line.strip().split(',')
                if tokens[0] == 'f':
                    if cnt > 0 and func.has_labels():
                        self.graphs.append(func.to_dgl())
                    warnings += func.warnings
                    func = FunctionGraph()
                    cnt += 1
                elif tokens[0] == 'g':
                    name = tokens[1]
                    succ = tokens[2:]
                    func.add_node(name, succ)
                else:
                    if tokens[-1] == '':
                        tokens = tokens[:-1]
                    data = np.array(list(map(float, tokens)))
                    func.attach_feat(data)
            if func.has_labels():
                self.graphs.append(func.to_dgl())
        # with open('graphdata.tmp', 'wb') as f:
        #     pickle.dump(self.graphs, f)

class ProgGNN(torch.nn.modules.module.Module):
    def __init__(self, n_layer, in_dim, h_dim):
        super(ProgGNN, self).__init__()
        layers = []
        last = in_dim
        for _ in range(n_layer - 1):
            layers.append(SAGEConv(last, h_dim, 'lstm', activation=torch.nn.functional.relu))
            last = h_dim
        layers.append(SAGEConv(last, 1, 'lstm', activation=torch.sigmoid))
        self.layers = torch.nn.Sequential(*layers)
    
    def forward(self, g, x):
        for layer in self.layers:
            x = layer(g, x)
        return x

if os.path.isfile("gnnmodel.th") and args.load_ckpt:
    model = torch.load("gnnmodel.th")
    print('loaded checkpoint')
else:
    model = ProgGNN(3, 23, 128)
model.to(device)

dataset = GraphDataset(args.dataset)
n_train = int(len(dataset.graphs) * 0.8)
train_set, test_set = torch.utils.data.random_split(dataset.graphs, [n_train, len(dataset.graphs) - n_train])
# torch.save([train_set, test_set], "graphdata.th")

loss_fn = torch.nn.BCELoss()
optim = torch.optim.Adam(model.parameters(), lr=1e-4)

for epoch in range(100):
    err = 0
    tot_examples = 0
    y_true = []
    y_pred = []
    train_set = np.random.permutation(train_set)
    for g in tqdm(train_set):
        g = g.to(device)
        optim.zero_grad()
        out = model(g, g.ndata['feat'])[:, 0]
        mask = torch.nonzero(g.ndata['mask'])
        out = out[mask]
        y_pred.append(out)
        label = g.ndata['label'][mask]
        y_true.append(label)
        loss = loss_fn(out, label)
        loss.backward()
        err += torch.sum(torch.abs(label - out))
        tot_examples += sum(g.ndata['mask'])
        optim.step()
    y_true = torch.cat(y_true)
    y_pred = torch.cat(y_pred)
    r2 = r2_score(y_true.detach().numpy(), y_pred.detach().numpy())
    print(f"{epoch}: {err / tot_examples} {r2} | {y_true[0]} {y_pred[0]}")
    print(f"average y_true {torch.mean(y_true)}")
    print(f"average y_pred {torch.mean(y_pred)}")

    torch.save(model, "gnnmodel.th")
    loss_tot = 0
    tot_examples = 0
    y_true = []
    y_pred = []
    for g in tqdm(test_set):
        out = model(g, g.ndata['feat'])[:, 0]
        mask = torch.nonzero(g.ndata['mask'])
        out = out[mask]
        label = g.ndata['label'][mask]
        loss = torch.sum(torch.abs(label - out))
        loss_tot += loss.detach().numpy()
        tot_examples += sum(g.ndata['mask'])
        y_pred.append(out)
        label = g.ndata['label'][mask]
        y_true.append(label)
    y_true = torch.cat(y_true)
    y_pred = torch.cat(y_pred)
    r2 = r2_score(y_true.detach().numpy(), y_pred.detach().numpy())
    print(f"test: {loss_tot / tot_examples} {r2}")
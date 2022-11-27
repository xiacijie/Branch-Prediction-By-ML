import torch
import torch.nn as nn  
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
from LinearNNModel import LinearBranchPredictModel, NUM_FEATURES, DEVICE
import os 

df = pd.read_csv(os.getenv("DATASET_ROOT") + "/dataset.csv")
train_data, test_data = train_test_split(df, test_size=0.2, shuffle=True)

train_X = torch.tensor(train_data[df.columns[0:-2]].values, device=DEVICE).float()
train_Y = torch.tensor(train_data[df.columns[-2:]].values, device=DEVICE).float()

test_X = torch.tensor(train_data[df.columns[0:-2]].values, device=DEVICE).float()
test_Y = torch.tensor(train_data[df.columns[-2:]].values, device=DEVICE).float()

model = LinearBranchPredictModel(NUM_FEATURES, DEVICE)
criterion = nn.BCELoss()
learning_rate = 0.0005
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

print(train_X.shape, train_Y.shape)

iters = 30000
for i in range(iters):
    print(i)
    optimizer.zero_grad()
    pred = model(train_X)
    loss = criterion(pred, train_Y)
    loss.requires_grad_(True)
    loss.backward()
    optimizer.step()

predictions = model(test_X)
print("R2 SCORE: ", r2_score(test_Y.cpu().detach().numpy(), predictions.cpu().detach().numpy()))

model = model.to("cpu")
torch.save(model.state_dict(), os.getenv("MODEL_ROOT") + "/LinearNN.state_dict")
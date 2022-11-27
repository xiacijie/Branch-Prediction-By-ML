
# from LinearNNModel import LinearBranchPredictModel
# from LinearNNModel import NUM_FEATURES, DEVICE
# import sys
# import torch
# import os
# from torch.nn import Module

import sklearn
from sklearn.neural_network import MLPClassifier
import pandas


X = [[0., 0.], [1., 1.]]
y = [0, 1]
clf = MLPClassifier(solver='lbfgs', alpha=1e-5, hidden_layer_sizes=(5, 2), random_state=1)
clf.fit(X, y)
# print(clf.predict([[2., 2.], [-1., -2.]]))
def foo(s):
    clf.predict([[0., 0.]])

# model = LinearBranchPredictModel(NUM_FEATURES, DEVICE)
# model.load_state_dict(torch.load(os.getenv("MODEL_ROOT") + "/LinearNN.state_dict"))
# model.eval()

# feature_string = sys.argv[1]

# features = feature_string.split(",")

# if len(features) != NUM_FEATURES:
#     print("error")
# else:
#     features = torch.tensor(list(map(lambda x: float(x), features)), device=DEVICE)
#     prediction = model(features)
#     print(prediction[0].item())




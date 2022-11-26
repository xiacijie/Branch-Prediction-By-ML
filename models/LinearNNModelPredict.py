import torch
from LinearNNModel import LinearBranchPredictModel
from LinearNNModel import NUM_FEATURES, DEVICE
import sys
import os

model = LinearBranchPredictModel(NUM_FEATURES, DEVICE)
model.load_state_dict(torch.load(os.getenv("MODEL_ROOT") + "/LinearNN.state_dict"))
model.eval()

feature_string = sys.argv[1]

features = feature_string.split(",")

if len(features) != NUM_FEATURES:
    print("error")
else:
    features = torch.tensor(list(map(lambda x: float(x), features)), device=DEVICE)
    prediction = model(features)
    print(prediction[0].item())




import pickle 
import os
import numpy as np 

model = pickle.load(open(os.getenv("MODEL_ROOT") + "/AdaRegression.model", 'rb'))
scaler = pickle.load(open(os.getenv("MODEL_ROOT") + "/AdaRegression.scaler", 'rb'))

def predict(X):
    # X is a string here
    X = X.split(",")
    X = np.array([list(map(lambda x: int(x), X))])
    X = scaler.transform(X)
    y = model.predict(X)
    return str(y.item())
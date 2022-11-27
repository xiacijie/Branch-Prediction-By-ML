import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score
import numpy as np 
import pickle
import os

from sklearn.neural_network import MLPClassifier
df = pd.read_csv(os.getenv("DATASET_ROOT") + "/dataset.csv")

X = df[df.columns[0:-2]]
Y = df[df.columns[-2:]]

train_X, test_X, train_Y, test_Y = train_test_split(X,Y, test_size=0.2, shuffle=True)

sc = StandardScaler()
scaler = sc.fit(train_X.values)
train_X_scaled = scaler.transform(train_X.values)
test_X_scaled = scaler.transform(test_X.values)

train_Y_labels = np.argmax(train_Y.to_numpy(),axis=1)
test_Y_labels = np.argmax(test_Y.to_numpy(),axis=1)


model = MLPClassifier(hidden_layer_sizes=(44,88,128,64), 
    max_iter=30000, 
    activation="relu", 
    learning_rate="adaptive",
    learning_rate_init=0.005,
    tol=0.00005,
    verbose=True,
    early_stopping=True,
    solver="adam")

model.fit(train_X_scaled, train_Y_labels)

preds = model.predict(test_X_scaled)
print("Accuracy Score: ", accuracy_score(test_Y_labels, preds))

pickle.dump(model, open(os.getenv("MODEL_ROOT") + "/MLPClassification.model", 'wb'))
pickle.dump(scaler, open(os.getenv("MODEL_ROOT") + "/MLPClassification.scaler", 'wb'))
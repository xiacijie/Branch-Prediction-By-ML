import pickle 
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPRegressor
from sklearn.metrics import r2_score
import os

df = pd.read_csv(os.getenv("DATASET_ROOT") + "/dataset.csv")

X = df[df.columns[0:-2]]
Y = df[df.columns[-2:]]

train_X, test_X, train_Y, test_Y = train_test_split(X,Y, test_size=0.2, shuffle=True)

sc = StandardScaler()
scaler = sc.fit(train_X.values)
train_X_scaled = scaler.transform(train_X.values)
test_X_scaled = scaler.transform(test_X.values)

train_Y = train_Y["left_prob"]
test_Y = test_Y["left_prob"]

model = MLPRegressor(hidden_layer_sizes=(44,88,128,64),
    max_iter=30000,
    activation="relu",
    learning_rate="adaptive",
    learning_rate_init=0.005,
    tol=0.00005,
    verbose=True,
    early_stopping=True,
    solver="adam")

model.fit(train_X_scaled, train_Y)

preds = model.predict(test_X_scaled)

print("R2 Score: ", r2_score(test_Y, preds))

pickle.dump(model, open(os.getenv("MODEL_ROOT") + "/MLPRegression.model", 'wb'))
pickle.dump(scaler, open(os.getenv("MODEL_ROOT") + "/MLPRegression.scaler", 'wb'))
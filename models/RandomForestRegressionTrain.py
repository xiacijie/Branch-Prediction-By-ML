import pickle 
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import r2_score
import os
from Plot import plot_learning_curves

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

model = RandomForestRegressor(n_estimators = 256, max_features = 'sqrt', max_depth = 64)

print("Plot learning curve...")
plot_learning_curves(model, train_X_scaled, train_Y, 5, "r2", "RandomForestRegression")
print("Finish plotting learning curve...")

model.fit(train_X_scaled, train_Y)

preds = model.predict(test_X_scaled)
print("R2 SCORE: ", r2_score(test_Y, preds))

pickle.dump(model, open(os.getenv("MODEL_ROOT") + "/RandomForestRegression.model", 'wb'))
pickle.dump(scaler, open(os.getenv("MODEL_ROOT") + "/RandomForestRegression.scaler", 'wb'))
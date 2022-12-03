import pickle 
import pandas as pd
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVR
from sklearn.metrics import r2_score
import os
from sklearnex import patch_sklearn 
from Plot import plot_learning_curves
patch_sklearn()

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


model = SVR(kernel="rbf", gamma="scale", C=0.1, verbose=True)

print("Plot learning curve...")
plot_learning_curves(model, train_X_scaled, train_Y, 5, "r2", "SVMRegression")
print("Finish plotting learning curve...")


model.fit(train_X_scaled, train_Y)
preds = model.predict(test_X_scaled)

print("R2 Score: ", r2_score(test_Y, preds))

pickle.dump(model, open(os.getenv("MODEL_ROOT") + "/SVMRegression.model", 'wb'))
pickle.dump(scaler, open(os.getenv("MODEL_ROOT") + "/SVMRegression.scaler", 'wb'))
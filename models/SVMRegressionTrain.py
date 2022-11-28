import pickle 
import pandas as pd
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVR
from sklearn.metrics import r2_score
import os
from sklearnex import patch_sklearn 

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


# param_grid = {'C': [0.1, 1, 10,100],   
#               'gamma': [1, 0.1, 0.01],  
#               'kernel': ['poly','sigmoid']} 

# grid = GridSearchCV(SVR(), param_grid, refit = True, verbose=2) 

# grid.fit(train_X_scaled, train_Y)

model = SVR(kernel="poly", gamma=0.1, C=1, verbose=True)
model.fit(train_X_scaled, train_Y)
# model = grid.best_estimator_
# print(model)
preds = model.predict(test_X_scaled)

print("R2 Score: ", r2_score(test_Y, preds))

pickle.dump(model, open(os.getenv("MODEL_ROOT") + "/SVMRegression.model", 'wb'))
pickle.dump(scaler, open(os.getenv("MODEL_ROOT") + "/SVMRegression.scaler", 'wb'))
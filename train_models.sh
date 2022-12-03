cd ./models

echo "Training AdaBoost Regression Model ..."
python3 AdaRegressionTrain.py
echo "Training MLP Classification Model ..."
python3 MLPClassificationTrain.py
echo "Training MLP Regression Model ..."
python3 MLPRegressionTrain.py
echo "Training SVM Regression Model ..."
python3 SVMRegressionTrain.py
echo "Training Random Forest Regression Model ..."
python3 RandomForestRegressionTrain.py

import pandas as pd
import numpy as np


iris_file='/content/drive/My Drive/ml/iris.csv'
DF3 = pd.read_csv(iris_file)

data = DF3.iloc[:,:-1]
labels = DF3.iloc[:,-1]

from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report

from sklearn.ensemble import RandomForestClassifier
  
X_train, X_test, y_train, y_test = train_test_split(data, labels, test_size=0.3)
  
classifier = RandomForestClassifier(n_estimators=100)
  
classifier.fit(X_train,y_train)
  
y_pred = classifier.predict(X_test)
print(classification_report(y_test,y_pred))
from sklearn import linear_model
import sys

X = []

History.getHistories(sys.maxint, filename='data/trainHistory.csv')


clf = linear_model.RidgeCV(alphas=[0.1, 1.0, 10.0])
clf.fit([[0, 0], [0, 0], [1, 1]], [0, .1, 1])
print clf.coef_
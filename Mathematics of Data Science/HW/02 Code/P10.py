"""
"""
import os.path
import math
import matplotlib.pyplot as plt
import numpy as np
import random

plt.close("all")
plt.rcParams['xtick.major.pad']='8'
plt.rcParams['ytick.major.pad']='8'

### CHANGE PATH TO WHEREVER YOU SAVE THE DATA FILES ### 
data = np.loadtxt("heights_weights.txt") 

#n_train = 20000
n_train = 100
n_test = 1000

# Randomly select training, test and validation sets
np.random.shuffle(data)
data_train = data[range(n_train),:]
data_test = data[range(n_train, n_train+n_test),:]
heights_train = data_train[:,1]
weights_train = data_train[:,2]
heights_test = data_test[:,1]
weights_test = data_test[:,2]

### INSERT CODE HERE ###
# Hint: To fit model 1 use the expression you found directly
# to fit model 2 you can use np.linalg.lstsq
x0 = 1/np.dot(heights_train.T, heights_train)
x = np.dot(np.dot(x0,heights_train.T), weights_train)
pred_model_1 = np.dot(x,heights_test)
A = np.vstack([heights_train, np.ones(len(heights_train))]).T
y1, y0 = np.linalg.lstsq(A, weights_train, rcond=None)[0]
pred_model_2 = np.dot(y1, heights_test) + y0

plt.figure(figsize=(12, 9))  
plt.plot(heights_test, weights_test, '.',  color='skyblue',markeredgecolor='blue')
plt.plot(heights_test, pred_model_1,  c="red")

plt.figure(figsize=(12, 9))  
plt.plot(heights_test, weights_test, '.', color='skyblue',markeredgecolor='blue')
plt.plot(heights_test, pred_model_2, c="red")

error_1 = np.sum(np.abs((pred_model_1 - weights_test)/weights_test))/n_test
error_2 = np.sum(np.abs((pred_model_2 - weights_test)/weights_test))/n_test

print ("Model 1 relative error: " + str(error_1))
print ("Model 2 relative error: " + str(error_2))

plt.show()
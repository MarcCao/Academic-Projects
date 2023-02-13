from __future__ import print_function
import pandas as pd
from sklearn.decomposition import PCA
from sklearn import preprocessing
import numpy as np
from statistics import variance
"""
Loads financial data as a pandas dataframe
"""
def load_dataframe(filename) :
    return pd.read_csv(filename,index_col=0)

"""
Loads financial data as a tuple: names,data.  
names is a list of the stock names represented in each column.
data is a 2d numpy array.  Each row of data corresponds to a trading day.
data[i,j] is the price (technically the adjusted closing price) of 
instrument names[j] on the ith day.  The days are ordered chronologically.
"""
def load_data(filename) :
    df = pd.read_csv(filename,index_col=0)
    names = df.columns.values.tolist()
    data = df.to_numpy()
    #data = df.as_matrix()
    return names,data

"""
Given a 1d numpy array vec of n values, and a list of n names,
prints the values and their associated names.
"""
def pretty_print(vec,names) :
    print(pd.DataFrame(vec,names,['']).transpose())

"""
Given a 1d numpy array vec of n values, and a list of n names,
prints the values and their associated names in a LaTeX friendly
format.
"""
def pretty_print_latex(vec,names,num_col=6) :
    print("\\begin{center}")
    print("\\begin{tabular}{c"+("|c"*(num_col-1))+"}")
    for i in range(0,len(names),num_col) :
        start = True
        for j in range(i,min(i+num_col,len(names))) :
            if not start :
                print(" & ",end='')
            start = False
            print(names[j],end='')
        print("\\\\")
        start = True
        for j in range(i,min(i+num_col,len(names))) :
            if not start :
                print(" & ",end='')
            start = False
            print("%.04f"%vec[j],end='')
        print("\\\\")
        if i+num_col < len(names) :
            print("\\hline")
    print("\\end{tabular}")
    print("\\end{center}")

def main() :
    names,data = load_data('stockprices.csv')
    print("# of stocks = %d, # of days = %d"%(data.shape[1],data.shape[0]))
    # center the data
    for i in range(0,18):
        data[:,i] = data[:,i] - data[:,i].mean()
    #pretty_print(data[0,:],names)

    ### Part (a)
    pca = PCA(n_components=2)
    pca.fit(data)

    c1 = pca.components_[0]
    #print("component 1:")
    #pretty_print(c1, names)
    c2 = pca.components_[1]
    #print("component 2:")
    #pretty_print(c2, names)

    v_a = variance(data[:,1])
    #print("variance of Amazon is:", v_a)
    v_g = variance(data[:,3])
    #print("variance of Google is:", v_g)

    # calculating variance for each stock
    v1 = np.zeros((18))
    for i in range(0,18):
        v1[i] = variance(data[:,i])
    #print("variance of each stock:")
    #pretty_print(v1,names)


    ### Part (b)
    # scaling data
    scaler = preprocessing.StandardScaler().fit(data)
    data_scaled = scaler.transform(data)

    # scaled PCA
    pca = PCA(n_components=2)
    pca.fit(data_scaled)

    c1 = pca.components_[0]
    #print("component 1:")
    #pretty_print(c1, names)
    c2 = pca.components_[1]
    #print("component 2:")
    #pretty_print(c2, names)

    ### Part (c)
    # calculate the variance of daily returns
    R = np.diff(data.T)
    R = R.T
    print(R)

    A = 100*np.ones((18))
    A[0:4] = 200
    print(A)
    sig = np.cov(R.T)
    var = np.dot(A.T, np.dot(sig, A))
    print(np.sqrt(var))

    ### Part (d)
    # calculating the mean of y = Ax
    m = np.zeros((18))
    for i in range(0,18):
        m[i] = R[:,i].mean()
    #print("mean of daily returns:")
    pretty_print(m,names)
    
    print(np.dot(A,m))
    print(R[:,0].mean())


if __name__ == "__main__": 
    main()


#pretty_print_latex(data[0,:],names)
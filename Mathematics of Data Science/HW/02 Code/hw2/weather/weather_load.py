# From the materials for Mathematical Tools for Data Science
# Instructor: Carlos Fernandez-Granda
# Contributors: Brett Bernstein, Aakash Kaku, Sheng Liu, Sreyas Mohan
# Used with permission of the instructor

# data loading helper functions for weather data in weather.zip


import matplotlib.pyplot as plt
import numpy as np
from os import listdir
from numpy import linalg as LA
data_path = "./weather/"



def extract_temp(file_name,col_ind):
    data_aux = np.loadtxt(file_name, usecols=range(10))
    data = data_aux[:,col_ind]
    err_count = 0
    ind_errs = []
    for ind in range(data.shape[0]):
        if data[ind] > 100 or data[ind] < -100:
            err_count = err_count + 1
            ind_errs.append(ind)
            data[ind] = data[ind-1]  
    print( "File name: " + file_name)
    print( "Errors: " + str(err_count) + " Indices: " + str(ind_errs))
    return data

def create_data_matrix(str_path):
    file_name_list = listdir(str_path)
    file_name_list.sort()
    col_ind = 8 # 8 = last 5 minutes, 9 = average over the whole hour
    data_matrix = []
    ind = 0
    for file_name in file_name_list:
        if file_name[0] == '.':
            continue
        else:
            print("Station " + str(ind))
            ind = ind + 1
            data_aux = extract_temp(str_path + file_name,col_ind)
            if len(data_matrix) == 0:
                data_matrix = data_aux
            else:
                data_matrix = np.vstack((data_matrix,data_aux))
    return data_matrix.T

def running_mean(x):
    l = 24
    return np.convolve(x, np.ones(l)/l, mode='valid')

def process_name(x):
    x = x[14:]
    x = x[:-7]
    x = x.translate(str.maketrans('','','_1234567890'))
    return x[2:] + ", " + x[:2]

load_files = False #either read through all csvs files or just load the precomputed npy file

if load_files:
    str_path_2015 = data_path + "hourly/2015/"
    data_matrix = create_data_matrix(str_path_2015)
    str_path_2016 = data_path + "hourly/2016/"
    data_matrix_2016 = create_data_matrix(str_path_2016)
else:
    data_matrix = np.load(data_path +"hourly_temperature_2015.npy")
    data_matrix_2016 = np.load(data_path +"hourly_temperature_2016.npy")

file_name_list = listdir(data_path + "hourly/2015/")
file_name_list.sort()

print(data_matrix.shape)

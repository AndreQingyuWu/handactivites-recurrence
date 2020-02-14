from sklearn.externals import joblib
import numpy as np # 快速操作结构数组的工具
from sklearn.svm import NuSVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import GradientBoostingClassifier 
from sklearn.linear_model import LinearRegression
data_num=20
train_target=[0]*data_num+[1]*data_num
data_set=np.zeros((40,9000),dtype=float)
for i in range(data_num):
    temp=np.load('./../data/use_phone/use_phone'+str(i)+'.npy')
    data_set[i,:]=temp.ravel()
    
for j in range(data_num):
    temp=np.load('./../data/tap/tap'+str(j)+'.npy')
    data_set[j+20,:]=temp.ravel()
train_data=data_set
clf = LinearRegression()
clf.fit(X=train_data, y=train_target)  
joblib.dump(clf, "my_model.m")





'''
import numpy as np
def mtx_similar1(arr1,arr2):
'''
'''
    farr1 = arr1.ravel()
    farr2 = arr2.ravel()
    len1 = len(farr1)
    len2 = len(farr2)
    if len1 > len2:
        farr1 = farr1[:len2]
    else:
        farr2 = farr2[:len1]

    numer = np.sum(farr1 * farr2)
    denom = np.sqrt(np.sum(farr1**2) * np.sum(farr2**2))
    similar = numer / denom # 这实际是夹角的余弦值
    return  (similar+1) / 2     # 姑且把余弦函数当线性

def mtx_similar2(arr1, arr2):
'''

'''
    if arr1.shape != arr2.shape:
        minx = min(arr1.shape[0],arr2.shape[0])
        miny = min(arr1.shape[1],arr2.shape[1])
        differ = arr1[:minx,:miny] - arr2[:minx,:miny]
    else:
        differ = arr1 - arr2
    numera = np.sum(differ**2)
    denom = np.sum(arr1**2)
    similar = 1 - (numera / denom)
    return similar


def mtx_similar3(arr1, arr2):
'''

'''
    if arr1.shape != arr2.shape:
        minx = min(arr1.shape[0],arr2.shape[0])
        miny = min(arr1.shape[1],arr2.shape[1])
        differ = arr1[:minx,:miny] - arr2[:minx,:miny]
    else:
        differ = arr1 - arr2
    dist = np.linalg.norm(differ, ord='fro')
    len1 = np.linalg.norm(arr1)
    len2 = np.linalg.norm(arr2)     # 普通模长
    denom = (len1 + len2) / 2
    similar = 1 - (dist / denom)
    return similar

test=np.load('./../data/test/nao.npy')
nao=np.load('./../data/nao.npy')
tap=np.load('./../data/tap.npy')
use_phone=np.load('./../data/use_phone.npy')
#print(mtx_similar1(A,B))
print(mtx_similar1(test,nao))
print(mtx_similar1(test,tap))
print(mtx_similar1(test,use_phone))
#mtx_similar3(A,B)
'''

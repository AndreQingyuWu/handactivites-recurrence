import os
from multiprocessing import Process
from threading import Thread
from time import sleep
from scipy.signal import lfilter
from numpy.fft import fft
import matplotlib.pyplot as plt
import numpy as np
import time
import struct
import subprocess
from sklearn.externals import joblib
import tkinter as tk  # 使用Tkinter前需要先导入
import cv2
'''
None_img = cv2.cv2.imread('./../source/None.jpg')
type_img = cv2.cv2.imread('./../source/type.jpg')
use_phone_img = cv2.cv2.imread('./../source/use_phone.jpg')
def asynhc(f):
    def wrapper(*args, **kwargs):
        thr = Thread(target = f, args = args, kwargs = kwargs)
        thr.start()
    return wrapper

@asynhc
def UI():
    if Label_text=='None':
        cv2.cv2.destroyAllWindows()
        cv2.cv2.imshow(Label_text,None_img)
        cv2.cv2.waitKey()
    elif Label_text=='use phone':
        cv2.cv2.destroyAllWindows()
        cv2.cv2.imshow(Label_text,use_phone_img)
        cv2.cv2.waitKey()
    elif Label_text=='type':
        cv2.cv2.destroyAllWindows()
        cv2.cv2.imshow(Label_text,type_img)
        cv2.cv2.waitKey()
'''
Label_text='None'
frames=3
startTime = 0
current_milli_time = lambda: int(round(time.time() * 1000))
fig = plt.figure()
ax1 = fig.add_subplot(1,1,1)
xar = []
yar = ([], [], [])
result_init_adb=os.system('adb forward tcp:4444 localabstract:/adb-hub')
if result_init_adb!=0:
    os.system('adb kill-server')
    os.system('adb forward tcp:4444 localabstract:/adb-hub')
os.system('adb connect 127.0.0.1:4444')
os.system('adb devices')
output=subprocess.Popen('adb -s 127.0.0.1:4444 shell cat /sys/class/misc/fastacc_mpu/device/fifo',shell=True,stdout=subprocess.PIPE)
#frame_X=np.zeros((256,48),dtype=float)
#frame_Y=np.zeros((256,48),dtype=float)
#frame_Z=np.zeros((256,48),dtype=float)
img_data=np.zeros((1000,frames,3),dtype=float)
clf = joblib.load("./../data/my_model.m")

while True:
    #print("data....")
    for frame in range(frames):
        print("frames="+str(frame))
        hexVal=output.stdout.read(49152)
        cnt=0
        X=[]
        Y=[]
        Z=[]
        for i in range(0,len(hexVal), 2):
            val=int((str(struct.unpack('>h',hexVal[i:i+2])).split('(')[1]).split(',')[0])
            if cnt%3==0:
                X.append(val)
            elif cnt%3==1:
                Y.append(val)
            elif cnt%3==2:
                Z.append(val)
            cnt=cnt+1
        fft_X=np.abs(np.fft.fft(X,4096))/4096.0
        fft_Y=np.abs(np.fft.fft(Y,4096))/4096.0
        fft_Z=np.abs(np.fft.fft(Z,4096))/4096.0
        print("fft XYZ Done!")
        img_data[:,frame,0]=fft_X[0:1000]
        img_data[:,frame,1]=fft_Y[0:1000]
        img_data[:,frame,2]=fft_Z[0:1000]
    '''
        if frame==0:
            frame_X=fft_X[0:256]
            frame_Y=fft_Y[0:256]
            frame_Z=fft_Z[0:256]
        else:
            frame_X=np.stack((frame_X,fft_X[0:256]))
            frame_Y=np.stack((frame_Y,fft_Y[0:256]))
            frame_Z=np.stack((frame_Z,fft_Z[0:256]))
    img_data=np.stack((frame_X,frame_Y,frame_Z))
    '''
    test=img_data.ravel()
    test=[test]
    result=clf.predict(test)
    print(result)
    if result>=-0.1 and result<=0.25:
        print(result)
        Label_text="use_phone"
    elif result>=1.2 and result<=1.5:
        print(result)
        Label_text='type'
    else:
        Label_text='None'
    #UI()
    print(Label_text)
    #np.save('./../data/use_phone/use_phone'+str(c)+'.npy',img_data)
    #print(img_data.shape,img_data)


#print(len(frame_x),frame_x)
#print(len(X),X)

'''
for hexVal in iter(output.stdout.read(49152),b''):
    #hexList = [struct.unpack('>h',hexVal[i:i+2]) for i in range(0,len(hexVal), 2)]
    print(len(hexVal))
'''
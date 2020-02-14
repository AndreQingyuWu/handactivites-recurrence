import os
from multiprocessing import Process
from threading import Thread
from time import sleep
from scipy.signal import lfilter
from numpy.fft import fft
import numpy as np


import time
import struct
import subprocess
root_path='./../data/Authentication/method3/'
mode='people2'+'/'
Label_text='None'
frames=48
startTime = 0
current_milli_time = lambda: int(round(time.time() * 1000))
result_init_adb=os.system('adb forward tcp:4444 localabstract:/adb-hub')
if result_init_adb!=0:
    os.system('adb kill-server')
    os.system('adb forward tcp:4444 localabstract:/adb-hub')
os.system('adb connect 127.0.0.1:4444')
os.system('adb devices')
output=subprocess.Popen('adb -s 127.0.0.1:4444 shell  \
    cat /sys/class/misc/fastacc_mpu/device/fifo',shell=True,stdout=subprocess.PIPE)

img_data=np.zeros((4096,frames,3),dtype=float)
Total=b''

while True:
    print('--------------------------------------------------------------------------------------------')
    print("data....")
    for frame in range(frames):
        print("frames="+str(frame))
        if len(Total)<49152:
            Total=output.stdout.read(49152)
        else:
            hexVal=output.stdout.read(1536)
            Total=Total[1536:49152]+hexVal
        print('len(Total)'+str(len(Total)))
        if len(Total)==0:
            print('XX EEROR XXXXX ERROR XXXXX ERROR XXXXX ERROR XXXXX ERROR XXXXX ERROR XXXXX ERROR XXXXX ERROR XXXXX ERROR XX')
        cnt=0
        X=[]
        Y=[]
        Z=[]
        for i in range(0,len(Total), 2):
            val=int((str(struct.unpack('>h',Total[i:i+2])).split('(')[1]).split(',')[0])
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
        img_data[:,frame,0]=fft_X
        img_data[:,frame,1]=fft_Y
        img_data[:,frame,2]=fft_Z
    print(img_data.shape)
    dir_list=os.listdir(root_path+mode)
    count=len(dir_list)
    np.save(root_path+mode+str(count)+'.npy',img_data)

    #test=img_data.ravel()
    #test=[test]
    #result=clf.predict(test)
    #print(result)
    #if result<=0.15:
    #    Label_text='use phone'
    #elif result>=1:
    #    Label_text='type'
    #else:
    #    Label_text='None'
    #UI()
    #print(Label_text)
    #print(img_data.shape,img_data)


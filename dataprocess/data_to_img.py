import numpy as np 
import cv2
import os
classes=['ring_finger','pull','mouse','type']
label=classes[3]
root_path='./train_data/'+label+'/'
files=os.listdir(root_path)
num=len(files)
for i in range(num):
    print(str(i))
    path=root_path+str(i)+'.npy'
    save_path='./image_data/'+label+'/'+str(i)+'.jpg'
    data=np.load(path)
    image=np.asanyarray(data,dtype=np.uint8)
    cv2.cv2.imwrite(save_path,image)
print('process done!')


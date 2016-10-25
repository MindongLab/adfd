import sys, os
from PIL import Image, ImageDraw
import matplotlib.pyplot as pyplot

def runTest(num):
  path = "images\\image-"+str(num)+".png"
  imgtmp =  Image.open(path)
  img = Image.open(path)
  print(img.size[0], img.size[1])
  draw = ImageDraw.Draw(imgtmp)
  draw.line((20,0,20,10),fill=0)
  height = img.size[1]
  width = img.size[0]

  def count_black(x0,y0,x1,y1):
    count=0
    for y in range(y0,y1):
      for x in range(x0,x1):
        if img.getpixel((x,y))==0:
          count=count+1
    return 100*count/(x1-x0)/(y1-y0)

  # find vertial columns
  density = []
  for w in range(0, width-10-1):
    black = count_black(w, 80, w+10, 2200)
    density.append({"position": w+5, "density": black});

  x=[]
  y=[]
  for item in density:
    x.append(item["position"])
    y.append(item["density"])
  pyplot.clf()
  pyplot.plot(x,y,marker="*")
  pyplot.savefig("black\\fig-"+str(num)+".png")

  x=[]
  y=[]
  y_delta=[]

  for h in range(0,height-56,1):
    black = count_black(80, h, 1500, h+55)
    #print(black)
    #if (black <= 2):
     # draw.line((0,h,img.size[0],h),fill=0)
    x.append(h)
    if (len(y)>0):
      y_delta.append(black - y[len(y)-1])
    y.append(black)
  
  for i in range(0,len(x)-1):
    if (i>0 and y_delta[i]*y_delta[i-1]<0): 
      draw.line((0,x[i],width-1,x[i]),fill=0)
    
  pyplot.clf()
  pyplot.plot(x,y,marker="*")
  pyplot.savefig("black\\fig-h-"+str(num)+".png")
  #imgtmp.show()
  imgtmp.save("processed\\gradient-"+str(num)+".png")

for i in range(1658, 1700):
  runTest(i)

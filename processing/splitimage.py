import sys, os
from PIL import Image, ImageDraw
import matplotlib.pyplot as pyplot

def splitImage(num):
  path = "images\\image-"+str(num)+".png"
  imgtmp = Image.open(path)
  img = Image.open(path)
  # print(img.size[0], img.size[1])
  draw = ImageDraw.Draw(imgtmp)
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

  block0 = [x for x in density if (x["position"]<=250 and x["density"]<=2)]
  print(block0[len(block0)-1])
  seperator1 = int(block0[len(block0)-1]["position"])

  block1 = [x for x in density if (350<= x["position"] and x["position"]<=600 and x["density"]<=2)]
  print(block1[len(block1)-1],block1[0])
  seperator2 = int((block1[len(block1)-1]["position"] + block1[0]["position"]) /2);
  
  block2 = [x for x in density if (600<= x["position"] and x["position"]<=900 and x["density"]<=2)]
  print(block2[len(block2)-1],block2[0])
  seperator3 = int((block2[len(block2)-1]["position"] + block2[0]["position"]) /2);
  
  block3 = [x for x in density if (1200<= x["position"] and x["density"]<=2)]
  print(block3[0])
  seperator4 = int(block3[0]["position"]);
  
  draw.line((seperator1,0,seperator1,height-1),fill=0)
  draw.line((seperator2,0,seperator2,height-1),fill=0)
  draw.line((seperator3,0,seperator3,height-1),fill=0)
  draw.line((seperator4,0,seperator4,height-1),fill=0)
  #find top and bottom
  
  
  density_h = []
  hseperator1=0
  hseperator2=height-16
  for h in range(0, height-6-1,3):
    black = count_black(6, h, width-6, h+6)
    density_h.append({"position": h+3, "density": black});

  blockh0 = [y for y in density_h if (y["position"]<=250 and y["density"]<=2)]
  print(len(blockh0))
  for i in range(1, len(blockh0)):
    if (blockh0[i]["position"]-blockh0[i-1]["position"]>5):
      hseperator1 = blockh0[i]["position"]+80
      break
  blockh1 = [y for y in density_h if (2000<=y["position"] and y["density"]<=2)]
  print(len(blockh1))
  for i in range(len(blockh1)-2, -1, -1):
    if (blockh1[i+1]["position"]-blockh1[i]["position"]>5):
      hseperator2 = blockh1[i+1]["position"]
      break
  print(hseperator1,hseperator2)
  
  def findwordblock(x1,y1,x2,y2):
    for i in range(x1, x2-21, 20):
        black = count_black(i, y1, i+20, y2)
        if black > 15:
            return True
    return False
  
  density_h_column1 = []
  density_h_column2 = []
  density_h_column3 = []
  linebreaks = []
  for h in range(hseperator1,hseperator2+10,1):
    black1 = count_black(seperator1, h, seperator2, h+5)
    density_h_column1.append({"position": h+2, "density": black1})
    black2 = count_black(seperator2, h, seperator3, h+5)
    density_h_column2.append({"position": h+2, "density": black2})
    black3 = count_black(seperator3, h, seperator4, h+5)
    density_h_column3.append({"position": h+2, "density": black3})
    #(black1 > 10) or (black2 >10) or
    if ( (black1 > 15) or (black2 >15) or findwordblock(seperator3, h, seperator4, h+3)): 
      a=1
      # line 
    else:
      linebreaks.append(h)
      
  
  newLineBreaks= []
  for i in range(0, len(linebreaks)):
    if len(newLineBreaks) == 0:
      newLineBreaks.append({"start":linebreaks[i], "end":linebreaks[i]})
    else:
      if linebreaks[i] - newLineBreaks[len(newLineBreaks)-1]["end"] >30:
        newLineBreaks.append({"start":linebreaks[i], "end":linebreaks[i]})
      elif linebreaks[i] - newLineBreaks[len(newLineBreaks)-1]["end"] ==1:
        newLineBreaks[len(newLineBreaks)-1]["end"]=linebreaks[i]
        
  for item in newLineBreaks:
    if item["end"]-item["start"]>30:
      # blank block 
      draw.line((0,item["start"],width-1,item["start"]),fill=0)
      draw.line((0,item["end"],width-1,item["end"]),fill=0)
    else:
      pos = int((item["end"]+item["start"])/2)
      draw.line((0,pos,width-1,pos),fill=0)
  #imgtmp.show()
  imgtmp.save("processed\\image-"+str(num)+".png")
for i in range(53,59):
  splitImage(i)

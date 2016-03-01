// Copyright 2012 Matthew Schranz and Seneca College
// Copying this code in whole or in part is not allowed without
// the authors' explicit consent.

int maxX = -70;

class Box {
  int num, xpos, stopX;

  Box(int num, int stopX) {
    this.num = num;
    this.stopX = stopX;
    xpos = 540;
  }

  void step() {
    xpos = xpos > stopX ? xpos - 5 : xpos;
  }

  void draw() {
    fill(204, 5, 100);
    if(xpos > stopX) {
      rect(xpos, 10, 70, 70);
      fill(0);
      text(num, xpos + 3, 44);
    }
    else if(xpos == stopX) {
      rect(xpos, 10, 70, 70);
      fill(0);
      text(num, xpos + 3, 44);
    }
  }
}

ArrayList boxes;
 
void setup() {
  background(200);
  size(550, 90);
  strokeWeight(4);
  boxes = new ArrayList();
}

void draw() {
  background(200);
  for (int i = 0; i < boxes.size(); i++) {
    Box b = (Box) boxes.get(i);
    b.draw();
    b.step();
  }
}

// Getter used by Javascript to remove Box at front of List after visual Dequeueing is done.
ArrayList getBoxes(){
  return boxes;
}

/* 
  Taken from the Processing Guide posted here: http://processingjs.org/articles/PomaxGuide.html
*/
interface JavaScript {
  void showXYCoordinates(int x, int y);
}

/* 
  Taken from the Processing Guide posted here: http://processingjs.org/articles/PomaxGuide.html
*/
void bindJavascript(JavaScript js) {
  javascript = js;
}

/* 
  Taken from the Processing Guide posted here: http://processingjs.org/articles/PomaxGuide.html
*/ 
JavaScript javascript;

void enqueue(int x){
  maxX += 80;
  aBox = new Box(x, maxX);
  boxes.add(aBox);
}

void dequeue(){
  // Decrement Global Max X, so future Enqueues place in the correct position
  // Ensure it maintains the starting value when dequeue is hit more times than there are boxes
  maxX = (maxX - 80) > 0 ? maxX - 80 : -70;  

  // Retrieve Box at front of Queue and report it's value to the DOM
  Box b = (Box)boxes.get(0);
  if(javascript != null && boxes.size() > 0){
    javascript.reportRemovedBox(b.num);
  }
  else {
    javascript.reportRemovedBox(-1);
  }

  for(int i = 0; i < boxes.size(); i++){
    b = (Box)boxes.get(i);
    b.stopX -= 80;    
  }
}
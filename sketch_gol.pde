//import g4p_controls.*;
 
//public class MyImageButton extends GImageButton {
//    public MyImageButton(PApplet theApplet, float p0, float p1, float p2, float p3, String[] fnames) {
//        super(theApplet, p0, p1, p2, p3, fnames, null);
//    }
 
//}

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Position X / Y
int posX = 0;
int posY = 0;

int cols,rows;
int scl = 20;

// New Cell matrix && buffer
Cell[][] cell;
Cell[][] cellsAlive;
Cell[][] cellsBuffer;

boolean running = false;
////Hold down the button
//boolean button = false;


void setup() {
  size(400, 500);
  textAlign(LEFT, TOP);
  smooth();
  gameButtonsSetup();
  int w = 400;
  int h = 400;
  cols = w / scl;
  rows = h / scl;
  // Save state of cell
  cell = new Cell[cols][rows];
  cellsBuffer = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each Cell object
      cell[i][j] = new Cell(i*rows,j*cols,scl,scl,false,0);
      
    }
  }
}
int value = 0;
void draw() {
  //if (!running) {
  //  noLoop();
  //}
  background(0);
  strokeWeight(2);
  //textFont("Arial");
  text("Generation" + lastRecordedTime, 50,200);
  update(mouseX, mouseY);
  drawButtons();
              if (running && !mousePressed){
           for (x = 0; x < cols; x++) {
            for (y = 0; y < rows; y++) {
              cellsBuffer[x][y] = cell[x][y];
            }

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int posX = x*scl;
      int posY = y*scl;
      //Cell currentPos = new Cell(x*rows,y*cols,scl,scl,false);
          
      stroke(55);
      
      // if mouse is within boundaries
      if ((mouseX >= posX && mouseX <= posX+scl) &&
        (mouseY >= posY && mouseY <= posY+scl)) {
        
          fill(75);
          
        if (mousePressed == true) {
          // find surrounding neighbors, and add life/death logic
          
          // to prevent fast cell toggles
          delay(125);

          println("Clicked at pos: " + posX + ", " + posY); //<>//
          //println("Clicked at pos/scl: " + x + ", " + y);
          
          //When you click on a cell, toggle it
          if (!cell[x][y].alive) {
            cell[x][y].alive = true;
            // Fill this color
            fill(204,102,0);
            
            //  save alive cells
            //cellsAlive[x][y] = cell[x][y];
            
             //checkNeighbor(x,y);
            //println(cell[x][y], cell[posX][posY]);
          } else {
            cell[x][y].alive = false;
             //checkNeighbor(x,y);
            //println(cell[x][y].alive);
            //println("yo");
          }

         fill(100);
         //println("yerr");
         //if (!running){
         //findSurrounding(x,y);
         ////whileLoop(x,y);
         //}
        }
         //println("Mouse at: " + posX + ", " + posY);
        } else {
          fill(50);

        }
        // if cell is toggled alive
        if (cell[x][y].alive) {
          // fill it
          fill(204,102,0);
          rect(posX, posY, scl, scl);
        }
      // Display each object
      cell[x][y].display();
              //findSurrounding(x,y);
  
      //println(cell[x][y].y + " - " + cell[x][y].);
    }
  }
   // Iterate if timer ticks
  if (millis()-lastRecordedTime>interval) {
    if (!running) {
      generation();
      lastRecordedTime = millis();
    }
  }
}
void generation(){// When the clock ticks
  // Save cells to buffer (so we operate with one array keeping the other intact)
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      cellsBuffer[x][y] = cell[x][y];
    }
  }
}
void whileLoop(int x, int y){
  
}
// A Cell object
class Cell {
  // A cell object knows about its location in the cell 
  // as well as its size with the variables x,y,w,h,
  // its alive/dead state && neighbors
  float x,y;   // x,y location
  float w,h;   // width and height
  boolean alive; // alive for checking alive / dead boolean
  int neighbor; // checks count of neighbors
  
   Cell(float tempX, float tempY, float tempW, float tempH, boolean tempAlive, int tempNeighbor) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    alive = tempAlive;
    neighbor = tempNeighbor;
   }    
    void display() {
    stroke(20);
    rect(x,y,w,h);
  }
//    void checkNeighbor() {
//  // find all surrounding cell by adding +/- 1 to col and row 
//  for (int i = cols - 1; i <= (cols + 1); i+=1) {
//    for (int j = rows - 1; j <= (rows + 1); j +=1) {
//      //if not the center cell
//      if (!((i == cols) && (j == rows))) {
//        // keeping within bounds...
//        if (inBounds(i,j)) {
//          println("Neighbor of " + cols + " " + rows + " - " + i + " " + j + " - Alive? - " + cell[x][y].alive );

//          //if() {
//          //}
//        }
//      }
//    }
//  }
//}
//}
}
void findSurrounding(int  col, int row) {
  for (int x=0; x<width/5; x++) {
    for (int y=0; y<height/5; y++) {
    // find all surrounding cells by adding +/- 1 to col and row 
    for (int colNum = col - 1 ; colNum <= (col + 1) ; colNum +=1  ) {
        for (int rowNum = row - 1 ; rowNum <= (row + 1) ; rowNum +=1  ) {
          
          
             // if not the center cell (skip the center)
            if(! ((colNum == col) && (rowNum == row))) {
              
                // stay within bounds of the cell
                if(withinBounds (colNum, rowNum)) {
                    //System.out.println("Neighbor of "+ col+ " "+ row + " - " + colNum +" " + rowNum );
                
                
                  // if surrounding cell is alive, increase neighbor value 
                  if(cell[colNum][rowNum].alive){
                   println(cell[colNum][rowNum].alive);
                   cell[colNum][rowNum].neighbor +=1;
                   
                  }
                  
                  // If the cell is alive and has 2 or 3 neighbors, 
                  // then it remains alive. Else it dies.
                  if (cell[colNum][rowNum].alive) { 
                   if (cell[colNum][rowNum].neighbor < 2 || 
                      cell[colNum][rowNum].neighbor > 3) {
                        cell[colNum][rowNum].alive = false;
                      } 
                    }
                    else {
                       // If the cell is dead and has exactly 3 neighbors, 
                      // then it comes to life. Else if remains dead.
                      if (cell[colNum][rowNum].neighbor == 3) {
                        cell[colNum][rowNum].alive = true;
                        }
                      }
                }
            }
        }
    }}}
           println("~~~~~~~~~~~~~~~~~");
}
 
//define if cell is within bounds of the matrix (... take the red pill)
boolean withinBounds(int colNum, int rowNum) {
    if((colNum < 0) || (rowNum <0) ) {
        return false;    //false if row or col are negative
    }
    if((colNum >= cols) || (rowNum >= rows)) {
        return false;    //false if row or col are > 75
    }
    return true;
}

void reset() {
  int w = 400;
  int h = 400;
  cols = w / scl;
  rows = h / scl;
  // Save state of cell
  cell = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each Cell object
      cell[i][j] = new Cell(i*rows,j*cols,scl,scl,false,0);
      
    }
  }
}

// game buttons
int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;
boolean start;

void gameButtonsSetup() {
  rectColor = color(0);
  rectHighlight = color(51);
  circleColor = color(255);
  circleHighlight = color(204);
  baseColor = color(102);
  currentColor = baseColor;
  circleX = 320;
  circleY = 453;
  rectX = 50;
  rectY = 407;
  ellipseMode(CENTER);
}

void drawButtons() {
  update(mouseX, mouseY);
  background(currentColor);
  
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize, 30);
  //text("Stop", 50, 400);
  
  if (circleOver) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
}

void update(int x, int y) {
  //if (start) {
  //    start = false;
  //    noLoop();
  //  } else {
  //    start = true;
  //    loop();
  //  }
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;

  } else {
    circleOver = rectOver = false;
  }
}

void mousePressed() {
  if (circleOver) {
    currentColor = circleColor;
     if (!running){ 
      for (int x = 0; x < cols; x++) {
        for (int y = 0; y < rows; y++) {
          findSurrounding(x, y);
        }
    }
      }
    //if (!running) {
    //  running = true;
    //          findSurrounding(posX,posY);
    //}
    //running = true;
  }
  if (rectOver) {
    currentColor = rectColor;
    running = false;
    //cell[x][y] =
    reset();
  }
  //if (mouseX > rectX-rectSize/2 && mouseX < rectX-rectSize/2 + rectSize &&
  //  mouseY > rectY-rectSize && mouseY < rectY-rectSize + rectSize/2) {
  //  //if (start) {
  //  //  start = false;
  //  //  noLoop();
  //  //} else {
  //  //  start = true;
  //  //  loop();
  //  //}
  //}
}


boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

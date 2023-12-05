/*

ROBOT 2 DOF

data: 23/11/2023
ora: 11:34

*/
float q1 = 0;
float q2 = 0;

float q1t = 0;
float q2t = 0;

float q1b = 0;
float q2b = 0;

float q1c = 0;
float q2c = 0;

float r = 10;
float linkLenght;

float xx = 0;
float yy = 0;

float gomito = 1;
float a;
float b1;
float b2;

float kp = 0.2;


void setup() {
   size(1000,1000);
   background(#7AA8E8);
  
   linkLenght = width/8;
   
   a = (xx*xx + yy*yy -2*linkLenght*linkLenght)/(2*linkLenght*linkLenght);
   b1 = linkLenght-linkLenght*cos(q2);
   b2 = linkLenght*sin(q2);
}



void draw(){
   background(#88E6F0);
   noStroke();
   
   a = (xx*xx + yy*yy -2*linkLenght*linkLenght)/(2*linkLenght*linkLenght);
   b1 = linkLenght-linkLenght*cos(q2);
   b2 = linkLenght*sin(q2);
   
   q2 = atan2(gomito*sqrt(abs(1-a*a)), a);
   q1 = atan2(-b2*xx+b1+yy, b1*xx+b2*yy) - PI/2;
   
   q2t = atan2(-gomito*sqrt(abs(1-a*a)), a);
   q1t = atan2(-b2*xx+b1+yy, b1*xx+b2*yy) - PI/2;
   
  
   q1 += 0.1;
   q2 -= 0.3;
   
   q1b = q1b -kp*(q1b-q1);
   q2b = q2b -kp*(q2b-q2);
   
   pushMatrix();
   pushMatrix();
   translate(width/4, height/4);
   fill(255);
   ellipse(0, 0, 4*linkLenght, 4*linkLenght);
   
   fill(0);
   ellipse(xx, yy, r, r);
   
   robot(r, linkLenght, q1, q2, 209, 163, 70);
   
   popMatrix();
   translate(3*width/4, height/4);
   robot(r, linkLenght, q1b, q2b, 255-209, 255-163, 255-70);
   
   popMatrix();
   translate(3*width/4, 3*height/4);
   robot(r, linkLenght, q1c, q2c, 100, 23, 56);
}


void link(float diameter, float lenght) {
  ellipse(0, 0, diameter, diameter);  // disegno un cerchio
  
  translate(-diameter/2, 0);
  rect(0, 0, diameter, lenght);
  
  translate(diameter/2, lenght);
  ellipse(0, 0, diameter, diameter);  // disegno un cerchio
}


void robot(float diameter, float lenght, float q1, float q2, int red, int green, int blue) {
    fill(red, green, blue);
  
    rotate(q1);
    link(diameter, lenght);
    
    rotate(q2);
    link(diameter, lenght);
}

void mousePressed() {
  
  xx = mouseX-width/4;
  yy = mouseY-height/4;
  
  
  println("x = "+xx);
  println("y = "+yy);
}

void keyPressed() {
  gomito*=-1;
}

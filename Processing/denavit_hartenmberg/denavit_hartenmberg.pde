float q1 = 0;
float q2 = 0;
float q3 = 0;
float q4 = 0;
float q5 = 0;
float q6 = 0;

float qr1 = 0;
float qr2 = 0;
float qr3 = 0;
float qr4 = 0;
float qr5 = 0;
float qr6 = 0;

float aX = PI/2;
float aY = PI/2;

float aXp = 0;    // p = partenza
float aYp= 0;     // p = partenza

int giunto = 1;
float incr = 0.5;

float kp = 0.02;


void setup() {
  size(500,500,P3D);
  background(#A8DDEA);

}


void draw(){
  background(#A8DDEA);
  
  q1 -= kp*(q1-qr1);
  q2 -= kp*(q2-qr2);
  q3 -= kp*(q3-qr3);
  
  translate(250,250,-100);
  
  rotateY(-aY);
  rotateX(aX);
  
  
  directionalLight(1126,126,126, 0,0,0.7);
  ambientLight(200,200,200);
  fill(#CEC962);
  noStroke();
  robot();

}


void robot() {
/*  ANTROPOMORFO
  link(q1,100,PI/2,100);
  link(q2,0,0,100);
  link(q3,0,0,100);
*/

/* SFERICO primo tipo
  link(q1,100,-PI/2,0);
  link(q2,100,+PI/2,0);
  link(0,100*q3,0,100);
*/


  link(q1,0,0,100);
  link(q2,0,0,100);
  link(0,100*q3,0,0);

}


void link(float theta, float d, float alpha, float a) {

  rotateZ(theta);
  sphere(25);
  
  translate(0,0,-d/2);
  box(25,25,d);
  
  translate(0,0,-d/2);
  rotateX(alpha);
  sphere(25);
  
  translate(-a/2,0,0);
  box(a,25,25);
  translate(-a/2,0,0);


}


void mousePressed() {
  aYp = aY + PI*mouseX/float(300);
  aXp = aX + PI*mouseY/float(300);
}


void mouseDragged() {
  aY = aYp + PI*mouseX/float(300);
  aX = aXp + PI*mouseY/float(300);
}


void keyPressed() {
  if (keyCode == '1') giunto = 1;
  if (keyCode == '2') giunto = 2;
  if (keyCode == '3') giunto = 3;
  
  if (keyCode == RIGHT) {
    if (giunto == 1) qr1 += incr;
    if (giunto == 2) qr2 += incr;
    if (giunto == 3) qr3 += incr;
  }
  
  if (keyCode == LEFT) {
    if (giunto == 1) qr1 -= incr;
    if (giunto == 2) qr2 -= incr;
    if (giunto == 3) qr3 -= incr;
  }
  
  if (keyCode == ENTER) {
    qr1 = PI/2;
    qr2 = PI/2;
    qr3 = 2;
  }
}

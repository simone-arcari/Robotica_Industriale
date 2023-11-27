import java.util.ArrayList;

// Parametri vari
int giunto = 1;
int robotIndex = 0;
float incr = 0.5;
float kp = 0.02;
float kd = 300;

// Parametri standard per il disegno
int fillColor = #CEC962;
int backgroundColor = #A9EDF0;
float linkSize = 25;             // valore spessore dei link

// Rotazione dell'ambinete grafico
float offsetZ = -100;  // indica la traslazione lungo l'asse Z che viene fatto all'inizio del draw()
float aX = PI/2;       // variabile per la rotazione dell'ambiente grafico lungo l'asse X
float aY = PI/2;       // variabile per la rotazione dell'ambiente grafico lungo l'asse Y
float aXp = 0;         // p = partenza
float aYp= 0;          // p = partenza
float Ka = 300;        // costate di proporzionalità inversa [usata in mousePressed() e mouseDragged()]

// Luci ambientali
int lightValue = 128;    // valore punto luce direzionabile
int ambientLight = 200;  // valore luce ambientale uniforme
float dirX = 0;          // componente X versore direzione punto luce
float dirZ = 1;          // componente Z versore direzione punto luce

// Robot correntemente caricato in memoria
Robot robot;



 
void setup() {
  size(1386,756,P3D);
  background(backgroundColor);
  
  makeTables();
  loadRobot(0);
}
 
 
void draw() {
  background(backgroundColor);
  
  translate(width/4, height/2, -100);
  rotateX(aX);   // rotazione dell'ambiente grafico lungo l'asse X [tramite mouse]
  rotateY(-aY);  // il meno server per ovviare al fatto che processing utilizza un sistema di riferimento sinistro
 
  directionalLight(lightValue, lightValue, lightValue, dirX, 0, dirZ);   // punto luce direzionabile
  ambientLight(ambientLight, ambientLight, ambientLight);                // luce ambientale uniforme
  
  noStroke();  // di base non vogliamo visualizzare le linee delle figure
  
  /*
    DA QUI INIZIA LA ZONA DI CODICE IN CUI POTER DISEGNARE
  */
  robot.drawRobot();  
}


void mousePressed() {
  aYp = aY + PI*mouseX/Ka;
  aXp = aX + PI*mouseY/Ka;
}


void mouseDragged() {
  aY = aYp + PI*mouseX/Ka;
  aX = aXp + PI*mouseY/Ka;
}


void keyPressed() {
  if (keyCode == '1') giunto = 1;
  if (keyCode == '2') giunto = 2;
  if (keyCode == '3') giunto = 3;
  if (keyCode == '4') giunto = 4;
  if (keyCode == '5') giunto = 5;
  if (keyCode == '6') giunto = 6;
  if (keyCode == '7') giunto = 7;
  if (keyCode == '8') giunto = 8;
  if (keyCode == '9') giunto = 9;
  if (keyCode == '0') giunto = 0;
  
  
  if (keyCode == UP) {
    robotIndex++;
    if(robotIndex >= table_number) robotIndex = 0;
    
    loadRobot(robotIndex);
  }
  
  if (keyCode == DOWN) {
    robotIndex--;
    if(robotIndex < 0) robotIndex = table_number-1;
    
    loadRobot(robotIndex);
  }
  
  
  if (keyCode == RIGHT) {
    if (giunto == 1) robot.qr.set(0, robot.qr.get(0)+incr);
    if (giunto == 2) robot.qr.set(1, robot.qr.get(1)+incr);
    if (giunto == 3) robot.qr.set(2, robot.qr.get(2)+incr);
    if (giunto == 4) robot.qr.set(3, robot.qr.get(3)+incr);
    if (giunto == 5) robot.qr.set(4, robot.qr.get(4)+incr);
    if (giunto == 6) robot.qr.set(5, robot.qr.get(5)+incr);
    if (giunto == 7) robot.qr.set(6, robot.qr.get(6)+incr);
    if (giunto == 8) robot.qr.set(7, robot.qr.get(7)+incr);
    if (giunto == 9) robot.qr.set(8, robot.qr.get(8)+incr);
    if (giunto == 0) robot.qr.set(9, robot.qr.get(9)+incr);
  }
  
  if (keyCode == LEFT) {
    if (giunto == 1) robot.qr.set(0, robot.qr.get(0)-incr);
    if (giunto == 2) robot.qr.set(1, robot.qr.get(1)-incr);
    if (giunto == 3) robot.qr.set(2, robot.qr.get(2)-incr);
    if (giunto == 4) robot.qr.set(3, robot.qr.get(3)-incr);
    if (giunto == 5) robot.qr.set(4, robot.qr.get(4)-incr);
    if (giunto == 6) robot.qr.set(5, robot.qr.get(5)-incr);
    if (giunto == 7) robot.qr.set(6, robot.qr.get(6)-incr);
    if (giunto == 8) robot.qr.set(7, robot.qr.get(7)-incr);
    if (giunto == 9) robot.qr.set(8, robot.qr.get(8)-incr);
    if (giunto == 0) robot.qr.set(9, robot.qr.get(9)-incr);
  }
}

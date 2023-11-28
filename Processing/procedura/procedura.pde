// Variabili generiche
int giunto = 0;      // indica quale giunto si intende controllare da tastiera
int robotIndex = 0;  // i robot memorizzati nel programma sono indicizzati 
float incr = 0.5;    // incremeto applicato tramite tastiere al valore del giunto selezionato
float kp = 0.02;     // costante moltiplicativa per la legge di controllo proporzionale
float kd = 300;      // costate moltiplicativa per i parametri q1,q2,... nel caso in cui siano giunti prismatici

// Parametri standard per il disegno
int fillColor = #CEC962;           // colore robot
int backgroundColor = #A9EDF0;     // colore sfondo
float linkSize = 25;               // valore spessore dei link

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


ArrayList<Robot> robots;


void setup() {
  size(1386,756,P3D);
  background(backgroundColor);
  
  robots = makeRobots(makeTables());
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
  robots.get(robotIndex).drawRobot();  
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
  if (keyCode == '1') giunto = 0;
  if (keyCode == '2') giunto = 1;
  if (keyCode == '3') giunto = 2;
  if (keyCode == '4') giunto = 3;
  if (keyCode == '5') giunto = 4;
  if (keyCode == '6') giunto = 5;
  if (keyCode == '7') giunto = 6;
  if (keyCode == '8') giunto = 7;
  if (keyCode == '9') giunto = 8;
  if (keyCode == '0') giunto = 9;
  
  
  if (keyCode == UP) {
    robotIndex++;
    if(robotIndex >= table_number) robotIndex = 0;    
  }
  
  if (keyCode == DOWN) {
    robotIndex--;
    if(robotIndex < 0) robotIndex = table_number-1;
  }
  
  
  if (keyCode == RIGHT) {
    Robot robot = robots.get(robotIndex);
    int n = robot.table.DoF;
    
    for (int i=0; i<n; i++) {
      if (giunto == i) {
        robot.qr.set(i, robot.qr.get(i)+incr);
      }
    }
  }
  
  if (keyCode == LEFT) {
    Robot robot = robots.get(robotIndex);
    int n = robot.table.DoF;
    
    for (int i=0; i<n; i++) {
      if (giunto == i) {
        robot.qr.set(i, robot.qr.get(i)-incr);
      }
    }
  }
}

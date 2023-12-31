// Variabili generiche
int giunto = 0;          // indica quale giunto si intende controllare da tastiera
int robotIndex = 0;      // i robot memorizzati nel programma sono indicizzati 
float incr = 0.5;        // incremeto applicato tramite tastiere al valore del giunto selezionato
float kp = 0.02;         // costante moltiplicativa per la legge di controllo proporzionale
float kd = 300;          // costate moltiplicativa per i parametri q1,q2,... nel caso in cui siano giunti prismatici
int sampleNumber = 300;  // ogni robot tiene traccia degli ultimi sampleNumber valori di q e qr allo scopo di graficarne l'andamento

// Parametri standard per il disegno
int fillColor = #CEC962;           // colore robot
int backgroundColor = #A9EDF0;     // colore sfondo
float linkSize = 25;               // valore spessore dei link

// Rotazione dell'ambinete grafico
float offsetZ = -100;  // indica la traslazione lungo l'asse Z che viene fatto all'inizio del draw()
float aX = 0;          // variabile per la rotazione dell'ambiente grafico lungo l'asse X
float aY = 0;          // ------------------------------------------------------------- Y
float aXp = 0;         // p = partenza x
float aYp= 0;          // ------------ y
float Ka = 300;        // costate di proporzionalità inversa [usata in mousePressed() e mouseDragged()]

// Luci ambientali
int lightValue = 128;      // valore punto luce direzionabile
int ambientLight = 200;    // valore luce ambientale uniforme
float dirX = sin(5*PI/6);  // componente X versore direzione punto luce
float dirZ = cos(5*PI/6);  // ---------- Z ----------------------------

// Oscilloscopio
float margin = 20;        // distanza tra il disegno dell'oscilloscopio ed i bordi della finestra
float w;                  // larghezza oscilloscopio
float h;                  // altezza oscilloscopio
float xp;                 // posizione x dell'angolo in alto a sinistra dell'oscilloscopio
float yp;                 // --------- y -------------------------------------------------
int lineNumber = 51;      // numero di linee verticali disegante sull'oscilloscopio (uguali al numero di linee orizzontali)


ArrayList<Robot> robots;    // lista dinamica di oggeti Robot
Oscilloscope oscilloscope;  // ogetto oscilloscopio per visualizzare i plot di q e qr


void setup() {
  size(1386,756,P3D);                
  background(backgroundColor);
  
  // parametri oscilloscopio
  w = width/2;              // larghezza
  h = height-2*margin;      // altezza
  xp = width-w-margin;      // posizione X spigolo in alto a sinistra
  yp = (height-h)/2;        // --------- Y --------------------------
  
  oscilloscope = new Oscilloscope(w,h, xp,yp, 4, lineNumber);  // crea oggetto oscilloscopio con parametri specificati
  robots = makeRobots(makeTables());                           // crea tutti gli oggetti robot tramite le tabelle memorizzate e ritorna la lista
}
 
 
void draw() {
  background(backgroundColor);
  
  // Grafici - Oscilloscopio
  oscilloscope.drawOscilloscope();                              // disegna lo schermo dell'oscilloscopio con la griglia e il bordino nero
  stroke(255,0,0);                                              // parametri q di colore rosso
  oscilloscope.drawSignals(robots.get(robotIndex).qData);       // grafica i parametri q
  stroke(0,0,255);                                              // parametri qr di colore blu
  oscilloscope.drawSignals(robots.get(robotIndex).qrData);      // grafica i parametri qr
  
  // Nomi dei robot
  fill(255,0,0);
  textSize(50);
  text(names[robotIndex], 10, height-20);
  
  // Setup spazio 3D
  translate(width/6, height/2, -200);
  rotateX(aX);                           // rotazione dell'ambiente grafico lungo l'asse X [tramite mouse]
  rotateY(-aY);                          // il meno server per ovviare al fatto che processing utilizza un sistema di riferimento sinistro
 
  // Setup luci - Ombre
  directionalLight(lightValue, lightValue, lightValue, dirX, 0, dirZ);   // punto luce direzionabile
  ambientLight(ambientLight, ambientLight, ambientLight);                // luce ambientale uniforme
  
  // Disegno robot
  noStroke();                                        // di base non vogliamo visualizzare le linee delle figure
  robots.get(robotIndex).drawRobot();                // disegna il robot selezionato tramite l'indice
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
  
  if (keyCode == ENTER) {
    Robot robot = robots.get(robotIndex);
    int n = robot.table.DoF;
    
    for (int i=0; i<n; i++) {
      robot.qr.set(i, 0.0);
    }
  }
}

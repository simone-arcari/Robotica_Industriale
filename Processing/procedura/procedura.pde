import java.util.ArrayList;

// Parametri vari
int giunto = 1;
float incr = 0.5;
float kp = 0.02;

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


/*
  Rappresenta una coppia di valori interi
*/
class Tupla {
  int val1;
  int val2;
  
  /* Costruttore */
  Tupla(int v1, int v2) {
    val1 = v1;
    val2 = v2;
  }
}


/*
  Rappressenta una tabella di Denavit-Hartenberg dinamica
*/
class DenavitTable {
  int DoF;
  
  ArrayList<Float> theta;    // Vettore dinamico theta[]   [rotazioni lungo Z]
  ArrayList<Float> d;        // Vettore dinamico d[]       [traslazioni lungo Z]
  ArrayList<Float> alpha;    // Vettore dinamico alpha[]   [rotazioni lungo X]
  ArrayList<Float> a;        // Vettore dinamico a[]       [traslazioni lungo X]
  
  ArrayList<Integer> t;      // Vettore dinamico t[]       [indica dove si trovano le varibili q1,q2,...]
  
  

  // Costruttore con parametri per impostare la lunghezza iniziale dei vettori [numero DoF]
  DenavitTable(int n) {
    DoF = n;
    
    // Inizializza gli ArrayList con la lunghezza iniziale
    theta = new ArrayList<Float>(DoF);
    d = new ArrayList<Float>(DoF);
    alpha = new ArrayList<Float>(DoF);
    a = new ArrayList<Float>(DoF);
    t = new ArrayList<Integer>(DoF);
  }
  
  /*
    Aggiorna i valori q1,q2,... della tabella
  */
  void update(ArrayList<Float> q) {
    for(int i=0; i<DoF; i++) {
      switch (t.get(i)) {
        
        case 0:
          theta.add(i, q.get(i));
          break;
          
        case 1:
          d.add(i, q.get(i));
          break;
          
        case 2:
          alpha.add(i, q.get(i));
          break;
          
        case 3:
          a.add(i, q.get(i));
          break;
      }
    }
  }
}


/*
  Rappressenta un robot qualsiasi
*/
class Robot {
  int robotColor;
  DenavitTable table;
  ArrayList<Float> q;    // Vettore dinamico q[]
  ArrayList<Float> qr;    // Vettore dinamico qr[] [valori per implemetare legge di controllo]
  
  
  // Costruttore
  Robot(DenavitTable inputTable, int inputColor) {
    table = inputTable;
    robotColor = inputColor;
    q = new ArrayList<Float>(table.DoF);
    qr = new ArrayList<Float>(table.DoF);
  }
  
  /*
    Movimenta il robot secondo unalegge di controllo proporzionale
  */
  void move() {
    int n = table.DoF;
    float oldValue;
    float newValue;
    
    for(int i=0; i<n; i++) {
      oldValue = q.get(i);
      newValue = oldValue - kp*(oldValue-qr.get(i));  //legge di controllo proporzionale
      q.set(i, newValue);    
    }
  }
  
  
  /*
    Disegna il robot sulla base della tabella di Denavit-Hartenberg fornita
  */
  void drawRobot() {
    int n = table.DoF;
    
    move();             // imposta i valori delle varibili q1,q2,...
    table.update(q);    // aggiorna i parametri q del robot essendo dinamici
    
    fill(robotColor);
    for(int i=0; i<n; i++) {
      link(table.theta.get(i), table.d.get(i), table.alpha.get(i), table.a.get(i));
    }
  }
}


DenavitTable prova;
Robot provarobot;

ArrayList<DenavitTable> table;    // Vettore dinamico table[]
ArrayList<Robot> robot;           // Vettore dinamico robot[]


 
void setup() {
  size(1386,756,P3D);
  background(backgroundColor);
  
  
  
  
  
  prova = new DenavitTable(2);
  provarobot = new Robot(prova, fillColor);
  
  prova.theta.add(0, 0.0);
  prova.theta.add(1, 0.0);

  prova.d.add(0, 0.0);
  prova.d.add(1, 0.0);

  prova.alpha.add(0, 0.0);
  prova.alpha.add(1, 0.0);

  prova.a.add(0, 100.0);
  prova.a.add(1, 100.0);
  
  prova.t.add(0, 0);
  prova.t.add(1, 0);
  
  
  
  provarobot.q.add(0, 0.0);
  provarobot.q.add(1, 0.0);

  provarobot.qr.add(0, 0.0);
  provarobot.qr.add(1, 0.0);




}
 
 
void draw() {
  background(backgroundColor);
  
  translate(width/2, height/2, -100);
  rotateX(aX);   // rotazione dell'ambiente grafico lungo l'asse X [tramite mouse]
  rotateY(-aY);  // il meno server per ovviare al fatto che processing utilizza un sistema di riferimento sinistro
 
  directionalLight(lightValue, lightValue, lightValue, dirX, 0, dirZ);   // punto luce direzionabile
  ambientLight(ambientLight, ambientLight, ambientLight);                // luce ambientale uniforme
  
  noStroke();  // di base non vogliamo visualizzare le linee delle figure
  
  /*
    DA QUI INIZIA LA ZONA DI CODICE IN CUI POTER DISEGNARE
  */
  provarobot.drawRobot();  
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
  
  if (keyCode == RIGHT) {
    if (giunto == 1) provarobot.qr.set(0, provarobot.qr.get(0)+incr);
    if (giunto == 2) provarobot.qr.set(1, provarobot.qr.get(1)+incr); 
  }
  
  if (keyCode == LEFT) {
    if (giunto == 1) provarobot.qr.set(0, provarobot.qr.get(0)-incr);
    if (giunto == 2) provarobot.qr.set(1, provarobot.qr.get(1)-incr); 
  }
  
}


/*
  Dissegna un link stilizzato di un robot rispettando i parametri geometrici forniti
  
  theta:   angolo rotazione asse Z
  d:       traslazione lungo asse Z
  alpha:   angolo rotazione asse X
  a:       traslazione asse X
*/
void link(float theta, float d, float alpha, float a) {
  rotateZ(theta);
  sphere(linkSize);              // disegna una sfera per simboleggiare un giunto del link
  
  translate(0, 0, -d/2);         // ci spostiamo di metà perchè i box hanno l'origine al loro centro interno
  box(linkSize, linkSize, d);
  
  translate(0, 0, -d/2);         // dal centro del primo box finiamo di traslare fino alla sua estremità
  rotateX(alpha);
  sphere(linkSize);
  
  translate(-a/2, 0, 0);
  box(a, linkSize, linkSize);
  translate(-a/2, 0, 0);
}

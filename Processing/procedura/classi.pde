import java.util.ArrayList;



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
          theta.set(i, q.get(i));
          break;
          
        case 1:
          d.set(i, q.get(i)*kd);
          break;
          
        case 2:
          alpha.set(i, q.get(i));
          break;
          
        case 3:
          a.set(i, q.get(i));
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

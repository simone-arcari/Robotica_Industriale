import java.util.ArrayList;  // per poter utilizzare i vettori dinamici




// Rappresenta un segnale a n componenti nel tempo
class Signal {
  int nSignals;
  ArrayList<ArrayList<Float>> signals;  // Vettore di vettori di float, ogni vettore e un insieme di campioni

  // Costruttore
  Signal(int nSignals, int nSamples) {
    this.nSignals = nSignals;
    signals = new ArrayList<ArrayList<Float>>(nSignals);
    
    for (int i=0; i<nSignals; i++) {
      ArrayList<Float> temp = new ArrayList<Float>(nSamples);
      signals.add(temp);
    }
  }
  
  // Metodi:
  float getAbsolutMax(int signalIndex) {
    float max;
    float current;
    
    // Controlla se l'ArrayList è vuoto
    if (signals.get(signalIndex).isEmpty()) {    
      return 0; 
    }
  
    max = abs(signals.get(signalIndex).get(0));  // Inizializza il valore massimo al primo elemento dell'ArrayList
  
    // Scorre gli elementi e aggiorna il valore massimo se necessario
    for (int i=1; i < signals.get(signalIndex).size(); i++) {
      current = abs(signals.get(signalIndex).get(i));
      if (current > max) {
        max = current;
      }
    }

    return max;  // Restituisci il valore massimo trovato
  }
}




// Rappressenta una tabella di Denavit-Hartenberg dinamica
class DenavitTable {
  int DoF;
  
  ArrayList<Float> theta;    // Vettore dinamico theta[]   [rotazioni lungo Z]
  ArrayList<Float> d;        // Vettore dinamico d[]       [traslazioni lungo Z]
  ArrayList<Float> alpha;    // Vettore dinamico alpha[]   [rotazioni lungo X]
  ArrayList<Float> a;        // Vettore dinamico a[]       [traslazioni lungo X]
  
  ArrayList<Integer> t;      // Vettore dinamico t[]       [indica su qual1 caselle della tabella di Denavit Hartenberg si trovano le varibili q1,q2,...]
  
  
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
  
  // Aggiorna i valori q1,q2,... della tabella
  void update(ArrayList<Float> q) {
    for (int i=0; i<DoF; i++) {
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




// Rappressenta un robot qualsiasi
class Robot {
  int robotColor;
  DenavitTable table;
  ArrayList<Float> q;     // Vettore dinamico q[]
  ArrayList<Float> qr;    // Vettore dinamico qr[] [valori per implemetare legge di controllo]
  Signal qData;           // Contiene un set di dati assunti dai vari q nel tempo in modo da poterli plottare a schermo
  Signal qrData;          // Contiene un set di dati assunti dai vari qr nel tempo in modo da poterli plottare a schermo
  
  // Costruttore
  Robot(DenavitTable inputTable, int inputColor) {
    table = inputTable;
    robotColor = inputColor;
    q = new ArrayList<Float>(table.DoF);
    qr = new ArrayList<Float>(table.DoF);
    
    qData = new Signal(table.DoF, sampleNumber);    // di base ogni oggetto Robot tiene traccia degli ultimi sampleNumber valori assunti dai vari q
    qrData = new Signal(table.DoF, sampleNumber);   // ------------------------------------------------------------------------------------------ qr
  }
  
  // Metodi:
  
  // Movimenta il robot secondo una legge di controllo proporzionale
  void move() {
    int n = table.DoF;
    float oldValue;
    float newValue;
    
    for (int i=0; i<n; i++) {
      oldValue = q.get(i);
      newValue = oldValue - kp*(oldValue-qr.get(i));  //legge di controllo proporzionale
      q.set(i, newValue);    
    }
  }
  
  /* 
    Dissegna un cilindro/cono
      
      sides:  numero facce triangolare che compongono la superficie
      r1:     raggio base inferiore
      r2:     raggio base superiore
      h:      altezza cono
  */
  void drawCylinder(int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;
    
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r1;
      float y = sin( radians( i * angle ) ) * r1;
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r2;
      float y = sin( radians( i * angle ) ) * r2;
      vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw body
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      float x1 = cos( radians( i * angle ) ) * r1;
      float y1 = sin( radians( i * angle ) ) * r1;
      float x2 = cos( radians( i * angle ) ) * r2;
      float y2 = sin( radians( i * angle ) ) * r2;
      vertex( x1, y1, -halfHeight);
      vertex( x2, y2, halfHeight);
    }
    endShape(CLOSE);
  }
  
  /*
    Dissegna i tre assi x y z di riferimento per i link
    
    lineLenght:  lunghezza degli assi diseganti
    sides:       numero facce triangolare che compongono la superficie dei coni (freccia asse)
    r:           raggio base dei coni
    h:           altezza coni
  */
  void drawAxis(float lineLenght, int sides, float r, float h) {
    
    strokeWeight(2); 
    
    /* asse X rosso */
    stroke(255, 0, 0);
    fill(255, 0, 0);
    pushMatrix();
    line(0, 0, 0, lineLenght, 0, 0); 
    translate(lineLenght, 0, 0);
    rotateY(PI/2);
    drawCylinder(sides, r, 0, h);
    popMatrix();
    
    /* asse Y verde */
    stroke(0, 255, 0);
    fill(0, 255, 0);
    pushMatrix();
    line(0, 0, 0, 0, -lineLenght, 0);     // il meno è dovuto al fatto che processing ha un s.r sinistro ma noi usiamo un s.r. destro
    translate(0, -lineLenght, 0);         // ---------------------------------------------------------------------------------------- 
    rotateX(PI/2);
    drawCylinder(sides, r, 0, h);
    popMatrix();
    
    /* asse Z blu */
    stroke(0, 0, 255);
    fill(0, 0, 255);
    pushMatrix();
    line(0, 0, 0, 0, 0, lineLenght); // z = blue
    translate(0, 0, lineLenght);
    drawCylinder(sides, r, 0, h);
    popMatrix();
  }
  
  /*
    Dissegna un link stilizzato di un robot rispettando i parametri geometrici forniti
    
    theta:   angolo rotazione asse Z
    d:       traslazione lungo asse Z
    alpha:   angolo rotazione asse X
    a:       traslazione asse X
  */
  void link(float theta, float d, float alpha, float a) {
    noStroke();
    fill(robotColor);
    
    rotateZ(-theta);              // il meno è dovuto al fatto che processing ha un s.r sinistro ma noi usiamo un s.r. destro 
    sphere(linkSize);             // disegna una sfera per simboleggiare un giunto del link
    
    translate(0, 0, d/2);         // ci spostiamo di metà perchè i box hanno l'origine al loro centro interno
    box(linkSize, linkSize, d);
    
    translate(0, 0, d/2);         // dal centro del primo box finiamo di traslare fino alla sua estremità
    rotateX(-alpha);              // il meno è dovuto al fatto che processing ha un s.r sinistro ma noi usiamo un s.r. destro
    sphere(linkSize);
    
    translate(a/2, 0, 0);
    box(a, linkSize, linkSize);
    translate(a/2, 0, 0);
    
    drawAxis(100,10,5,15);
  }
  
  // Disegna il robot sulla base della tabella di Denavit-Hartenberg fornita
  void drawRobot() {
    int n = table.DoF;
    
    move();             // imposta i valori delle varibili q1,q2,...
    table.update(q);    // aggiorna i parametri q del robot essendo dinamici
    
    fill(robotColor);
    drawAxis(100,10,5,15);    // assi di riferimento 0
    
    for (int i=0; i<n; i++) {
      link(table.theta.get(i), table.d.get(i), table.alpha.get(i), table.a.get(i));
      
      // Memorizza i valori correnti di q e qr
      qData.signals.get(i).add(q.get(i));
      qrData.signals.get(i).add(qr.get(i));
      
      if (qData.signals.get(i).size() > sampleNumber) {
        qData.signals.get(i).remove(0);
        qrData.signals.get(i).remove(0);
      }
    }
  }
}




// Rappressenta uno oscilloscopio
class Oscilloscope {
  float oWidth;
  float oHeight;
  float x0;
  float y0;
  float margin;
  int lineNumber;
  
  
  // Costruttore
  Oscilloscope(float w, float h, float x, float y, float m, int n) {
    oWidth = w;
    oHeight = h;
    x0 = x;
    y0 = y;
    margin = m;
    lineNumber = n;
  }
  
  // Metodi:
  
  void drawOscilloscope() {
    float stepX = oWidth/(lineNumber+1);
    float stepY = oHeight/(lineNumber+1);
    
    noStroke();
    
    
    fill(0);
    rect(x0, y0, oWidth, oHeight);
    fill(255);
    rect(x0+margin, y0+margin, oWidth-2*margin, oHeight-2*margin);
    
    strokeWeight(1);
    stroke(225);   // Imposta il colore della linea grigio chiaro
    for (int i=1; i<=lineNumber; i++) {
      line(x0+stepX*i, y0+margin, x0+stepX*i, y0+oHeight-margin);
      line(x0+margin, y0+stepY*i, x0+oWidth-margin, y0+stepY*i);
    }
  }
  
  void drawSignals(Signal r) {
    int n = r.nSignals;                                    // numero segnali scalari contenuti dal segnale vettoriale
    float step = (oWidth-2*margin)/(sampleNumber-1);
    
    float maxValue = 30;
    float maxRange = oHeight - 2*margin;
    
    float originX = x0 + margin;
    float originY = y0 + oHeight/2;
    
    float firstPointX;
    float secondPointX;
    float firstPointY;
    float secondPointY;
      
    
    for (int i=0; i<n; i++) {
      ArrayList<Float> temp = r.signals.get(i);
      
      maxValue = r.getAbsolutMax(i);
      if (maxValue < 2*PI)  maxValue = 2*PI;
      
      firstPointX = originX;
      firstPointY = originY + (temp.get(0)/maxValue)*maxRange;
      
      for (int j=1; j<temp.size(); j++) {
        secondPointX = originX + step*j;
        secondPointY = originY - (temp.get(j)/maxValue)*(maxRange/2);  // il meno serve perche di base l'asse y è verso il basso
        
        line(firstPointX, firstPointY, secondPointX, secondPointY);
        
        firstPointX = secondPointX;
        firstPointY = secondPointY;
      }
    }
  }
}

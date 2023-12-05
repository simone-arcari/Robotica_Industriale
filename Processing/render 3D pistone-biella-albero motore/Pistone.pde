
PShape pistone;
PShape biella;
PShape piedeBiella;

//Angolo per ruotare l'ambiente grafico
float rotAngleY = 0;
float rotAngleX = 0;

//Coordinate del centro del link 1 del robot che viene spostato col mouse
float xBase;
float yBase;
float zBase;

void setup() {
  size(800, 600, P3D);
  pistone = loadShape("pistone.obj");
  pistone.setFill(color(255, 0, 0)); // Imposta il colore di riempimento in rosso
  //pistone.setStroke(color(0, 0, 0)); // Imposta il colore dei bordi in nero
  //pistone.setStrokeWeight(1.5);      // Imposta lo spessore dei bordi
  
  biella = loadShape("biella.obj");
  biella.setFill(color(0, 255, 0)); // Imposta il colore di riempimento in verde
  
  piedeBiella = loadShape("piedeBiella.obj");
  piedeBiella.setFill(color(0, 0, 255)); // Imposta il colore di riempimento in blu
  
  //Posizione iniziale della base
  xBase = width/2;
  yBase = 2*height/3;
  
  
}

void draw() {
  background(204);
  lights();
  
  if (mousePressed)
  {
    xBase = mouseX;
    yBase = mouseY;
  }

  if (keyPressed)
  {
    //Movimento ambiente grafico (vista camera)
    if (keyCode == DOWN)
    {
      zBase -= 30;
    }
    if (keyCode == UP)
    {
      zBase += 30;
    }
    if (keyCode == LEFT)
    {
      rotAngleY -= 2* PI/180;
    }
    if (keyCode == RIGHT)
    {
      rotAngleY += 2* PI/180;
    }
  }
  
  //Da qui ci occupiamo della grafica 3D

  translate(xBase, yBase, zBase);

  rotateY(rotAngleY);
  rotateX(rotAngleX);
  
  rotateZ(PI);
  
  shape(pistone, 0, 0);
  translate(-1,-108,27);
  shape(biella, 0, 0);
  translate(0,-32.5,0);
  shape(piedeBiella, 0, 0);
  
}

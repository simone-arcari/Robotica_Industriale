import processing.data.*;


int table_number = 11;  // numero di robot mappati nel programma correntemente (per ogni robot aggiunto aggiornare valore qui)
String[] names = {"planare2DoF", "planare3DoF", "cartesiano", "cilindrico", "scara", "sfericoTipo1", "sfericoStanford", "antropomorfo", "polsoSferico", "puma", "stanford"};


Table planare2DoF = new Table();
Table planare3DoF = new Table();
Table cartesiano = new Table();
Table cilindrico = new Table();
Table scara = new Table();
Table sfericoTipo1 = new Table();
Table sfericoStanford = new Table();
Table antropomorfo = new Table();
Table polsoSferico = new Table();
Table puma = new Table();
Table stanford = new Table();




ArrayList<Table> makeTables() {
  TableRow row;
  ArrayList<Table> tables = new ArrayList<Table>(table_number);
  
  /**** Planare 2DoF ****/
  planare2DoF.addColumn("theta");
  planare2DoF.addColumn("d");
  planare2DoF.addColumn("alpha");
  planare2DoF.addColumn("a");
  
  row = planare2DoF.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 200);
  
  row = planare2DoF.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 200);
  
  tables.add(planare2DoF);
  
  
  
  /**** Planare 3DoF ****/
  planare3DoF.addColumn("theta");
  planare3DoF.addColumn("d");
  planare3DoF.addColumn("alpha");
  planare3DoF.addColumn("a");
  
  row = planare3DoF.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 200);
  
  row = planare3DoF.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 200);
  
  row = planare3DoF.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 200);
  
  tables.add(planare3DoF);
  
  
  
  /**** Cartesiano ****/
  cartesiano.addColumn("theta");
  cartesiano.addColumn("d");
  cartesiano.addColumn("alpha");
  cartesiano.addColumn("a");
  
  row = cartesiano.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = cartesiano.addRow();
  row.setFloat("theta", -PI/2);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = cartesiano.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(cartesiano);
  
  
  
  /**** Cilindrico ****/
  cilindrico.addColumn("theta");
  cilindrico.addColumn("d");
  cilindrico.addColumn("alpha");
  cilindrico.addColumn("a");
  
  row = cilindrico.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  row = cilindrico.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = cilindrico.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(cilindrico);
  
  
  
  /**** Scara ****/
  scara.addColumn("theta");
  scara.addColumn("d");
  scara.addColumn("alpha");
  scara.addColumn("a");
  
  row = scara.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", 0);
  row.setFloat("a", 100);
  
  row = scara.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha",0);
  row.setFloat("a", 100);
  
  row = scara.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(scara);
  
  
  
  /**** Sferico Tipo 1 ****/
  sfericoTipo1.addColumn("theta");
  sfericoTipo1.addColumn("d");
  sfericoTipo1.addColumn("alpha");
  sfericoTipo1.addColumn("a");
  
  row = sfericoTipo1.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = sfericoTipo1.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 100);
  
  row = sfericoTipo1.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(sfericoTipo1);
  
  
  
  /**** Sferico di Stanford ****/
  sfericoStanford.addColumn("theta");
  sfericoStanford.addColumn("d");
  sfericoStanford.addColumn("alpha");
  sfericoStanford.addColumn("a");
  
  row = sfericoStanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = sfericoStanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 150);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = sfericoStanford.addRow();
  row.setFloat("theta", 0);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(sfericoStanford);
  
  
  
  /**** Antropomorfo ****/
  antropomorfo.addColumn("theta");
  antropomorfo.addColumn("d");
  antropomorfo.addColumn("alpha");
  antropomorfo.addColumn("a");
  
  row = antropomorfo.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = antropomorfo.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 100);
  
  row = antropomorfo.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 100);
  
  tables.add(antropomorfo);
  
  
  
  /**** Polso Sferico ****/
  polsoSferico.addColumn("theta");
  polsoSferico.addColumn("d");
  polsoSferico.addColumn("alpha");
  polsoSferico.addColumn("a");
  
  row = polsoSferico.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = polsoSferico.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = polsoSferico.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 100);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(polsoSferico);
  
  
  
  /**** Puma ****/
  puma.addColumn("theta");
  puma.addColumn("d");
  puma.addColumn("alpha");
  puma.addColumn("a");
  
  row = puma.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = puma.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", 0);
  row.setFloat("a", 100);
  
  row = puma.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = puma.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 150);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = puma.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = puma.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 100);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(puma);
  
  
  
  /**** Stanford ****/
  stanford.addColumn("theta");
  stanford.addColumn("d");
  stanford.addColumn("alpha");
  stanford.addColumn("a");
  
  row = stanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 200);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = stanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 150);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = stanford.addRow();
  row.setFloat("theta", -PI/2);
  row.setFloat("d", Float.NaN);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  row = stanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", -PI/2);
  row.setFloat("a", 0);
  
  row = stanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 0);
  row.setFloat("alpha", PI/2);
  row.setFloat("a", 0);
  
  row = stanford.addRow();
  row.setFloat("theta", Float.NaN);
  row.setFloat("d", 150);
  row.setFloat("alpha", 0);
  row.setFloat("a", 0);
  
  tables.add(stanford);
  
  
  return tables;
}



Robot makeRobot(Table table) {
  int rowNumber = table.getRowCount();  
  DenavitTable denavitTable = new DenavitTable(rowNumber);
  Robot robot = new Robot(denavitTable, fillColor);
  
  for (int i=0; i<rowNumber; i++) {
    float v1 = table.getFloat(i, "theta");
    float v2 = table.getFloat(i, "d");
    float v3 = table.getFloat(i, "alpha");
    float v4 = table.getFloat(i, "a");
    
    
    if (Float.isNaN(v1)) {
      denavitTable.theta.add(i, 0.0);
      denavitTable.t.add(i, 0);
    } else {
      denavitTable.theta.add(i, v1);
    }
    
    if (Float.isNaN(v2)) {
      denavitTable.d.add(i, 0.0);
      denavitTable.t.add(i, 1);
    } else {
      denavitTable.d.add(i, v2);
    }
    
    if (Float.isNaN(v3)) {
      denavitTable.alpha.add(i, 0.0);
      denavitTable.t.add(i, 2);
    } else {
      denavitTable.alpha.add(i, v3);
    }
    
    if (Float.isNaN(v4)) {
      denavitTable.a.add(i, 0.0);
      denavitTable.t.add(i, 3);
    } else {
      denavitTable.a.add(i, v4);
    }
    
    // Imposto i valori iniziali
    robot.q.add(i, 0.0);
    robot.qr.add(i, 0.0);
    
    // Memorizza i valori correnti di q e qr in modo che l'oscilloscopio abbia almeno un dato iniziale per plottare senza errori
    robot.qData.signals.get(i).add(0.0);
    robot.qrData.signals.get(i).add(0.0);
  }
  
  return robot;
}


ArrayList<Robot> makeRobots(ArrayList<Table> tables) {
  ArrayList<Robot> robo = new ArrayList<Robot>(table_number);
  
  for(int i=0; i<table_number; i++) {
    robo.add(makeRobot(tables.get(i)));
  }
  
  return robo;
}

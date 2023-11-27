Table tabella;

void setup() {
  // Sostituisci con il percorso reale del tuo file CSV
  String percorsoFile = "Untitled";
  
  // Carica la tabella dal file CSV
  tabella = loadTable(percorsoFile, "csv", "header");
  
  // Stampa i dati della tabella
  stampaDatiTabella();
}

// Funzione per stampare i dati della tabella
void stampaDatiTabella() {
  // Stampa l'intestazione (se presente)
  String[] intestazione = tabella.getColumnTitles();
  if (intestazione.length > 0) {
    printArray(intestazione);
  }

  // Stampa i dati
  for (TableRow riga : tabella.rows()) {
    printArray(riga.getStringArray());
  }
}

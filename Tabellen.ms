Measure = 
DATATABLE("Dummy", STRING, {{"x"}})

// ---------------------------------------------------------------------
// Dokumentation
// Tabelle:    Measure
// Typ:        Berechnete Tabelle
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Strukturierung aller DAX-Maßzahlen in einer zentralen Tabelle
// Beschreibung:
//   - Diese Hilfstabelle enthält eine Dummy-Zeile, um die Erstellung
//     einer dedizierten Measure-Tabelle zu ermöglichen
//   - Dient ausschließlich der logischen Gliederung, nicht zur Analyse
//   - Alle Measures des Projekts werden hier gespeichert
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Halte es einfach und praktisch
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------


dim_Datum = 
CALENDAR(DATE(2022,1,1), DATE(2030,12,31))

// ---------------------------------------------------------------------
// Dokumentation
// Tabelle:    dim_Datum
// Typ:        Dimensionstabelle (Datum)
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Einheitliche Zeitdimension für Zeitreihenanalyse aller Tickets
// Beschreibung:
//   - Erstellt eine vollständige Datumstabelle von 2022 bis 2030
//   - Wird verknüpft mit "Erstellt am" aus der Faktentabelle "Tickets_gesamt"
//   - Ermöglicht Monats-, Quartals- und Jahresanalysen
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Halte es einfach und praktisch
// ---------------------------------------------------------------------


dim_Kategorie = 
DISTINCT(
    SELECTCOLUMNS('fact_Tickets_gesamt', "Kategorie", 'fact_Tickets_gesamt'[Kategorie])
)

// ---------------------------------------------------------------------
// Dokumentation
// Tabelle:    dim_Kategorie
// Typ:        Dimensionstabelle
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Kategoriedimension für Gruppierungen und Filterungen von Tickets
// Beschreibung:
//   - Extrahiert eindeutige Kategorien aus "Tickets_gesamt"
//   - Unterstützt Analysen nach Servicetypen oder Vorfallarten
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
// ---------------------------------------------------------------------


dim_Referat = 
DISTINCT(
    SELECTCOLUMNS('fact_Tickets_gesamt', "Referat", 'fact_Tickets_gesamt'[Sachgebiet])
)

// ---------------------------------------------------------------------
// Dokumentation
// Tabelle:    dim_Referat
// Typ:        Dimensionstabelle
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Strukturierung der Analyse nach zuständigen Referaten / SGLs
// Beschreibung:
//   - Listet alle in "Tickets_gesamt" vorkommenden Sachbearbeitergruppen
//   - Dient als Gruppierungs- und Filterdimension in Visualisierungen
//   - Grundlage für die Ampelsteuerung auf Referatsebene
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------


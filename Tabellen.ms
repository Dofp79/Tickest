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
// Projekt:    TicketsNachReferate_1.0.0
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

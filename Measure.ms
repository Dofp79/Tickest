Abgeschlossene_Tickets = 
CALCULATE(
    [Anzahl_Tickets],
    'fact_Tickets_gesamt'[Status] = "Geschlossen"
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Abgeschlossene_Tickets
// Typ:        Measure (Zählmaß)
// Tabelle:    Measure
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Zählt alle Tickets mit Status "Geschlossen"
// Beschreibung:
//   - Filtert alle Tickets mit dem Status "Geschlossen" aus der Faktentabelle
//   - Basis für Abschlussquoten, Performancekennzahlen und Reporting
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
// ---------------------------------------------------------------------

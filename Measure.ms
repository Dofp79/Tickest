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


Abschlussquote_Referat_Prozent = 
DIVIDE(
    [Abgeschlossene_Tickets],
    [Anzahl_Tickets],
    0
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Abschlussquote_Referat_Prozent
// Typ:        Measure (Verhältnis / KPI)
// Tabelle:    Measure
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Anteil der geschlossenen Tickets pro Referat in Prozent
// Beschreibung:
//   - Teilt geschlossene Tickets durch alle Tickets pro Referat
//   - Wird als prozentuale KPI visualisiert (mit %-Formatierung)
//   - Dient der Vergleichbarkeit von Leistungsfähigkeit je Gruppe
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Arbeite iterativ mit Feedback
//   - Denk und arbeite ganzheitlich
// ---------------------------------------------------------------------


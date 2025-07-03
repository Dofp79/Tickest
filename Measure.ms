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


Ampelstatus = 
SWITCH(TRUE(),
    [Offene_Ticketlast] < 0.8, "Grün",
    [Offene_Ticketlast] < 1.2, "Gelb",
    "Rot"
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Ampelstatus
// Typ:        Measure
// Tabelle:    Measure
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Visuelle Einordnung der offenen Ticketlast in Ampelkategorien
// Beschreibung:
//   - Bewertet die relative Ticketlast anhand der KPI "Offene_Ticketlast"
//   - Teilt Werte in Kategorien "Grün", "Gelb" und "Rot"
//   - Unterstützt gezielte Steuerung und Alerts nach Belastung
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
//   - Arbeite iterativ mit Feedback
//   - Denk und arbeite ganzheitlich
// ---------------------------------------------------------------------


Anzahl_Tickets = 
COUNTROWS('fact_Tickets_gesamt')

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Anzahl_Tickets
// Typ:        Measure
// Tabelle:    Measure
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Ermittlung der Gesamtanzahl aller Tickets (Incidents & Aufträge)
// Beschreibung:
//   - Zählt alle Zeilen in der kombinierten Tabelle "Tickets_gesamt"
//   - Grundlage für alle Folgeanalysen wie Verteilung, Trends oder Status
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Beginne dort, wo du stehst
//   - Halte es einfach und praktisch
// ---------------------------------------------------------------------


Durchschnitt_Tickets_pro_Tag = 
DIVIDE(
    [Anzahl_Tickets],
    DISTINCTCOUNT('fact_Tickets_gesamt'[Erstellt am])
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Durchschnitt_Tickets_pro_Tag
// Typ:        Measure
// Tabelle:    Measure
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Durchschnittliche tägliche Ticketanzahl
// Beschreibung:
//   - Nutzt die Anzahl eindeutiger Tage aus "Erstellt am"
//   - Division mit Fehlervermeidung via DIVIDE()
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Halte es einfach und praktisch
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------


Offene_Ticketlast = 
DIVIDE(
    [Offene_Tickets],
    [Verfügbare_Kapazität_Tage], 
    0
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Offene_Ticketlast
// Typ:        Measure
// Tabelle:    Measure
// Projekt:    Tickest
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   0.07.2025
// Zweck:      Verhältnis offener Tickets zur verfügbaren Bearbeitungskapazität
// Beschreibung:
//   - Misst die relative Belastung je Referat oder Sachbearbeitergruppe
//   - Wird als KPI zur Ampelsteuerung (Grün, Gelb, Rot) verwendet
//   - Nutzt DIVIDE mit Fehlervermeidung (Division durch 0 ergibt 0)
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Arbeite iterativ mit Feedback
//   - Denk und arbeite ganzheitlich
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------




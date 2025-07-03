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


dim_Status = 
DISTINCT(
    SELECTCOLUMNS('fact_Tickets_gesamt', "Status", 'fact_Tickets_gesamt'[Status])
)

// ---------------------------------------------------------------------
// Dokumentation
// Tabelle:    dim_Status
// Typ:        Dimensionstabelle
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Bereitstellung einer sauberen Statusdimension für Ticketanalysen
// Beschreibung:
//   - Extrahiert alle eindeutigen Statuswerte aus der Faktentabelle "Tickets_gesamt"
//   - Ermöglicht Gruppierung, Segmentierung und Filterung nach Status
//   - Basis für saubere Modellierung (Star Schema)
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Optimiere und automatisiere


fact_Tickets_gesamt = 
UNION(
    SELECTCOLUMNS(
        fact_Incidents,
        "aktueller_SB", [aktueller SB],
        "Erstellt am", [Erstellt am],
        "Kategorie", [Kategorie],
        "Status", [Status],
        "Tickettyp", "Incident",
        "Sachgebiet", [akt. Sachgeb.]
    ),
    SELECTCOLUMNS(
        fact_Auftraege,
        "aktueller_SB", [aktueller SB],
        "Erstellt am", [Erstellt am],
        "Kategorie", [Kategorie],
        "Status", [Status],
        "Tickettyp", "Auftrag",
        "Sachgebiet", [akt. Sachgeb.]
    )
)
// ---------------------------------------------------------------------
// Beziehung:   fact_Tickets_gesamt[aktueller_SB] → dim_Referat[Referat]
// Typ:         Viele-zu-Eins (n:1)
// Richtung:    Einfach (von dim_Referat zu fact_Tickets_gesamt)
// Projekt:     TicketsNachReferate_1.0.0
// Autor:       Doniman Francisco Peña Parra
// Erstellt:    02.07.2025
// Zweck:       Verknüpfung der Tickets mit Referatsgruppen für Gruppierung & Analyse
// Beschreibung:
//   - "aktueller_SB" enthält in der Faktentabelle die Sachbearbeiter-Zuordnung
//   - "dim_Referat" liefert dazu eine eindeutige Liste als Gruppierungsdimension
//   - Vermeidet Redundanzen, vereinfacht Filterlogik im Modell
// Datenschutz: Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Halte es einfach und praktisch
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------

// ---------------------------------------------------------------------
// Beziehung:   fact_Tickets_gesamt[Status] → dim_Status[Status]
// Typ:         Viele-zu-Eins (n:1)
// Richtung:    Einfach (von dim_Status zu fact_Tickets_gesamt)
// Projekt:     TicketsNachReferate_1.0.0
// Autor:       Doniman Francisco Peña Parra
// Erstellt:    02.07.2025
// Zweck:       Filterung und Gruppierung von Tickets nach Statuswerten
// Beschreibung:
//   - Verknüpft jeden Ticket-Status mit einem eindeutigen Eintrag in der Status-Dimension
//   - Grundlage für Segmentierungen, Auswertungen, Drilldowns und Formatierungen
// Datenschutz: Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Halte es einfach und praktisch
//   - Denk und arbeite ganzheitlich
// ---------------------------------------------------------------------

// ---------------------------------------------------------------------
// Beziehung:   fact_Tickets_gesamt[Kategorie] → dim_Kategorie[Kategorie]
// Typ:         Viele-zu-Eins (n:1)
// Richtung:    Einfach (von dim_Kategorie zu fact_Tickets_gesamt)
// Projekt:     TicketsNachReferate_1.0.0
// Autor:       Doniman Francisco Peña Parra
// Erstellt:    02.07.2025
// Zweck:       Kategorisierung und Filterung von Tickets nach Thema/Funktion
// Beschreibung:
//   - Ermöglicht die Gruppierung und Visualisierung nach Auftrags- oder Störfalltypen
//   - Unterstützt Filterung, KPI-Vergleiche und Dashboards nach Kategorie
// Datenschutz: Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Arbeite iterativ mit Feedback
// ---------------------------------------------------------------------

// ---------------------------------------------------------------------
// Beziehung:   fact_Tickets_gesamt[aktueller_SB] → dim_Referat[Referat]
// Typ:         Viele-zu-Eins (n:1)
// Richtung:    Einfach (von dim_Referat zu fact_Tickets_gesamt)
// Projekt:     TicketsNachReferate_1.0.0
// Autor:       Doniman Francisco Peña Parra
// Erstellt:    02.07.2025
// Zweck:       Verknüpfung der Tickets mit Referatsgruppen für Gruppierung & Analyse
// Beschreibung:
//   - "aktueller_SB" enthält in der Faktentabelle die Sachbearbeiter-Zuordnung
//   - "dim_Referat" liefert dazu eine eindeutige Liste als Gruppierungsdimension
// Datenschutz: Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Halte es einfach und praktisch
// ---------------------------------------------------------------------

// ---------------------------------------------------------------------
// Beziehung:   fact_Tickets_gesamt[Erstellt am] → dim_Datum[Date]
// Typ:         Viele-zu-Eins (n:1)
// Richtung:    Einfach (von dim_Datum zu fact_Tickets_gesamt)
// Projekt:     TicketsNachReferate_1.0.0
// Autor:       Doniman Francisco Peña Parra
// Erstellt:    02.07.2025
// Zweck:       Zeitbasierte Analyse und Filterung von Tickets
// Beschreibung:
//   - Verbindet jedes Ticket mit einem Eintrag im Datumskalender
//   - Ermöglicht Zeitachsen, Monats-/Quartalsberichte und Zeitvergleiche
// Datenschutz: Keine personenbezogenen Daten enthalten
// ITIL 4 Prinzipien:
//   - Arbeite iterativ mit Feedback
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------








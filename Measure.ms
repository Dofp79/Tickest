Zeitraum = 
VAR Von = MIN('dim_Datum'[Date])
VAR Bis = MAX('dim_Datum'[Date])
RETURN
    "Datenzeitraum: " &
    FORMAT(Von, "dd.mm.yyyy") &
    " bis " &
    FORMAT(Bis, "dd.mm.yyyy")
// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Zeitraum_Text
// Typ:        Text-Maßzahl (für Anzeige)
// Tabelle:    Measure
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:
//   - Zeigt den ausgewählten Analysezeitraum als lesbaren Text
//   - Unterstützt Transparenz in Berichten
// Beschreibung:
//   - Nutzt MIN und MAX auf dim_Datum[Date] basierend auf Filterkontext
//   - Format: „dd.mm.yyyy bis dd.mm.yyyy“
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 – Prinzipien:
//   - Fördere Transparenz
//   - Halte es einfach und praktisch
// ---------------------------------------------------------------------


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
// Projekt:    Tickets
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
// Projekt:    Tickets
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
// Projekt:    Tickets
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
// Projekt:    Tickets
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
// Projekt:    Tickets
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
// Projekt:    Tickets
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


Offene_Tickets = 
CALCULATE(
    COUNTROWS('fact_Tickets_gesamt'),
    'fact_Tickets_gesamt'[Status] IN { "Offen", "In Bearbeitung" }
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Offene_Tickets
// Typ:        Measure
// Tabelle:    Measure
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   03.07.2025
// Zweck:      Berechnung der offenen Tickets über alle Referate hinweg
// Beschreibung:
//   - Filtert Tickets, deren Status "Offen" oder "In Bearbeitung" ist
//   - Ermöglicht Monitoring der aktiven Tickets im Backlog
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Optimiere und automatisiere
// ---------------------------------------------------------------------


Verfügbare_Kapazität_Tage = 
AVERAGEX(
    VALUES('fact_Tickets_gesamt'[aktueller_SB]),
    CALCULATE(
        COUNTROWS('fact_Tickets_gesamt'),
        DATESINPERIOD(
            'fact_Tickets_gesamt'[Erstellt am],
            MAX('fact_Tickets_gesamt'[Erstellt am]),
            -30,
            DAY
        )
    ) / 30
)

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Verfügbare_Kapazität_Tage
// Typ:        Measure (historisch geschätzt)
// Tabelle:    Measure
// Projekt:    Tickets
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:      Automatische Schätzung der täglichen Bearbeitungskapazität je Referat
// Beschreibung:
//   - Nutzt vergangene 30 Tage Ticketdaten zur Berechnung des Durchschnitts
//   - Kein manuelles Eingreifen durch Referate oder Admin erforderlich
//   - Basiert auf stabiler Organisationsstruktur mit konstanter Ticketverteilung
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 - Prinzipien:
//   - Fokussiere dich auf den Wert 
//   - Fördere Transparenz



Zeitraum_Alle_Tickets = 
VAR Von_Incidents = CALCULATE(MIN('fact_Incidents'[Erstellt am]), ALL('fact_Incidents'))
VAR Bis_Incidents = CALCULATE(MAX('fact_Incidents'[Erstellt am]), ALL('fact_Incidents'))
VAR Von_Auftraege = CALCULATE(MIN('fact_Auftraege'[Erstellt am]), ALL('fact_Auftraege'))
VAR Bis_Auftraege = CALCULATE(MAX('fact_Auftraege'[Erstellt am]), ALL('fact_Auftraege'))

VAR Von_Gesamt = MIN(Von_Incidents, Von_Auftraege)
VAR Bis_Gesamt = MAX(Bis_Incidents, Bis_Auftraege)

RETURN
    "Gesamter Zeitraum der Datensätze: " &
    FORMAT(Von_Gesamt, "dd.mm.yyyy") &
    " bis " &
    FORMAT(Bis_Gesamt, "dd.mm.yyyy")

// ---------------------------------------------------------------------
// Dokumentation
// Measure:    Zeitraum_Alle_Tickets
// Typ:        Text-Maßzahl (für Berichtsmetadaten)
// Tabelle:    Measure
// Projekt:    TicketsNachReferate_1.0.0
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   02.07.2025
// Zweck:
//   - Kombinierte Darstellung des Gesamtzeitraums aus zwei Faktentabellen
// Beschreibung:
//   - Berechnet das jeweils kleinste und größte Datum in beiden Tabellen
//   - Gibt eine konsolidierte Zeitspanne zurück
//   - Ideal für Kartenvisualisierung und Kopfzeile in Berichten
// Datenschutz:
//   - Keine personenbezogenen Daten enthalten
// ITIL 4 – Prinzipien:
//   - Fördere Transparenz
//   - Denk und arbeite ganzheitlich
// ---------------------------------------------------------------------








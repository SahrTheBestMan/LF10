Projektantrag für das FISI Projekt in Lernfeld 10
Gruppe 1 - Vahan Telunz & Sahr Qasm
1. Projektbezeichnung
Automatisierte Speicherbereinigung auf Arbeitsplatzrechnern zur Optimierung der Systemleistung und Entlastung der Benutzer
1.1 Kurzform der Aufgabenstellung
Das gewählte Lernfeld 10 Szenario A ist ein freies Projekt-Auswahl im Themenbereich „Serverdienste bereitstellen und Administrationsaufgaben automatisieren“. Im Rahmen unseres Projekts sollen VMs automatisch bereinigt und nicht mehr benötigte alte Log-Dateien gelöscht werden.
1.2 Ist-Analyse
Derzeit haben viele VMs wenig freien Speicherplatz. Benutzer müssen regelmäßig manuell Dateien löschen, um Speicher freizugeben. Dieser Vorgang ist zeitaufwendig und unterbricht die Arbeit der Benutzer häufig. Zudem führt das auch dazu, dass die Systeme langsamer werden und teilweise nicht mehr voll funktionsfähig sind. 
Das Problem besteht seit längerer Zeit.
2. Zielsetzung / Entwicklung Soll-Konzept
2.1 Was soll am Ende des Projekts erreicht sein?
Am Ende des Projekts sollen die VMs automatisch bereinigt werden. Über ein Skript kann erkannt werden, ob der Speicher z.B. zu 90% voll ist, falls das zutrifft, können alte Log Dateien automatisch gelöscht werden. Falls keine Log Datein vorhanden sind, die älter als vier Wochen sind, dann wird die IT-Abteilung per E-Mail automatisch benachrichtigt. 
Durch Behebung des Problems verbessert sich die Performance der VMs, die Benutzer werden entlastet und Ausfälle durch genug vorhandenen Speicher werden vermieden. Langfristig entsteht so eine stabile und effiziente Arbeitsumgebung. 
Eine andere Möglichkeit wäre, über Azure die VM Speicher zu erweitern, das würde aber mehr kosten und daher macht eine Bereinigung sinnvoller.
2.2 Welche Anforderungen müssen erfüllt sein?
Automatische Ausführung des Skripts.
Löschung unnötiger Dateien wie z.B. Log Dateien.
Automatische Speicherplatzüberwachung und Benachrichtigung.
Einhaltung von vordefinierten Speicherbereinigungsregeln. 
Einfache Erweiterbarkeit.
Sicherstellung, dass keine systemkritischen Dateien gelöscht werden.
2.3 Welche Einschränkungen müssen berücksichtigt werden?
Es dürfen ausschließlich nicht kritische Dateien gelöscht werden
Das Projekt beschränkt sich auf VMs innerhalb der Firma
3. Projektplanung
Es handelt sich um ein In-House Projekt, das in enger Abstimmung mit der IT-Fachabteilung umgesetzt wird. Iterative Vorgehensweise und Tests auf Referenzsystemen sind vorgesehen.

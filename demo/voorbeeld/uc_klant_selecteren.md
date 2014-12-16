# Use Case Klant selecteren

## Situering

* **Niveau**: subfunctie
* **Primaire actor**: hotelmedewerker verantwoordelijk voor reservaties
* **Precondities**: BINFSea Booking is gestart
* **Postcondities**: Er is een klant geselecteerd

## Normaal verloop

1. De hotelmedewerker voert ofwel een klantnummer ofwel (een deel van) een naam (van een
persoon of bedrijf) in.
2. Het systeem zoekt alle klanten die voldoen aan de hierboven ingegeven zoekcriteria en geeft
een lijst van de gevonden klanten het klantnummer en de naam.
3. De hotelmedewerker selecteert een klant uit de lijst.
4. Het systeem geeft een detail van alle gegevens in verband met de klant die in het systeem
zitten.
5. De hotelmedewerker bevestigt de selectie.

## Alternatief verloop

* **3a**: Het moet mogelijk zijn terug te keren naar stap 1 om een nieuwe zoekopdracht op te geven
* **5a**: Het moet mogelijk zijn terug te keren naar stap 3 om een nieuwe klant te selecteren.
* **1-4**: Voor definitieve selectie moet het steeds mogelijk zijn het selectieproces af te sluiten.

## Andere vereisten

Klantgegevens bij te houden in het systeem:

* Klant ID
* Aanspreekvorm (Bijv. Mr., Mevr., Mme., Mrs., Ms., enz.)
* Voor- en familienaam
* Naam bedrijf/organisatie, ondernemingsnummer (indien van toepassing)
* Adres (hou rekening met klanten in het buitenland)
* Telefoon-, fax- en mobiel nummer (internationaal formaat, bijv. +32 9 243 87 87)
* E-postadres
* Rekeningnummer, IBAN/BIC-code
* ISO-639 taalcode
* Notities (specifieke opmerkingen ivm de klant)

## Open issues

* Als de klant niet gevonden is in de lijst, zou er een nieuwe klant aangemaakt moeten
worden.
* Als de klant wel gevonden is, maar de adres- of andere gegevens zijn niet (meer) correct,
dan zou het moeten mogelijk zijn de klantgegevens aan te passen.

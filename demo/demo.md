---
title: 'Scenario Git demo'
author: Bert Van Vreckem
...

* Twee gebruikers: `bertvv` en `lenevv`
* Hebben elk een terminal open

# Git repo aanmaken

* `bertvv` maakt een repo aan op Github, bv. `git@github.com:HoGentTIN/p02g10.git` incl. README
* `bertvv` en `lenevv` doen `git clone git@github.com:HoGentTIN/p02g10.git`

## Inhoud README

```Markdown
# p02g10

Project en workshops 2 - groep 10
```

# Wijzigingen doorvoeren

## Eerst `bertvv`: groepsleden toevoegen

Nieuwe inhoud `README.md`

```Markdown
| Naam             | Gebruikersnaam |
| :---             | :---           |
| Bert Van Vreckem | `bertvv`       |
| Lene Van Vreckem | `lenevv`       |
```

```ShellSession
$ git add .
$ git commit -m "Groepsleden toegevoegd aan README"
$ git push
```

* Laat verschil zien op GitHub
* Toon opeenvolgende commits

## Dan `lenevv`: websites toevoegen

Nieuwe inhoud `README.md`

```Markdown
| Naam             | Gebruikersnaam | Website                   |
| :---             | :---           | :---                      |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |
```

```ShellSession
$ git add .
$ git commit -m "Websites toegevoegd"
$ git push
```

## `bertvv` vergeet te pullen

```ShellSession
$ vi .gitignore
$ git rm .README.md.un~
$ git status
$ git add .
$ git commit -m "Negeer backups"
$ git push
```

Foutboodschap op dit punt: remote weigert wijzigingen te aanvaarden.

* `git pull`
    * Vi open om commit message te geven: Merge branch
* `git status`
* `git log` (`h` shortcut)
    * Revisies gaan even uit elkaar en komen terug samen

# Conflicten

* Zorg dat beide gebruikers up-to-date zijn (dus `git pull`)
* Bekijk de history bij beide gebruikers: identiek!
* Beide gebruikers wijzigen parallel README.md

Lene voegt toe aan `README.md`

```Markdown
# p02g10

Project en workshops 2 - groep 10

# Groepsleden

| Naam             | Gebruikersnaam | Website |
| :---             | :---           | :---    |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |

# Gebruikte tools

* Kanban-bord: https://trello.com/
* Tijdregistratie: https://toggl.com/

```

Bert maakt ook wijzigingen aan `README.md`

```Markdown
# p02g10

Project en workshops 2 - groep 10

# Groepsleden

| Naam             | Gebruikersnaam | Website                   |
| :---             | :---           | :---                      |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |

# Begeleiders

* Irina Malfait (irina.malfait@example.com)
* Stefaan Samyn (stefaan.samyn@example.com)
```

## Bert pusht als eerste, lukt

```ShellSession
$ git add .
$ git commit -m "Begeleiders toegevoegd"
$ git push
```

## Lene pusht later, conflict

```ShellSession
lene@jace $ git add README.md 
lene@jace $ git commit -m "Tools toegevoegd"
[master 7684c26] Tools toegevoegd
 1 file changed, 5 insertions(+)
lene@jace $ git push
To git@github.com:HoGentTIN/p02g10.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'git@github.com:HoGentTIN/p02g10.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
lene@jace $ git pull
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

Inhoud van README.md:

```Markdown
# p02g10

Project en workshops 2 - groep 10

# Groepsleden

| Naam             | Gebruikersnaam | Website                   |
| :---             | :---           | :---                      |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |

<<<<<<< HEAD
# Gebruikte tools

* Kanban-bord: https://trello.com/
* Tijdregistratie: https://toggl.com/

=======
# Begeleiders
>>>>>>> 4ff1588e771287af4f8bac0246a32d6b160a4260

* Irina Malfait (irina.malfait@example.com)
* Stefaan Samyn (stefaan.samyn@example.com)
```

* Conflict aangeduid met `<<<<<<<<`. `========`, `>>>>>>>>`
* Bestand verbeteren, committen en pushen

```ShellSession
lene@jace $ git add README.md
lene@jace $ git commit -m 'Conflict opgelost: tools en begeleiders'
[master 73c057e] Conflict opgelost: tools en begeleiders
lene@jace $ git push
Counting objects: 10, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 718 bytes | 0 bytes/s, done.
Total 6 (delta 2), reused 0 (delta 0)
To git@github.com:HoGentTIN/p02g10.git
   4ff1588..73c057e  master -> master
```

## Bert haalt wijzigingen binnen

```ShellSession
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

nothing to commit, working directory clean
```

Merk op dat dit misleidend is! De branch is **niet** up-to-date.

```ShellSession
$ git pull
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (4/4), done.
Unpacking objects: 100% (6/6), done.
remote: Total 6 (delta 2), reused 6 (delta 2)
From github.com:HoGentTIN/p02g10
   4ff1588..73c057e  master     -> origin/master
Updating 4ff1588..73c057e
Fast-forward
 README.md | 5 +++++
 1 file changed, 5 insertions(+)
$ h
*   73c057e 2014-11-16 Conflict opgelost: tools en begeleiders (HEAD, origin/master, origin/HEAD, mast
|\  
| * 4ff1588 2014-11-16 Begeleiders toegevoegd Bert Van Vreckem, 10 minutes ago
* | 7684c26 2014-11-16 Tools toegevoegd Lene Van Vreckem, 9 minutes ago
|/  
*   d9ab141 2014-11-15 upstream wijzigingen toepassen Bert Van Vreckem, 27 minutes ago
|\  
| * be7ed03 2014-11-15 Websites toegevoegd Lene Van Vreckem, 44 minutes ago
* | 914c94c 2014-11-15 Negeer backups Bert Van Vreckem, 28 minutes ago
|/  
* 5d8b7a6 2014-11-15 Groepsleden toegevoegd aan README Bert Van Vreckem, 48 minutes ago
* fdd6528 2014-11-15 Initial commit Bert Van Vreckem, 2 hours ago
```

## Hoe doe je het best wel?

Vóór commit:

* `git fetch`
* `git rebase origin/master`

## Bert voegt bestand toe

Bert voegt nieuw bestand toe: `use_cases/uc_klant_selecteren.md:`

```Markdown
# Use Case Klant selecteren

# Situering

* **Niveau**: subfunctie
* **Primaire actor**: hotelmedewerker verantwoordelijk voor reservaties
* **Precondities**: BINFSea Booking is gestart
* **Postcondities**: Er is een klant geselecteerd

# Normaal verloop

1. De hotelmedewerker voert ofwel een klantnummer ofwel (een deel van) een naam (van een
persoon of bedrijf) in.
2. Het systeem zoekt alle klanten die voldoen aan de hierboven ingegeven zoekcriteria en geeft
een lijst van de gevonden klanten het klantnummer en de naam.
3. De hotelmedewerker selecteert een klant uit de lijst.
4. Het systeem geeft een detail van alle gegevens in verband met de klant die in het systeem
zitten.
5. De hotelmedewerker bevestigt de selectie.

# Alternatief verloop

* **3a**: Het moet mogelijk zijn terug te keren naar stap 1 om een nieuwe zoekopdracht op te geven
* **5a**: Het moet mogelijk zijn terug te keren naar stap 3 om een nieuwe klant te selecteren.
* **1-4**: Voor definitieve selectie moet het steeds mogelijk zijn het selectieproces af te sluiten.
```

Bert `push`t en Lene `pull`t, dus alle drie de repo's zijn synchroon.

History op dit moment (1e twee lijnen):

```
* a4c2011 2014-11-16 UC Klant Selecteren toegevoegd Bert Van Vreckem, 12 minutes ago
*   73c057e 2014-11-16 Conflict opgelost: tools en begeleiders Lene Van Vreckem, 9 hours ago
```

## Bert voegt sectie "andere vereisten" toe

Inhoud toegevoegd aan `use_cases/uc_klant_selecteren`:

```Markdown
# Andere vereisten
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
```

Achteraf `commit` en `push`.

History op dit moment:

```
* f7a8d07 2014-11-16 UC Klant selecteren: Andere vereisten toegevoegd (HEAD, origin/master, origin/HEAD
* a4c2011 2014-11-16 UC Klant Selecteren toegevoegd Bert Van Vreckem, 12 minutes ago
*   73c057e 2014-11-16 Conflict opgelost: tools en begeleiders Lene Van Vreckem, 9 hours ago
```

## Lene voegt sectie "open issues" toe


Inhoud toegevoegd aan `use_cases/uc_klant_selecteren`:

```Markdown
# Open issues

* Als de klant niet gevonden is in de lijst, zou er een nieuwe klant aangemaakt moeten
worden.
* Als de klant wel gevonden is, maar de adres- of andere gegevens zijn niet (meer) correct,
dan zou het moeten mogelijk zijn de klantgegevens aan te passen.
```

Daarna `commit`, maar `push` wordt (uiteraard) geweigerd.

## Versies samenvoegen

Lene:

```ShellSession
lene@jace $ git fetch
lene@jace $ git rebase origin/master
First, rewinding head to replay your work on top of it...
Applying: UC Klant selecteren: open issues toegevoegd
Using index info to reconstruct a base tree...
M use_cases/uc_klant_selecteren.md
Falling back to patching base and 3-way merge...
Auto-merging use_cases/uc_klant_selecteren.md
CONFLICT (content): Merge conflict in use_cases/uc_klant_selecteren.md
Failed to merge in the changes.
Patch failed at 0001 UC Klant selecteren: open issues toegevoegd
The copy of the patch that failed is found in:
   /home/lene/p02g10/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
```

In `use_cases/uc_klant_selecteren.md` vind je opnieuw markeringen voor merge-conflict. Bestand bewerken en opslaan, daarna:

```ShellSession
lene@jace $ git add use_cases/uc_klant_selecteren.md
lene@jace $ git status
rebase in progress; onto f7a8d07
You are currently rebasing branch 'master' on 'f7a8d07'.
  (all conflicts fixed: run "git rebase --continue")

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

  modified:   use_cases/uc_klant_selecteren.md

lene@jace $ git rebase --continue
Applying: UC Klant selecteren: open issues toegevoegd
lene@hace $ h
* c21260f 2014-11-16 UC Klant selecteren: open issues toegevoegd (HEAD, master) Lene Van Vreckem, 15 m
* f7a8d07 2014-11-16 UC Klant selecteren: Andere vereisten toegevoegd (origin/master, origin/HEAD) Ber
* a4c2011 2014-11-16 UC Klant Selecteren toegevoegd Bert Van Vreckem, 26 minutes ago
[...]
```


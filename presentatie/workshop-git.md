% Git tutorial
% Bert Van Vreckem
% HoGent Vakgroep Informatica, 2014-12-XX

# Preliminaries

## Over multi-tasken

* Technische workshop, pittig tempo
* Workshop volgen en tegelijk ander werk doen zal niet lukken...

## Software

* Git client: [http://git-scm.com/download/](http://git-scm.com/download/)
    * Incl. "Git Bash"
* Evt. GUI: [http://git-scm.com/downloads/guis](http://git-scm.com/downloads/guis)
    * bv. SourceTree of GitHub for Mac/Windows

## CLI vs. GUI

Er bestaan GUI's, waarom CLI?

* éénduidig en compact
* makkelijker reproduceerbaar
* beter zicht op interne werking
* heel goede info-/foutboodschappen

## Enkele instellingen

```
git config --global user.name "Lene Van Vreckem"
git config --global user.email "lene.vanvreckem@gmail.com"
git config --global push.default simple
```

# Git solo

## Initialiseer repository

```bash
$ mkdir my_project
$ cd my_project/
$ git init
Initialized empty Git repository in /home/bert/linux/my_project/.git/
$ git status
On branch master

Initial commit

nothing to commit (create/copy files and use "git add" to track)
```

## Werkomgeving

* Working copy
    * de directorystructuur en bestanden waarin je wijzigingen aanbrengt
* Staging
    * "Tussenstation" tussen *working copy* en *repository*
    * Laat toe wijzigingen selectief te *committen*
* Repository
    * Verzameling van alle commits, branches, tags, ...

## Workflow

![Eenvoudige workflow voor één persoon](img/workflow-solo.png)

---

Bestand(en) aanmaken of wijzigen:

```bash
$ vi README.md
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

  README.md

nothing added to commit but untracked files present (use "git add" to track)
```

---

Bestand naar staging verplaatsen: `git add`

```bash
$ git add README.md
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

  new file:   README.md
```

---

Wijzigingen doorvoeren (*Inchecken*, *committen*): `git commit`

```bash
$ git commit -m "README toegevoegd"
[master (root-commit) aadfd67] README toegevoegd
 1 file changed, 3 insertions(+)
 create mode 100644 README.md
$ git status
On branch master
nothing to commit, working directory clean
```
## Ctrl-Z!

* Je kan (zo goed als) elke stap ongedaan maken!
* Lokale wijzigingen aan `README.md` ongedaan maken:

    ```bash
    git checkout -- README.md
    ```

* `README.md` opnieuw uit `staging` halen :

    ```bash
    git reset HEAD README.md
    ```

* `git status` herinnert telkens aan deze commando's!

# Tips en truuks

## Aanbevelingen

* Zo vaak mogelijk committen (*atomair*)
* Geef goede commit-boodschappen
* `git status` voordat je iets doet
* Lees de foutboodschappen
* Vermijd *artefacten* (automatisch gegenereerde bestanden)
* Vermijd *binaire* bestanden die vaak gewijzigd worden
    * Geen Word-documenten! Gebruik Markdown

## `.gitignore`

* Negeer bepaalde bestanden in de repository, aan de hand van een patroon
* bv. backup-bestanden, "artefacten", ...

```
*~      # Text editor backups (Linux)
*.bak
build/  # directory with compiled files
```

## Wijzigingen bekijken

Wijzigingen van *working copy* t.o.v. *repository*:

```diff
$ git diff
diff --git a/README.md b/README.md
index ea596b8..3d13212 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,5 @@
# README

Dit is mijn eerste Git repository!
+
+Deze lijn is gewijzigd
```

## Historiek

```none
$ git log
commit 97deea303754171c717291387af87e9b891f28fb
Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
Date:   Sat Nov 15 16:50:20 2014 +0100

    Added .gitignore

commit aadfd674f5dec9205fde484a5d921041b256b135
Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
Date:   Sat Nov 15 14:47:46 2014 +0100

    README toegevoegd

$ git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d
    %C(green)%an%C(reset), %C(cyan)%ar"
    --date=short --graph
* 97deea3 2014-11-15 Added .gitignore (HEAD, master) Bert Van Vreckem, 22 minutes ago
* aadfd67 2014-11-15 README toegevoegd Bert Van Vreckem, 2 hours ago
```

# Werken met remotes

## Workflow

![Synchroniseren met een externe repository](img/workflow-remote.png)

## Github

[https://github.com/](https://github.com/)

* Belangrijkste hosting-provider voor Git repositories
* Gratis voor open source
* Ondersteunen Subversion clients (bv. Visual Paradigm diagrammen)

## Bitbucket

[https://bitbucket.org/](https://bitbucket.org/)

* Goed alternatief voor Github
* Ongelimiteerd private repositories tot 5 teamleden = gratis

## Github account

* Maak een account aan (gebruik hogent.be-emailadres)
* Vraag eventueel het "Student Developer Pack" aan
    * [https://education.github.com/pack](https://education.github.com/pack)
    * o.a. gratis 5 private repositories, $100 hosting-pakket op DigitalOcean

## SSH-sleutels aanmaken

Zie [https://help.github.com/articles/generating-ssh-keys/](https://help.github.com/articles/generating-ssh-keys/)

* *SSH-sleutel* is een beveiligde authenticatiemethode zonder wachtwoord
* nieuwe sleutel aanmaken (evt. zonder "pass phrase")
    * In (Git) Bash: ``ssh-keygen -t rsa -C "bert.vanvreckem@hogent.be"``
* Publieke sleutel openen en kopiëren
    * In (Git) Bash: `cat ~/.ssh/id_rsa.pub`
* In Github, klik rechtsboven op het tandwiel
    * Selecteer in het menu links **SSH keys**
    * Klik **Add SSH key**
    * Publieke sleutel plakken in het *Key*-veld
    * Klik **Add key**
* Testen: `ssh -T git@github.com`

---

```
[lene@jace ~]$ ssh-keygen -t rsa -C "lene@example.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/home/lene/.ssh/id_rsa): [ENTER]
Created directory '/home/lene/.ssh'.
Enter passphrase (empty for no passphrase): [ENTER]
Enter same passphrase again: [ENTER]
Your identification has been saved in /home/lene/.ssh/id_rsa.
Your public key has been saved in /home/lene/.ssh/id_rsa.pub.
The key fingerprint is:
e7:fe:2b:ca:09:87:61:26:90:2a:d1:7f:8c:2c:8b:18 lene@example.com
The key's randomart image is:
+--[ RSA 2048]----+
|                 |
| . .             |
|. +              |
| o + o           |
|E . = * S .      |
|oo o = o o       |
|o .   o . .      |
|       + o.      |
|        +..oo.   |
+-----------------+
[lene@jace ~]$ cat .ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKGL1YqIK/67bYib2FaVnRVnlTVJHxUq+DtF3e1aDCZYAWzIYK+MTceW1Qg0fuAlYc5qvUCMmSy9eWgnG8jS8PU7DWgOjIbLtbqTLBDwGEUgMNhRc2wHwYiZqIswe9nr4/zMFW4AVd/GpOXiFjTfXZoLCh2m0+NcB5Z1OoiMv3vti1OsMZJ1ECIDZ5QGkju2bhyZpqsQ7FYUZT3CYkCwsKVVZJUoEU09A5DyhakZJedIMO5Qdlinu45qKjQwJr9t5Dw75pRcHarMHVCQJKwIv3wRzO1PImhk45rjHsBGWYPH4bfistbFbTLrWbdPZYlYrk2hI3z15O4TrGHasBPCMx lene@example.com
```


## Repository aanmaken

Maak op Github een nieuwe repository aan (bv. `my_project`)

* Website wordt: `https://github.com/USER/PROJECT`
* Repo url (https) wordt: `https://github.com/USER/PROJECT.git`
* Repo url (**ssh**) wordt: `git@github.com:USER/PROJECT.git`

## Anderen toegang geven tot je repository

* Klik rechts op **Settings**
* In het menu links, klik op **Collaborators**
* Voeg de gebruikersnamen toe van wie toegang moet krijgen

## Lokale repository synchroniseren

```
$ git remote add origin git@github.com:bertvv/my_project.git
$ git remote -v
 origin git@github.com:bertvv/my_project.git (fetch)
 origin git@github.com:bertvv/my_project.git (push)
$ git push -u origin master
```

* De code staat nu op Github!
* Git push: als argumenten "doel" en "bron" opgeven
    * Optie `-u` zorgt dat dat maar één keer moet

## Externe repository kopiëren

Stel, je wil verder werken aan het project van iemand anders:

```
$ git clone git@github.com:bertvv/my_project.git
Cloning into 'my_project'...
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (6/6), done.
Receiving objects: 100% (9/9), done.
remote: Total 9 (delta 0), reused 9 (delta 0)
Checking connectivity... done.
```

# Werken in team

## Een project opzetten in GitHub

* Eén persoon doet:
    * Aanmaken nieuwe repository
    * Optie voor creëeren README + `.gitignore` aanvinken
    * Teamleden (+ begeleider) toevoegen
* Iedereen doet
    * `git clone git@github.com:USER/PROJECT.git`

---

![Nieuw project aanmaken voor een team](img/new-repo.png)

## Eenvoudige workflow

* Haal laatste revisie binnen: `git pull`
* Maak wijzigingen
* 

% title: Scenario Git demo
% author: Bert Van Vreckem

* Twee gebruikers: `bertvv` en `lenevv`
* Hebben elk een terminal open

## Git repo aanmaken

* `bertvv` maakt een repo aan op Github, bv. `git@github.com:HoGentTIN/p02g10.git` incl. README
* `bertvv` en `lenevv` doen `git clone git@github.com:HoGentTIN/p02g10.git`

### Inhoud README

```Markdown
# p02g10

Project en workshops 2 - groep 10
```

## Wijzigingen doorvoeren

### Eerst `bertvv`: groepsleden toevoegen

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

### Dan `lenevv`: websites toevoegen

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

### `bertvv` vergeet te pullen

```ShellSession
$ vi .gitignore
$ git rm .README.md.un~
$ git status
$ git add .
$ git commit -m "Negeer backups"
$ git push
```

Foutboodschap op dit punt

* `git pull`
    * Vi open om commit message te geven: Merge branch
* `git status`
* `git log` (`h` shortcut)
    * Revisies gaan even uit elkaar en komen terug samen

## Conflicten

* Zorg dat beide gebruikers up-to-date zijn (dus `git pull`)
* Bekijk de history bij beide gebruikers: identiek!
* Beide gebruikers wijzigen parallel README.md

Lene:

```Markdown
# p02g10

Project en workshops 2 - groep 10

## Groepsleden

| Naam             | Gebruikersnaam | Website |
| :---             | :---           | :---    |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |

## Gebruikte tools

* Kanban-bord: https://trello.com/
* Tijdregistratie: https://toggl.com/

```

Bert:

```Markdown
# p02g10

Project en workshops 2 - groep 10

## Groepsleden

| Naam             | Gebruikersnaam | Website                   |
| :---             | :---           | :---                      |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |

## Begeleiders

* Irina Malfait (irina.malfait@hogent.be)
* Stefaan Samyn (stefaan.samyn@hogent.be)
```

### Bert pusht als eerste, lukt

```ShellSession
$ git add .
$ git commit -m "Begeleiders toegevoegd"
$ git push
```

### Lene pusht later, conflict

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

## Groepsleden

| Naam             | Gebruikersnaam | Website                   |
| :---             | :---           | :---                      |
| Bert Van Vreckem | `bertvv`       | https://github.com/bertvv |
| Lene Van Vreckem | `lenevv`       | https://github.com/lenevv |

<<<<<<< HEAD
## Gebruikte tools

* Kanban-bord: https://trello.com/
* Tijdregistratie: https://toggl.com/

=======
## Begeleiders
>>>>>>> 4ff1588e771287af4f8bac0246a32d6b160a4260

* Irina Malfait (irina.malfait@hogent.be)
* Stefaan Samyn (stefaan.samyn@hogent.be)
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

### Bert haalt wijzigingen binnen

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



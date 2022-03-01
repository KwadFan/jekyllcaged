# jekyllcaged

## Standartized Development Root for Mainsail Docs using Jekyll

### Requirements

A proper installation of Docker and Docker Compose according to your System/OS.

### Setup

**Open config in your prefered Text Editor and modify to your needs**
The config file is well documented.

_To prevent Errors with file permissions, you should consider to clone your repo
this repo_

    cd </path/to>/jekyllcage
    git clone https://github.com/mainsail-crew/docs.git

_for example._

_**Note: Use a Texteditor that is capable of using End Of Line Sequence in Unix Format! ( "LF" )
Those are for example: Atom, Sublime, VSCode or Notepad++ **_

---

### Launch our trap, to cage in Jekyll :)

    docker-compose up --remove-orphans

---

**You can talk to Jekyll safely through:**

_Open your favorite Browser and type:_

    http://localhost:4000

for the live rendered preview.

---

**To stop the running container use:**

<kbd>CTRL</kbd> + <kbd>c</kbd>

---

Now go on, do your "effing" Job!

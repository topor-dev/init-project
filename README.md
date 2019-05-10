# init-project

Helps to initialize python project from template.

When running, inserts the project name into the pyproject.toml file, updates the license year.
Copies files to the directory from which it is run.

## Installation

1. Clone or download this repo:
```sh
$ git clone https://github.com/topor-dev/init-project.git
```
2. Update template/* files. Don't forget to replace my name and email with your (pyproject and LICENSE files).
3. Add repo directory into PATH variable or make symlink to init-project.sh in any directory from $PATH. Symlink example:
```sh
$ cd init-project
$ ln -s $PWD/init-project.sh $HOME/.local/bin
```

## Usage

Call script in new project directory:
```sh
$ init-project.sh
```
Then enter project name and accept copying files.

Project name could also be specified as first argument
```sh
$ init-project.sh snake-offline
```
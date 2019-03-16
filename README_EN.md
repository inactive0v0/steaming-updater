# Steaming Updater
An extendable auto-updater script suitable for various Steam game servers. 

## Features
* Automatic update-checking by running SteamCMD, and determining if a restart is needed by reading its output;
* Can be used on servers running GNU Screen and tmux as backend shell.
* Uses modularized design, and is easily extendable by writing `restart` functions for different game servers accordingly (PRs are welcome).

## Currently supported servers
| Server                                                       | Plugin |
| ------------------------------------------------------------ | ------ |
| [Don't Starve Together](https://github.com/inactive-virus/steaming-updater/wiki/Plugin:DSTDS) | dstds  |
| ……                                                           | ……     |

## Usage

First, set up the configuration files by editing `updater.conf`, and `conf` files under `plugins/` directory (Check the [Wiki page](https://github.com/inactive-virus/steaming-updater/wiki) for details);

Then, execute `./steaming_updater.sh <Shell> <Plugin>`

Example: auto-updating a Don't Starve Together server running inside tmux:

```
./steaming_updater.sh tmux dstds
```

If the script executed with no errors, it can be added into `crontab` as a scheduled task.

Example: To execute the auto-updater script every hour, and output logs:

```
0 * * * * ~/steaming_updater/steaming_updater.sh tmux dstds >> ~/steaming_updater/dstds.log 2>&1
```

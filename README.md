[![Unlicense License](https://img.shields.io/github/license/yuri-becker/scoop-auto-update?style=for-the-badge)](https://github.com/yuri-becker/scoop-auto-update/blob/main/LICENSE.md)
[![GitHub Repo stars](https://img.shields.io/github/stars/yuri-becker/scoop-auto-update?style=for-the-badge)](https://github.com/yuri-becker/scoop-auto-update/stargazers)
[![GitHub Repo stars](https://img.shields.io/github/last-commit/yuri-becker/scoop-auto-update?style=for-the-badge)](https://github.com/yuri-becker/scoop-auto-update/commits/main)


<br />
<div align="center">

  <h1 align="center">scoop-auto-update</h1>

  <p align="center">
    Automatically update your <a href="https://scoop.sh/">scoop</a> packages.
    <br />
    <br />
    <a href="https://github.com/yuri-becker/scoop-auto-update/issues">Report a Bug</a>
</div>


## About

This is just a powershell script to automatically update packages installed via <a href="https://scoop.sh/">scoop</a>. It will send notifications whenever packages are updated.

When first executing scoop-auto-update, it automatically creates a daily task.

## Installing

Clone the repo somewhere you want it to stay at and execute the script.
```powershell
git clone https://github.com/yuri-becker/scoop-auto-update.git
cd 
.\scoop-auto-update\scoop-auto-update.ps1
```
Now, a scheduled task is created to update your packages daily at midnight (or whenever you turn on your computer afterwards).


## Uninstalling

Simply remove the scoop-auto-update folder and delete the scheduled task called "ScoopAutoUpdate" - either in the Task Scheduler or via

```powershell
Unregister-ScheduledTask -TaskName ScoopAutoUpdate
```

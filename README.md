This repo contains my personal dotfiles for the platforms I regularly use (Windows, Linux, MacOS). I believe dotfiles should be tailored for each individual, but I've decided to make this repo public anyways, since I've also ~stolen~ taken some ideas from other people when doing these. They're not complicated at all as I like things minimalistic, without much noise (I used to love ricing out every system to the max though, keyword **used**).

To install these, for each platform there's a script which takes care of checking some bootstrapping constraints, like checking if git is installed, package managers etc...Then most of the work is done by symlinking the config files under `/common` and the platform specific ones, i.e.; only **Windows** contains a powershell profile, and only **Linux** contains a bash profile.

**Run the scripts as Administrator, sudo**. The scripts are:

- windows/install.ps1
- linux/install.sh
- macos/install.sh

Current profiles/configurations:

- Starship. Profile screenshot [here](images/starship.png)
# dotfiles

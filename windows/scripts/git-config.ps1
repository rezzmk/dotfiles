# Git - Configuration
git config --global user.name "Marcos Caramalho"
git config --global core.editor "vim"
git config --global alias.pom 'pull origin main'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short --graph"
git config --global alias.ammend "commit -a --amend"
git config --global alias.aliases "config --get-regexp alias"

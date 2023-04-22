Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"

function Set-Location-One-Time { Set-Location ".."; };
Set-Alias -Name ".." -Value "Set-Location-One-Time";

function Set-Location-Two-Times { Set-Location "..\.."; };
Set-Alias -Name "..." -Value "Set-Location-Two-Times";

function Set-Location-Three-Times { Set-Location "..\..\.."; };
Set-Alias -Name "...." -Value "Set-Location-Three-Times";

function New-Folder-Navigate-To-It {
 param($newFolderName);

 New-Item $newFolderName -ItemType directory;
 Set-Location -Path $newFolderName;
};
Set-Alias -Name "mkcd" -Value "New-Folder-Navigate-To-It";

function Open-Recycle-Bin {
 explorer.exe Shell:RecycleBinFolder;
}
Set-Alias -Name "trash" -Value "Open-Recycle-Bin";

################################################################################
#                          System Maintenance Aliases                          #
################################################################################

function Update-System {
 Update-Module;
 Update-Help -Force;
 choco upgrade -y "chocolatey";
 choco upgrade -y all --execution-timeout 7200;
 wsl sudo apt --yes update;
 wsl sudo apt --yes upgrade;
};
Set-Alias -Name "updsys" -Value "Update-System";

################################################################################
#                         Environment Variables Aliases                        #
################################################################################

function Invoke-List-Path {
 $env:Path -split ';';
};
Set-Alias -Name "pathl" -Value "Invoke-List-Path";

################################################################################
#                                  Git Aliases                                 #
################################################################################

function Invoke-Git-Super-Clone {
 param($repositoryName);
 $folderName = $repositoryName.Split("/")[-1].Replace(".git", "")
 & git clone $repositoryName $folderName | Out-Null;
 Set-Location $folderName;
 git submodule init;
 git submodule update;
};
Set-Alias -Name "gsc" -Value "Invoke-Git-Super-Clone";

function Invoke-Git-Checkout-Branch {
 param($branchName);

 git checkout -b $branchName;
};
Set-Alias -Name "gcb" -Value "Invoke-Git-Checkout-Branch";

function Invoke-Git-Add {
 param($fileToAdd);

 git add $fileToAdd;
};
Set-Alias -Name "ga" -Value "Invoke-Git-Add";

function Invoke-Git-Add-All {
 git add --all;
};
Set-Alias -Name "gaa" -Value "Invoke-Git-Add-All";

function Invoke-Git-Status {
 git status;
};
Set-Alias -Name "gst" -Value "Invoke-Git-Status";

function Invoke-Git-Commit-Message {
 param($message);

 git commit -m $message;
};
Set-Alias -Name "gcmsg" -Value "Invoke-Git-Commit-Message";

function Invoke-Git-Push-Origin-Current-Branch {
 git push origin HEAD;
};
Set-Alias -Name "ggp" -Value "Invoke-Git-Push-Origin-Current-Branch";

function Invoke-Git-Log-Stat {
 git log --stat;
};
Set-Alias -Name "glg" -Value "Invoke-Git-Log-Stat";

function Invoke-Git-Soft-Reset-Last-Commit {
 git reset --soft HEAD^1;
};
Set-Alias -Name "gsrlc" -Value "Invoke-Git-Soft-Reset-Last-Commit";

function Invoke-Git-Hard-Reset-Last-Commit {
 git reset --hard HEAD~1;
};
Set-Alias -Name "ghrlc" -Value "Invoke-Git-Hard-Reset-Last-Commit";

################################################################################
#                                  Vim Aliases                                 #
################################################################################

function Invoke-Edit-Vimrc {
 vim ~/.vimrc;
};
Set-Alias -Name "editvim" -Value "Invoke-Edit-Vimrc";

################################################################################
#                                Docker Aliases                                #
################################################################################

# Download Docker image
function Invoke-Docker-Pull {
 docker pull;
};
Set-Alias -Name "dpl" -Value "Invoke-Docker-Pull";

# List the Docker containers working
function Invoke-Docker-List-Working-Containers {
 docker container ls;
};
Set-Alias -Name "dlc" -Value "Invoke-Docker-List-Working-Containers";

# List all the Docker containers
function Invoke-Docker-List-Containers {
 docker container ls -a;
};
Set-Alias -Name "dlca" -Value "Invoke-Docker-List-Containers";

# List all the Docker images
function Invoke-Docker-Images {
 docker images;
};
Set-Alias -Name "dli" -Value "Invoke-Docker-Images";

# Stop Docker container
function Invoke-Docker-Stop-Container {
 docker container stop;
};
Set-Alias -Name "dsc" -Value "Invoke-Docker-Stop-Container";

# Delete Docker container
function Invoke-Docker-Delete-Container {
 docker container rm;
};
Set-Alias -Name "drc" -Value "Invoke-Docker-Delete-Container";

# Delete Docker image
function Invoke-Docker-Delete-Image {
 docker image rm;
};
Set-Alias -Name "dri" -Value "Invoke-Docker-Delete-Image";

# Edit config-ini
function Invoke-Edit-ConfigIni {
 vim $([System.Environment]::GetEnvironmentVariable('WORK_CONFIGURATION_FILE', 'machine'))
}
Set-Alias -name "cini" -Value "Invoke-Edit-ConfigIni"

function which ($command) {
   Get-Command -Name $command -ErrorAction SilentlyContinue |
       Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function cd-to-desktop {
   $DesktopPath = [Environment]::GetFolderPath("Desktop")
   cd $DesktopPath
}
Set-Alias -name "desktop" -Value "cd-to-desktop"

Set-Alias -name "bash" -Value "wsl"

function set-hyperv-vmware {
   bcdedit /set hypervisorlaunchtype off
}

function set-hyperv-auto {
   bcdedit /set hypervisorlaunchtype auto
}

function goto-blog-path {
   cd $DevPath\side\blog
}
Set-Alias -name "gotoblog" -Value "goto-blog-path"

function reload-config {
   & $PROFILE
}
Set-Alias -name "reload" -Value "reload-config"
Set-Alias -name "vim" -Value "nvim"

function tail ($file) {
   Get-Content $file -Wait
}
Set-Alias -name "tailfile" -Value "tail"

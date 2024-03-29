#!/bin/bash


# Set variables for the new account
echo "What is the username"
read username

echo "Enter a password"
read password

# Create the new user account
sudo dscl . -create /Users/$username
sudo dscl . -create /Users/$username UserShell /bin/bash
sudo dscl . -create /Users/$username RealName "$username"
sudo dscl . -create /Users/$username UniqueID "1001"
sudo dscl . -create /Users/$username PrimaryGroupID 20
sudo dscl . -create /Users/$username NFSHomeDirectory /Users/$username
sudo dscl . -passwd /Users/$username $password
sudo dscl . -append /Groups/admin GroupMembership $username

# Configure laptop settings
# Set computer name
echo "Enter new computer name:"
read computer_name
sudo scutil --set ComputerName "$computer_name"
sudo scutil --set HostName "$computer_name"
sudo scutil --set LocalHostName "$computer_name"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computer_name"
sudo softwareupdate --install --recommended
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "This laptop is Lawrence Berkeley Lab Property."
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "My Laptop"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server ServerDescription -string "File Sharing and Printing"
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
sudo defaults write /Library/Preferences/com.apple.TimeMachine AutoBackup -bool false
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server signing_required -bool false
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server GuestAccess -bool false
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.discoveryd.plist

echo "The new account has been created and settings have been configured."


# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install common packages via Homebrew
brew install git
brew install wget
brew install curl
brew install python3
brew install node

# Configure git
echo "Enter your git name:"
read git_name
echo "Enter your git email:"
read git_email
git config --global user.name "$git_name"
git config --global user.email "$git_email"

# Install Visual Studio Code
brew install visual-studio-code

# Configure VS Code
code --install-extension ms-vscode.cpptools
code --install-extension vscodevim.vim
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension ms-python.python
code --install-extension ms-azuretools.vscode-docker

echo "MacBook configuration completed!"

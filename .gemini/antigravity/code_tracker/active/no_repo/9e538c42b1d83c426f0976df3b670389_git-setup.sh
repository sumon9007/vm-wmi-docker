¨#!/bin/bash
set -e

echo "Starting Git setup..."

# 1. Install Git and GitHub CLI
echo "Checking for Git and GitHub CLI..."
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y git
else
    echo "Git is already installed: $(git --version)"
fi

if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y gh
else
    echo "GitHub CLI is already installed: $(gh --version)"
fi

# 2. Configure Git Identity
echo "Configuring Git Identity..."
CURRENT_NAME=$(git config --global user.name || echo "")
CURRENT_EMAIL=$(git config --global user.email || echo "")

if [ -z "$CURRENT_NAME" ]; then
    read -p "Enter your Git Name: " NAME
    git config --global user.name "$NAME"
else
    echo "Git Name already set to: $CURRENT_NAME"
fi

if [ -z "$CURRENT_EMAIL" ]; then
    read -p "Enter your Git Email: " EMAIL
    git config --global user.email "$EMAIL"
else
    echo "Git Email already set to: $CURRENT_EMAIL"
fi

# 3. GitHub Authentication Note
echo "============================================================"
echo "Setup Complete!"
echo "============================================================"
echo "You have chosen to login via browser."
echo "To authenticate with GitHub, you can use the GitHub CLI (if installed) or HTTPS."
echo ""
echo "Command for browser login (via gh cli):"
echo "  gh auth login"
echo ""
echo "If strictly using HTTPS, just git clone your repo and you will be prompted for credentials."
B *cascade08B{*cascade08{± *cascade08±á*cascade08áπ *cascade08π∫*cascade08∫¬ *cascade08¬√*cascade08√∆ *cascade08∆«*cascade08«» *cascade08»…*cascade08…  *cascade08 Õ*cascade08Õ˜	 *cascade08˜	¸	*cascade08¸	˛	 *cascade08˛	É
*cascade08É
Ñ
 *cascade08Ñ
Ü
*cascade08Ü
á
 *cascade08á
å
*cascade08å
ç
 *cascade08ç
é
*cascade08é
è
 *cascade08è
ï
*cascade08ï
ñ
 *cascade08ñ
ô
*cascade08ô
°
 *cascade08°
¨
*cascade08¨
Ø
 *cascade08Ø
∞
*cascade08∞
±
 *cascade08±
π
*cascade08π
∫
 *cascade08∫
“
*cascade08“
‘
 *cascade08‘
Ò
*cascade08Ò
É *cascade08Éà*cascade08àâ *cascade08âä*cascade08äã *cascade08ãå*cascade08åé *cascade08éè*cascade08èê *cascade08êí*cascade08íì *cascade08ìî*cascade08îï *cascade08ïô*cascade08ôõ *cascade08õû*cascade08ûü *cascade08ü¢*cascade08¢£ *cascade08£•*cascade08•¶ *cascade08¶ÆÆØ *cascade08Ø∞*cascade08∞≤ *cascade08≤¥*cascade08¥∏ *cascade08∏π*cascade08π∫ *cascade08∫Ω*cascade08Ω« *cascade08«ÀÀÃ *cascade08Ã”*cascade08”‘ *cascade08‘◊*cascade08◊ÿ *cascade08ÿ‹*cascade08‹› *cascade08›Ì*cascade08Ì *cascade08á*cascade08áà *cascade08àé*cascade08éè *cascade08èì*cascade08ìï *cascade08ï¢*cascade08¢£ *cascade08£§*cascade08§¶ *cascade08¶®*cascade08®© *cascade08©™*cascade08™¨ *cascade082*file:///home/wmiadmin/scripts/git-setup.sh
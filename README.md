# Assumption
- Operating system: Ubuntu
- `npm` and `node` are installed

# How to install?
```
apt-get update
apt-get install -y python-yaml fish git curl build-essential
python -m pip install PyYAML
mkdir -p ~/.config/nvim
git clone git@github.com:wongjiahau/my-neovim-config.git ~/.config/nvim
cd ~/.config/nvim
./install
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim
```

_source=$HOME/.config/nvim
_backup="$HOME/.cache/nvim_$(date +%s)"
echo "Backed up current nvim config at $_backup."
mv nvim $_backup
cp -r $_source nvim
echo "Copied new config from $_source to $PWD/nvim."

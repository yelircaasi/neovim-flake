_target=$HOME/.config/nvim
_backup="$HOME/.cache/nvim_$(date +%s)"
echo "Backed up current nvim config at $_backup."
mv $_target/ $_backup
cp -r nvim $_target
echo "Copied new config to $_target."

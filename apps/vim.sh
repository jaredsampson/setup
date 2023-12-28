
vim_plug="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$vim_plug" ]; then
    echo "downloading plug.vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "using existing plug.vim"
fi
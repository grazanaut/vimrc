all:update

install:
	@PWD=$(pwd)
	@echo "Backing up existing .vimrc, .gvimrc and .vim to $(HOME)/.[g]vim[rc].bak"
	@if [ -e $(HOME)/.vimrc ]; then mv $(HOME)/.vimrc $(HOME)/.vimrc.bak; fi
	@if [ -e $(HOME)/.vim ]; then mv $(HOME)/.vim $(HOME)/.vim.bak; fi
	@if [ -e $(HOME)/.gvimrc ]; then mv $(HOME)/.gvimrc $(HOME)/.gvimrc.bak; fi
	@echo "initialising submodules..."
	@git submodule update --init
	@echo "Linking up new .vimrc, .gvimrc and .vim"
	@ln -s ${PWD}/vimrc $(HOME)/.vimrc
	@ln -s ${PWD}/gvimrc $(HOME)/.gvimrc
	@ln -s ${PWD} $(HOME)/.vim
	@echo "All done. vim away!"

update:
	@git submodule foreach git pull origin master
	@make -s pathogen

pathogen:
	@cd ${PWD}/autoload && curl -so ./pathogen.vim \
		https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim


.PHONY: all
all: scripts zsh tmux xorg mutt git fluxbox vim

.PHONY: scripts
scripts:
	for file in $(shell find $(CURDIR)/bin -type f); do \
	    f=$$(basename $$file); \
	    ln -sf $$file ~/.local/bin$$f; \
	done

.PHONY: zsh
zsh:
	ln -s ${CURDIR}/zsh/zshrc ~/.zshrc

tmux:
	ln -s ${CURDIR}/tmux/tmux.conf ~/.tmux.conf

xorg:
	ln -s ${CURDIR}/Xstuff/Xmodmap ~/.Xmodmap
	ln -s ${CURDIR}/Xstuff/Xresources ~/.Xresources

mutt:
	ln -s ${CURDIR}/mutt/mutt ~/.mutt
	ln -s ${CURDIR}/mutt/muttrc ~/.muttrc

git:
	ln -s ${CURDIR}/git/gitconfig ~/.gitconfig
	ln -s ${CURDIR}/git/gitignore ~/.gitignore

fluxbox:
	ln -s ${CURDIR}/fluxbox ~/.fluxbox

vim:
	ln -s ${CURDIR}/vim/vimrc ~/.vimrc
	ln -s ${CURDIR}/vim/vim ~/.vim
	mkdir ~/.vim/tmp

.PHONY: test
test:
	./test.sh

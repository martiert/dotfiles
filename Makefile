FILES=zsh/zshrc \
      tmux/tmux.conf \
      Xstuff/Xmodmap \
      Xstuff/Xresources \
      mutt/mutt \
      mutt/muttrc \
      git/gitconfig \
      git/gitignore \
      fluxbox \
      vim/vimrc \
      vim/vim


.PHONY: all
all: scripts dotfiles


.PHONY: scripts
scripts:
	for file in $(shell find $(CURDIR)/scripts -type f); do \
	    f=~/.local/bin/$$(basename $$file); \
	    ln -sf $(CURDIR)/$$file $$f; \
	done

.PHONY: dotfiles
dotfiles:
	for file in $(FILES); do \
	    f=~/.$$(basename $$file); \
	    ln -sf $(CURDIR)/$$file $$f; \
	done
	if [ ! -d ~/.vim/tmp ]; then \
	    rm -fr ~/.vim/tmp; \
	    mkdir ~/.vim/tmp; \
	fi


.PHONY: clean_scripts
clean_scripts:
	for file in $(shell find $(CURDIR)/scripts -type f); do \
	    f=$$(basename $$file); \
	    [ -L ~/.local/bin/$$f ] && rm ~/.local/bin/$$f; \
	done

.PHONY: clean_dotfiles
clean_dotfiles:
	rm -fr ~/.vim/tmp
	for file in $(FILES); do \
	    f=$$(basename $$file); \
	    [ -L ~/.$$f ] && rm ~/.$$f; \
	done


.PHONY: clean
clean: clean_scripts clean_dotfiles


.PHONY: test
test:
	./test.sh

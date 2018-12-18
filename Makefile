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
all: clean scripts dotfiles


.PHONY: scripts
scripts:
	for file in $(shell find $(CURDIR)/scripts -type f); do \
	    f=$$(basename $$file); \
	    ln -sf $$file ~/.local/bin/$$f; \
	done

.PHONY: dotfiles
dotfiles:
	for file in $(FILES); do \
	    f=$$(basename $$file); \
	    ln -s "$(CURDIR)/$$file" ~/.$$f; \
	done
	mkdir ~/.vim/tmp


.PHONY: clean_scripts
clean_scripts:
	for file in $(shell find $(CURDIR)/scripts -type f); do \
	    f=$$(basename $$file); \
	    rm ~/.local/bin/$$f; \
	done

.PHONY: clean_dotfiles
clean_dotfiles:
	rm -fr ~/.vim/tmp
	for file in $(FILES); do \
	    f=$$(basename $$file); \
	    rm ~/.$$f; \
	done

.PHONY: clean
clean: clean_scripts clean_dotfiles


.PHONY: test
test:
	./test.sh

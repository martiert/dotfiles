FILES=zsh/zshrc \
      tmux/tmux.conf \
      Xstuff/Xmodmap \
      Xstuff/Xresources \
      mutt/mutt \
      mutt/muttrc \
      gdb/gdbinit \
      git/gitconfig \
      git/gitignore \
      fluxbox \
      vim/vimrc \
      vim/vim


.PHONY: all
all: scripts dotfiles thirdparty


.PHONY: scripts
scripts:
	for file in $(shell find $(CURDIR)/scripts -type f); do \
	    f=~/.local/bin/$$(basename $$file); \
	    ln -sf $$file $$f; \
	done

.PHONY: thirdparty
thirdparty:
	for dir in $(shell ls $(CURDIR)/thirdparty/); do \
	    d=~/.local/share/$$dir; \
	    dir="$(CURDIR)/thirdparty/$$dir"; \
	    [ -L "$$d" ] && rm "$$d"; \
	    ln -sf $$dir $$d; \
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

.PHONY: clean_thirdparty
clean_thirdparty:
	for dir in $(shell ls $(CURDIR)/thirdparty/); do \
	    [ -L ~/.local/share/$$dir ] && rm ~/.local/share/$$dir; \
	done

.PHONY: clean_dotfiles
clean_dotfiles:
	rm -fr ~/.vim/tmp
	for file in $(FILES); do \
	    f=$$(basename $$file); \
	    [ -L ~/.$$f ] && rm ~/.$$f; \
	done


.PHONY: clean
clean: clean_scripts clean_dotfiles clean_thirdparty


.PHONY: test
test:
	./test.sh

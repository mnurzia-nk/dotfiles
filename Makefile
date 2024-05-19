CC=gcc
CFLAGS=--std=c89 -Wall -Wpedantic -Werror -Wextra -Wshadow -Iinclude -g

all: bin bin/prompt bin/colors bin/get_ip bin/get_ip6 bin/fetch bin/name_weight bin/ascii bin/bviz bin/cprec bin/wordington bin/keyprobe ~/.config/tmux ~/.config/nvim

bin:
	mkdir -p bin

bin/prompt: prompt/prompt.c include/aparse.c
	$(CC) $(CFLAGS) --std=gnu89 prompt/prompt.c include/aparse.c -o bin/prompt

bin/colors: colors/colors.c
	$(CC) $(CFLAGS) colors/colors.c -o bin/colors

bin/get_ip: get_ip/get_ip.sh
	cp get_ip/get_ip.sh bin/get_ip
	chmod +x bin/get_ip

bin/get_ip6: get_ip6/get_ip6.sh
	cp get_ip6/get_ip6.sh bin/get_ip6
	chmod +x bin/get_ip6

bin/fetch: fetch/fetch.c
	$(CC) $(CFLAGS) fetch/fetch.c -o bin/fetch

bin/name_weight: name_weight/name_weight.py
	cp name_weight/name_weight.py bin/name_weight
	chmod +x bin/name_weight

bin/ascii: ascii/ascii.c
	$(CC) $(CFLAGS) ascii/ascii.c -o bin/ascii

bin/keyprobe: keyprobe/keyprobe.c
	$(CC) $(CFLAGS) -std=gnu99 keyprobe/keyprobe.c -o bin/keyprobe

bin/bviz: bviz/bviz.c include/aparse.c
	$(CC) $(CFLAGS) -std=c99 bviz/bviz.c include/aparse.c -o bin/bviz

bin/cprec: cprec/cprec.c
	$(CC) $(CFLAGS) -std=c99 cprec/cprec.c -o bin/cprec

bin/wordington: wordington/wordington.py
	cp wordington/wordington.py bin/wordington
	chmod +x bin/wordington

~/.config/tmux: tmux/tmux.conf
	ln -sf $(shell realpath ./tmux) $@

~/.config/nvim: nvim/init.lua
	ln -sf $(shell realpath ./nvim) $@

clean:
	rm -rf bin

.PHONY: all normal tiny clean

all: normal tiny reduction

normal:
	@go build -o normal main.go
	@echo -n "Size of normal binary is: "
	@echo "$$(du -k normal | cut -f1)K"

tiny:
	@GOARCH=386 go build -a -gcflags=all="-l -B" -ldflags="-w -s" -o tiny main.go
	@upx --best --ultra-brute --lzma tiny > /dev/null
	@echo -n "Size of tiny binary is: "
	@echo "$$(du -k tiny | cut -f1)K"

reduction:
	@echo -n "Reduction in size is: "
	@echo "$$(echo "scale=2; (($(shell du -k normal | cut -f1) - $(shell du -k tiny | cut -f1)) / $(shell du -k normal | cut -f1)) * 100" | bc)%"

clean:
	@rm -f normal tiny
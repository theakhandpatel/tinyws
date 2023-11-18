In my project, I first compiled my Go code into a binary using the following command:

```bash
GOARCH=386 go build -a -gcflags=all="-l -B" -ldflags="-w -s" main.go
```

 GOARCH=386 specifies that the target architecture is 32-bit x86. The -a flag forces all packages to be rebuilt, even if they're already up-to-date. The -gcflags=all="-l -B" part disables function inlining and bounds checking in the Go compiler. Lastly, -ldflags="-w -s" tells the linker to omit debugging information, making the resulting binary smaller.

After I had my binary, I wanted to make it even smaller. So, I used UPX  with the following command:

```bash
upx --best --ultra-brute --lzma main
```


The --best and --ultra-brute options tell UPX to use the maximum compression level, even if it takes longer. The --lzma option specifies that it should use the LZMA compression algorithm. The result is a much smaller binary that still works just like the original.
This is an attempt to simplify the xz backdoor code.

This uses the binary found in [5.6.1][1] and uses [RetDec][2] to decompile it
to C.

The first step would be to get it to compile, and then try to see if the result
reproduces the behavior.

[1]: https://www.openwall.com/lists/oss-security/2024/03/30/4
[2]: https://retdec.com/

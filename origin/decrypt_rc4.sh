#!/bin/sh

export LC_ALL=C

deinterleave() {
	for x in $(seq 16); do
		(head -c +1024 >/dev/null) && head -c +2048
	done
	(head -c +1024 >/dev/null) && head -c +939
}

decrypt() {
	awk '
	BEGIN {
		FS="\n";
		RS="\n";
		ORS="";
		for (i = 0; i < 256; i++) {
			t[sprintf("x%c",i)]=i;
			c[i]=((i*7)+5) % 256;
		}
		i=0;
		j=0;
		for (l = 0; l < 8192; l++) {
			i=(i+1) % 256;
			a=c[i];
			j=(j+a) % 256;
			c[i]=c[j];
			c[j]=a;
		}
	}
	{
		v=t["x" (NF < 1 ? RS : $1)];
		i=(i+1) % 256;
		a=c[i];
		j=(j+a) % 256;
		b=c[j];
		c[i]=b;
		c[j]=a;
		k=c[(a+b) % 256];
		printf "%c",(v+k) % 256
	}
	'
}

xz -dc "$1" | deinterleave | \
	sed "s/\(.\)/\1\n/g" | decrypt | \
	xz -dc --single-stream | head -c +88664

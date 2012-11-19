#!/bin/sh
#
# ditz seems to just dump comments verbatim into HTML when making pages.  This
# causes several (minor) issues when rendering in a web browser:
# - The newlines are eaten up
# - anything html-tag-like could go horribly astray
# This script attempts to fix those issues where possible.

for PAGE in html/*.html
do
	gawk '
		/<\/td>/{
			COMMENT=0
		}
		(COMMENT==1){
			gsub(/</,"\\&lt;",$0)
			gsub(/>/,"\\&gt;",$0)
			$0=$0"<br>"
		}
		{
			print$0
		}
		/<td[^>]*class="logcomment">/{
			COMMENT=1
		}
	' "$PAGE" > "$PAGE"-tmp
	mv "$PAGE"-tmp "$PAGE"
done

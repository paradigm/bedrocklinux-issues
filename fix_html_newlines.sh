#!/bin/sh
#
# ditz seems to just dump comments verbatim into HTML when making pages.  This
# means it ends up eating the newlines.  This script simply adds <br>'s where
# appropriate to ensure newlines are retained when the issue comment is viewed
# in a web browser.  If it already sees a <br>, it will avoid placing a second
# one.

for PAGE in html/*.html
do
	awk '
		/<\/td>/{
			COMMENT=0
		}
		{
			if (COMMENT == 1 && substr($0,length($0)-3,4) != "<br>")
				print$0"<br>"
			else
				print$0
		}
		/<td[^>]*class="logcomment">/{
			COMMENT=1
		}
	' $PAGE > $PAGE-tmp
	mv $PAGE-tmp $PAGE
done

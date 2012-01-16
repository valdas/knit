#!/bin/bash

[ -n "$1" ] && export QUERY_STRING="$1"

tinytim() {
	cat content/*  themes/$1/theme.txt |
	gawk -f lib/tinytim.awk -f lib/plugins.awk |
	sed 's/^<pre>/<script type="syntaxhighlighter" class="brush: cpp"><![CDATA[/' |
	sed 's/^<\/pre>/<\/script>/'
}

#tinytim wink
#tinytim auklet
tinytim trendygreen


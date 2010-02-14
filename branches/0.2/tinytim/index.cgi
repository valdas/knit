#!/bin/bash

tinytim() {
	cat site.txt themes/$1/theme.txt |
	gawk -f lib/tinytim.awk |
	sed 's/^<pre>/<script type="syntaxhighlighter" class="brush: cpp"><![CDATA[/' |
	sed 's/^<\/pre>/<\/script>/'
}


tinytim wink
#tinytim auklet
#tinytim trendygreen


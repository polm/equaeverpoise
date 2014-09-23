browser: equaeverpoise.ls
	rm -f equaeverpoise.js
	lsc -c equaeverpoise.ls
	browserify equaeverpoise.js > eep.js

clean:
	rm -r eep.js equaeverpoise.js

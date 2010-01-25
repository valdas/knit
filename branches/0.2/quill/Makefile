#---------------------------------------------------------------------------
# QUILL processes "wak" files and, depending on your taste, "wak" means:
#
# - "awk", al mixed up
#
# - or "words and kode" (code)
#
# - or super weird/awful/crazy/mad effed up
#   (From http://www.urbandictionary.com/define.php?term=wak.)
#
# - or one of the alines in the film "Explorers" (1985) played by Henry Alvarez
# 
#   At his core, Wak is a teenager. Though an alien, he has an annoying
#   little sister, watches a ton of television, and had more angst than
#   you can shake a latex eyeball on a stick at. Okay, so this is
#   another goofy 80s movie, but it has Ethan Hawke, River Phoenix and
#   a trash can spaceship. Plus, Wak has suction cup fingers.
#   (From http://cardboardmonocle.com/blog/?page_id=747)
#
# - or the  creator god in the mythology of southern Ethiopia, Uganda,
#   and Somaliland, for which it is said:
#   (Wak was an) African (Ethiopian) god who dwelled in the clouds. He was
#   supreme and a benefactor god. He kept the heavens at a distance from
#   the earth and ornamented it with stars. When the earth was flat, Wak
#   asked man to build himself a coffin. Man did so and Wak shut him up
#   in it and buried it. For seven years he made fire rain down. This is
#   how the mountains were formed. Wak then danced upon the place where
#   the coffin was buried and man sprang forth, alive. He was sure he
#   had slept for a brief moment only and was shocked to find it had
#   been so long and earth had changed so much; this is why man is awake
#   for most of the day. Eventually man grew tired of living
#   alone. Knowing of man's loneliness, Wak took some of his blood and
#   after four days, the blood turning into a woman whom the man
#   married. Man and woman had 30 children, but man was so ashamed at
#   having had so many that he hid fifteen of them away. Wak was angry
#   at this, and as a result, the children man hid away were turned into
#   animals and demons.
#   (From http://www.monamagick.com/resources_deities_african4.html)

This    = quill#
Version = 0.1#

about: 
	@echo "A test engine for QUILL function $(This), v$(Version)"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

PrettyFeathers:=$(subst .wak,.html,$(shell ls *.wak))

builds 	: $(Html)/$(subst .html ,.html $(Html)/,$(PrettyFeathers))

$(Html)/%.html : %.wak
	$(MAKE) This=$(subst .wak,,$^) build

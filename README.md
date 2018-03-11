# paperclip maximizer maximizer - maximize fitness of paperclip maximizers


## building

Requires geckodriver and the splinter python library. On arch linux just run make.
On other systems, add a new Makefile target that depends on `deps` and name it `deps_<systemname>`, make a pull request, and go outside to enjoy some fresh air.


## files/dirs

| file/dir         | description                                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| paperclips/      | mirror of the game, cloned from https://github.com/siemanko/paperclips, adapted to include arena.js and bot.js                                       |
| paperclips-auto/ | Bot template. Cloned from https://github.com/marclitchfield/paperclips-auto                                                                          |

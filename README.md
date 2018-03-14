# paperclip maximizer maximizer - maximize fitness of paperclip maximizers


## building

Requires geckodriver and the splinter python library. On arch linux just run make.
On other systems, add a new Makefile target that depends on `deps` and name it `deps_<systemname>`, make a pull request, and go outside to enjoy some fresh air.


## running

Execute `make run` and watch. To run indefinitely, execute `yes | make run`.

`arena.sh` is called like this: `arena.sh <numberOfChildren> <timeoutInSeconds>`. To adjust these values, edit the place in the Makefile where `arena.sh` is called.


## files/dirs

| file/dir         | description                                                                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `paperclips/` | mirror of the game, cloned from [siemanko/paperclips](https://github.com/siemanko/paperclips), adapted to include the bot from [marclitchfield/paperclips-auto](https://github.com/marclitchfield/paperclips-auto) |
| `Makefile` | Installs dependencies (`make`), runs the evolution (`make run`), cleans up |
| `recombine.pl` | Recombines two parents into a certain number of children and mutates them. If it is called with `--no-sex` as the fourth argument, it clones just the one parent before mutating the children, thus implementing asexual reproduction. |
| `arena.sh` | Sets up the game for each child, runs them by calling `runBot.py`, and chooses the two new parents according to the resulting fitness. |
| `runBot.py` | Runs a bot for a certain amount of time, then reads the resulting amount of paperclips, thus determining the fitness of the bot. |

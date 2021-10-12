WETr
====


An R package for running the [GOTM-WET](https://projects.au.dk/wet/software/) model. `WETr` holds version 0.1 of the Water Ecosystems Tool (WET). This package does not contain the source code for the model, only the executables. Use `wet_version()` to figure out what version of GOTM you are running. This package was inspired by [GOTMr](https://github.com/aemon-j/GOTMr).


WET was originally published in: **WET – a new generation of flexible aquatic ecosystem modelling software**, in preparation, by Schnedler-Meyer, N. A., Hu, F., Bolding, K., Andersen, T. K., Nielsen, A., and Trolle, D.

FABM-PCLake was originally published in: **FABM-PCLake – linking aquatic ecology with hydrodynamics**, Geoscientific Model Development 9: 2271-2278, by Hu, F., Bolding, K., Bruggeman, J., Jeppesen, E., Flindt, M. R., van Gerven, L., Janse, J. H., Janssen, A. B. G., Kuiper, J. J., Mooij, W. M., and Trolle, D. 2016.

The original PCLake model was published in: **A model of nutrient dynamics in shallow lakes in relation to multiple stable states**, Hydrobiologia 342/343: 1-8, by Janse, J. 1997.

## Installation

You can install WETr from Github with:

```{r gh-installation, eval = FALSE}
# install.packages("devtools")
devtools::install_github("aemon-j/WETr")
```

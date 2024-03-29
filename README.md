# Fish scripts

In your fish config file add following line.

First you need to set the environment variable for easifem configuration. See more at [website](https://www.easifem.com)

```bash
set -q XDG_DATA_HOME
and set -gx EASIFEM_CONFIG_PATH "$XDG_DATA_HOME/easifem"
or set -gx EASIFEM_CONFIG_PATH "$HOME/.config/easifem"
```

```bash
if test -f $EASIFEM_CONFIG_PATH/scripts/easifem_functions.fish
    source $EASIFEM_CONFIG_PATH/scripts/easifem_functions.fish
end
```

After that reload the fish.

## Fish functions 

- edoc 
- erun 
- etest
- baseBuild
- baseInstall
- classBuild
- classInstall
- evim
- egreet
- erebuild


## TODO 

Add details of usage of `fish` functions.

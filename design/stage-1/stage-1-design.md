# Stage 1 design

This is a simplified design of Stage 1 deliverables.

## Possible inputs
- `environments.csv` file specifying environements, users and required key aliases for all instances.

## Prerequisities validation script
- each instance specified withing `environments.csv` file has either a custom key alias defined, or has an ancestor alias on the path (so that there is no "orphan" key)
- the directories for SSH keys, SSH root config file and SSH target config file should exist. The root SSH config file must be writeable. The SSH target config file must be createable/overwritable.

## Key generation script

### Input file

Source file will be a CSV file of the following form:

```
envA-groupA-instanceA,userA
envA-groupA-instanceB
envA-groupA-*,userAA,sharedKey
envB-*,,anotherSharedKey
*,userC,globalKey
```

For demonstration, let's call this `environments.csv`

Each line specifies a separate entry in the .ssh/config file.
This entry will specify matching host and potentially the specified user and potentially a reused key (no value in key field means there will be no entry for this one in the configuration file).

AC:
- create a check so that there is always fallback to some key for each instance specified

### Arguments

- Required argument with default value for `environments.csv` file
- Optional argument for the already existing `keys.csv` file
- Optional argument for overwrite strategy if a key with given alias exists (only when `keys.csv` is provided)
- Required argument with default value for the SSH keys root directory

### Result 

The results of the script execution should be:
- generated key pairs for each unique key identifier in the `environments.csv` file. 
- a file that maps key aliases from `environments.csv` file to actual key pairs. Let's call this file `keys.csv` 

`keys.csv` file structure:
```
sharedKey, /home/bob/.ssh/id_ecdsa_sharedKey.pub, /home/bob/.ssh/id_ecdsa_sharedKey
anotherSharedKey, /home/bob/.ssh/id_ecdsa_anotherSharedKey.pub, /home/bob/.ssh/id_ecdsa_anotherSharedKey
globalKey, /home/bob/.ssh/id_ecdsa_globalKey.pub, /home/bob/.ssh/id_ecdsa_globalKey
```

### Considerations

- Can this key generation be parallelized?
- How to force encryption? Can a single password be used?

## SSH Config update script

- updated, in-order SSH configuration file linked in .ssh/config

- Should we sort the file at the very beginning in order to create valid .ssh/config file?
- How to distinguish sections created by this script from other sections within the config file?

### Input files

`environments.csv` and `keys.csv` files

### Arguments

- Required argument with default value for target SSH configuration file
- Required argument with default value for `environments.csv` file
- Required argument with default value for `keys.csv` file
- Required argument with default value for SSH configuration file

### Result 

- The SSH configuration file contains entry on top including the target SSH configuration file
- The target SSH configuration file constains entries in-order from specific to general, specifying users and keys to be used. (will be overriden?)

### Considerations

- Should we always overwrite the target SSH config file?
- How to handle other SSH files included in the root SSH config file?

## Key regeneration script

TODO: based on the key expiration data

```
fingerprint,revoked
fingerprint,

```

## Key upload script (parallel?)

## TODO: Move to Stage 2

 - Add an optional argument for the key expiration file `key-expirations.csv` which will allow reusage/regeneration of the old keys.
 
## TODO: move to later stages
 - Consider auditing instances for access in order to determine who was using login on what time (given that an account is shared). Restrict sudo access.
 
## TODO: reconsider using ECDSA as it may have some flaws (RSA is more standard?)
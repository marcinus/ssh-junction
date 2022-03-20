# Stage 1 design

This is a simplified design of Stage 1 deliverables.

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

### Result 

The results of the script execution should be:
- generated key pairs for each unique key identifier in the `environments.csv` file. 
- a file that maps key aliases from `environments.csv` file to actual key pairs. Let's call this file `keys.csv` 
- updated, in-order SSH configuration file .ssh/config

`keys.csv` file structure:
```
sharedKey, /home/bob/.ssh/id_ecdsa_sharedKey.pub, /home/bob/.ssh/id_ecdsa_sharedKey
anotherSharedKey, /home/bob/.ssh/id_ecdsa_anotherSharedKey.pub, /home/bob/.ssh/id_ecdsa_anotherSharedKey
globalKey, /home/bob/.ssh/id_ecdsa_globalKey.pub, /home/bob/.ssh/id_ecdsa_globalKey
```

### Considerations

- Can this key generation be parallelized?
- How to force encryption? Can a single password be used?

## Key regeneration script

TODO: based on the key expiration data

```
fingerprint,revoked
fingerprint,

```

## Key upload script (parallel?)

## TODO: Move to Stage 2

 - Add an optional argument for the key expiration file `key-expirations.csv` which will allow reusage/regeneration of the old keys.
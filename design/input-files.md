# Goals

The instances file should list the instances that should be set up for connectivity. This includes:
- Names of selected environments
- Names of selected groups
- Names and IP addresses of each instances
- [Optionally] Fingerprints set on any of the following levels:
    - common
    - per-environment
    - per-group
    - per-instance
- [Optionally] The key generation type (same groups as above, defaults to per-group) - TODO?
- [Extra] Allow having a single group on an environment to skip the naming convention

## Format

Consider using YAML file format for storing the data.

### Format considerations

TODO: what's the best, industry-standard YAML format for this kind of data?

So there is some data associated with a label which is important (it is a name of a tree level)
- Should this be stored as a property with a name "name", or should this just be the key in the dictionary?
- Can numbers be keys in the dictionaries? Answer: yes

*This is a very simple matter but one should decide on a convention and be consistent.*
It is important when there is metadata associated with the container - then it's hard to distinguish a subgroup from the metadata, and sometimes there may be more complex metadata associated.

What if there is no metadata associated? So there is a container object explicitly containing only data?

Preferably: create a container whenever possible and then have items as data

## Example file

- [instances.yaml](samples/instances.yaml) contains an example of instances specification
- [credentials.yaml](samples/credentials.yaml) contains an example of credentials specification




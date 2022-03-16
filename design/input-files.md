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
- [Optionally] The key generation type (same groups as above, defaults to per-group)
- [Extra] Allow having a single group on an environment to skip the naming convention

## Format

Consider using YAML file format for storing the data

## Example file

TODO: please see an attached file

# Stages of delivery

## Stage 1 - local development

- Local scripts for manual settings of files:
	- simplification: keep repository structure ready for consumption for bash files (CSV)
	- local script for generation of necessary keys and setting up ssh configuration files
	- local script for uploading the desired keys onto the instances
	
## Stage 2 - central server

- setting up simple http server hosting the instances and credentials file on authorization
- accepting response with public keys to be uploaded
- connecting to target instances and setting up keys

## Stage 3 - securing the design

- introducing proper encryption and digital signatures into the communication schemas
- polishing the designs of communication formats
- encryption of local files on the server

## Stage 4 - public release

TODO

## Stage 5 - dockerization

- build the server architecture as a Docker image

## Stage 6 - connectivity checks

- include additional connectivity checks on server
- include additional connectivity checks on client (DNS lookup, cURL commands, ping reachibility, /etc/hosts validation)
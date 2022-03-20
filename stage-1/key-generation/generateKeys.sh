#!/bin/bash

ALGORITHM="ecdsa"
OUTPUT_FILE="keys.csv"

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -a|--algorithm)
      ALGORITHM="$2"
      shift # past argument
      shift # past value
      ;;
    -f|--file)
      FILE="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

print_usage() {
	echo "Required argument: -f, --file the file with key specifications"
	echo "Required argument: -a, --algorithm the algorithm to generate keys"
	exit 1
}

check_args() {
	([ -z "$FILE" ] || [ -z "$ALGORITHM" ]) && print_usage
}

check_args

set -- "${POSITIONAL_ARGS[@]}" 

echo "Processing file: $FILE"

DATA=$(awk -F "\"*,\"*" '{print $3}' "$FILE")

truncate -s 0 "$OUTPUT_FILE"

for key_alias in ${DATA[@]}
do
   ssh-keygen -f ~/.ssh/"$key_alias" -t "$ALGORITHM" -C "$key_alias"
   FINGERPRINT_ENTRY=$(ssh-keygen -l -E SHA256 -f ~/.ssh/"$key_alias.pub")
   FINGERPRINT=$(echo "$FINGERPRINT_ENTRY" | cut -d' ' -f2)
   echo "$key_alias,$FINGERPRINT" >> "$OUTPUT_FILE"
   # TODO: save fingerprint to a different file?
done

#!/bin/bash

set -euo pipefail

CONFIG_FILE="image-config.yaml"
CONTAINERFILE="Containerfile"

echo "# Auto-generated Containerfile" > $CONTAINERFILE

BASE_IMAGE=$(yq '.image.base' "$CONFIG_FILE")
STAGES=$(yq '.image.stages | length' "$CONFIG_FILE")

for i in $(seq 0 $((STAGES - 1))); do
  NAME=$(yq ".image.stages[$i].name" "$CONFIG_FILE")
  FROM=$(yq ".image.stages[$i].from // \"$BASE_IMAGE\"" "$CONFIG_FILE")

  echo -e "\nFROM $FROM AS $NAME" >> $CONTAINERFILE

  # DNF INSTALL
  INSTALL_PKGS=$(yq ".image.stages[$i].dnf.install[]" "$CONFIG_FILE" 2>/dev/null || true)
  if [ -n "$INSTALL_PKGS" ]; then
    echo "RUN dnf install -y $INSTALL_PKGS && dnf clean all" >> $CONTAINERFILE
  fi

  # DNF REMOVE
  REMOVE_PKGS=$(yq ".image.stages[$i].dnf.remove[]" "$CONFIG_FILE" 2>/dev/null || true)
  if [ -n "$REMOVE_PKGS" ]; then
    echo "RUN dnf remove -y $REMOVE_PKGS && dnf clean all" >> $CONTAINERFILE
  fi

  # SYSTEMCTL
  ENABLE_SERVICES=$(yq ".image.stages[$i].systemctl.enable[]" "$CONFIG_FILE" 2>/dev/null || true)
  DISABLE_SERVICES=$(yq ".image.stages[$i].systemctl.disable[]" "$CONFIG_FILE" 2>/dev/null || true)

  if [ -n "$ENABLE_SERVICES" ]; then
    echo "RUN systemctl enable $ENABLE_SERVICES" >> $CONTAINERFILE
  fi

  if [ -n "$DISABLE_SERVICES" ]; then
    echo "RUN systemctl disable $DISABLE_SERVICES" >> $CONTAINERFILE
  fi

  # COMMANDS
  COMMANDS=$(yq ".image.stages[$i].commands[]" "$CONFIG_FILE" 2>/dev/null || true)
  if [ -n "$COMMANDS" ]; then
    echo "$COMMANDS" | while read -r cmd; do
      echo "RUN $cmd" >> $CONTAINERFILE
    done
  fi

  # COPY from previous stage
  COPY_LENGTH=$(yq ".image.stages[$i].copy | length" "$CONFIG_FILE" 2>/dev/null || echo "0")
  for j in $(seq 0 $((COPY_LENGTH - 1))); do
    COPY_FROM=$(yq ".image.stages[$i].copy[$j].from" "$CONFIG_FILE")
    COPY_SRC=$(yq ".image.stages[$i].copy[$j].source" "$CONFIG_FILE")
    COPY_DEST=$(yq ".image.stages[$i].copy[$j].destination" "$CONFIG_FILE")
    echo "COPY --from=$COPY_FROM $COPY_SRC $COPY_DEST" >> $CONTAINERFILE
  done
done

echo -e "\n# Done generating Containerfile"

#!/bin/sh

CONFIG_PATH="/etc/nixos/configuration.nix"
BACKUP_PATH="./etc-nixos-configuration.nix"

show_diff() {
    echo "Differences:"
    diff --color -u "$1" "$2" || true
}

backup() {
    if [[ ! -e "$CONFIG_PATH" ]]; then
        echo "Error: $CONFIG_PATH does not exist."
        exit 1
    fi

    echo "Backing up $CONFIG_PATH to $BACKUP_PATH..."
    show_diff "$CONFIG_PATH" "$BACKUP_PATH"
    cp "$CONFIG_PATH" "$BACKUP_PATH"
    echo "Backup complete."
}

restore() {
    if [[ ! -e "$BACKUP_PATH" ]]; then
        echo "Error: Backup file $BACKUP_PATH does not exist."
        exit 1
    fi

    echo "Restoring $CONFIG_PATH from $BACKUP_PATH..."
    show_diff "$CONFIG_PATH" "$BACKUP_PATH"

    read -p "Are you sure you want to overwrite $CONFIG_PATH? [y/N]: " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Restore cancelled."
        exit 0
    fi

    sudo cp "$BACKUP_PATH" "$CONFIG_PATH"
    echo "Restore complete."
}

if [[ "$1" == "backup" ]]; then
    backup
elif [[ "$1" == "restore" ]]; then
    restore
else
    echo "Usage: $0 {backup|restore}"
    exit 1
fi


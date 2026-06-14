#!/bin/bash
set -e
BACKUP_DIR="$HOME/.config/hyprland_backups"
HYPR_CONFIG="$HOME/.config/hypr"
mkdir -p "$BACKUP_DIR"

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

get_timestamp() {
    date '+%d_%m_%y_%Hh_%Mm'
}

while true; do
    echo -e "\n${CYAN}━━━━━━ HYPRLAND BACKUP MANAGER ━━━━━━${NC}"
    echo "1) 📦 Create backup"
    echo "2) 📋 List backups"
    echo "3) 🔄 Restore backup"
    echo "4) 🗑️  Delete backups"
    echo "5) ❌ Exit"
    read -p "Choose: " choice
    
    case $choice in
        1)
            TIMESTAMP=$(get_timestamp)
            BACKUP="hypr_backup_$TIMESTAMP.tar.gz"
            echo "Creating: $BACKUP"
            tar -czf "$BACKUP_DIR/$BACKUP" -C "$HOME/.config" hypr
            echo -e "${GREEN}✓ Done!${NC}"
            ;;
        2)
            echo "Available backups:"
            ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | nl || echo "No backups found"
            ;;
        3)
            echo "Select backup to restore:"
            ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | nl
            read -p "Number: " num
            FILE=$(ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | sed -n "${num}p")
            if [ -z "$FILE" ]; then
                echo -e "${RED}✗ Invalid number${NC}"
                continue
            fi
            echo -e "${YELLOW}⚠️  Restoring from: $(basename $FILE)${NC}"
            read -p "Are you sure? (yes/no): " confirm
            if [ "$confirm" = "yes" ]; then
                # Save current config as error backup
                ERROR_TIME=$(get_timestamp)
                ERROR_BACKUP="error_$ERROR_TIME.tar.gz"
                echo "Saving current config as: $ERROR_BACKUP"
                tar -czf "$BACKUP_DIR/$ERROR_BACKUP" -C "$HOME/.config" hypr
                
                # Restore
                echo "Extracting..."
                rm -rf "$HYPR_CONFIG"
                tar -xzf "$FILE" -C "$HOME/.config"
                
                # Reload
                echo "Reloading Hyprland..."
                hyprctl reload
                echo -e "${GREEN}✓ Restored and reloaded!${NC}"
            fi
            ;;
        4)
            echo "Select backups to delete (space-separated or range):"
            echo "Examples: '1 3 5' or '2 5' or '1'"
            ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | nl
            read -p "Numbers: " numbers
            
            if [ -z "$numbers" ]; then
                echo -e "${RED}✗ No selection${NC}"
                continue
            fi
            
            FILES_TO_DELETE=""
            for num in $numbers; do
                FILE=$(ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | sed -n "${num}p")
                if [ -n "$FILE" ]; then
                    FILES_TO_DELETE="$FILES_TO_DELETE$(basename $FILE)\n"
                fi
            done
            
            if [ -z "$FILES_TO_DELETE" ]; then
                echo -e "${RED}✗ Invalid numbers${NC}"
                continue
            fi
            
            echo -e "${RED}${BOLD}Will be deleted:${NC}"
            echo -e "$FILES_TO_DELETE"
            read -p "Confirm? (yes/no): " confirm
            
            if [ "$confirm" = "yes" ]; then
                for num in $numbers; do
                    FILE=$(ls -1t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | sed -n "${num}p")
                    if [ -n "$FILE" ]; then
                        rm -f "$FILE"
                        echo "Deleted: $(basename $FILE)"
                    fi
                done
                echo -e "${GREEN}✓ Deleted!${NC}"
            fi
            ;;
        5) exit 0 ;;
        *) echo "Invalid choice" ;;
    esac
done
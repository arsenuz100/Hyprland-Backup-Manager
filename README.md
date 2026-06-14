# Hyprland Backup Manager 🚀

A simple, elegant bash script to backup and restore your Hyprland configuration on Arch Linux.

## Features ✨

- 📦 **Create backups** - Compress your entire Hyprland config
- 📋 **List all backups** - View all saved backups with timestamps
- 🔄 **Restore easily** - Restore from any previous backup
- 🗑️ **Delete multiple** - Remove old backups in one command
- 🔐 **Auto-save** - Creates error backup before restoring
- 🔧 **Auto-reload** - Automatically reloads Hyprland after restore
- 📝 **Smart naming** - Backups named like: `hypr_backup_26_06_14_13h_01m.tar.gz`

## Requirements 📋

- Arch Linux with Hyprland installed
- `bash`, `tar`, `gzip`
- `hyprctl` command available

Install on Arch:
```bash
sudo pacman -S hyprland base-devel
```

## Installation 💾

1. Clone or download the script:
```bash
# Download
wget https://github.com/arsenuz100/Hyprland-Backup-Manager/backup.sh

# Or copy the script content
nano ~/backup.sh
chmod +x ~/backup.sh
```

2. Run it:
```bash
./backup.sh
```

## Usage 🎯

### Create Backup
$ ./backup.sh

📦 Create backup


1

Creating: hypr_backup_26_06_14_13h_01m.tar.gz

✓ Done!


### List Backups

📋 List backups


2

Available backups:

1 hypr_backup_26_06_14_13h_01m.tar.gz

2 hypr_backup_26_06_14_12h_30m.tar.gz

3 error_26_06_14_12h_15m.tar.gz


### Restore Backup

🔄 Restore backup


3

[Lists all backups]

Number: 1

⚠️  Restoring from: hypr_backup_26_06_14_13h_01m.tar.gz

Are you sure? (yes/no): yes

Saving current config as: error_26_06_14_13h_05m.tar.gz

Extracting...

Reloading Hyprland...

✓ Restored and reloaded!


### Delete Backups

🗑️  Delete backups


4

[Lists all backups]

Numbers: 2 3

⚠️  Will be deleted:

hypr_backup_26_06_14_12h_30m.tar.gz

error_26_06_14_12h_15m.tar.gz

Confirm? (yes/no): yes

✓ Deleted!


## Backup Location 📁

All backups are stored in:
~/.config/hyprland_backups/

## How It Works 🔧

1. **Create**: Compresses `~/.config/hypr` directory with gzip
2. **List**: Shows all `.tar.gz` files sorted by date (newest first)
3. **Restore**: 
   - Saves current config as `error_*.tar.gz`
   - Extracts selected backup
   - Runs `hyprctl reload` automatically
4. **Delete**: Select multiple backups by number

## Safety ✅

- ✅ Auto-saves current config before restoring
- ✅ Asks for confirmation before destructive operations
- ✅ Backups stored separately from config
- ✅ Original files never deleted without confirmation

## Troubleshooting 🐛

**"No backups found"**
- Create your first backup: Choose option 1

**"Hyprctl reload" command not found**
- Make sure you're in an active Hyprland session
- Not available in TTY or other window managers

**Wrong backup restored**
- Don't panic! Your current config was saved as `error_*.tar.gz`
- Restore from that backup

## Customization 🎨

Edit the script to change:
- Backup directory: `BACKUP_DIR="$HOME/.config/hyprland_backups"`
- What to backup: Change `hypr` to include more configs

## Tips 💡

- Create backup before making major changes
- Keep only last 5-10 backups (use delete option)
- Backup regularly (weekly recommended)
- Share backups safely with others

## License 📄

Public Domain - Do whatever you want with it!

## Support 🤝

If it helps, please:
- Star on GitHub
- Share on Reddit
- Report bugs

---

**Made with ❤️ for Hyprland community**

Last updated: 2026-06-14
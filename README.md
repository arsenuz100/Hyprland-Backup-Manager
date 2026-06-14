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

- **Hyprland installed** on Arch Linux (or compatible distro)
- **Active Hyprland session** (graphical environment, NOT TTY)
- Commands: `bash`, `tar`, `gzip`, `hyprctl`
- At least 1 GB free disk space for backups

⚠️ **IMPORTANT**: This script MUST be run from an active Hyprland session (GUI). It will NOT work in:
- TTY (Ctrl+Alt+F3-F6)
- SSH sessions without X11 forwarding
- Other window managers (GNOME, KDE, etc.)

Install on Arch:
```bash
sudo pacman -S hyprland base-devel
```

## Installation 💾

1. Clone or download the script:
```bash
# Clone repository
git clone https://github.com/arsenuz100/Hyprland-Backup-Manager.git

# Or just download the script
wget https://raw.githubusercontent.com/arsenuz100/Hyprland-Backup-Manager/main/backup.sh
chmod +x backup.sh
```

2. Make it executable and run **from Hyprland GUI** (not TTY):
```bash
chmod +x ./backup.sh
./backup.sh
```

⚠️ **Must be run from Hyprland GUI session, not TTY!**

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
   - Runs `hyprctl reload` automatically (requires active Hyprland session)
4. **Delete**: Select multiple backups by number

⚠️ **Note**: Script checks if Hyprland config exists before starting. If it fails, you're not in a Hyprland session.

## Safety ✅

- ✅ Auto-saves current config before restoring
- ✅ Asks for confirmation before destructive operations
- ✅ Backups stored separately from config
- ✅ Original files never deleted without confirmation

## Troubleshooting 🐛

**"No backups found"**
- Create your first backup: Choose option 1

**"Error: Hyprland config not found"**
- Make sure you're running the script from an active Hyprland session (GUI)
- NOT from TTY (Ctrl+Alt+F3)
- Reinstall Hyprland if necessary

**"Hyprctl reload" command not found or fails**
- ❌ You're NOT in an active Hyprland session
- ❌ You're in TTY mode (Ctrl+Alt+F3-F6) - switch back to GUI (Ctrl+Alt+F2)
- ❌ Hyprland crashed - restart it
- Run: `systemctl --user status hyprland` to check status

**Script exits immediately**
- Make sure `~/.config/hypr` directory exists
- Create backup from Hyprland settings before using script

**Wrong backup restored**
- Don't panic! Your current config was saved as `error_*.tar.gz`
- Restore from that backup (option 3)

## Customization 🎨

Edit the script to change:
- Backup directory: `BACKUP_DIR="$HOME/.config/hyprland_backups"`
- What to backup: Change `hypr` to include more configs

## Tips 💡

- Create backup before making major changes
- Keep only last 5-10 backups (use delete option)
- Backup regularly (weekly recommended)
- Share backups safely with others
- **Run only from Hyprland GUI session** - use GUI login screen or `startx hyprland`
- **Cannot run in TTY** (Ctrl+Alt+F3) - switch to GUI with Alt+F2 or restart

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
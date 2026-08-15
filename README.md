# No Update On Shutdown

GNOME Shell extension that removes the **"Install pending software updates"** checkbox from the
Power Off / Restart dialog and keeps it off, so updates are never installed on shutdown.

It only hides the option: no updates are triggered, cancelled or otherwise touched. Updating
through GNOME Software or the package manager keeps working as before.

## Requirements

GNOME Shell 50.

## Install

```sh
./install.sh
```

Then log out and back in.

## Uninstall

```sh
gnome-extensions disable no-update-on-shutdown@pndhd1.github.io
rm -rf ~/.local/share/gnome-shell/extensions/no-update-on-shutdown@pndhd1.github.io
```

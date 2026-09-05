# golden-kitty

Cross-platform `kitty` configuration for Linux and macOS.

## What this repo does

This setup uses one top-level config and small OS-specific overrides:

- `kitty.conf`: entrypoint that includes shared settings, OS overrides, and theme
- `common.conf`: shared behavior for both Linux and macOS
- `linux.conf`: Linux-only font/size overrides
- `macos.conf`: macOS-only font/size overrides + macOS behavior
- `theme.conf`: color theme (using your macOS theme)

This is intentionally `Option B` style because `macos_*` directives are not valid on Linux.

## Install

From this repo:

```bash
./scripts/install.sh
```

Custom target directory:

```bash
./scripts/install.sh /path/to/kitty-config
```

Then start kitty normally; it auto-selects `linux.conf` or `macos.conf` via `${KITTY_OS}`.

## Update

Pull latest changes from git and reinstall:

```bash
./scripts/update.sh
```

If you intentionally have local changes in this repo, allow update anyway:

```bash
./scripts/update.sh --allow-dirty
```

## Behavior defaults

- URL opener (Linux): `google-chrome-stable`
- URL opener (macOS): `firefox`
- macOS app-launch PATH fix: `exe_search_path /opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin`
- macOS title bar: hidden with `hide_window_decorations titlebar-only`; terminal tabs remain available. Restart Kitty after changing this setting.
- Layout: `grid`
- Window nav: `ctrl+shift+right` / `ctrl+shift+left`
- Opacity: `0.95`
- Padding: `10`
- Infinite scrollback: enabled (`-1`)
- Shell integration: enabled
- Latency tuning: `repaint_delay 10`, `input_delay 3`

## Notes

1. Keep OS-specific values in `linux.conf` and `macos.conf` only.
2. If Firefox still fails on macOS, verify with `command -v firefox`; if needed, use `/Applications/Firefox.app/Contents/MacOS/firefox` in `macos.conf`.
3. If `google-chrome-stable` is unavailable on Linux, switch to `open_url_with default` in `linux.conf`.
4. If fonts differ across machines, keep separate `font_family` per OS (already done).

## Optional local override pattern

`kitty.conf` already has:

```conf
globinclude ./local.conf
```

`local.conf` is gitignored, so you can add machine-specific overrides without changing tracked files.

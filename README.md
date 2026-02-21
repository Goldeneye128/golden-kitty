# golden-kitty

Cross-platform `kitty` configuration for Linux and macOS.

## What this repo does

This setup uses one top-level config and small OS-specific overrides:

- `kitty.conf`: entrypoint that includes shared settings, OS overrides, and theme
- `common.conf`: shared behavior for both Linux and macOS
- `linux.conf`: Linux-only font/size overrides
- `macos.conf`: macOS-only font/size overrides + macOS behavior
- `theme.conf`: color theme (using your macOS theme)
- `current-theme.conf`: compatibility shim for older setups

This is intentionally `Option B` style because `macos_*` directives are not valid on Linux.

## Install

From this repo:

```bash
mkdir -p ~/.config/kitty
cp kitty.conf common.conf linux.conf macos.conf theme.conf current-theme.conf ~/.config/kitty/
```

Then start kitty normally; it auto-selects `linux.conf` or `macos.conf` via `${KITTY_OS}`.

## Behavior defaults

- URL opener (Linux): `google-chrome-stable`
- URL opener (macOS): `firefox`
- macOS app-launch PATH fix: `exe_search_path /opt/homebrew/bin:/usr/local/bin`
- Layout: `grid`
- Window nav: `ctrl+shift+right` / `ctrl+shift+left`
- Opacity: `0.95`
- Padding: `10`
- Infinite scrollback: enabled (`-1`)

## Recommendations

1. Keep OS-specific values in `linux.conf` and `macos.conf` only.
2. Keep `open_url_with` in the OS files only, so each platform can use its native/browser-specific command.
3. If Firefox still fails on macOS, verify with `command -v firefox`; if needed, use `/Applications/Firefox.app/Contents/MacOS/firefox` in `macos.conf`.
4. If fonts differ across machines, keep separate `font_family` per OS (already done).
5. Add a `local.conf` include (gitignored) if you want host-specific overrides without changing tracked files.
6. Consider enabling shell integration and performance tuning in `common.conf`: `shell_integration enabled`, `repaint_delay 10`, `input_delay 3`.

## Optional local override pattern

At the bottom of `kitty.conf`, add:

```conf
include ./local.conf
```

Then create `local.conf` on each machine for personal tweaks.

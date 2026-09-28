-- ------------------------------------------------------------------
-- Toolkit environment: consistent theming + file dialogs
--   * GTK / Firefox / Chromium -> xdg-desktop-portal FileChooser (portal-first)
--   * Qt (QFileDialog)          -> native KDE KFileWidget (Dolphin/KIO look)
-- ------------------------------------------------------------------
-- Set here (and NOT in ~/.config/uwsm/env) because this session is started by
-- SDDM via /usr/bin/start-hyprland (not uwsm), so the uwsm env files are never
-- sourced. hl.env values are applied to the compositor process at start and
-- inherited by every process it spawns (requires re-login; hyprctl reload does
-- not re-apply env).
-- Ref: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Qt6 + Qt5 platform theme. Qt splits the value on ':' and uses the FIRST token
-- as the plugin KEY; both libqt5ct.so (Qt5) and libqt6ct.so (Qt6) declare the
-- "qt5ct" key, so Qt5 apps load qt5ct and Qt6 apps load qt6ct.
-- File dialogs: qt6ct uses `standard_dialogs=kde` (see qt6ct.conf) ->
-- plasma-integration's KdePlatformTheme -> native KFileWidget (Dolphin/KIO look).
-- GTK/Chromium keep using the xdg-desktop-portal FileChooser.
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct:qt6ct")

-- Prefer native Wayland, fall back to XCB (XWayland) when unavailable.
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- Let Qt honor the compositor's scale factor.
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- GTK3 (and Firefox): force GtkFileChooserNative through the portal.
-- Only a value whose first char is '1' enables it.
hl.env("GTK_USE_PORTAL", "1")

-- GTK4 does NOT read GTK_USE_PORTAL; portals are forced via GDK_DEBUG.
hl.env("GDK_DEBUG", "portals")

-- Deliberately NOT set: PLASMA_INTEGRATION_USE_PORTAL.
-- plasma-integration's KdePlatformTheme reads it in useXdgDesktopPortal():
-- unset/"0" -> KDEPlatformFileDialogHelper (native KFileWidget, Dolphin look);
-- "1"       -> QXdgDesktopPortalFileDialog (portal -> xdg-desktop-portal-gtk,
--              i.e. the GTK3 chooser that looks like Thunar).
-- File dialogs for Qt are served by the KDE backend, so the portal must stay off.

-- GTK apps: Wayland first, X11 fallback.
hl.env("GDK_BACKEND", "wayland,x11")

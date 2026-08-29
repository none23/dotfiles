#!/usr/bin/env python3

import argparse
import json
import signal
import subprocess
import sys

import gi

gi.require_version("Gdk", "3.0")
gi.require_version("Gtk", "3.0")
gi.require_version("GtkLayerShell", "0.1")

from gi.repository import Gdk, GLib, Gtk, GtkLayerShell


def parse_args():
    parser = argparse.ArgumentParser(
        description="Show a border around each output when a non-default keyboard layout is active."
    )
    parser.add_argument(
        "--border-color",
        default="#2563eb",
        help="CSS color for the border. Default: %(default)s",
    )
    parser.add_argument(
        "--border-width",
        default=2,
        type=int,
        help="Border width in pixels. Default: %(default)s",
    )
    parser.add_argument(
        "--default-layout-index",
        default=0,
        type=int,
        help="Layout index treated as the default/non-highlighted layout. Default: %(default)s",
    )
    parser.add_argument(
        "--poll-ms",
        default=250,
        type=int,
        help="Polling interval for layout changes in milliseconds. Default: %(default)s",
    )
    return parser.parse_args()


class EdgeWindow(Gtk.Window):
    def __init__(self, monitor, edge, border_width):
        super().__init__(type=Gtk.WindowType.TOPLEVEL)
        self.edge = edge

        self.set_decorated(False)
        self.set_accept_focus(False)
        self.set_skip_taskbar_hint(True)
        self.set_skip_pager_hint(True)
        self.stick()

        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_namespace(self, "keyboard-layout-border")
        GtkLayerShell.set_monitor(self, monitor)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
        GtkLayerShell.set_keyboard_mode(self, GtkLayerShell.KeyboardMode.NONE)
        GtkLayerShell.set_exclusive_zone(self, 0)

        for anchored_edge in (
            GtkLayerShell.Edge.TOP,
            GtkLayerShell.Edge.RIGHT,
            GtkLayerShell.Edge.BOTTOM,
            GtkLayerShell.Edge.LEFT,
        ):
            GtkLayerShell.set_anchor(self, anchored_edge, False)

        if edge == "top":
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)
            self.set_size_request(-1, border_width)
        elif edge == "bottom":
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)
            self.set_size_request(-1, border_width)
        elif edge == "left":
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
            self.set_size_request(border_width, -1)
        elif edge == "right":
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, True)
            GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)
            self.set_size_request(border_width, -1)
        else:
            raise ValueError(f"Unsupported edge: {edge}")

        frame = Gtk.Box()
        frame.get_style_context().add_class("keyboard-layout-border")
        self.add(frame)


class KeyboardLayoutBorderApp:
    def __init__(self, args):
        self.args = args
        self.display = Gdk.Display.get_default()
        if self.display is None:
            raise RuntimeError("No graphical display is available.")

        self.windows = []
        self.visible = False

        self._install_css()
        self._rebuild_windows()

        if hasattr(self.display, "connect"):
            self.display.connect("monitor-added", self._on_monitor_changed)
            self.display.connect("monitor-removed", self._on_monitor_changed)

        GLib.timeout_add(self.args.poll_ms, self._refresh_visibility)
        self._refresh_visibility()

    def _install_css(self):
        css = Gtk.CssProvider()
        css.load_from_data(
            f"""
            .keyboard-layout-border {{
                background-color: {self.args.border_color};
            }}
            """.encode("utf-8")
        )
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            css,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
        )

    def _rebuild_windows(self, *_args):
        for window in self.windows:
            window.destroy()
        self.windows = []

        for monitor_index in range(self.display.get_n_monitors()):
            monitor = self.display.get_monitor(monitor_index)
            for edge in ("top", "right", "bottom", "left"):
                window = EdgeWindow(monitor, edge, self.args.border_width)
                self.windows.append(window)

        self._set_visible(self.visible)

    def _on_monitor_changed(self, *_args):
        self._rebuild_windows()

    def _set_visible(self, visible):
        self.visible = visible
        for window in self.windows:
            if visible:
                window.show_all()
            else:
                window.hide()

    def _refresh_visibility(self):
        should_show = self._should_show_border()
        if should_show != self.visible:
            self._set_visible(should_show)
        return True

    def _should_show_border(self):
        keyboard = self._get_primary_keyboard()
        if keyboard is None:
            return False

        active_layout_index = keyboard.get("xkb_active_layout_index")
        if active_layout_index is None:
            return False

        return active_layout_index != self.args.default_layout_index

    @staticmethod
    def _get_primary_keyboard():
        try:
            result = subprocess.run(
                ["swaymsg", "-t", "get_inputs", "--raw"],
                check=True,
                capture_output=True,
                text=True,
            )
        except (FileNotFoundError, subprocess.CalledProcessError):
            return None

        try:
            inputs = json.loads(result.stdout)
        except json.JSONDecodeError:
            return None

        for input_device in inputs:
            if input_device.get("type") == "keyboard":
                return input_device
        return None


def main():
    args = parse_args()

    try:
        app = KeyboardLayoutBorderApp(args)
    except Exception as exc:
        print(f"keyboard-layout-border: {exc}", file=sys.stderr)
        return 1

    signal.signal(signal.SIGINT, lambda *_args: Gtk.main_quit())
    signal.signal(signal.SIGTERM, lambda *_args: Gtk.main_quit())

    Gtk.main()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

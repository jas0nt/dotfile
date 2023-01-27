from .const import *
from .widgets import *
from libqtile import bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen


screens = [
    Screen(
        wallpaper='~/.config/wallpaper.jpg',
        wallpaper_mode='stretch',
        bottom=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    background = theme["background"],
                    custom_icon_paths = [("~/.config/qtile/icons")],
                    foreground = theme["foreground"],
                    scale = 0.8,
                    ),
                #widget.CurrentLayout(),

                widget.GroupBox(
                    active = theme["green"],
                    background = theme["background"],
                    block_highlight_text_color = theme["purple"],
                    disable_drag = True,
                    foreground = theme["foreground"],
                    fontsize = 10,
                    highlight_color = theme["selection"],
                    highlight_method = "line",
                    inactive = theme["foreground"],
                    urgent_border = theme["red"],
                    ),

                widget.Prompt(
                    prompt = 'Run: ',
                    padding = 5,
                    foreground = theme["purple"],
                    bell_style = 'visual',
                    visual_bell_color = theme["red"],
                    ignore_dups_history = True,
                    ),

                widget.WindowName(
                    foreground = theme["foreground"]
                    ),

                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),

                widget.Systray(
                    #icon_size = 22,
                    #foreground = theme["comment"],
                    ),

                widget.Net(
                    format = '{total}',
                    foreground = theme["green"],
                    mouse_callbacks = {'Button1': lazy.spawn('nm-connection-editor')},
                    ),

                widget.Clock(
                    format="%Y/%m/%d %a %I:%M %p",
                    foreground = theme["yellow"],
                    ),

                widget.Battery(
                    foreground = theme["cyan"],
                    ),

                widget.Volume(
                    fmt='🔊: {}',
                    foreground = theme["purple"],
                    ),

                #widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

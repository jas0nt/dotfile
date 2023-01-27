from .const import *
from libqtile import layout
from libqtile.config import Match


floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

layout_theme = {"border_width": 2,
                "margin": 3,
                "border_focus": theme['green'],
                "border_normal": theme['background']
                }

layouts = [
    layout.MonadTall(**layout_theme, ratio=0.75),
    layout.Max(),
    # layout.Columns(**layout_theme),
    # layout.Tile(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

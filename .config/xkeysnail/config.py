import re
from xkeysnail.transform import *

# define_keymap(
#     re.compile("War Thunder \(Vulkan, 64bit\)"),
#     {
#         K("Ctrl-Shift-J"): ,
#     },
# )
define_keymap(
    re.compile("Firefox|firefox|firefox-aurora|librewolf-default|Chromium-freeworld"),
    {
        # ALT IS FOR TABS

        K("Alt-T"): K("C-T"),
        # C for last Closed tab
        K("Alt-C"): K("C-Shift-T"),
        # Fix broken Alt-d and add Alt-enter
        K("Alt-d"): K("C-L"),
        K("Alt-Enter"): K("C-L"),
        # go to End
        K("Alt-E"): K("Alt-KEY_9"),
        # Switch tabs with Alt+Arrows
        K("Alt-left"): K("C-Shift-Tab"),
        K("Alt-right"): K("C-Tab"),
        # Switch tabs with Alt+Tab and Alt+Tilda
        K("Alt-Tab"): K("C-tab"),
        K("Alt-grave"): K("C-Shift-tab"),
        # K("Alt-R"): K("C-Shift-L"), # TODO: map it in firefox extension
        # Navigate history with Alt-F(orward)/B(ackward)
        K("Alt-B"): K("Alt-left"),
        K("Alt-F"): K("Alt-right"),

        # Open bookmarks with F1
        K("F1"): K("C-b"),
        # Open history sidebar
        K("F2"): K("C-h"),
        # Show bookamrks panel
        K("F3"): K("C-Shift-B"),
        # Open tab switcher (see ~/.config/i3/keys)
        K("F4"): K("C-Super-Shift-F4"),
        # Stuff
        K("Alt-Q"): K("Ctrl-W"),
        K("C-Y"): [K("Alt-D"), K("Ctrl-C"), K("ESC")],
        K("C-R"): K("C-Y"),
        K("C-W"): K("PAGE_UP"),
        K("C-U"): K("PAGE_UP"),
        K("C-S"): K("PAGE_DOWN"),
        K("C-D"): K("PAGE_DOWN"),
        K("C-M"): K("C-D"),
    },
)

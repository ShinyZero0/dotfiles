import re
from xkeysnail.transform import *

define_keymap(re.compile("firefox|librewolf-default"), {
    # ALT IS FOR TABS
    K("Alt-T"): K("C-T"),
    # C for last Closed tab
    K("Alt-C"): K("C-Shift-T"),
    # go to End
    K("Alt-E"): K("Alt-KEY_9"),
    # Switch tabs with Alt+Arrows
    K("Alt-left"): K("C-Shift-Tab"),
    K("Alt-right"): K("C-Tab"),
    # Switch tabs with Alt+Tab and Alt+Tilda
    K("Alt-Tab"): K("C-tab"),
    K("Alt-grave"): K("C-Shift-tab"),
    # Navigate history with Alt-ZX
    K("Alt-Z"): K("Alt-left"),
    K("Alt-X"): K("Alt-right"),
    # Open bookmarks with F1
    K("F1"): K("C-b"),
    # Open history sidebar
    K("F2"): K("C-h"),
    # Show bookamrks panel
    K("F3"): K("C-Shift-B"),
    K("Alt-Q"): K("Ctrl-W"),
    K("Alt-Enter"): K("Alt-D"),
    }
)

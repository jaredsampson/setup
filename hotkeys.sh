#!/bin/bash


# TODO
# iTerm:
#   Settings > Keyboard > Shortcuts > Services > Files and folders
#   "New iTerm Window Here" ${CTRL}${OPT}${CMD}t
# Rstudio
#   Next Tab
#   Previous Tab




# first argument is either domain or -g for global hotkey,
# followed by space-delimited key-value pairs.
# e.g. set_hotkeys -g "Duplicate" "@d"
function set_hotkeys() {
    domain=$1
    echo
    if [ $domain == "-g" ]; then
        echo "Setting global hotkeys..."
    else
        echo "Setting hotkeys for $domain..."
    fi
    shift

    # make sure we have complete key-value pairs
    leftover=$(($# % 2))
    if [ $leftover -ne 0 ]; then
        echo "  Hotkey pairs don't match up...try again!"
        echo
        return 1
    fi

    keys=''
 
    while [ $# -gt 0 ];
    do
        echo "  \"$1\" -> \"$2\""
        keys+=$(cat <<EOF
"$1"="$2";
EOF
)
        shift 2
    done

    defaults write $domain NSUserKeyEquivalents "{ $keys }"
    #defaults read $domain NSUserKeyEquivalents
    echo "  ...done."
    return 0
}



############################################################
# Utility variables
############################################################
CMD="@"
OPT="~"
SHIFT="\$"
CTRL='^'

CMDSHIFT="${CMD}${SHIFT}"
SHIFTCMD="${SHIFT}${CMD}"
CMDOPT="${CMD}${OPT}"
OPTCMD="${OPT}${CMD}"
CTRLCMD="${CTRL}${CMD}"
CMDCTRL="${CMD}${CTRL}"

META="${SHIFT}${OPT}${CMD}"
SUPER="${CTRL}${OPT}${CMD}"
HYPER="${SHIFT}${CTRL}${OPT}${CMD}"

# Unicode keys (see below for more)
LEFTARROW="\UF702"
RIGHTARROW="\UF703"
RETURN="\U000A"


# Global
set_hotkeys -g \
    "Duplicate" "${CMD}d" \
    "Save As..." "${SHIFTCMD}s" \
    "Show Help menu" "${SHIFTCMD}/" \
    "Superscript" "${CTRLCMD}=" \
    "Subscript" "${CTRLCMD}-" \
    "Select Previous Tab" "${OPTCMD}${LEFTARROW}" \
    "Select Next Tab" "${OPTCMD}${RIGHTARROW}" \
    "Save as PDF" "${CMD}p" \
    "Show Previous Tab" "${OPTCMD}${LEFTARROW}" \
    "Show Next Tab" "${OPTCMD}${RIGHTARROW}"

# Audacity
# set_hotkeys net.sourceforge.audacity \
#     "Export..." "${SHIFTCMD}e" \
#     "Export Selection..." "${META}e" \
#     "Fade In" "${CMD}<" \
#     "Fade Out" "${CMD}>" \
#     "Zoom In" "${CMD}=" \
#     "Zoom Out" "${CMD}-"

# Calendar
set_hotkeys com.apple.iCal \
    "Previous" "${OPTCMD}${LEFTARROW}" \
    "Next" "${OPTCMD}${RIGHTARROW}"

# Chrome
set_hotkeys com.google.Chrome \
    "Jared (Personal)" "${CTRLCMD}j" \
    "Jared (Schrödinger)" "${CTRLCMD}s" \
    "Print..." "${OPTCMD}p" \
    "Print Using System Dialog..." "${CMD}p"

# Mendeley
# set_hotkeys com.mendeley.Mendeley\ Desktop \
#     "Read" "${SHIFTCMD}r" \
#     "Unread" "${SHIFTCMD}u" \
#     "Enter Full Screen" "${SHIFTCMD}f"

# Microsoft OneNote
# set_hotkeys com.microsoft.onenote.mac \
#     "Code" "${OPTCMD}m"

# nvUltra
set_hotkeys com.multimarkdown.nvUltra \
    "Move Selection to Next Change" "${HYPER}n"

# Pages
set_hotkeys com.apple.Pages \
    "Page Break" "${CMD}${RETURN}"

# Papers
# set_hotkeys com.mekentosj.papers3 \
#     "Hide Cover Page" "${SUPER}c" \
#     "Search" "${CMD}s" \
#     "Actual Size" "${CMD}0" \
#     "Zoom to Fit" "${CMD}9"
#     "Export…->BibTeX Library" "${SHIFTCMD}e"
set_hotkeys com.ReadCube.Papers \
    "Close Tab" "${CMD}w"

# Pixelmator (doesn't work)
#set_hotkeys com.pixelmatorteam.pixelmator \
#"Flip Horizontal" "\$@h" \
#"Flip Vertical" "\$@v" \
#"90° Right" "\$@r"

# RStudio
set_hotkeys com.rstudio.desktop \
    "Previous Tab" "${OPTCMD}${LEFTARROW}" \
    "Next Tab" "${OPTCMD}${RIGHTARROW}"

# Safari
set_hotkeys com.apple.Safari \
    "Show Previous Tab" "${OPTCMD}${LEFTARROW}" \
    "Show Next Tab" "${OPTCMD}${RIGHTARROW}"

# Smultron
#set_hotkeys com.peterborgapps.Smultron4 \
    #"Compile Lilypond" "@l"

# XQuartz
set_hotkeys org.xquartz.X11 \
    "Zoom" "${SUPER}="


## To enter modifier keys (escape with \\ to use literals)
# Command @
# Option ~
# Shift \$
# Control ^

## Literal backslash in a hotkey
# \ \U05C

## Unicode values for some non-character keys
#Esc \U001B
#Tab \U0009
#ShiftTab \U0019
#Return \U000A
#Enter \U000D
#Del \U007F
#UpArrow \UF700
#DownArrow \UF701
#LeftArrow \UF702
#RightArrow \UF703
#Help \UF746
#FwdDel \UF728
#Home \UF729
#End \UF72B
#PageUp \UF72C
#PageDown \UF72D
#Clear \UF739
#F1 \UF704
#F2 \UF705
#F3 \UF706
#F4 \UF706
#F5 \UF707
#F6 \UF708
#F7 \UF709
#F8 \UF70A
#F9 \UF70B
#F10 \UF70C
#F11 \UF70D
#F12 \UF70E
#F12 \UF70F
#F13 \UF710
#F14 \UF711
#F15 \UF712
#F16 \UF713
#F17 \UF714
#F18 \UF715
#F19 \UF716
#F20 \UF717
#F21 \UF718
#F22 \UF719
#F23 \UF71A
#F24 \UF71B
#F25 \UF71C
#F26 \UF71D
#F27 \UF71E
#F28 \UF71F
#F29 \UF720
#F30 \UF721
#F31 \UF722
#F32 \UF723
#F33 \UF724
#F34 \UF725
#F35 \UF726

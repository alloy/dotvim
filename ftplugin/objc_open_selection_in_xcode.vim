command Xcode call system("xcrun xed -l " . line(".") . " " . fnameescape(expand('%:p')) . " && echo 'tell application \"Xcode-Beta\"\\nactivate\\nend tell\\ntell application \"System Events\"\\ntell application process \"Xcode\"\\nclick menu item \"Jump to Selection\" of menu \"Navigate\" of menu bar 1\\nend tell\\nend tell' | osascript")

if exists('s:did_add_open_in_xcode')
  finish
endif
let s:did_add_open_in_xcode = 1

command Xcode call system("xcrun xed -l " . line(".") . " " . fnameescape(expand('%:p')) . " && echo 'tell application \"Xcode\"\\nactivate\\nend tell\\ntell application \"System Events\"\\ntell application process \"Xcode\"\\nclick menu item \"Jump to Selection\" of menu \"Navigate\" of menu bar 1\\nend tell\\nend tell' | osascript")

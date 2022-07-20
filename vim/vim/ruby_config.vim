map <silent> <LocalLeader>rb :TestFile<CR>
map <silent> <LocalLeader>rf :TestNearest<CR>
map <silent> <LocalLeader>rl :TestLast<CR>

let test#strategy = "neovim"
let test#neovim#term_position = "bo 15"

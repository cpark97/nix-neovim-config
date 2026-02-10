-- https://neovim.io/doc/user/lua-guide.html
-- https://neovim.io/doc/user/options.html

-- 엔터를 치거나 o나 O를 사용해 새로운 라인을 만들 때, 현재 라인의 들여쓰기를 복사한다.
-- 이때 새로운 라인에 어떠한 문자도 입력하지 않은 채로 다시 엔터를 치거나 Esc 치거나 다른 줄로 커서를 이동시키면 들여쓰기가 사라진다.
-- default on
-- set autoindent

-- >>, << 명령을 이용해 들여쓰기, 내어쓰기 할 때 삽입될 스페이스 개수
-- default 8
vim.opt.shiftwidth = 2

-- tab 문자가 몇 개의 스페이스로 보이게 할 것인지
-- default 8
vim.opt.tabstop = 8

-- 탭 키를 눌렀을 때 삽입될 스페이스 개수
-- 백스페이스로 지울 때 이전 소프트탭스톱 위치까지 한번에 여러 개의 스페이스를 지움
-- 0으로 설정(미설정)시 tabstop 값이 사용됨
-- default 0
vim.opt.softtabstop = 2

-- 탭 키를 눌렀을 때 tab 문자 대신 스페이스를 삽입
-- default off
vim.opt.expandtab = true

-- <leader> 키 설정
-- default 역슬래시(\)
-- vim.g.mapleader = "\"

-- current directory의 .nvim.lua .nvimrc .exrc 파일을 자동으로 실행
vim.opt.exrc = true

-- Make line numbers default
vim.opt.number = true

vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
-- status line 아래에 모드 표시 비활성화
vim.opt.showmode = false

-- Save undo history
-- 원래 buffer를 닫으면 undo history 날아감
-- undo history를 파일에 저장해서 같은 파일을 다시 열면 undo history를 유지
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
-- \C 사용하지 않으면 대소문자 구분 없이 검색
vim.opt.ignorecase = true
-- 패턴에 대문자가 있으면 대소문자 구분 검색
vim.opt.smartcase = true

-- Configure how new splits should be opened
-- :vsplit 할 때 새로운 윈도우를 오른쪽에 만듬
vim.opt.splitright = true
-- :split할 때 새로운 윈도우를 아래쪽에 만듬
vim.opt.splitbelow = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- 커서가 맨 밑 라인이나 맨 위 라인이 아니더라도 10번째 라인부터 화면이 스크롤됨
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- 원래 검색하면 찾은 결과가 하나씩 하이라이팅되면서 표시되는데, 모든 검색결과에 하이라이팅 표시
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- wezterm에서 osc52 clipboard 읽기를 지원하지 않음
-- 클립보드에서 붙여넣기는 일반적으로 Ctrl-Shift-v 나 Cmd-v 로 가능
-- https://www.reddit.com/r/neovim/comments/1e9vllk/neovim_weird_issue_when_copypasting_using_osc_52/?show=original
-- https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- Diagnostic keymaps
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setqflist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

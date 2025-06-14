# DEAD ENDED

I have added so much to DNSGeek's vim-purebasic that it doesn't make sense to view this as a fork of his repository. I'm pushing my work-in-progress and then creating a new repo.

I had syntax based folding working and a few minor tweaks but the code is not packaged properly. I've copied in some of the Ada code that I still need to review, created what I think are the files needed for a good ftplugin, and left in some notes and grammars from D.Brall on the PureBasic forums.

Sources of code or inspiration:

- Vim's built in Ada support
- Steve Losh's _Learn Vim the Hard Way_
- DNSGeek's original syntax file.
- A good bit of searching and reading of Reddit, SO, and a few blog posts.

## Vim-PureBasic

A Vim syntax highlighting module for `PureBasic` and `SpiderBasic`

### Current Goals

I'm trying to set up indenting and proper comment recognition. I'd really like to write a tree-sitter grammar but that will wait.

### To do

- Comment recognition, working properly for gq gw
- Compiling
  - get run working
  - How to set configuration options
  - Compiler diagnostics as quickfix list & jumps
- Create Neovim fork (after Vim is complete)

### Changes so far

- Added all `pb` file types to `ftdetect`
- Daniel Brall provided pointed me at some grammars he wrote that I might be able to use when building a Tree-sitter grammar. (`DarkDragon` on the PureBasic forums)
  - Downloaded an EBNF grammar for PureBasic
  - Downloaded a Flex grammar for PureBasic
- Added support to compile from vim, folding by indent, jump by sections
- My standard start of file comment style

### Repo items of interest

```text
.
|-- LICENSE
|-- README.md
|-- TreeSitter                    -- References for future expansion
| |-- purebasic.bnf               -- From Daniel Brall
| |-- purebasic.flex
| `-- another.vim                 -- syntax file from vim-scripts/PureBasic-Syntax-File
|-- ftdetect
|   `-- purebasic.vim
|-- ftplugin
| `-- purebasic
|       |-- dicts.vim             -- holding for data from PBIDE that will be vimified
|       |-- folding.vim           -- fold and indent
|       |-- running.vim           -- compile and run from vim
|       |-- sections.vim          -- jump by sections
|       |-- sets.vim              -- settings for PureBasic files
|       `-- work.vim              -- scratch
|-- indent
|   `-- purebasic.vim             -- indent function and support
|-- syntax
|   `-- purebasic.vim             -- original syntax file plus changes
`-- testdata
    |-- README.md
    |-- ide-indented.pb           -- as the PBIDE indents the source
    |-- not-indented.pb           -- no leading white space
    `-- vim-indented.pb           -- testing output
```

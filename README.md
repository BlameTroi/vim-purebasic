# Vim-PureBasic

A Vim syntax highlighting module for `PureBasic` and `SpiderBasic`

## Current Goals

I'm trying to set up indenting and proper comment recognition. I'd really like to write a tree-sitter grammar but that will wait.

## To do

- Comment recognition, working properly for gq gw
- Compiling
  - get run working
  - How to set configuration options
  - Compiler diagnostics as quickfix list & jumps
- Create Neovim fork (after Vim is complete)

## Changes so far

- Added all `pb` file types to `ftdetect`
- Daniel Brall provided pointed me at some grammars he wrote that I might be able to use when building a Tree-sitter grammar. (`DarkDragon` on the PureBasic forums)
  - Downloaded an EBNF grammar for PureBasic
  - Downloaded a Flex grammar for PureBasic
- Added support to compile from vim, folding by indent, jump by sections
- My standard start of file comment style

## Repo items of interest

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
|       |-- folding.vim           -- fold and indent
|       |-- running.vim           -- compile and run from vim
|       |-- sections.vim          -- jump by sections
|       `-- sets.vim -- sets tab/indent stuf
`-- syntax
    `-- purebasic.vim -- original syntax file plus changes
```

# Testing for PureBasic Plugin

## Indenting

Here are a couple of files to work with:

- `ide-indented.pb` -- As the PB IDE would have it.
- `not-indented.pb` -- Leading white space stripped as a base for Vim.

At this point the procedure is to copy `not-indented.pb` to `vim-indented.pb`, edit the new file, indent the whole file via `gg=G`, save it, and diff it against `ide-indented.pb`.

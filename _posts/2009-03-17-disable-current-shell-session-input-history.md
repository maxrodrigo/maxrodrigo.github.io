---
---
If you work a lot in the terminal you may recognize the input history, aka `history`, as a major productivity boost, even if you use the arrow keys to navigate throw it.  
We need to understand that **the history buffer is not committed until you log out**, so everything you see when running the `history` command is not yet written to disk.

To avoid the current input history to be saved we should unset the `HISTFILE` environment variable.

```sh
unset HISTFILE
```

Removing history completely is not a good practice. A better option would be ignoring or deleting a specific line.  
An easy way to avoid saving to the input history is to prepend a blank space before each command. To do this we need to set `HISTCONTROL` to `ignorespace`.

```sh
export HISTCONTROL=ignorespace
```
Finally, to simply delete specific commands from history execute:
```sh
history -d <history-number>
```

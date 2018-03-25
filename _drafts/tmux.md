## A `tmux` introduction

`tmux` is a Terminal Multiplexer and allows you to easily manage multiple terminal applications across sessions, windows, or panes.
Here's an analogy

~~~
tmux:terminal applications::window manager:gui applications
~~~

One important part is that `tmux` will keep these terminal applications running in the background even if you close your session, unless you kill the entire tmux server, i.e. when rebooting.
You can continue your work by simply attaching to a previous session.

Another very popular use case is for [pair programming](https://en.wikipedia.org/wiki/Pair_programming) to allow multiple people to work together on a single version of code
### Why `tmux`?


![why tmux](./images/bhtmux-cartoon.jpg)

Imagine a scenario, which is all too common:

* You are editing code in your favorite terminal editor
* You then need to compile that code
* You also want to test it by running your executable in a another terminal
* You then want to plot some data using a dynamically typed language 
* You then want to monitor the running processes on your system
* You need another terminal to commit your code
* etc.

Normally, this would required 5 seperate terminal windows to manage all of the running tasks.
Furthermore, once a terminal is closed it also closes the associated task.

Now imagine you're trying to do all of this on a remote system over SSH.
If the connection breaks, or you need to disconnect, then all of your running tasks are killed.
This is a huge advantage for those working from a mobile system (laptop).

![tmux](./images/tmux_in_practice.png)

### `tmux` basics

First, you can install `tmux` on Ubuntu using:

~~~
sudo apt-get update
sudo apt-get install tmux
~~~

or Mac OSX (assuming you have [Homebrew](https://brew.sh/)):

~~~
brew install tmux
~~~

Verify that it's installed by running:

~~~
tmux -V
~~~

### Using `tmux`

### Prefix

By default, `tmux` uses the `<prefix>` command `Ctrl-b` before any operation.
This means that you hit `Ctrl` and hold it while hitting the `b` key, then release both and then enter your `tmux` command.

For example, to view a list of running sessions you would enter: `<prefix> s`.

This means you hold `Ctrl` and `b` and then release both then enter `s`.

The `Ctrl` key is used VERY OFTEN, so it makes sense to map your `CapsLock` key to `Ctrl`, which can be done in the settings. 

Add the following to your `.bashrc` or `.zshrc` file on Ubuntu

~~~
setxkbmap -option "caps:escape"
~~~

On Mac OSX you can look in the keyboard properties

![Modifier keys](./images/modifier_keys.png)

### Starting

tmux is based around session.
You start tmux by typing `tmux new` into a terminal window.
It should look exactly like a normal terminal window, except for a green bar at the bottom, which like everything can be customized at will.

![tmux default](./images/tmux_default.png)

### Leaving

You can exit by simply typing `exit`.
However, this is typically not what is best. 
Instead, you usually want to `detach` from tmux but leave it running in the background.

Detach : `<prefix> d`

The detached session is still available and just as you left it. 
You can attach to the session and continue your work exactly as you left it

### Viewing sessions

You can view all sessions by running

List sessions : Outside of `tmux ls` or `<prefix> s` from within

Each session will have a number associated with it (zero based) which can be used to attach to as desired.

~~~
tmux attach-sesion -t 3
~~~

Or just attach to the last session with

~~~
tmux a
~~~

Or to switch to another session from within tmux

~~~
<prefix> s
~~~

which will open a list of all sessions

### Viewing windows

You can switch between windows easily

~~~
<prefix> w
~~~

will open a list of the windows in the current session. You can cycle between them using `<prefix> n` or `<prefix> p` or select them at will `<prefix> [0 through 9]`

### Naming sessions

We don't have to rely on cryptic numbers to refer to sessions.
Instead we can give them specific names, perhaps related to task to purpose

~~~
tmux new -s [name of session]
~~~

Then we can attach to it:

~~~
tmux a -t [name of session]
~~~

And from within tmux we can rename our current session

~~~
<prefix> $ [name of session] <Return>
~~~

### Naming windows

You can rename each window within a session in a similar fashion:

~~~
<prefix> , [type name of current window] <Enter>
~~~

### Managing Windows and Panes

In a GUI environment you have windows which allow you to interact with multiple open applications.
tmux has a similar concept of `panes` which allows you to interact with multiple terminals at once.

Horizontal split : `<prefix> "`

Vertical split : `<previx> %`

![split](./images/split.png)

You can create any number of panes in any configuration!

To move between panes you can use:

~~~
<prefix> [arrow keys]
~~~

Panes can be resized at will:

~~~
<prefix> : resize-pane -[direction] [number of lines]
~~~

where the direction is one of : Up: `U` Down:`D` Left:`L` Right:`R` 


### Customizing `tmux` to the hilt

You can configure almost everything about `tmux` to your liking by modifying options inside of `~/.tmux.conf`
Here is a pretty basic example with some sane settings

~~~
# first bind the prefix to Ctrl-a instead
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# the r key will allow you to source updates to tmux.conf easily
bind r source-file ~/.tmux.conf; display-message "~/.tmux.conf is reloaded!"

# pane navigation uses vim keys in addition to arrow keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# split panes with | and -
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"

# Resize panes easily, but not so that you do it accidentally when switching
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
~~~

For more ideas you can look at the following:

* [Shankar's setup](https://github.com/skulumani/system_setup/blob/master/dotfiles/.tmux.conf)

## Advanced concepts

This covers some more of the theory of how tmux works, and how I end up using tmux most often.

One key idea is the ability to seperate your work into various compartments based on the task or purpose.
I will usually have multiple sessions at any given time.

* `classes` - courses I'm teaching
* `research` - research and papers I'm working on
* `personal` - my fun work and projects
* `computer` - manage some often used computer settings/files. Such as my dotfiles or my `texmf` tree and papers

Within each session, I may have multiple windows further seperating the work.
Within each window I may have multiple panes for all the tools I'm using at any given time.

![nesting](./images/tmuxnesting.png)

This is a guide that I use in practice:

* **Sessions** are used for overall theme of the work. Such as *research* or *work* or *personal*
* **Windows** are used for projects within that theme. So within my *research* session, I might have a window for *publications* and another window for the *code* I'm working on.
* **Panes** are views/applications within the current project. Inside of my *code* window I might have a pane devoted to `vim` and another pane devoted to `ipython`

### Recommendations

1. Use only a few sessions and windows. It is easy to get lost with dozens of windows and sessions
2. Always name your panes and windows to something useful
3. Stick with a sane set of settings before going crazy with customization.


## Resources

* [Tmux Book](https://pragprog.com/book/bhtmux/tmux)
* [Tmux tutorial](http://lmgtfy.com/?q=tmux+tutorial)
* [Cheatsheet](https://gist.github.com/Starefossen/5955406#file-tmux-cheats-md)


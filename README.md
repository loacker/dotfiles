dotfiles
========

My personal configuration files

Clone the repository:
~~~
$ git clone git@github.com:loacker/dotfiles.git ~/.dotfiles
~~~

Create all the symbolic link using the script config.sh and answer the questions:
~~~
$ ~/.dotfiles/config.sh
~~~

The script create a backup in the ~/.dotfiles/bck directory for the old files replaced by a symbolic link.

For the using the script in interactive mode use the "-i" parameter and answer the questions:
~~~
$ ~/.dotfiles/config.sh -i
~~~

The deffault directory for the symbolic link is ~/.dotfiles use the "-d" parameter for an alternative:
~~~
$ ~/.dotfiles/config.sh -d /tmp 
~~~

For a simple and stupid help use the "-h" parameter:
~~~
$ ~/.dotfiles/config.sh -h
Usage: /root/.dotfiles/config.sh [-i] [-d <dotfiles directory absolute path>] args

        The script create a symbolic link for all the dotfiles present in the
        default directory path ~/dotfiles, unless the -d args is used for
        specifing another path.
        Interactively choice which file to link using -i args.
~~~


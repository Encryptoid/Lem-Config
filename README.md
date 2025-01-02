# Lem User Configuration

This is my configuration for Lem. I worked it out from the descriptions here, and the example configs posted at the bottom of the page:
https://lem-project.github.io/usage/configuration/#site-init

I place these files and dirs in ~/.lem

Files in src are not loaded unless added to the module in lem-site-init.asd

I think it's recommended to start your files the following, and then you don't need to refer to Lem fuctions with the Lem prefix. But I am choosing not to, to help learn the namespaces.
```lisp
  (in-package :lem-user)
```

# Structure
## lem-site-init.asd
This defines the lem-site-init system. Here this will load src/example.lisp & src/example2.lisp

```lisp
  (asdf/parse-defsystem:defsystem "lem-site-init"
    :depends-on ()
    :components ((:module "src"
                  :components ((:file "example") (:file "example2")))))
```

There appears to be no need to include files here from the base level of ~/.lem are loaded already.
I like this setup as it lets me define which files are included, and excluded them if needed.


## init.lisp
This is just a basic file which call the function to load the above system
```lisp
  (lem-core::load-site-init)
```

# Loading Contrib Packages (trailing-spaces, tetris, etc.)
Using trailing-spaces as an example, you will want this in your config:
```common-lisp
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (change-buffer-mode buffer 'lem-trailing-spaces::trailing-spaces t)))
```

But also in `lem-site-init.lisp` you will need:
```common-lisp
(asdf/parse-defsystem:defsystem "lem-site-init"
  :depends-on ("lem-trailing-spaces")
  :components ((:module "src" ...)))
```

# vi-mode

See `src/vi-mode.lisp` for more.

## Paredit
When enabling paredit, it can interfere with vim keys (eg. [, {, etcl). For now the solution to undefine the paredit key like so (you can also re-enable in insert-mode):
```common-lisp
(undefine-key *paredit-mode-keymap* "[")
(define-key lem-vi-mode:*insert-keymap* "[" 'paredit-insert-bracket)

(undefine-key *paredit-mode-keymap* "{")
(define-key lem-vi-mode:*insert-keymap* "{" 'paredit-insert-brace)
```

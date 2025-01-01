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


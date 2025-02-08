# Hotwired ATS

This is just my version of the code written in the excellent tutorial found here: https://book.hotwiringrails.com

## Differences

* Uses `vite_ruby`
* Uses docker

## System dependencies

* Docker

## Getting Started

* Build everythign using:

  `script/setup`

* Get it running using:

  `script/restart`


## Merging Changes back into base

If your history looks like this:

```sh
- x - x - x (v2) - x - x - x (v2.1)
           \
            x - x - x (v2-only) - x - x - x (wss)
```

You could use git rebase --onto v2 v2-only wss to move wss directly onto v2:

```sh
- x - x - x (v2) - x - x - x (v2.1)
          |\
          |  x - x - x (v2-only)
           \
             x - x - x (wss)
```
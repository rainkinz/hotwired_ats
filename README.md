# Hotwired ATS

This is just my version of the code written in the excellent tutorial [Hotwiring Rails](https://book.hotwiringrails.com)

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

* Get a console using:

  `script/console`

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

## References

* [Stimulus Controller Docs](https://stimulus.hotwired.dev/reference/controllers)
* [Stimulus Components](https://www.stimulus-components.com)
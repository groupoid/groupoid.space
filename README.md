# Groupoid Infinity, Inc.

Groupoid Infinity is doing research in type theory, term encodings,
program extraction, and effective compilation.
Infinity stack consists of following languages:

* O (lambda) — untyped lambda CPS interpreter
* Om (pts) — typechecker and code extraction
* Infinity (mltt) — high level language with dependent types

Applications:

* Effects (eff) — collection of approaches for each MLTT language
* Types (mltt/types) — MLTT base library

Documentation:

* Papers (tex) — Groupoid Infinity articles.

## Install

```
$ npm install
$ npm start
```

## Site Map

```
.
├── eff
│   ├── io
│   └── ioi
├── lambda
│   ├── extract
│   ├── intro
│   └── runtime
├── mltt
│   ├── inductive
│   ├── infinity
│   ├── iso
│   ├── lambek
│   └── types
│       ├── cat
│       ├── either
│       ├── equiv
│       ├── fun
│       ├── functor
│       ├── iso
│       ├── iso.pi
│       ├── iso.sigma
│       ├── lambek
│       ├── list
│       ├── maybe
│       ├── nat
│       ├── path
│       ├── pi
│       ├── propset
│       ├── proto
│       ├── sigma
│       └── stream
├── pts
│   ├── intro
│   ├── pure
│   ├── semantics
│   └── status
├── styles
└── tex
    ├── articles
    ├── dissertation
    └── slides
```

## Credits

* Arseniy Bushyn
* Maxim Sokhatsky

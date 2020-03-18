# Groupoid Infinity

We are doing research in type theory, encodings, extraction and formalization of mathematics.

## Languages

Groupoid Infinity Runtimes and Provers:

```
groupoid.space/lang
├── apl/
├── cps/
├── eff/io/
├── eff/ioi/
├── hts/
├── ip/
├── ip/process
└── pts/
```

### Runtimes

* APL — tensor array processing runtime (get, put, fold)
* CPS — fast L1 lambda interpreter as runtime (fun, app)
* EFF — effect type system for (in)finite I/O (getString, putString, pure)
* IP — intercore protocol for process calculus (spawn, send, recv)

### Provers

* PTS — pure type system for encodings exploration
* HTS — homotopy type system for mathematical modeling

## Base Library

### Foundation

In the `core` folder presented the PTS/MLTT/HTS base library:

```
groupoid.space/core/
├── list/
├── maybe/
├── nat/
├── path/
├── pi/
├── prop/
├── proto/
├── sigma/
└── stream/
```

### Mathematics

In the `math` folder you will find Mathematical Components for HTS:

```
groupoid.space/math/
├── bundle/
├── category/
├── cw/
├── derham/
├── disc/
├── equiv/
├── functor/
├── homology/
├── hopf/
├── inductive/
├── iso/
├── lambek/
├── limits/
├── presheaf/
├── pullback/
├── sheaf/
└── topos/
```

## Credits

* Arseniy Bushyn
* Maxim Sokhatsky

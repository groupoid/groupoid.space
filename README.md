# Groupoid Infinity

Groupoid Infinity is doing research in type theory, encodings, extraction and formalization of mathematics.

## Languages

Groupoid Infinity Runtimes could be found in `lang` folder:

### Runtimes

```
groupoid.space/lang/
├── cps/
├── eff/
├── ip/
└── apl/
```

* APL — persistent tensor array processing runtime (get, put, fold)
* CPS — fast certified L1 lambda CPS interpreter as runtime (fun, app)
* EFF — effect type system for (in)finite I/O (getString, putString, pure)
* IP — intercore protocol for process calculus (spawn, send, recv)

### Provers

```
groupoid.space/
├── pure/
└── homotopy/
```

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
├── io/
├── ioi/
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

## Usage

The main purpose of HTS is to check Homotopy Types:

```
$ ./homotopy check https://groupoid.space/math/hopf/hopf.txt
```

## Credits

* Arseniy Bushyn
* Maxim Sokhatsky

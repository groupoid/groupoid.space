# Groupoid Infinity

Groupoid Infinity is doing research in type theory, encodings, extraction and formalization of mathematics. 

## Integrated Environment for Mathematician

* ANT — Publishing environment a la ТеХ
* NOTE — Notebook Interface a la Jupyter
* MATH — Computable and Symbolic Mathematics a la Wolfram Mathematica
* ANDERS — Theorem Prover a la Lean/Agda

## Languages

* APL — persistent tensor array processing runtime (get, put, fold)
* CPS — fast certified L1 lambda CPS interpreter as runtime (fun, app)
* EFF — effect type system for (in)finite I/O (getString, putString, pure)
* ITS — intercore protocol for process calculus (spawn, send, recv)

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

In the `foundations` folder presented the MLTT, Modal and Univalent base libraries:

```
groupoid.space/library/foundations/
├── mltt/
│   ├── bool/
│   ├── either/
│   ├── fin/
│   ├── induction/
│   ├── list/
│   ├── maybe/
│   ├── mltt/
│   ├── nat/
│   ├── pi/
│   ├── sigma/
│   └── vec/
├── modal
│   └── infinitesimal/
└── univalent
    ├── equiv/
    ├── extensionality/
    ├── iso/
    ├── path/
    └── prop/
```

### Mathematics

In the `mathematics` folder you will find Mathematical Components for HTS:

```
groupoid.space/library/mathematics/
├── algebra/
│   ├── homology/
│   └── algebra/
├── analysis/
│   └── real/
├── categories/
│   ├── abelian/
│   ├── category/
│   ├── functor/
│   └── groupoid/
├── geometry/
│   ├── bundle/
│   ├── etale/
│   └── formalDisc/
├── homotopy/
│   ├── KGn/
│   ├── S1/
│   ├── Sn/
│   ├── coequalizer/
│   ├── hubSpokes/
│   ├── pullback/
│   ├── pushout/
│   ├── quotient/
│   ├── suspension/
│   └── truncation/
── topoi/
    └── topos/
```

## Misc

```
groupoid.space/misc/
├── course/
├── hist/
├── ncatlab/
├── references/
├── semantics/
└── status/
```

## Articles

```
groupoid.space/articles/
├── cwf/
├── equ/
├── hit/
├── hott/
├── inductive/
├── mltt/
├── pts/
├── quantum/
├── set/
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
* Siegmentation Fault

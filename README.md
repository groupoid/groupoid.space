# Groupoid Infinity

Groupoid Infinity is doing research in type theory, encodings, extraction and formalization of mathematics. 

## Integrated Environment for Mathematician

* ANT — Publishing environment a la ТеХ
* NOTE — Notebook Interface a la Jupyter
* MATH — Computable and Symbolic Mathematics a la Wolfram Mathematica
* HOMOTOPY — Theorem Prover a la Lean/Agda

### Virtual Machines and Runtime Languages

* APL — persistent tensor array processing runtime (get, put, fold)
* CPS — fast certified L1 lambda CPS interpreter as runtime (fun, app)
* EFF — effect type system for (in)finite I/O (getString, putString, pure)
* N2O — app frameworks: MNESIA, BPE, N2O, KVS, NITRO
* PROCESS — intercore protocol for process calculus (spawn, send, recv)

### Verification Languages

* Principia — METAMATH-like prover
* PTS — Pure Type System for encodings exploration
* HTS — Modal CCHM Homotopy Type System for math modeling
* HoTT-I — JetBrains Arend-like core
* HoTT-∂ — Groupoid Homotopy Core

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

The main purpose of Anders is doing Homotopy Theory:

```
$ opam install anders
$ anders repl
Anders theorem prover [MLTT][CCHM][HTS][deRham] version 1.1.1
>
```

## Credits

* Arseniy Bushyn
* Maxim Sokhatsky
* Siegmentation Fault

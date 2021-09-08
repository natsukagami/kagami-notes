---
title: A Brief on Blame Calculus
date: 2021-09-08T17:00:00+09:00
draft: false
---

# A Brief on Blame Calculus

This is a short overview of [Philip Wadler and Robert Bruce Findler. 2009. Well-Typed Programs Can’t Be Blamed. In *Programming Languages and Systems* (Lecture Notes in Computer Science), Springer, Berlin, Heidelberg, 1–16. DOI:https://doi.org/10.1007/978-3-642-00590-9_1](https://doi.org/10.1007/978-3-642-00590-9_1).

## 1. What is Blame Calculus and what is it for?

Blame calculus is an extension of a mixed-typed lambda calculus (i.e. containing both typed terms and untyped terms working on the catch-all type `Dyn`).

The purpose is to create a language where:

- Both untyped terms and typed terms co-exist, and typed terms are well-typed.
- There exists a decidable well-form check, and a *semi*-decidable well-typedness check.
- All well-typed terms (both typed and untyped) have a single type.

### Additions to mixed-typed calculus

It features the following extensions to the type system:

- Refinement types: $\text{Nat} = \{x : \text{Int} \mid x \ge 0\}$, with runtime casting.
- A fully dynamic type `Dyn`, with compile-time upcasting and runtime downcasting.

It features the following extensions to the expression list:

- Casting operation: $\left<S\Leftarrow T\right>^{p} s$ is a cast from $s: T$ to $S$ (when $S \sim T$ - $S$ is *compatible to* $T$) , either
  - succeeding returning $s: S$, or
  - failing, returning $\Uparrow p$. We call this __blaming on $p$__.
- An internal transformation expression: $t \triangleright^p s_B$ where $t: \text{Bool}$, either
  - succeeding with $s: \{B \mid t\}$ when $t = \text{True}$, or
  - failing with $\Uparrow p$ otherwise.

A blame on $p$ can either be 

- **positive**, where the cast fails due to the *inner expression* having an incompatible type with the destination type.

- **negative**, where the cast fails due to the *surrounding context* failing to comply with the destination type.

  - This is possible only from the *delayed* casting behavior of Blame Calculus:

  $$
  (\left<S \rightarrow T \Leftarrow S' \rightarrow T'\right>^p f)(v : S) 
  	\longrightarrow
  \left<T \Leftarrow T'\right>^p\left(f \left(\left<S' \Leftarrow S\right>^{\overline{p}}v\right)\right)
  $$

  (notice the flip from $p$ to $\overline p$ on the cast of $v$)

### Subtyping in Blame Calculus

Instead of the standard subtyping relation, which is **undecidable** in Blame Calculus (due to refinement types), it opts to an equally powerful system called positive (safe casts without positive blames) (denoted as $S <:^+ T$), negative ($S <:^- T$) and naive ($S <:_n T$) (which means $S <:^+ T$ and $T <:^- S$).

Unlike standard subtyping which is contravariant on the argument and covariant on the return type, naive subtyping is covariant on both sides.

### Well-formednes

Two additional syntax extensions are made in order to mix typed and untyped expressions:

- $\lfloor M \rfloor$ casts the *typed* expression $M$ into an untyped expression. This is well-formed if and only if $M : \text{Dyn}$ (so a cast is most likely to happen somewhere).
- $\lceil M \rceil$ casts the *untyped* expression $M$ into a typed expression returning $\text{Dyn}$. This is well-formed if and only if 
  - all free variables in it has type $\text{Dyn}$, and
  - all of its subterms have type $\text{Dyn}$.

## 2. Remarks

The central result of the paper, the **Blame Theorem**, states that:

> Let $t$ be a well-typed term with a subterm $\left<T \Leftarrow S\right>^p s$ containing the only occurrences of $p$ in $t$.
>
> Then:
>
> - If $S <:^+ T$ then $t \not\longrightarrow^* \Uparrow p$.
> - If $S <:^- T$ then $t \not\longrightarrow^* \Uparrow \overline p$.
> - If $S <: T$ then $t$ will not blame on either $p$ nor $\overline p$.

In other words, from the decidable positive/negative subtyping relations, we can safely deduce which casts will not create a positive or negative blame. 

This solidifies the intuition of upcasting/downcasting in the simple OOP sense, and allows us to extend this blame calculus with more structures, as long as the subtyping relations are still decidable.

## 3. Semantics

Please refer to the paper.
# Chapter 2, Section 2: Hierarchical Data and the Closure Property

**Signal processing** is the process of treating processes as a flow which is
transformed one step at a time. While this style doesn't require a specific
order, it typically works as follows:
1. **Enumerate:** generate a list of data elements according to some
   specification.
2. **Filter:** take a list and a test (predicate), and return all the elements
   that satisfy that test.
3. **Map:** take a procedure and a list, and return a new list with that
   procedure applied to every element of the list.
   * **Do:** imperative-style list iteration that performs an operation for
     each list element. AKA for-each.
4. **Accumulate:** combine a list of inputs with a given procedure. AKA
   combine, fold, or collapse.

* **Modularity:** allowing components to be added, removed, and composed in
  different ways. Embodied by the Unix philosphy:
  > Do one thing, and do it well.
* **Conventional interface:** generic interface, as higher-order compositions
  of general operations on data, independent of its representation.
* **Application programming interface:** data abstraction example of a conventional interface. Makes an entire program a composable, extensible unit of anything you want. AKA API.
* **Stratified design:** complex systems should be structured as a hierarchy of
  levels, each of which only communicates with the levels directly above and
  below it. Like a stack!
* **Primitive:** most elementary, indivisible data or operation that is
  implicitly defined by its behavior and not other data/procedures.
* **Robustness:** small changes in specification result in small changes in
  representation. Often involves modular, stratified code that utilizes stream
  processing techniques.

[![Actions Status](https://github.com/lizmat/Map-Agnostic/workflows/test/badge.svg)](https://github.com/lizmat/Map-Agnostic/actions)

NAME
====

Map::Agnostic - be a map without knowing how

SYNOPSIS
========

    use Map::Agnostic;
    class MyMap does Map::Agnostic {
        method INIT-KEY($key,$value) { ... }
        method AT-KEY($key)          { ... }
        method EXISTS-KEY($key)      { ... }
        method keys()                { ... }
    }

    my %m is MyMap = a => 42, b => 666;

    my %m is Map::Agnostic = ...;

DESCRIPTION
===========

This module makes a `Map::Agnostic` role available for those classes that wish to implement the `Associative` role as an immutable `Map`. It provides all of the `Map` functionality while only needing to implement 4 methods:

Required Methods
----------------

### method INIT-KEY

    method INIT-KEY($key, $value) { ... }

Bind the given value to the given key in the map, and return the value. This will only be called during initialization of the `Map`. The functioality is the same as the `BIND-KEY` method, but it will only be called at initialization time, whereas `BIND-KEY` can be called at any time and will fail.

### method AT-KEY

    method AT-KEY($key) { ... }

Return the value at the given key in the map.

### method EXISTS-KEY

    method EXISTS-KEY($key) { ... }

Return `Bool` indicating whether the key exists in the map.

### method keys

    method keys() { ... }

Return the keys that currently exist in the map, in any order that is most convenient.

Optional Methods (provided by role)
-----------------------------------

You may implement these methods out of performance reasons yourself, but you don't have to as an implementation is provided by this role. They follow the same semantics as the methods on the [Map object](https://docs.perl6.org/type/Map).

In alphabetical order: `elems`, `end`, `gist`, `Hash`, `iterator`, `kv`, `list`, `List`, `new`, `pairs`, `perl`, `Slip`, `STORE`, `Str`, `values`

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Map-Agnostic . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2021 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


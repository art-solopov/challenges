# Python 3: Metaclasses

This nano-project is a quick intro to metaclasses in Python, mostly in the way
they're used to build ORMs.

The `converter` module houses the `Converter` descriptor, which, on setting the
assigned attribute value, converts it to the given type. It also contains the
`ConvertMeta` metaclass, which sets up the converters.

The `main` module provides an example usage. The `Account` class there uses
`ConvertMeta` as its metaclass, assigning its attributes to a type. Together,
the `ConvertMeta` metaclass and the `Converter` descriptor provide a way to
convert the attributes' values on the fly.

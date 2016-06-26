class Converter:
    """A descriptor used to convert the attribute into a given type
    """

    def __init__(self, tp, name):
        self.type = tp
        self.name = name

    def __set__(self, obj, value):
        if isinstance(value, self.type):
            obj.__dict__[self.name] = value
        else:
            obj.__dict__[self.name] = self.type(value)

    def __get__(self, obj, _objtype):
        return obj.__dict__.get(self.name, None)

class ConvertMeta(type):
    def __new__(cls, name, bases, namespace, **kw):
        for k, v in namespace.items():
            if not isinstance(v, type):
                continue
            namespace[k] = Converter(v, name=k)
        return type.__new__(cls, name, bases, namespace)

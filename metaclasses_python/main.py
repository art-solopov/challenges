from converter import ConvertMeta

class Money:
    """A small currency class
    """

    def __init__(self, amount, cents_qty=100):
        self.cents_qty = cents_qty
        self.amount = int(float(amount) * cents_qty) # Convert to integer cents

    def __float__(self):
        return self.amount / self.cents_qty

    def __int__(self):
        return self.amount // self.cents_qty

    def __str__(self):
        return "{:.2f}".format(float(self.amount / self.cents_qty))

class Account(metaclass=ConvertMeta):
    id = int
    name = str
    amount = Money

    def __init__(self, id, name, amount):
        self.id = id
        self.name = name
        self.amount = amount

    def __str__(self):
        return "[{0}] {1}: {2}".format(self.id, self.name, self.amount)

if __name__ == '__main__':
    acc = Account(name='John#card', id="510001", amount="42300.50")
    acc2 = Account(name='John#current', id=510010, amount = 1300)
    print(acc)
    print(acc2)

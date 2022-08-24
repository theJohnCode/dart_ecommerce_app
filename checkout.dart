import 'dart:io';

class Product {
  const Product({required this.id, required this.name, required this.price});
  final int id;
  final String name;
  final double price;

  String get displayName => '($initial)${name.substring(1)}: \$$price';
  String get initial => name.substring(0, 1);
}

class Item {
  const Item({required this.product, this.quantity = 1});
  final Product product;
  final int quantity;

  double get price => quantity * product.price;

  @override
  String toString() => '$quantity x ${product.name}: \$$price';
}

class Cart {
  final Map<int, Item> _items = {};

  void addProducts(Product product) {
    final item = _items[product.id];
    if (item == null) {
      _items[product.id] = Item(product: product, quantity: 1);
    } else {
      _items[product.id] = Item(product: product, quantity: item.quantity + 1);
    }
  }

  bool get isEmpty => _items.isEmpty;

  double total() => _items.values
      .map((item) => item.price)
      .reduce((value, element) => value + element);

  @override
  String toString() {
    if (_items.isEmpty) {
      return 'Cart is Empty';
    }
    final itemizedList =
        _items.values.map((item) => item.toString()).join('\n');
    return '------\n$itemizedList\nTotal: \$${total()}\n------';
  }
}

const allProducts = [
  Product(id: 1, name: 'Apple', price: 150.0),
  Product(id: 2, name: 'Banana', price: 300.0),
  Product(id: 3, name: 'Egg', price: 100.0),
  Product(id: 4, name: 'Tea', price: 70.0),
  Product(id: 5, name: 'Meat', price: 500.0),
  Product(id: 6, name: 'Orange', price: 50.0),
];
void main() {
  final cart = Cart();
  while (true) {
    stdout.write(
        'What do you want to do? (v)iew items, (a)dd items, (c)checkout ');
    final line = stdin.readLineSync();
    if (line == 'a') {
      final product = chooseProduct();
      if (product != null) {
        cart.addProducts(product);
        print(cart);
      }
    } else if (line == 'c') {
      if (checkout(cart)) {
        break;
      }
    } else if (line == 'v') {
      print(cart);
    }
  }
}

Product? chooseProduct() {
  final productLists =
      allProducts.map((product) => product.displayName).join('\n');
  stdout.write('Available products:\n$productLists\n Your choice ');
  final line = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial.toLowerCase() == line) {
      return product;
    }
  }
  print('Not Found');
  return null;
}

bool checkout(Cart cart) {
  if (cart.isEmpty) {
    print('Cart is Empty');
    return false;
  }
  final total = cart.total();
  print('Total: \$$total');
  stdout.write('Payment in cash ');
  final line = stdin.readLineSync();
  if (line == null || line.isEmpty) {
    return false;
  }
  final paid = double.tryParse(line);
  if (paid == null) {
    return false;
  }
  if (paid >= total) {
    final change = paid - total;
    print('Change: \$${change.toStringAsFixed(2)}');
    return true;
  } else {
    print('Not enough cash ');
    return false;
  }
}

import 'cart_item.dart';

class Purchase {
  final String name;
  final String email;
  final List<CartItem> cart;

  Purchase({required this.name, required this.email, required this.cart});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    var cartList =
        (json['cart'] as List).map((item) => CartItem.fromJson(item)).toList();

    return Purchase(name: json['name'], email: json['email'], cart: cartList);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'cart': cart.map((item) => item.toJson()).toList(),
    };
  }
}

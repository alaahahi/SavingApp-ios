class CartItem {
  final int id;
  int quantity;

  CartItem({
    this.id = 0,
    this.quantity = 1,
  });

  CartItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}

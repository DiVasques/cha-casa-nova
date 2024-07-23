class CartItem {
  final String id;
  final String name;
  final double piecePrice;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.piecePrice,
    required this.quantity,
  });
  @override
  String toString() {
    return 'item: $name quantidade: $quantity';
  }
}

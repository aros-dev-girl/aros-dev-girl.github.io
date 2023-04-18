import 'package:tiara/modelos/cart_item.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> membros;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.membros,
    required this.date,
  });
}

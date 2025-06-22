class CartItem {
  final int eventId;
  final String eventName;
  final int ticketId;
  final String ticketType;
  final int quantity;
  final double price;

  CartItem({
    required this.eventId,
    required this.eventName,
    required this.ticketId,
    required this.ticketType,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      eventId: int.parse(json['event_id'].toString()),
      eventName: json['event_name'].toString(),
      ticketId: int.parse(json['ticket_id'].toString()),
      ticketType: json['ticket_type'].toString(),
      quantity: int.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }

  CartItem copyWith({
    int? eventId,
    String? eventName,
    int? ticketId,
    String? ticketType,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      ticketId: ticketId ?? this.ticketId,
      ticketType: ticketType ?? this.ticketType,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'ticket_id': ticketId,
      'quantity': quantity,
      'price': price,
    };
  }
}

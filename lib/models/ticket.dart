class Ticket {
  final int id;
  final int eventId;
  final String type;
  final double price;
  final int quantityAvailable;

  Ticket({
    required this.id,
    required this.eventId,
    required this.type,
    required this.price,
    required this.quantityAvailable,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json['id'],
    eventId: json['event_id'],
    type: json['type'],
    price: json['price'].toDouble(),
    quantityAvailable: json['quantity_available'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'type': type,
      'price': price,
      'quantity_available': quantityAvailable,
    };
  }
}

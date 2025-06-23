import 'package:flutter_test/flutter_test.dart';
import 'package:eventeny_app/models/ticket.dart';

void main() {
  group('Ticket Model', () {
    test('fromJson and toJson work correctly', () {
      final json = {
        'id': 1,
        'event_id': 42,
        'type': 'VIP',
        'price': 99.99,
        'quantity_available': 100,
      };

      // Test fromJson
      final ticket = Ticket.fromJson(json);
      expect(ticket.id, 1);
      expect(ticket.eventId, 42);
      expect(ticket.type, 'VIP');
      expect(ticket.price, 99.99);
      expect(ticket.quantityAvailable, 100);

      // Test toJson
      final backToJson = ticket.toJson();
      expect(backToJson, {
        'id': 1,
        'event_id': 42,
        'type': 'VIP',
        'price': 99.99,
        'quantity_available': 100,
      });
    });
  });
}

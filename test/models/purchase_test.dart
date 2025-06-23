import 'package:flutter_test/flutter_test.dart';
import 'package:eventeny_app/models/purchase.dart';

void main() {
  group('Purchase Model', () {
    test('fromJson and toJson work correctly', () {
      final json = {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'cart': [
          {'event_id': 1, 'ticket_id': 10, 'quantity': 2, 'price': 50.0},
          {'event_id': 2, 'ticket_id': 20, 'quantity': 1, 'price': 100.0},
        ],
      };

      final purchase = Purchase.fromJson(json);
      expect(purchase.name, 'John Doe');
      expect(purchase.email, 'john.doe@example.com');
      expect(purchase.cart.length, 2);

      final cartItem1 = purchase.cart[0];
      expect(cartItem1.eventId, 1);
      expect(cartItem1.ticketId, 10);
      expect(cartItem1.quantity, 2);
      expect(cartItem1.price, 50.0);

      final cartItem2 = purchase.cart[1];
      expect(cartItem2.eventId, 2);
      expect(cartItem2.ticketId, 20);
      expect(cartItem2.quantity, 1);
      expect(cartItem2.price, 100.0);

      // NOW, when you serialize back to JSON, it should match the original input JSON
      expect(purchase.toJson(), equals(json));
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

// State structure: Map<ticketId, quantity>
final ticketQuantityProvider =
    StateNotifierProvider<TicketQuantityNotifier, Map<int, int>>(
      (ref) => TicketQuantityNotifier(),
    );

class TicketQuantityNotifier extends StateNotifier<Map<int, int>> {
  TicketQuantityNotifier() : super({});

  void setQuantity(int ticketId, int quantity) {
    state = {...state, ticketId: quantity};
  }

  int getQuantity(int ticketId) {
    return state[ticketId] ?? 0;
  }

  void clear() {
    state = {};
  }
}

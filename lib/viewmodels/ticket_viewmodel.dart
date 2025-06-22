import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/ticket.dart';
import '../providers/providers.dart';

final ticketViewModelProvider = Provider<TicketViewModel>((ref) {
  final api = ref.read(apiServiceProvider);
  return TicketViewModel(api);
});

class TicketViewModel {
  final ApiService api;

  TicketViewModel(this.api);

  Future<List<Ticket>> fetchTickets(int eventId) async {
    return await api.getTickets(eventId);
  }
}

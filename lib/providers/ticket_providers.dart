import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket.dart';
import '../viewmodels/ticket_viewmodel.dart';
import '../providers/providers.dart';

final ticketViewModelProvider = Provider<TicketViewModel>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return TicketViewModel(apiService);
});

// New FutureProvider.family for async UI state
final ticketsProvider = FutureProvider.family<List<Ticket>, int>((
  ref,
  eventId,
) async {
  final viewModel = ref.read(ticketViewModelProvider);
  return viewModel.fetchTickets(eventId);
});

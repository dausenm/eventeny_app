import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import '../providers/providers.dart';

final eventViewModelProvider = Provider((ref) => EventViewModel(ref));

class EventViewModel {
  final Ref ref;

  EventViewModel(this.ref);

  Future<List<Event>> fetchEvents() {
    final api = ref.read(apiServiceProvider);
    return api.getEvents();
  }
}

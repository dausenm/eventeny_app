import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import '../providers/providers.dart';

final filteredEventProvider = FutureProvider.family<List<Event>, String>((
  ref,
  query,
) async {
  final api = ref.read(apiServiceProvider);
  final allEvents = await api.getEvents();

  if (query.isEmpty) {
    return allEvents;
  }

  return allEvents
      .where((event) => event.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import './providers.dart';
import '../models/event.dart';

final eventListProvider = FutureProvider<List<Event>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return await api.getEvents();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final sortOrderProvider = StateProvider<String>(
  (ref) => 'date',
); // or 'price', etc.
final categoryFilterProvider = StateProvider<String?>(
  (ref) => null,
); // null = no filter

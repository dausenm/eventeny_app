import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/purchase.dart';
import './providers.dart';

final submitOrderProvider = FutureProvider.family<void, Purchase>((
  ref,
  purchase,
) async {
  final api = ref.read(apiServiceProvider);
  await api.submitOrder(purchase);
});

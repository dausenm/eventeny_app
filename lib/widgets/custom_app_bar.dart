import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/event_providers.dart';
import '../providers/ticket_providers.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Widget titleWidget;

  const CustomAppBar({Key? key, required this.titleWidget}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: titleWidget,
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Invalidate providers to refresh data
            ref.invalidate(eventListProvider);
            ref.invalidate(ticketsProvider);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

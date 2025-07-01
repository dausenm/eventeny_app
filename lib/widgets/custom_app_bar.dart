import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/event_providers.dart';
import '../providers/ticket_providers.dart';
import '../viewmodels/filtered_event_viewmodel.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Widget titleWidget;

  const CustomAppBar({Key? key, required this.titleWidget}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      foregroundColor: theme.appBarTheme.foregroundColor,
      title: titleWidget,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Home',
          onPressed: () {
            ref.invalidate(eventListProvider);
            ref.invalidate(filteredEventProvider(''));
            ref.invalidate(ticketsProvider);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'Cart',
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

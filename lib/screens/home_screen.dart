import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';
import '../viewmodels/filtered_event_viewmodel.dart';
import '../exceptions/no_internet_exception.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventListAsync = ref.watch(filteredEventProvider(_searchQuery));

    return Scaffold(
      appBar: const CustomAppBar(titleWidget: Text('Events')),
      bottomNavigationBar: const CustomFooter(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: eventListAsync.when(
              data:
                  (events) =>
                      events.isEmpty
                          ? const Center(child: Text('No events found.'))
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: events.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 1,
                                  ),
                              itemBuilder: (context, index) {
                                final event = events[index];
                                return EventCard(
                                  event: event,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => EventDetailsScreen(
                                              event: event,
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) {
                if (error is NoInternetException) {
                  return const Center(
                    child: Text(
                      'No internet connection.\nPlease check your network settings and try again.',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Center(child: Text('Error: ${error.toString()}'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

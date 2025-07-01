import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';
import '../models/ticket.dart';
import '../models/purchase.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/no_internet_exception.dart';
import 'dart:io';

class ApiService {
  static const String baseUrl =
      'https://eventenybackend-production.up.railway.app';

  Future<List<Event>> getEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_events.php'));

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((json) => Event.fromJson(json)).toList();
        } catch (e) {
          throw ApiException("parsing_error", "Failed to parse event data.");
        }
      } else {
        throw ApiException("fetch_error", "Failed to load events.");
      }
    } on SocketException {
      throw NoInternetException(); // Custom exception for offline handling
    } catch (e) {
      throw ApiException("unexpected_error", e.toString());
    }
  }

  Future<List<Ticket>> getTickets(int eventId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get_tickets.php?event_id=$eventId'),
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Ticket.fromJson(json)).toList();
      } catch (e) {
        throw ApiException("parsing_error", "Failed to parse ticket data.");
      }
    } else {
      throw ApiException("fetch_error", "Failed to load tickets.");
    }
  }

  Future<void> submitOrder(Purchase purchase) async {
    final response = await http.post(
      Uri.parse('$baseUrl/submit_order.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(purchase.toJson()),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      if (response.body.contains("Not enough tickets")) {
        throw ApiException(
          "not_enough_tickets",
          "Not enough tickets available.",
        );
      }

      try {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final backendError = errorResponse['details'] ?? "Unknown error";
        throw ApiException("backend_error", backendError);
      } catch (_) {
        throw ApiException("unexpected", "Failed to submit order.");
      }
    }
  }
}

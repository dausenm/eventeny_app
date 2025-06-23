import 'package:flutter_test/flutter_test.dart';
import 'package:eventeny_app/models/event.dart';

void main() {
  group('Event Model', () {
    test('Event Model fromJson and toJson work correctly', () {
      final json = {
        'id': 1,
        'name': 'Test Event',
        'date': '2025-07-18T00:00:00.000',
        'location': 'Huntsville, AL',
        'description': 'Test Description',
        'image_url': 'https://example.com/image.jpg',
      };

      final event = Event.fromJson(json);
      expect(event.id, 1);
      expect(event.name, 'Test Event');
      expect(event.date, DateTime(2025, 7, 18));
      expect(event.location, 'Huntsville, AL');
      expect(event.description, 'Test Description');
      expect(event.imageUrl, 'https://example.com/image.jpg');

      final toJson = event.toJson();
      expect(toJson, {
        'id': 1,
        'name': 'Test Event',
        'date': '2025-07-18T00:00:00.000',
        'location': 'Huntsville, AL',
        'description': 'Test Description',
        'image_url': 'https://example.com/image.jpg',
      });
    });
  });
}

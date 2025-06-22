class Event {
  final int id;
  final String name;
  final String location;
  final DateTime date;
  final String description;
  final String? imageUrl;

  Event({
    required this.id,
    required this.name,
    required this.location,
    required this.date,
    required this.description,
    this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'date': date.toIso8601String(),
      'description': description,
      'image_url': imageUrl,
    };
  }
}

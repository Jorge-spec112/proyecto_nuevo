class Info {
  final String title;
  final String imageUrl;
  final String description;
  final String date;

  Info({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.date,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

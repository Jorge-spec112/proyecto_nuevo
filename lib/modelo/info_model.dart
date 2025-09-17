class Info {
  final String title;
  final String imageUrl;

  Info({required this.title, required this.imageUrl});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(title: json['title'] ?? '', imageUrl: json['imageUrl'] ?? '');
  }
}

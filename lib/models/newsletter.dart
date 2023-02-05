class Newsletter {
  final String title;
  final String description;
  final String readTime;
  final String writer;
  final String topic;
  final String imageUrl;

  Newsletter({
    required this.title,
    required this.description,
    required this.readTime,
    required this.writer,
    required this.topic,
    required this.imageUrl,
  });

  contains(String searchTerm) {}
}

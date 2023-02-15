class Newsletter {
  final String id;
  final String title;
  final String description;
  final String readTime;
  final String writer;
  final String topic;
  final String imageUrl;
  final String pdfLink;
  final bool isBookmarked;
  Newsletter({
    required this.id,
    required this.title,
    required this.description,
    required this.readTime,
    required this.writer,
    required this.topic,
    required this.imageUrl,
    required this.pdfLink,
    required this.isBookmarked,
  });

  contains(String searchTerm) {}
}

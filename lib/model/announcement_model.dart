class AnnouncementModel {
  final int id;
  final String title;
  final String content;
  final String publishedDate;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedDate,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    // Extract text from nested content array
    String extractedContent = '';
    if (json['content'] is List && json['content'].isNotEmpty) {
      for (var item in json['content']) {
        if (item['children'] is List && item['children'].isNotEmpty) {
          for (var child in item['children']) {
            if (child['text'] != null) {
              extractedContent += child['text'];
            }
          }
        }
      }
    }

    return AnnouncementModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: extractedContent,
      publishedDate: json['published'] ?? '',
    );
  }
}

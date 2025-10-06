class PollModel {
  final int id;
  final String title;
  final Map<String, String> options;
  final String? endDate;
  final bool active;

  PollModel({
    required this.id,
    required this.title,
    required this.options,
    required this.endDate,
    required this.active,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'],
      title: json['title'] ?? '',
      options: Map<String, String>.from(json['options'] ?? {}),
      endDate: json['end_date'],
      active: json['active'] ?? false,
    );
  }
}

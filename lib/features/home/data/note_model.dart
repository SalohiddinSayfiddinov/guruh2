class NoteModel {
  final String userId;
  final String title;
  final String content;

  NoteModel({
    required this.userId,
    required this.title,
    required this.content,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'NoteModel(userId: $userId, title: $title, content: $content)';
  }
}

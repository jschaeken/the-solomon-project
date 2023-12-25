class ConvoPreview {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isFavorite;

  const ConvoPreview({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isFavorite = false,
  });
}

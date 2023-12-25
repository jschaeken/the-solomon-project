class Message {
  final String id;
  final String text;
  final DateTime createdAt;
  final bool fromSoloman;

  Message({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.fromSoloman,
  });
}

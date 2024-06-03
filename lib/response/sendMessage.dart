
class SendMessage {
  final Map<String, String>? messages;
  final List<Map<String, String>>? options;
  final List<Map<String, String>>? subOptions;

  const SendMessage({
    required this.messages,
    required this.options,
    required this.subOptions
  });
}
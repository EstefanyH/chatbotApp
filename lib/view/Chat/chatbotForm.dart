import 'package:appchatbot/viewModel/chatViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBotForm extends StatefulWidget {
  const ChatBotForm({super.key});

  @override
  State<ChatBotForm> createState() => _ChatBotFormState();
}

class _ChatBotFormState extends State<ChatBotForm> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

 @override
  void initState() {
    super.initState();
  }

  void _sendMessage(BuildContext context, String text) {
    setState(() {
      _messages.add({'text': text, 'sender': 'user'});
    });
    _controller.clear();
    //_getBotResponse(text);
    context.read<ChatViewModel>().sendMessage(context,messages: _messages, texto: text);
    
    setState(() {
      _messages.add({'text': context.read<ChatViewModel>().resultado, 'sender': 'bot'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ChatViewModel>().chatFormKey,
      child: Padding(
        padding: const EdgeInsets.all(5.0), 
        child: Column(
         children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return ListTile(
                  title: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      child: Text(message['text']!),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(context, _controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ], 
        ),
      ),  
    );
  }

}

import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/network/ChatService.dart';
import 'package:appchatbot/viewModel/chatViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBotForm extends ChatViewModel {
 
  ChatService get chatViewModel => context.read<ChatService>();
  
  final TextEditingController _controller = TextEditingController();
  
  @override
  void initState() {
    super.initState(); 
    chatViewModel.clearMessage();
  }
  
  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            closeView();
          },
          icon: const Icon(Icons.close, 
          color: Colors.indigo,)),
        backgroundColor: Colors.white,
        title: const Text("ChatBot", 
          style: style16Black,),
      ),
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.all(5.0), 
        child: Column(
         children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: chatViewModel.messages?.length,
              itemBuilder: (context, index) {
                final messagex = chatViewModel.messages?[index];
                final isUser = messagex?['sender'] == 'user';
                return ListTile(
                  title: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      child: Text(messagex!['text']!),
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
                      sendMessage(texto: _controller.text);
                      _controller.clear();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera),
                  onPressed: () { },
                )
              ],
            ),
          ),
        ], 
        ),
      ),  
    );
  }
}
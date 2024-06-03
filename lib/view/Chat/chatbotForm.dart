import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/network/ChatService.dart';
import 'package:appchatbot/viewModel/chatViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              itemCount: chatViewModel.sendMessage?.length,
              itemBuilder: (context, index) {
                final row = chatViewModel.sendMessage?[index];
                final message = row?.messages;
                final option = row?.options;
                final isUser = message?['sender'] == 'user'; 

                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child:  Container(
                            padding: const EdgeInsets.all(8),
                            color: isUser ? Colors.blue[100] : Colors.grey[300],
                            child: Text(message!['text']!),
                          ),                          
                        ),
                      ),
                      Wrap(
                        direction: Axis.vertical, 
                        children: List.generate(option!.length,(f) {
                          final buttons = option[f];
                          final nameBtn = buttons['text'];
                          final codeBtn = buttons['code'];  
                          final typeBtn = buttons['type'];  
                          return Visibility(
                            child: TextButton.icon(
                              icon:  (typeBtn == 'select') ? const Icon(Icons.format_list_bulleted) : const Icon(Icons.reply), //Icons.discount
                              label: Text( nameBtn! ),
                              onPressed: () {
                                if (typeBtn == 'select') {
                                  showBottomSheet(
                                    context: context, 
                                    builder: (builder) {
                                      return const Wrap(
                                        children: [
                                          ListTile(
                                            title: Text('1 a'),
                                            subtitle: Text('1b'),
                                          ),
                                          ListTile(
                                            title: Text('2 a'),
                                            subtitle: Text('2 b'),
                                          )
                                        ],
                                      );
                                    }
                                  );
                                } else {
                                  showEventOption(codeBtn!);
                                }
                              },
                            )); 
                        } ),
                      ),
                    ],
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
                  onPressed: () { 

                  },
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
import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/network/chatService.dart';
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
  void dispose() {
    super.dispose();
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
                final suboption = row?.subOptions;

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
                          var buttons = option[f];
                          var nameBtn = buttons['text'];
                          var codeBtn = buttons['code'];  
                          var typeBtn = buttons['type'];  
                          return TextButton.icon(
                              icon:  (typeBtn == 'select') ? const Icon(Icons.format_list_bulleted) : const Icon(Icons.reply), //Icons.discount
                              label: Text( nameBtn! ),
                              onPressed: () {
                                if (typeBtn == 'select') {
                                  showBottomSheet(
                                    context: context, 
                                    builder: (builder) {
                                      return Wrap(
                                        children: List.generate(suboption!.length,(x) {
                                          var subBtn = suboption[x];
                                          var textIn = subBtn['text'];
                                          var subTitleIn = subBtn['subtitle'];
                                          var codeIn = subBtn['code'];
                                          return  ListTile(
                                            title:  Text(textIn!), 
                                            subtitle:  Text(subTitleIn!),
                                            onTap: () {
                                              var valor = '${codeIn}'; 
                                              showEventOption(valor);
                                            },
                                          ); 
                                        })
                                      );
                                    }
                                  );
                                } else {
                                  showEventOption(codeBtn!);
                                }
                              },
                            ); 
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
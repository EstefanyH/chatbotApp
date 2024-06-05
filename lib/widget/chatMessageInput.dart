import 'dart:io';

import 'package:appchatbot/response/sendMessage.dart';
import 'package:flutter/material.dart';

import '../viewModel/chatViewModel.dart';

class ChatMessageInput extends StatelessWidget {
  final ChatViewModel viewModel;
  final SendMessage? item;

  const ChatMessageInput({
    required this.item,
    required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    final message = item?.messages;
    final option = item?.options;
    final suboption = item?.subOptions;
    final isUser = message?['sender'] == 'user';
    final isImg = message?['type'] == 'img';
    String ruta = '/data/user/0/com.example.appchatbot/cache/69ad847c-0f28-4753-bd1a-84b8b2493df73724646059768108362.jpg';

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: isImg,
              child: Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Image.file(
                  fit: BoxFit.contain,
                  width: 200,
                  File(message!['text']!),),
              )
          ),
          Visibility(
              visible: isImg ? false : true,
              child: ListTile(
                title: Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child:  Container(
                    padding: const EdgeInsets.all(8),
                    color: isUser ? Colors.blue[100] : Colors.grey[300],
                    child: isImg ?  Text('') : Text(message!['text']!) ,
                  ),
                ),
              )
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
                                    viewModel.showEventOption(codeIn!);
                                  },
                                );
                              })
                          );
                        }
                    );
                  } else {
                    viewModel.showEventOption(codeBtn!);
                  }
                },
              );
            } ),
          ),
        ],
      ),
    );
  }
}

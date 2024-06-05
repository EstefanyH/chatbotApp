import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/network/chatService.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:appchatbot/viewModel/chatViewModel.dart';
import 'package:appchatbot/widget/chatMessageInput.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatBotForm extends ChatViewModel {
 
  ChatService get chatViewModel => context.read<ChatService>();
  
  final TextEditingController _controller = TextEditingController();
  Image? _image;
  Uint8List? _imageBytes;
  
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

                return ChatMessageInput(
                    item: row,
                    viewModel: this,) ;
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
                      sendMessage(texto: _controller.text, type: TypeMessage.text);
                      _controller.clear();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera),
                  onPressed: () { 
                    showModalBottomSheet(
                      context: context, 
                      builder: (context) {
                        return Container(
                          height: 150,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camara'),
                                onTap: () {
                                  _pickImage(ImageSource.camera, context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_album),
                                title: const Text('Galeria'),
                                onTap: () {
                                  _pickImage(ImageSource.gallery, context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
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

  void _pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // Do something with the selected image (e.g., display it, upload it)
      print('Picked image: ${image.path}');

      sendMessage(texto: image.path, type: TypeMessage.img);
    }
    Navigator.pop(context);
  }

}
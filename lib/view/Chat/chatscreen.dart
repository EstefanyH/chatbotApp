import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  String? _projectId;
  String? _sessionId = '102910453948635067322'; // Puedes usar un ID de sesión fijo o generarlo dinámicamente.
  ServiceAccountCredentials? _credentials;

  @override
  void initState() {
    super.initState();
    _loadServiceAccountCredentials();
  }

  Future<void> _loadServiceAccountCredentials() async {
    final jsonString = await rootBundle.loadString('assets/cred.json');
    final jsonMap = json.decode(jsonString);
    setState(() {
      _credentials = ServiceAccountCredentials.fromJson(jsonMap);
      _projectId = jsonMap['project_id'];
    });
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add({'text': text, 'sender': 'user'});
    });
    _controller.clear();
    _getBotResponse(text);
  }

  Future<void> _getBotResponse(String text) async {
    if (_credentials == null || _projectId == null) {
      print('Credenciales no cargadas aún.');
      return;
    }

    final authClient = await clientViaServiceAccount(
      _credentials!,
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    final response = await http.post(
      Uri.parse('https://dialogflow.googleapis.com/v2/projects/$_projectId/agent/sessions/$_sessionId:detectIntent'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authClient.credentials.accessToken.data}',
      },
      body: json.encode({
        'queryInput': {
          'text': {
            'text': text,
            'languageCode': 'en',
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final fulfillmentText = data['queryResult']['fulfillmentText'];
      setState(() {
        _messages.add({'text': fulfillmentText, 'sender': 'bot'});
      });
    } else {
      print('Error al comunicarse con Dialogflow API: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot App'),
      ),
      body: Column(
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
                      padding: EdgeInsets.all(8),
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
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
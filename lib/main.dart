// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      debugShowCheckedModeBanner: false,
      home: Chatbot(),
    );
  }
}

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  // List to store the messages
  List<String> messages = [];

  // TextEditingController to control the input field
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // Method to load the messages from local storage
  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      messages = prefs.getStringList('messages') ?? [];
    });
  }

  // Method to save the messages to local storage
  void _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('messages', messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 34, 63, 35),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(
                      // minHeight: 50.0,
                      // maxHeight: 200.0,
                      minWidth: 10.0,
                      maxWidth: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(messages[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // title: Text(
          //           messages[index],
          //           ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      messages.add(messageController.text);
                      messageController.clear();
                      _saveMessages();
                    });
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

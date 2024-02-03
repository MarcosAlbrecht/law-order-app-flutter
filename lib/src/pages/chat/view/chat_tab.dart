import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        color: Colors.red,
        child: Text(
          'Conversas',
        ),
      ),
    );
  }
}

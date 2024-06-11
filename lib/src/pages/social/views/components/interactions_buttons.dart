// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';

class InteractionsButtons extends StatefulWidget {
  final bool liked;
  final VoidCallback onPressed;
  const InteractionsButtons({
    Key? key,
    required this.liked,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<InteractionsButtons> createState() => _InteractionsButtonsState();
}

class _InteractionsButtonsState extends State<InteractionsButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: widget.onPressed,
          icon: widget.liked ? Icon(FontAwesome.heart) : Icon(FontAwesome.heart_empty),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: widget.onPressed,
          icon: Icon(Linecons.comment),
        ),
      ],
    );
  }
}

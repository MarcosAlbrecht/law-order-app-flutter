import 'package:flutter/material.dart';

class MoreComments extends StatefulWidget {
  const MoreComments({super.key});

  @override
  State<MoreComments> createState() => _MoreCommentsState();
}

class _MoreCommentsState extends State<MoreComments> {
  final comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        color: Colors.white,
        height: 200,
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 140,
              child: Container(
                width: 100,
                height: 50,
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 260,
                      child: TextField(
                        controller: comment,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          //islodaing = true;
                        });
                        if (comment.text.isNotEmpty) {}
                        setState(() {
                          //islodaing = false;
                          comment.clear();
                        });
                      },
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

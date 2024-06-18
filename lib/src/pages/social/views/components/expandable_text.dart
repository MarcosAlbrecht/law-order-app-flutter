import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final bool paddingTop;
  final bool fontSize14;

  ExpandableText({
    Key? key,
    required this.text,
    required this.maxLines,
    this.paddingTop = true,
    this.fontSize14 = false,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: widget.text,
          style: const TextStyle(height: 1.5),
        );
        final tp = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        tp.layout(maxWidth: constraints.maxWidth);
        showButton = tp.didExceedMaxLines;

        return Padding(
          padding: widget.paddingTop ? const EdgeInsets.only(top: 10) : const EdgeInsets.only(top: 0),
          child: Container(
            alignment: Alignment.topLeft, // Ensure the content is aligned to the top left
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.text,
                  maxLines: isExpanded ? null : widget.maxLines,
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: widget.fontSize14
                      ? const TextStyle(
                          height: 1.5,
                          fontSize: 14,
                        )
                      : const TextStyle(
                          height: 1.5,
                          fontSize: 12,
                        ),
                ),
                if (showButton)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Ver menos' : 'Ver mais',
                      style: TextStyle(color: CustomColors.blueDark2Color),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/request_model.dart';

class RequestTile extends StatelessWidget {
  final RequestModel requestModel;

  const RequestTile({
    Key? key,
    required this.requestModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: CustomColors.cyanColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      shadowColor: CustomColors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: 100,
                color: Colors.blue,
                child: Text('Texto'),
              ),
            ],
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.green,
              width: 5,
            ),
          ) // Barra verde no canto esquerdo
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 26,
            ),
            color: CustomColors.cyanColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          requestModel.requester?.profilePicture != null
                              ? NetworkImage(
                                  requestModel.requester!.profilePicture!.url!)
                              : const AssetImage("assets/ICONPEOPLE.png")
                                  as ImageProvider<Object>,
                    ),
                    VerticalDivider(
                      width: 20,
                    ),
                    Text(
                      '${requestModel.requester?.firstName} ${requestModel.requester?.lastName}',
                      style: TextStyle(fontSize: CustomFontSizes.fontSize14),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        utilServices.priceToCurrency(
                          requestModel.total!,
                        ),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: CustomFontSizes.fontSize14),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Aguardando aceite',
                          style: TextStyle(
                              color: CustomColors.black,
                              fontSize: CustomFontSizes.fontSize12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.green,
              width: 10,
            ),
          ) // Barra verde no canto esquerdo
        ],
      ),
    );
  }
}

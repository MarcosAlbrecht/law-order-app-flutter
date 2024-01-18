// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/request_model.dart';
import 'package:app_law_order/src/pages/profile/view/portfolio_screen.dart';
import 'package:app_law_order/src/pages/requests/controller/request_controller.dart';

class RequestTile extends StatelessWidget {
  final RequestModel requestModel;
  final String currentCategory;

  const RequestTile({
    Key? key,
    required this.requestModel,
    required this.currentCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
      builder: (controller) {
        final statusInfo =
            controller.serviceRequestStatus(status: requestModel.status!);
        return GestureDetector(
          onTap: () {
            controller.selectedRequest = requestModel;
            Get.toNamed(PagesRoutes.requestDetailScreen);
          },
          child: Material(
            elevation: 3,
            color: CustomColors.cyanColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
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
                        //container com nome e demais informaçoes
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: requestModel
                                          .requester?.profilePicture !=
                                      null
                                  ? NetworkImage(requestModel
                                      .requester!.profilePicture!.url!)
                                  : const AssetImage("assets/ICONPEOPLE.png")
                                      as ImageProvider<Object>,
                            ),
                            const VerticalDivider(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  currentCategory == 'received'
                                      ? Text(
                                          '${requestModel.requester!.firstName?.trim()} ${requestModel.requester!.lastName?.trim()}',
                                          style: TextStyle(
                                              fontSize:
                                                  CustomFontSizes.fontSize16),
                                        )
                                      : Text(
                                          '${requestModel.requested!.firstName?.trim()} ${requestModel.requested!.lastName?.trim()}',
                                          style: TextStyle(
                                              fontSize:
                                                  CustomFontSizes.fontSize16),
                                        ),
                                  const Divider(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_outlined,
                                        size: 16,
                                        color: CustomColors.blueDark2Color,
                                      ),
                                      Text(
                                        ' ${utilServices.formatDateTime(requestModel.createdAt)}',
                                        style: TextStyle(
                                            fontSize:
                                                CustomFontSizes.fontSize12),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    height: 5,
                                    color: Colors.transparent,
                                  ),
                                  Visibility(
                                    visible: requestModel.deadline != null &&
                                        requestModel.deadline!.isNotEmpty,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Iconic.clock,
                                          size: 16,
                                          color: CustomColors.blueDark2Color,
                                        ),
                                        Text(
                                          ' ${utilServices.formatDate(requestModel.deadline)}',
                                          style: TextStyle(
                                              fontSize:
                                                  CustomFontSizes.fontSize12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        //container com o total e status do serviço
                        Padding(
                          padding: const EdgeInsets.only(top: 26.0, bottom: 10),
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
                                    fontSize: CustomFontSizes.fontSize16),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                  color: statusInfo.color
                                      .withOpacity(statusInfo.opacidade),
                                ),
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  '${statusInfo.text}',
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
                      color: statusInfo.color.withOpacity(0.8),
                      width: 10,
                    ),
                  ) // Barra verde no canto esquerdo
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/pages/home/controller/follow_controller.dart';
import 'package:app_law_order/src/pages_routes/pages_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/follows_model.dart';
import 'package:app_law_order/src/models/user_model.dart';

class ProviderTile extends StatefulWidget {
  final UserModel item;

  const ProviderTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  //final FollowsModel? follow;

  @override
  _ProviderTileState createState() => _ProviderTileState();
}

class _ProviderTileState extends State<ProviderTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              //Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
              Get.toNamed(
                PagesRoutes.profileViewScreen,
                arguments: {'idUser': widget.item.id},
              );
            },
            child: Material(
              //color: CustomColors.backgroudCard,
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

              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: widget.item.profilePicture != null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.item.profilePicture!.url!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/ICONPEOPLE.png",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const Divider(
                              height: 10,
                              color: Colors.transparent,
                            ),
                            RatingBarIndicator(
                              //unratedColor: CustomColors.black,
                              rating: widget.item.rating ?? 0,
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rate,
                                color: CustomColors.blueDark2Color,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${widget.item.firstName} ${widget.item.lastName}',
                                      style: TextStyle(
                                        fontSize: CustomFontSizes.fontSize16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GetBuilder<FollowController>(
                                    init: FollowController(user: widget.item),
                                    global: false,
                                    builder: (controller) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: GestureDetector(
                                          onTap: () async {
                                            //print("clicou no follow");
                                            await controller.handleFollow();
                                          },
                                          child: controller.followed == null
                                              ? Icon(
                                                  FontAwesome.user_plus,
                                                  size: 18,
                                                  color: CustomColors.blueDark2Color,
                                                )
                                              : Icon(
                                                  FontAwesome.user_times,
                                                  size: 18,
                                                  color: CustomColors.blueDarkColor,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    size: 16,
                                    color: CustomColors.blueDark2Color,
                                  ),
                                  const VerticalDivider(
                                    width: 10,
                                    color: Colors.transparent,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${widget.item.city}, ${widget.item.state}',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: CustomFontSizes.fontSize14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.transparent,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.wallet_giftcard_outlined,
                                    size: 16,
                                    color: CustomColors.blueDark2Color,
                                  ),
                                  const VerticalDivider(
                                    width: 10,
                                    color: Colors.transparent,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${widget.item.occupationArea}',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: CustomFontSizes.fontSize14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 10,
                                color: Colors.transparent,
                              ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       height: 35,
                              //       child: ElevatedButton(
                              //           style: ElevatedButton.styleFrom(
                              //             backgroundColor:
                              //                 CustomColors.blueColor,
                              //             shape: RoundedRectangleBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //             ),
                              //           ),
                              //           onPressed: () {},
                              //           child: Text(
                              //             'Seguir',
                              //             style: TextStyle(
                              //               color: CustomColors.white,
                              //               fontSize:
                              //                   CustomFontSizes.fontSize14,
                              //             ),
                              //           )),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

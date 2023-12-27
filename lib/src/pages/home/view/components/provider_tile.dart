// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderTile extends StatefulWidget {
  const ProviderTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final UserModel item;

  @override
  _ProviderTileState createState() => _ProviderTileState();
}

class _ProviderTileState extends State<ProviderTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              //Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
            },
            child: Card(
              //color: CustomColors.backGround,
              elevation: 6,
              shadowColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                                  ? Image.network(
                                      widget.item.profilePicture!.url!,
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
                            const Row(
                              children: [
                                Icon(
                                  Icons.star_rate,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                        const VerticalDivider(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.item.firstName} ${widget.item.lastName}',
                                style: TextStyle(
                                  fontSize: CustomFontSizes.fontSize18,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    color: CustomColors.blueColor,
                                  ),
                                  const VerticalDivider(
                                    width: 10,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    '${widget.item.city},${widget.item.state}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: CustomFontSizes.fontSize16,
                                      color: Colors.grey.shade600,
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
                                    color: CustomColors.blueColor,
                                  ),
                                  const VerticalDivider(
                                    width: 10,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    '${widget.item.occupationArea}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: CustomFontSizes.fontSize16,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 10,
                                color: Colors.transparent,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CustomColors.blueColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Visualizar',
                                          style: TextStyle(
                                            color: CustomColors.white,
                                            fontSize:
                                                CustomFontSizes.fontSize14,
                                          ),
                                        )),
                                  ),
                                  const VerticalDivider(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CustomColors.blueColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Seguir',
                                          style: TextStyle(
                                            color: CustomColors.white,
                                            fontSize:
                                                CustomFontSizes.fontSize14,
                                          ),
                                        )),
                                  ),
                                ],
                              )
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

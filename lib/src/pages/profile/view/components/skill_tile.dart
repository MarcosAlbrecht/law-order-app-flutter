// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_law_order/src/config/custom_colors.dart';
import 'package:app_law_order/src/services/util_services.dart';

class SkillTile extends StatelessWidget {
  final String skill;
  SkillTile({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.backgroudCard,
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        title: Text(
          skill,
          style: TextStyle(fontSize: CustomFontSizes.fontSize14),
        ),
      ),
    );
  }
}

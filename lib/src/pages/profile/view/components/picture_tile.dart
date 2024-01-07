// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_law_order/src/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_law_order/src/models/picture_model.dart';

class PictureTile extends StatefulWidget {
  final int index;
  final PictureModel picture;

  const PictureTile({
    Key? key,
    required this.index,
    required this.picture,
  }) : super(key: key);

  @override
  State<PictureTile> createState() => _PictureTileState();
}

class _PictureTileState extends State<PictureTile> {
  final profileController = Get.find<ProfileController>();

  Uint8List _buildMemoryBytes(String base64Image) {
    return base64Decode(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (widget.index > 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Remover imagem'),
              actions: [
                TextButton(
                  onPressed: () {
                    profileController.deleteImagePortfolio(
                      picture: widget.picture,
                      index: widget.index,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Confirmar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Fechar o AlertDialog
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 2),
            width: 170,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: widget.picture.url != null
                    ? NetworkImage(widget.picture.url!) as ImageProvider<Object>
                    : FileImage(File(widget.picture.localPath!)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 5,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Remover imagem'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          profileController.deleteImagePortfolio(
                            picture: widget.picture,
                            index: widget.index,
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Confirmar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Fechar o AlertDialog
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

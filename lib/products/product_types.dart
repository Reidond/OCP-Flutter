import 'package:flutter/material.dart';

class ProductType {
  int value;
  String label;

  ProductType(this.value, this.label);

  static IconData getCorrespondingImageType(int productType) {
    switch (productType) {
      case 1:
        return Icons.text_fields;
        break;
      case 2:
        return Icons.videocam;
        break;
      case 3:
        return Icons.music_note;
        break;
      case 4:
        return Icons.image;
        break;
      case 4:
        return Icons.insert_drive_file;
        break;
      default:
        return Icons.insert_drive_file;
    }
  }
}
import 'package:flutter/widgets.dart';

abstract interface class ImageService {
  ImageProvider getImage(String path);
}

class AssetImageService implements ImageService {
  @override
  ImageProvider getImage(String path) => AssetImage(path);
}

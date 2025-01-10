
import 'package:flutter/widgets.dart';

// This class is used to provide images to the app.
// It is used to abstract the image provider so that it can be mocked in tests.
// It allows different implementations of the image provider to be used in the app.
// For now, we get the assets from the assets, but in the future we may want to get assets from the network.
// In which case, ImageRepository be implemented and the app code that uses ImageRepository will not need to change.
// class RemoteImageRepository implements ImageRepository {
//   ImageProvider getImage(String path) {
//     return NetworkImage("https://user-images.githubusercontent.com/76099779/190876253-b6188221-38b7-4aaa-85b8-9f607b4b774b.png");
//   }
// }
//
class ImageRepository {
  ImageProvider getImage(String path) {
    return AssetImage(path);
  }
}

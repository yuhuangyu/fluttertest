// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutterdemo/mixin/photoGallery/photo_gallery.dart';


void openPhotoGalleryDialog(BuildContext context, List<String> items, int index) => showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: PhotoGallery(
            images: items,
            currentIndex: index,
          ),
        );
      },
    );

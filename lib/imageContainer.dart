import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  String gameImage;

  ImageContainer({required this.gameImage});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image(image: AssetImage(gameImage)),
    );
  }
}

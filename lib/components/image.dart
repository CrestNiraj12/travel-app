import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:traveller/config.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    this.height = 100,
    this.width = 100,
    required this.imageUrl,
  });

  final double height;
  final double width;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 100,
      width: 100,
      fit: BoxFit.cover,
      imageUrl: "${Config.imagePath}/$imageUrl",
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text(
            'Error loading image',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

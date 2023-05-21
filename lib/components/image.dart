import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:traveller/config.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    this.height = 300,
    this.width = 300,
    this.radius = 25,
    this.isBottomRadius = true,
    this.colorBlendMode = null,
    this.color = null,
    this.addUrlPrefix = true,
    required this.imageUrl,
  });

  final double height;
  final double width;
  final String imageUrl;
  final double radius;
  final bool isBottomRadius;
  final bool addUrlPrefix;
  final Color? color;
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(radius),
        bottom: isBottomRadius ? Radius.circular(radius) : Radius.zero,
      ),
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: "${addUrlPrefix ? '${Config.imagePath}/' : ''}$imageUrl",
        color: color,
        colorBlendMode: colorBlendMode,
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
      ),
    );
  }
}

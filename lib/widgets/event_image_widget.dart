import 'package:flutter/material.dart';

class EventImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String heroTag;

  const EventImageWidget({
    required this.imageUrl,
    required this.heroTag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.width > 600 ? 300 : 200;

    return Hero(
      tag: heroTag,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child:
            imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : Container(color: Colors.grey[300]),
      ),
    );
  }
}

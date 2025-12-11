import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';

class FullScreenImageGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageGallery({super.key, required this.images, this.initialIndex = 0});

  @override
  State<FullScreenImageGallery> createState() => _FullScreenImageGalleryState();
}

class _FullScreenImageGalleryState extends State<FullScreenImageGallery> {
  late PageController controller;
  late int current;

  @override
  void initState() {
    super.initState();
    current = widget.initialIndex;
    controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), title: Text('${current + 1}/${widget.images.length}')),
      body: PageView.builder(
        controller: controller,
        itemCount: widget.images.length,
        onPageChanged: (i) => setState(() => current = i),
        itemBuilder: (ctx, idx) {
          final url = widget.images[idx];
          return Hero(tag: 'apartment_img_$idx', child: PhotoView(imageProvider: NetworkImage(url), backgroundDecoration: const BoxDecoration(color: Colors.black)));
        },
      ),
    );
  }
}

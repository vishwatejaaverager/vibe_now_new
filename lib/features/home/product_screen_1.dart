import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_text/url_text.dart';
import 'package:vibe_now/models/cloth_model.dart';
import 'package:vibe_now/routes/app_routes.dart';
import 'package:vibe_now/utils/utils.dart';

class ProductOverViewScreen extends ConsumerStatefulWidget {
  final ClothsModel clothsModel;
  static const id = AppRoutes.productScreen;
  const ProductOverViewScreen({super.key, required this.clothsModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends ConsumerState<ProductOverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("wedding Wear"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                sbh(24),
                Center(
                  child: SizedBox(
                    height: size.height / 2,
                    child: CarouselSlider(
                        items: List.generate(widget.clothsModel.images.length,
                            (index) {
                          return Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                  widget.clothsModel.images[index]),
                            ),
                          );
                        }),
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {},
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                ),
                sbh(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "About this product",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: size.width,
                          child: Text(widget.clothsModel.about)),
                      sbh(12),
                      const Text(
                        "Tap on links : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width,
                    child: UrlText(
                      widget.clothsModel.links[0],
                      urlStyle: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.purple,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800),
                      style: const TextStyle(
                        color: Colors.pink,
                        overflow: TextOverflow.ellipsis,
                      ),
                      markdown: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

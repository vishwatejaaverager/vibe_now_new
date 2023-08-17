import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe_now/features/auth/login_provider.dart';
import 'package:vibe_now/features/home/home_provider.dart';
import 'package:vibe_now/features/home/product_screen.dart';
import 'package:vibe_now/routes/app_routes.dart';
import 'package:vibe_now/routes/navigation.dart';
import 'package:vibe_now/services/streams.dart';
import 'package:vibe_now/utils/frequency_tabs.dart';
import 'package:vibe_now/utils/utils.dart';

import '../../models/cloth_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.homeScreen;
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    var s = ref.read(authProvider).uid;
    ref.read(homePro).configAndGetUserModel(s);
    //   ref.read(homePro).getDressesFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "FitFabels",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Image.asset('assets/Love.png')
                ],
              ),
              sbh(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Offers...",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      sbh(6),
                      SizedBox(
                        height: size.height / 9,
                        width: size.width / 1.5,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://www.feedough.com/wp-content/uploads/2021/08/advertisement.png',
                              width: size.width / 1.5,
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ],
                  ),
                  sbh(6),
                  Consumer(
                    builder: (context, ref, child) {
                      final home = ref.watch(homePro);
                      return home.userModel == null
                          ? Container(
                              height: size.height / 5,
                              width: size.width / 4,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(90, 90)),
                              ),
                            )
                          : Container(
                              height: size.height / 5,
                              width: size.width / 4,
                              decoration: BoxDecoration(
                                //  color: Colors.black,

                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                      home.userModel!.photoUrl,
                                    )),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(90, 90)),
                              ),
                            );
                    },
                  ),
                ],
              ),
              sbh(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'What you are ',
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: 'looking',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF60505)),
                        ),
                        TextSpan(
                            text: ' for ?', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final home = ref.watch(homePro);
                      return home.userModel == null
                          ? const Text("")
                          : SizedBox(
                              width: size.width / 3,
                              child: Text(
                                "Hello  ${home.userModel!.name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              ));
                    },
                  ),
                ],
              ),
              FrequencyTabs(
                  controller: _tabController,
                  tags: const [],
                  tabs: const [
                    SizedBox(child: Center(child: Text("Wedding"))),
                    SizedBox(child: Center(child: Text("Date"))),
                    SizedBox(child: Center(child: Text("Club/Night"))),
                    SizedBox(child: Center(child: Text("Collage Fest")))
                  ]),
              sbh(12),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: const [
                  ClothesWidget(
                    clothType: "wedding",
                  ),
                  ClothesWidget(
                    clothType: "date",
                  ),
                  ClothesWidget(
                    clothType: "club",
                  ),
                  ClothesWidget(
                    clothType: "collage",
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ClothesWidget extends StatelessWidget {
  final String clothType;
  const ClothesWidget({super.key, required this.clothType});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final home = ref.watch(homePro).userModel;
        return StreamBuilder(
          stream: Streams()
              .clothQuery
              .where('gender', isEqualTo: home!.gender)
              .where('type', isEqualTo: clothType)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemBuilder: (context, index) {
                  ClothsModel clothsModel =
                      ClothsModel.fromMap(snapshot.data!.docs[index].data());
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigation.instance.navigateTo(
                              ProductOverViewScreen.id.path,
                              args: clothsModel);
                        },
                        child: CarouselSlider(
                            items: List.generate(clothsModel.images.length,
                                (index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  clothsModel.images[index],
                                  fit: BoxFit.fitHeight,
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
                      Positioned(
                          top: 4,
                          right: 8,
                          child: Image.asset('assets/Love.png')),
                    ],
                  );
                },
              );
            } else {
              return const Text("Loading");
            }
          },
        );
      },
    );
  }
}

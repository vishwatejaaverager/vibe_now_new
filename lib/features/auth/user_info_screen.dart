import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:lottie/lottie.dart';
import 'package:vibe_now/features/auth/login_provider.dart';
import 'package:vibe_now/routes/app_routes.dart';
import 'package:vibe_now/utils/utils.dart';

class OnBoardingIntroScreens extends ConsumerStatefulWidget {
  static const id = AppRoutes.onBoardingScreen;
  const OnBoardingIntroScreens({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnBoardingIntroScreensState();
}

class _OnBoardingIntroScreensState
    extends ConsumerState<OnBoardingIntroScreens> {
  List a = [
    'assets/diamond.png',
    'assets/heart.png',
    'assets/round.png',
    'assets/square.png'
  ];
  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(authProvider);
    final List<Introduction> list = [
      Introduction(
          title: 'Height',
          subTitle: 'Mention Your Height So That We Can Suggest Better Dresses',
          imageUrl: Column(
            children: [
              Lottie.network(
                  'https://lottie.host/6ab56a7a-4b7c-4f36-9a12-72d1c4aa8411/NPv67MbboI.json'),
              Slider(
                min: 0.0,
                max: 7,
                value: double.parse(prov.height),
                onChanged: (value) {
                  prov.configHeight(value.toStringAsFixed(2));
                },
              ),
              Text(
                "${prov.height} Ft",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          )),
      Introduction(
        title: 'Weight',
        subTitle: 'Mention Your Weight So That We Can Suggest Better Dresses',
        imageUrl: Column(
          children: [
            Lottie.network(
                'https://lottie.host/301c6603-a1ac-4035-859b-9f9087235bfb/Opxnm49WaU.json',
                height: size.height / 5),
            Slider(
              min: 0.0,
              max: 150,
              value: double.parse(prov.weight),
              onChanged: (value) {
                prov.configWeight(value.toStringAsFixed(2));
              },
            ),
            Text(
              "${prov.weight} Kg's",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )
          ],
        ),
      ),
      Introduction(
          title: 'Face Shape',
          subTitle: '',
          imageUrl: Column(
            children: [
              // Image.asset(
              //   'assets/google.png',
              //   fit: BoxFit.cover,
              //   alignment: Alignment.center,
              // ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2 // Set the cross count to 2
                    ),
                itemCount: a.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      prov.configFaceShape(index.toString());
                    },
                    child: Image.asset(
                      a[index],
                      scale: int.parse(prov.faceShape) == index ? 1 : 6,
                    ),
                  );
                },
              )
            ],
          )),
      Introduction(
          title: 'Gender',
          subTitle: 'Select Your Gender',
          imageUrl: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        prov.configGender('male');
                      },
                      child: Image.asset(
                        'assets/male.png',
                        scale: prov.gender == 'male' ? 1 : 1.5,
                      )),
                  sbw(24),
                  InkWell(
                      onTap: () {
                        prov.configGender('female');
                      },
                      child: Image.asset(
                        'assets/female.png',
                        scale: prov.gender == 'female' ? 1 : 1.5,
                      )),
                ],
              ),
              prov.gender == 'male'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bread",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Switch(
                          value: prov.beard,
                          onChanged: (value) {
                            prov.configBeard(value);
                          },
                        )
                      ],
                    )
                  : const SizedBox()
            ],
          )),
      Introduction(
          title: 'Face Complexity',
          subTitle: 'Slide According to Your Tone',
          imageUrl: Column(
            children: [
              Image.asset(
                'assets/face_complexity.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              Slider(
                min: 0.0,
                max: 10,
                value: double.parse(prov.facComplex),
                onChanged: (value) {
                  prov.configFaceComplex(value.toStringAsFixed(0));
                },
              ),
              Text(
                prov.facComplex,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          )),
    ];
    return IntroScreenOnboarding(
      introductionList: list,
      skipTextStyle: const TextStyle(color: Colors.white),
      onTapSkipButton: () {
        var a = ref.read(authProvider).user;
        ref.read(authProvider).createUserInDb(a!);
      },
    );
  }
}

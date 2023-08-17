import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe_now/features/auth/user_info_screen.dart';
import 'package:vibe_now/features/home/home_screen.dart';
import 'package:vibe_now/routes/app_routes.dart';
import 'package:vibe_now/routes/navigation.dart';
import 'package:vibe_now/services/streams.dart';
import 'package:vibe_now/utils/utils.dart';

import '../../utils/loading.dart';
import 'login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.loginScreen;
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/home.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Positioned(
            top: size.height / 8,
            left: 24,
            child: const Text(
              "OUR  FASHION",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            )),
        Positioned(
            top: size.height / 3,
            left: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '''
Shop the most 
modern 
essensials
''',
                  style: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
                const Icon(
                  Icons.arrow_right,
                  size: 32,
                ),
                sbh(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sbw(size.width / 6),
                    InkWell(
                        onTap: () async {
                          ref
                              .read(authProvider)
                              .signInWithGoogle()
                              .then((value) {
                            if (value != null) {
                              ref.read(authProvider).configUSer(value);
                              // ref
                              //     .read(authProvider)
                              //     .checkAndCreateUser(value.uid, value);
                              Streams()
                                  .userQuery
                                  .doc(value.uid)
                                  .get()
                                  .then((value) {
                                if (value.exists) {
                                  log("came here ");
                                  Navigation.instance
                                      .navigateTo(HomeScreen.id.path);
                                } else {
                                  Navigation.instance.navigateTo(
                                      OnBoardingIntroScreens.id.path);
                                }
                              });
                            } else {
                              appToast("Some Error Occured");
                            }
                          });
                          Loading().indicator(context);
                        },
                        child: Image.asset('assets/google.png')),
                  ],
                )
              ],
            )),
      ],
    ));
  }
}

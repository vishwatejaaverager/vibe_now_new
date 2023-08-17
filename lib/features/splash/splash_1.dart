import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe_now/features/auth/login_screen.dart';
import 'package:vibe_now/features/home/home_provider.dart';
import 'package:vibe_now/features/home/home_screen.dart';
import 'package:vibe_now/routes/navigation.dart';
import 'package:vibe_now/services/streams.dart';

import '../auth/login_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        var a = FirebaseAuth.instance.currentUser!.uid;
        Streams().userQuery.doc(a).get().then((value) {
          if (value.exists) {
            ref.read(authProvider).configUserID(a);
            ref.read(homePro).configAndGetUserModel(a).whenComplete(() {
              Navigation.instance.pushAndRemoveUntil(HomeScreen.id.path);
            });
          } else {
            Navigation.instance.pushAndRemoveUntil(LoginScreen.id.path);
          }
        });
      } catch (e) {
        Navigation.instance.pushAndRemoveUntil(LoginScreen.id.path);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

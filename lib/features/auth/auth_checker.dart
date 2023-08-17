import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe_now/features/auth/login_screen.dart';
import 'package:vibe_now/features/home/home_screen.dart';

import 'login_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRefState = ref.watch(authStateProvider);
    return authRefState.when(
      data: (data) {
        if (data != null) {
          ref.read(authProvider).configUserID(data.uid);
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}

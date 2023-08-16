import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe_now/routes/app_routes.dart';
import 'package:vibe_now/utils/utils.dart';

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
            child: Text(
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
                Text(
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
                Icon(
                  Icons.arrow_right,
                  size: 32,
                ),
                sbh(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sbw(size.width / 6),
                    Image.asset('assets/google.png'),
                  ],
                )
              ],
            )),
      ],
    ));
  }
}

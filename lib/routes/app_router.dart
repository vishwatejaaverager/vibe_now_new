import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibe_now/features/auth/login_screen.dart';
import 'package:vibe_now/features/auth/user_info_screen.dart';
import 'package:vibe_now/features/home/home_screen.dart';
import 'package:vibe_now/features/home/product_screen.dart';
import 'package:vibe_now/models/cloth_model.dart';

class AppRouter {
  static Route generateRoute(RouteSettings route) {
    const PageTransitionType style = PageTransitionType.fade;

    PageTransition pageTransition(Widget child) {
      return PageTransition(child: child, type: style);
    }

    if (route.name == LoginScreen.id.path) {
      return pageTransition(const LoginScreen());
    } else if (route.name == HomeScreen.id.path) {
      return pageTransition(const HomeScreen());
    } else if (route.name == OnBoardingIntroScreens.id.path) {
      return pageTransition(const OnBoardingIntroScreens());
    } else if (route.name == ProductOverViewScreen.id.path) {
      ClothsModel clothsModel = route.arguments as ClothsModel;
      return pageTransition(ProductOverViewScreen(
        clothsModel: clothsModel,
      ));
    } else {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('No view defined for this route'),
          ),
        ),
      );
    }
  }
}

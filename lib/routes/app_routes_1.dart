enum AppRoutes {
  homeScreen("home_screen"),
  onBoardingScreen('onBoarding'),
  productScreen('product'),
  loginScreen("login_screen");

  const AppRoutes(this.path);
  final String path;
}

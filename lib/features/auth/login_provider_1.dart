import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vibe_now/features/auth/user_info_screen.dart';
import 'package:vibe_now/features/home/home_screen.dart';

import '../../models/user_model.dart';
import '../../routes/navigation.dart';
import '../../services/streams.dart';

final authProvider = ChangeNotifierProvider((ref) {
  return LoginProvider();
});

final authStateProvider = StreamProvider<User?>(((ref) {
  return ref.read(authProvider).authStateChange;
}));

class LoginProvider with ChangeNotifier {
  final _streams = Streams();
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  Future<User?> signInWithGoogle() async {
    // final _googleSignIn = GoogleSignIn();
    User? user;
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        log('succesfully signed in ');

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // ignore: prefer_interpolation_to_compose_strings
        log('came here ' +
            googleSignInAuthentication.accessToken.toString() +
            " this is acces token");

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        var a = await _auth.signInWithCredential(authCredential);
        user = a.user;
        log(user!.uid.toString());
        return user;

        //  log(authCredential.toString());
      } else {
        log("came here once");
        return user;
      }
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        String errorMessage =
            "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
        log(errorMessage);
        //  errorCallback(errorMessage);
      } else {
        String errorMessage = "Something went wrong.";
        log(e.toString());
        // errorCallback(errorMessage);
      }
    }
    return null;
  }

  checkAndCreateUser(String uid, User user) async {
    await _streams.userQuery.doc(uid).get().then((value) {
      if (value.exists) {
        log(uid);

        log("came here");
        Navigation.instance.pushAndRemoveUntil(HomeScreen.id.path);
        // Navigation.instance.pushBack();
      } else {
        // var randomName = generator.generate(user.displayName!.split(" ").first,
        //     hasNumbers: true, prefix: 'broken');

        Navigation.instance.navigateTo(OnBoardingIntroScreens.id.path);
      //  Navigation.instance.pushBack();
      }
    });
  }

  User? _user;
  User? get user => _user;

  configUSer(User user) {
    _user = user;
  }

  createUserInDb(User user) {
    UserModel userModel = UserModel(
        uid: user.uid,
        photoUrl: user.photoURL.toString(),
        name: user.displayName.toString(),
        email: user.email.toString(),
        beard: _beard,
        height: _height,
        weight: _weight,
        faceShape: _faceShape,
        complexity: _faceComplex,
        gender: _gender);
    log("###### creating user ####");
    log(userModel.toMap().toString());

    _streams.userQuery.doc(user.uid).set(userModel.toMap()).then((value) {
      Navigation.instance.pushAndRemoveUntil(HomeScreen.id.path);
    });
  }

  String _uid = '';
  String get uid => _uid;

  configUserID(String uid) {
    _uid = uid;
  }

  String _height = '0';
  String get height => _height;

  configHeight(String height) {
    _height = height;
    notifyListeners();
  }

  String _weight = '0';
  String get weight => _weight;

  configWeight(String w) {
    _weight = w;
    notifyListeners();
  }

  String _faceShape = '0';
  String get faceShape => _faceShape;

  configFaceShape(String shape) {
    _faceShape = shape;
    notifyListeners();
  }

  String _gender = '';
  String get gender => _gender;

  configGender(String gen) {
    _gender = gen;
    notifyListeners();
  }

  bool _beard = false;
  bool get beard => _beard;

  configBeard(bool a) {
    _beard = a;
    notifyListeners();
  }

  String _faceComplex = '0';
  String get facComplex => _faceComplex;

  configFaceComplex(String a) {
    _faceComplex = a;
    notifyListeners();
  }
}

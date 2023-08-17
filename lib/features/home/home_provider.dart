import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe_now/models/user_model.dart';
import 'package:vibe_now/services/streams.dart';

final homePro = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider with ChangeNotifier {
  final Streams _streams = Streams();
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future configAndGetUserModel(String userId) async {
   await  _streams.userQuery.doc(userId).get().then((value) {
      _userModel = UserModel.fromMap(value.data()!);
      //  getDressesFromFirebase();
    });

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   notifyListeners();
    // });
    //_userModel = userModel;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _dresses = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get dresses => _dresses;

  getDressesFromFirebase() async {
    var a = await _streams.clothQuery
        .where('gender', isEqualTo: _userModel!.gender)
        .get();
    var b = a.docs;
    _dresses = b;
    notifyListeners();
  }

//  ]
}

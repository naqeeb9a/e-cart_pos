import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/profile_model.dart';
import '../../utils/utills.dart';
import '../extras/api_status_controller.dart';
import '../extras/expection_controller.dart';

class LoadProfileController extends GetxController {
  ProfileModel? _profileModel;
  bool _loading = false;

  bool get loading => _loading;
  ProfileModel? get profileModel => _profileModel;

  void setLoading(bool loading) {
    _loading = loading;
    update();
  }

  void setProfileModel(ProfileModel? profileModel) {
    _profileModel = profileModel;
  }

  Future<bool> getProfile(BuildContext context, String? accessToken) async {
    setLoading(true);
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
        Uri.parse(
          "$baseUrl/api/auth/seller/profile",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(401, "token expired");
      });
    }).then((value) {
      if (value is Success) {
        setProfileModel(profileModel);
        setLoading(false);
        return true;
      }
      if (value is Failure) {
        Fluttertoast.showToast(msg: value.errorResponse.toString());
        setLoading(false);
        return false;
      }
      return false;
    });
  }
}

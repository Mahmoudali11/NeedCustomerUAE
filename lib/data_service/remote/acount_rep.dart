import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:need/bl/modles/log_req.dart';
import 'package:need/bl/modles/refresh_token_req.dart';
import 'package:need/bl/modles/refresh_token_res.dart';
import 'package:need/bl/modles/register_req.dart';
import 'package:need/bl/modles/reset_pass_email_res.dart';
import 'package:need/bl/modles/resetpass_Res.dart';
import 'package:need/bl/modles/resetpass_req.dart';
import 'package:need/bl/modles/resetpasswordemail_req.dart';
import 'package:need/data_service/local/pref_manager.dart';

import '../../bl/modles/logi_res.dart';
import '../../bl/modles/register_res.dart';
import '../../constans/networks.dart';

import 'package:http/http.dart' as http;

class AccountsRep {
  Future login(LoginReq req) async {
    try {
      final url = Uri.parse(NetworkApis.base + NetworkApis.login);

      var b = req.toJson();
      var res = await http.post(url,
          body: jsonEncode(b), headers: NetworkApis.requestHeader);
      if (res.statusCode == 200) {
        var dJs = jsonDecode(res.body);
        var logRes = LoginRes.fromJson(dJs);
        if (logRes.success == 0) {
          return logRes;
        }
        await PrefManager.setValue(PrefManager.token, logRes?.token);
        await PrefManager.setValue(
            PrefManager.userDetails, jsonEncode(logRes.userDetails?.toJson()));
        await PrefManager.setValue(PrefManager.username, req.username);
        await PrefManager.setValue(PrefManager.password, req.password);

        return logRes;
      } else {
        return res;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future register(RegisterReq req) async {
    try {
      final url = Uri.parse(NetworkApis.base + NetworkApis.register);

      var b = req.toJson();
      var res = await http.post(url,
          body: jsonEncode(b), headers: NetworkApis.requestHeader);
      if (res.statusCode == 200) {
        var dJs = jsonDecode(res.body);
        return RegisterRes.fromJson(dJs);

      } else {
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


  Future resetPasswordEmail(ResetPasswordEmailReq req) async {
    try {
      final url = Uri.parse(NetworkApis.base + NetworkApis.resetPassEmail);

      var b = req.toJson();
      var res = await http.post(url,
          body: jsonEncode(b), headers: NetworkApis.requestHeader);
      if (res.statusCode == 200) {
        var dJs = jsonDecode(res.body);
        return ResetPasswordEmailRes.fromJson(dJs);
      } else {
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future resetPassword(ResetPassword req) async {
    try {
      var token = await PrefManager.getValue(PrefManager.token);
      Map<String, String> head = <String, String>{};
      head.addAll(NetworkApis.requestHeader);
      head["Authorization"] = "Bearer $token";
      var eJs = jsonEncode(req.toJson());
      final url = Uri.parse(NetworkApis.base + NetworkApis.resetPassword);

       var res = await http.post(url, body: eJs, headers: head);
      if (res.statusCode == 200) {

        var dJs = jsonDecode(res.body);
        var resetRes= ResetPasswordRes.fromJson(dJs);
        if (resetRes.success != 0) {
          PrefManager.setValue(PrefManager.password, req.newPassword);
          return resetRes;
        }
        else if (resetRes.success == 0) {
          var username = await PrefManager.getValue(PrefManager.username);
          var password = await PrefManager.getValue(PrefManager.password);
          if (username != null && password != null) {
            await AccountsRep()
                .login(LoginReq(username: username, password: password));
            await resetPassword(req);
          } else {
            return resetRes;
          }
        }
      } else {
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


   static Future refreshToken(RefreshTokenReq req) async {
    try {
      var token = await PrefManager.getValue(PrefManager.token);
      Map<String, String> head = <String, String>{};
      head.addAll(NetworkApis.requestHeader);
      head["Authorization"] = "Bearer $token";
      var eJs = jsonEncode(req.toJson());
      final url = Uri.parse(NetworkApis.base + NetworkApis.refreshToken);

      var res = await http.post(url, body: eJs, headers: head);
      if (res.statusCode == 200) {

        var dJs = jsonDecode(res.body);
        var resetRes= RefreshTokenRes.fromJson(dJs);
            return resetRes;

      } else {
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

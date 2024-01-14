import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:need/bl/modles/all_enquires.dart';
import 'package:need/bl/modles/log_req.dart';
import 'package:need/bl/modles/save_inq_res.dart';
import 'package:need/bl/modles/service_cat_m_res.dart';
import 'package:need/constans/keys.dart';
import 'package:need/constans/networks.dart';
import 'package:need/data_service/local/pref_manager.dart';
import 'package:need/data_service/remote/acount_rep.dart';
import 'package:need/ui/views/service/services_main.dart';

import '../../bl/modles/save_enquiry_req.dart';

class ServiceRep {
  Future getServiceCat() async {
    try {
      var token = await PrefManager.getValue(PrefManager.token);

      final url = Uri.parse(NetworkApis.base + NetworkApis.category);
      Map<String, String> head = <String, String>{};
      head.addAll(NetworkApis.requestHeader);
      head["Authorization"] = "Bearer $token";
      var res = await http.get(url, headers:head);
      if (res.statusCode == 200) {
        var dJs = jsonDecode(res.body);
        var serviceRes = ServiceCategoryM.fromJson(dJs);
        if (serviceRes.success != 0) {
          return serviceRes;
        }
        //refresh token make silent login
        else if (serviceRes.success == 0) {
          var username = await PrefManager.getValue(PrefManager.username);
          var password = await PrefManager.getValue(PrefManager.password);
          if (username != null && password != null) {
            await AccountsRep()
                .login(LoginReq(username: username, password: password));
            return CKeys.tokenEx;
           } else {
            return null;
          }
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  //book service
  Future saveEnquiry(SaveEnquiryReq model) async {
    try {
      var token = await PrefManager.getValue(PrefManager.token);
      Map<String, String> head = <String, String>{};
      head.addAll(NetworkApis.requestHeader);
      head["Authorization"] = "Bearer $token";
      var eJs=jsonEncode(model.toJson());

      final url = Uri.parse(NetworkApis.base + NetworkApis.saveEnquiry);
      var res = await http.post(url,body: eJs, headers: head);
      if (res.statusCode == 200) {
        var dJs = jsonDecode(res.body);
        var serviceRes = SaveInqRes.fromJson(dJs);
        if (serviceRes.success != 0) {
          return serviceRes;
        }
      else if (serviceRes.success == 0&&serviceRes.status!=422) {
        var username = await PrefManager.getValue(PrefManager.username);
        var password = await PrefManager.getValue(PrefManager.password);
        if (username != null && password != null) {
          await AccountsRep()
              .login(LoginReq(username: username, password: password));
          return CKeys.tokenEx;
        } else {
          return serviceRes;
        }
      }
      return serviceRes;
      } else {
        return res.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getUserEnquiries(String  userId) async {
    try {
      var token = await PrefManager.getValue(PrefManager.token);
      Map<String, String> head = <String, String>{};
      head.addAll(NetworkApis.requestHeader);
      head["Authorization"] = "Bearer $token";

      final url = Uri.parse(NetworkApis.base + "${NetworkApis.getUserEnquires}?userId=$userId");
      var res = await http.get(url,headers: head);
      if (res.statusCode == 200) {
        var dJs = jsonDecode(res.body.replaceFirst("17", ""));
        var serviceRes = AllUserEnquiries.fromJson(dJs);
        if (serviceRes.success != 0&& (serviceRes.message is bool &&serviceRes.message)) {
          return serviceRes;
        }
      else if (serviceRes.success == 0&&(serviceRes.message is! bool)) {
        var username = await PrefManager.getValue(PrefManager.username);
        var password = await PrefManager.getValue(PrefManager.password);
        if (username != null && password != null) {
          await AccountsRep()
              .login(LoginReq(username: username, password: password));
          return CKeys.tokenEx;
         } else {
          return serviceRes;
        }
      }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}

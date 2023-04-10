import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'api.dart';

extension on Object {
  void log() => devtools.log(toString());
}

class ApiService {
  Future<dynamic> postRequest(String url, Map data) async {
    //debugPrint('${Apis.BASE_URL}$url');
    //debugPrint('data:$data');
    final Client client = http.Client();
    try {
      final Response response = await client.post(
          Uri.parse('${Apis.BASE_URL}$url'),
          body: data,
          headers: {"Accept": "application/json"});
      //headers: await getHeaders());
      //debugPrint('myResponse ' + response.body.toString());
      final hashMap = jsonDecode(response.body);
      //print('myHashmapStatus: ${hashMap['status']}');
      if (hashMap['status'] == 1) {
        var data = hashMap['response'];
        return data;
      }
//      showToast(hashMap['message']);
      return null;
    } catch (e) {
      print(e.toString() + '=>$url');
      return null;
      // return MJResource<R>(MJStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<dynamic> getRequest(String url) async {
    //debugPrint('${APIS.BASE_URL}$url');
    final Client client = http.Client();
    try {
      final http.Response response = await client.get(
          Uri.parse('${Apis.BASE_URL}$url'),
          headers: {"Accept": "application/json"});
      //headers: await getHeaders());

      final hashMap = json.decode(response.body);
      //debugPrint('response: $hashMap');
      if (hashMap['status'] == 1) {
        dynamic data = hashMap['response'];
        return data;
      }
//      showToast(hashMap['message']);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      client.close();
    }
  }

  Future<dynamic> getData0() async {
    'into data'.log();
    final rp = ReceivePort();
    await Isolate.spawn(getData, rp.sendPort);
    "data received".log();
     debugPrint('rp.first==>${await rp.first}');
     'test'.log();
  }

  Future<dynamic> getData(SendPort sp) async {
    'inside _getData'.log();
    final Client client = http.Client();
    var result = null;

    try {
      final Response response = await client.get(
          Uri.parse(
              'https://foodie.junaidali.tk/api/v1/products/deal-detail/1'),
          headers: {"Accept": "application/json"});
      response.log();
      final hashMap = jsonDecode(response.body);
      print('myHashmapStatus: ${hashMap['status_code']}');
      if (hashMap['status_code'] == 1) {
        var data = hashMap['response'];
        result = data;
        'data+=> $data'.log();
      }
    } catch (e) {
      e.log();
    } finally {
      client.close();
    }
    Isolate.exit(sp, result);
  }
}

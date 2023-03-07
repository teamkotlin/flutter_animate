import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleSheetsData extends StatefulWidget {
  const GoogleSheetsData({Key? key}) : super(key: key);

  @override
  State<GoogleSheetsData> createState() => _GoogleSheetsDataState();
}

class _GoogleSheetsDataState extends State<GoogleSheetsData> {
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _getDataFromSheet();
  }

  Future<void> _getDataFromSheet() async {
    final String apiUrl =
        'https://sheets.googleapis.com/v4/spreadsheets/162g8_itu5BOJ_KyO3eOTFUT-cILKb5xpuBruVECUC50/values/Sheet1';

    final response = await http
        .get(Uri.parse('$apiUrl?key=AIzaSyDZCpUD6G6eHwhQR_lLAnw0nuintJP1cio'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['values'] is List &&
          data['values'].every((row) => row is List)) {
        setState(() {
          _data = List<List<dynamic>>.from(data['values']);
          debugPrint("_date+=>$_data");
          debugPrint("data+=>${data['values']}");
        });
      } else {
        throw Exception('Failed to load data from Google Sheets');
      }
    } else {
      throw Exception('Failed to load data from Google Sheets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sheets'),
      ),
      body: Center(
        child: Text('Data'),
      ),
    );
  }
}

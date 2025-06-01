import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dosen_model.dart';

Future<List<Dosen>> loadDosen() async {
  final String data =
      await rootBundle.loadString('assets/json_data_chat_dosen/dosen_chat.json');
  final List<dynamic> jsonResult = jsonDecode(data);
  return jsonResult.map((json) => Dosen.fromJson(json)).toList();
}

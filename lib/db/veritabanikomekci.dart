import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Veritabanikomekci {
  static String veritabanAdi = "flaqquiz.sqlite";

  static Future<Database> veritabanierisim() async {
    String veritabanYolu = join(await getDatabasesPath(), veritabanAdi);
    if (await databaseExists(veritabanYolu)) {
      print("kopyalanmis");
    } else {
      ByteData data = await rootBundle.load("lib/veritabani/$veritabanAdi");
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabanYolu).writeAsBytes(bytes, flush: true);
      print("kopyalaniyor...");
    }
    return openDatabase(veritabanYolu);
  }
}

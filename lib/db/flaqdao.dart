import 'package:quiz/db/flaq.dart';
import 'package:quiz/db/veritabanikomekci.dart';

class Flaqdao {
  Future<List<Flaq>> rastGele() async {
    var db = await Veritabanikomekci.veritabanierisim();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Flaqs ORDER BY RANDOM() LIMIT 9");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Flaq(satir["flaq_id"], satir["flaq_name"], satir["flaq_image"]);
    });
  }

  Future<List<Flaq>> yalnisGetir(int flaqId) async {
    var db = await Veritabanikomekci.veritabanierisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Flaqs WHERE flaq_id != $flaqId ORDER BY RANDOM() LIMIT 3");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Flaq(satir["flaq_id"], satir["flaq_name"], satir["flaq_image"]);
    });
  }
}

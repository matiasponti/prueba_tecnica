import 'package:marvel_app/models/creators_model.dart';
import 'package:marvel_app/models/series_model.dart';
import 'package:marvel_app/provider/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeriesProvider {

  int limit =20;

  Future<List<Serie>> getSeries(offset) async {
    final url = generateUrl("series", aditional: "&offset=$offset&limit=${limit.toString()}");
    print(url);
    final resp = await http.get(url.toString());
    print(resp);
    final decodedData = json.decode(resp.body.toString());

    final series = new Series.fromJsonList(decodedData["data"]["results"]);

    return series.items;
  }

 Future<List<Creator>> getCreator(id) async {
   final url = generateUrl("series/$id/creators");
   print(url);
   final resp = await http.get(url.toString());
   print(resp);
   final decodedData = json.decode(resp.body.toString());

   final creators = new ListCreators.fromJsonList(decodedData["data"]["results"]);

   return creators.items;
 }

}
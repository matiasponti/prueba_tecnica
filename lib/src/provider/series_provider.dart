
import 'package:http/http.dart' as http;
import 'package:marvel_app/src/models/creators_model.dart';
import 'dart:convert';
import 'package:marvel_app/src/models/series_model.dart';
import 'package:marvel_app/src/provider/helper.dart';

class SeriesProvider {


  Future<List<Serie>> getSeries(offset, limit) async {
    final url = generateUrl("series", aditional: "&offset=$offset&limit=$limit}");
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
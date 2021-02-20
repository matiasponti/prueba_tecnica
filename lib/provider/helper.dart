import 'dart:convert';
import 'package:crypto/crypto.dart';



class Helper {
  static String publicApiKey = "8e50214c7e9db2d60185fd8ec4175ec7";
  static String privateApiKey = "3309b0351859dca7526ec74c307f2db78c571cc3";
}

var url = "http://gateway.marvel.com/v1/public/";
var timeStamp = DateTime.now();
var hash;

String generateUrl(String subject, {String aditional = ""}) {
  generateHash();
  String urlFinal =
      "$url$subject?apikey=${Helper.publicApiKey}&hash=$hash&ts=${timeStamp.toIso8601String()}$aditional";
  print(urlFinal);
  return urlFinal;
}

generateHash() {
  hash = generateMd5(
      timeStamp.toIso8601String() + Helper.privateApiKey + Helper.publicApiKey);
  print(hash);
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

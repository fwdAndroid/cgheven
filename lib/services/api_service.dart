import 'dart:convert';
import 'package:cgheven/model/assets_model.dart';
import 'package:cgheven/model/category.dart';
import 'package:http/http.dart' as http;

class AssetService {
  static const String apiUrl = "https://api.cgheven.com/api/assets";
  static const String token =
      "Bearer 12ff81f7e95cc7350e90abc24e7562ab5dc38744d6fddc53cb1e5271cd60cdf9a2d9776d0f26f514bac372ddec587770492928da21d3b6e74822e648aa171ccf149099c9096cf10d61fe5e688861018f9dbc78ad5c7172342e63bd3f7c7a99c062d71b933c79c88eff0d60d1e96bbcc77a4239c53631e40e600836af144aed70";

  static Future<List<Asset>> fetchAssets() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": token,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List assetsJson = jsonData["data"];
      return assetsJson.map((e) => Asset.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch assets: ${response.body}");
    }
  }
}

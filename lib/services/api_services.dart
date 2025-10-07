import 'dart:convert';
import 'package:cgheven/model/announcement_model.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/model/polls_model.dart';
import 'package:http/http.dart' as http;

class AssetApiService {
  static const String newAssetUrl =
      'https://api.cgheven.com/api/assets?populate=*';
  static const String pollUrl = "https://api.cgheven.com/api/polls/";

  static const String annoucementUrl =
      "https://api.cgheven.com/api/announcements/";
  //    'https://api.cgheven.com/api/assets?sort=createdAt:desc';

  static const String token =
      "Bearer 9355813bda7bf9f9e8a89812a95b8ae3e190a7980dc156538093608344b26b637fd66b2a15c765816ec57b86549959bde01542070c2903db06443a5a3e8780bc919382806d8e702e0782827af4b9685e2b1bbf0d1aee7cf8de6d705ccc4b85198bad30ce3d82303b1557aa95b825b4afef2c661d824b9185e515e390955a4ee1";
  Future<List<AssetModel>> fetchNewAssets() async {
    final response = await http.get(
      Uri.parse(newAssetUrl),
      headers: {
        "Authorization": token,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load assets');
    }
  }

  //Polls
  Future<List<PollModel>> fetchPolls() async {
    final response = await http.get(
      Uri.parse(pollUrl),
      headers: {"Authorization": token, "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => PollModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load polls');
    }
  }

  // ----------- Announcements -----------
  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    final response = await http.get(
      Uri.parse(annoucementUrl),
      headers: {"Authorization": token, "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => AnnouncementModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }
}

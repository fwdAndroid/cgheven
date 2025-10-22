import 'dart:convert';
import 'package:cgheven/model/announcement_model.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/model/polls_model.dart';
import 'package:cgheven/model/promo_model.dart';
import 'package:cgheven/services/eam.dart';
import 'package:http/http.dart' as http;

class AssetApiService {
  static const String baseUrl = 'https://api.cgheven.com/api/assets';
  static const String pollUrl = "https://api.cgheven.com/api/polls/";
  static const String annoucementUrl =
      "https://api.cgheven.com/api/announcements/";
  static const String promoUrl = "https://api.cgheven.com/api/promos/";
  static const String subcategoryUrl =
      "https://api.cgheven.com/api/subcategories?populate=*";

  static const String token =
      "Bearer 9355813bda7bf9f9e8a89812a95b8ae3e190a7980dc156538093608344b26b637fd66b2a15c765816ec57b86549959bde01542070c2903db06443a5a3e8780bc919382806d8e702e0782827af4b9685e2b1bbf0d1aee7cf8de6d705ccc4b85198bad30ce3d82303b1557aa95b825b4afef2c661d824b9185e515e390955a4ee1";

  // ---------------------- FETCH NEW ASSETS ----------------------
  Future<List<AssetModel>> fetchNewAssets() async {
    const baseUrl =
        'https://api.cgheven.com/api/assets?populate=*&sort=createdAt:desc&filters[categorie][Name][\$eq]=VFX';
    const pageSize = 1000;
    int currentPage = 1;
    bool hasMore = true;

    List<AssetModel> allAssets = [];

    while (hasMore) {
      final url =
          '$baseUrl&pagination[page]=$currentPage&pagination[pageSize]=$pageSize';

      final response = await http.get(Uri.parse(url), headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List data = jsonData['data'];

        if (data.isEmpty) {
          hasMore = false;
        } else {
          allAssets.addAll(data.map((e) => AssetModel.fromJson(e)).toList());
          currentPage++;
        }

        final pagination = jsonData['meta']?['pagination'];
        if (pagination != null &&
            pagination['page'] >= pagination['pageCount']) {
          hasMore = false;
        }
      } else {
        throw Exception('Failed to load assets');
      }
    }

    print("✅ Total VFX Assets Fetched: ${allAssets.length}");
    return allAssets;
  }

  // ---------------------- FETCH PROMOS ----------------------
  Future<List<Promo>> fetchPromos() async {
    final response = await http.get(Uri.parse(promoUrl), headers: _headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => Promo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load promos');
    }
  }

  // ---------------------- FETCH POLLS ----------------------
  Future<List<PollModel>> fetchPolls() async {
    final response = await http.get(Uri.parse(pollUrl), headers: _headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => PollModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load polls');
    }
  }

  // ---------------------- FETCH ANNOUNCEMENTS ----------------------
  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    final response = await http.get(
      Uri.parse(annoucementUrl),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => AnnouncementModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }

  // ---------------------- SEARCH ASSETS ----------------------
  Future<List<AssetModel>> searchAssets(String query) async {
    if (query.trim().isEmpty) return [];

    final encodedQuery = Uri.encodeComponent(query.trim());
    final url = '$baseUrl?filters[Title][\$containsi]=$encodedQuery&populate=*';

    final response = await http.get(Uri.parse(url), headers: _headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search assets');
    }
  }

  // ---------------------- PAGINATED ASSETS ----------------------
  Future<List<AssetModel>> fetchPaginatedAssets({
    int page = 1,
    int pageSize = 20,
  }) async {
    const baseUrl =
        'https://api.cgheven.com/api/assets?populate=*&sort=createdAt:desc&filters[categorie][Name][\$eq]=VFX';

    final url =
        '$baseUrl&pagination[page]=$page&pagination[pageSize]=$pageSize';
    final response = await http.get(Uri.parse(url), headers: _headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load assets');
    }
  }

  // ---------------------- FETCH CATEGORIES ----------------------
  Future<List<Category>> fetchCategories() async {
    const String url = 'https://api.cgheven.com/api/categories?populate=*';

    final response = await http.get(Uri.parse(url), headers: _headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['data'];

      final categories = items
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();

      final vfxSubcategories = categories
          .where((cat) => cat.parentCategory?.name.toLowerCase() == "vfx")
          .toList();

      return vfxSubcategories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // ---------------------- FETCH BY CATEGORY ----------------------
  Future<List<AssetModel>> fetchAssetsByCategory(String categoryName) async {
    final url =
        'https://api.cgheven.com/api/assets?populate=*&sort=createdAt:desc&filters[categorie][Name][\$eq]=$categoryName';

    final response = await http.get(Uri.parse(url), headers: _headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load assets for $categoryName');
    }
  }

  // ---------------------- FETCH BY SUBCATEGORY ----------------------
  Future<List<AssetModel>> fetchAssetsBySubcategory(
    String subcategoryName,
  ) async {
    final encodedName = Uri.encodeComponent(subcategoryName.trim());
    final url =
        'https://api.cgheven.com/api/assets?populate=*&filters[categorie][Name][\$eq]=VFX&filters[subcategories][Name][\$containsi]=$encodedName';

    final response = await http.get(Uri.parse(url), headers: _headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      print(
        "✅ Found ${data.length} VFX assets in subcategory $subcategoryName",
      );
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      print("❌ Failed to load VFX assets for subcategory: $subcategoryName");
      throw Exception(
        'Failed to load VFX assets for subcategory: $subcategoryName',
      );
    }
  }

  // ---------------------- FETCH LATEST EDITED ----------------------
  Future<List<AssetModel>> fetchLatestEditedAssets({int limit = 10}) async {
    final url =
        'https://api.cgheven.com/api/assets?populate=*&sort=updatedAt:desc&pagination[page]=1&pagination[pageSize]=$limit';

    final response = await http.get(Uri.parse(url), headers: _headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      print("✅ Latest Edited Assets Fetched: ${data.length}");
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      print("❌ Failed to fetch latest edited assets: ${response.statusCode}");
      throw Exception('Failed to load latest edited assets');
    }
  }

  // ---------------------- PRELOAD ALL HOME DATA ----------------------
  Future<void> preloadAllHomeData() async {
    try {
      await Future.wait([
        fetchNewAssets(),
        fetchPromos(),
        fetchPolls(),
        fetchAnnouncements(),
        fetchCategories(),
        fetchLatestEditedAssets(limit: 10),
      ]);
      print("✅ All API data preloaded successfully before HomeScreen.");
    } catch (e) {
      print("⚠️ API preload failed: $e");
    }
  }

  // ---------------------- INTERNAL HEADERS ----------------------
  Map<String, String> get _headers => {
    "Authorization": token,
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
}

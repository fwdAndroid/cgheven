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
  //    'https://api.cgheven.com/api/assets?sort=createdAt:desc';

  static const String promoUrl = "https://api.cgheven.com/api/promos/";

  static const String subcategoryUrl =
      "https://api.cgheven.com/api/subcategories?populate=*";

  static const String token =
      "Bearer 9355813bda7bf9f9e8a89812a95b8ae3e190a7980dc156538093608344b26b637fd66b2a15c765816ec57b86549959bde01542070c2903db06443a5a3e8780bc919382806d8e702e0782827af4b9685e2b1bbf0d1aee7cf8de6d705ccc4b85198bad30ce3d82303b1557aa95b825b4afef2c661d824b9185e515e390955a4ee1";

  //APis

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

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List data = jsonData['data'];

        if (data.isEmpty) {
          hasMore = false;
        } else {
          allAssets.addAll(data.map((e) => AssetModel.fromJson(e)).toList());
          currentPage++;
        }

        // If total assets are less than page size, stop automatically
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

  // ----------- Fetch Promos -----------
  Future<List<Promo>> fetchPromos() async {
    final response = await http.get(
      Uri.parse(promoUrl),
      headers: {
        "Authorization": token,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => Promo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load promos');
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

  // ----------- Search Assets -----------
  Future<List<AssetModel>> searchAssets(String query) async {
    if (query.trim().isEmpty) return [];

    final encodedQuery = Uri.encodeComponent(query.trim());
    final url = '$baseUrl?filters[Title][\$containsi]=$encodedQuery&populate=*';

    final response = await http.get(
      Uri.parse(url),
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
      throw Exception('Failed to search assets');
    }
  }

  //Pagnination Wise Results
  Future<List<AssetModel>> fetchPaginatedAssets({
    int page = 1,
    int pageSize = 20,
  }) async {
    const baseUrl =
        'https://api.cgheven.com/api/assets?populate=*&sort=createdAt:desc&filters[categorie][Name][\$eq]=VFX';

    final url =
        '$baseUrl&pagination[page]=$page&pagination[pageSize]=$pageSize';

    final response = await http.get(
      Uri.parse(url),
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

  //Subcategories of APi
  // ----------- Fetch Subcategories of a Category -----------
  Future<List<Category>> fetchCategories() async {
    const String url = 'https://api.cgheven.com/api/categories?populate=*';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": token,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['data'];

      // Parse into Category model
      final categories = items
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();

      // Filter subcategories where parent_category.Name == "VFX"
      final vfxSubcategories = categories
          .where((cat) => cat.parentCategory?.name.toLowerCase() == "vfx")
          .toList();

      return vfxSubcategories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  //Comparing
  // Inside AssetApiService
  Future<List<AssetModel>> fetchAssetsByCategory(String categoryName) async {
    final url =
        'https://api.cgheven.com/api/assets?populate=*&sort=createdAt:desc&filters[categorie][Name][\$eq]=$categoryName';

    final response = await http.get(
      Uri.parse(url),
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
      throw Exception('Failed to load assets for $categoryName');
    }
  }

  // ----------- Fetch Assets by Subcategory Name -----------
  Future<List<AssetModel>> fetchAssetsBySubcategory(
    String subcategoryName,
  ) async {
    // Encode the subcategory name to handle spaces or special chars
    final encodedName = Uri.encodeComponent(subcategoryName.trim());

    final url =
        'https://api.cgheven.com/api/assets?populate=*&filters[subcategories][Name][\$eq]=$encodedName';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": token,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      print("✅ Found ${data.length} assets in subcategory $subcategoryName");
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      print("❌ Failed to load assets for subcategory: $subcategoryName");
      throw Exception(
        'Failed to load assets for subcategory: $subcategoryName',
      );
    }
  }
}

class AssetModel {
  final int id;
  final String documentId;
  final String title;
  final String description;
  final InfoJson infoJson;
  final List<String> thumbnail;
  final List<String> files;
  final List<String> previews;
  final List<String> additionalImages;
  final bool isPatreonLocked;
  final String category;
  final List<String> subCategories;
  final String? tierRequireds;
  final String assetsSlug;
  final String? greenScreen;
  final int earlyAccess;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String bucketId;
  final List<String> tags;

  AssetModel({
    required this.id,
    required this.documentId,
    required this.title,
    required this.description,
    required this.infoJson,
    required this.thumbnail,
    required this.files,
    required this.previews,
    required this.additionalImages,
    required this.isPatreonLocked,
    required this.category,
    required this.subCategories,
    this.tierRequireds,
    required this.assetsSlug,
    this.greenScreen,
    required this.earlyAccess,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.bucketId,
    required this.tags,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      documentId: json['documentId'],
      title: json['title'],
      description: json['description'] ?? '',
      infoJson: InfoJson.fromJson(json['info_json']),
      thumbnail: List<String>.from(json['thumbnail'] ?? []),
      files: List<String>.from(json['files'] ?? []),
      previews: List<String>.from(json['previews'] ?? []),
      additionalImages: List<String>.from(json['additional_images'] ?? []),
      isPatreonLocked: json['is_patreon_locked'] ?? false,
      category: json['category'],
      subCategories: List<String>.from(json['sub_categories'] ?? []),
      tierRequireds: json['tier_requireds'],
      assetsSlug: json['assets_slug'],
      greenScreen: json['green_screen'],
      earlyAccess: json['early_access'] ?? 0,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      bucketId: json['bucketId'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "documentId": documentId,
      "title": title,
      "description": description,
      "info_json": infoJson.toJson(),
      "thumbnail": thumbnail,
      "files": files,
      "previews": previews,
      "additional_images": additionalImages,
      "is_patreon_locked": isPatreonLocked,
      "category": category,
      "sub_categories": subCategories,
      "tier_requireds": tierRequireds,
      "assets_slug": assetsSlug,
      "green_screen": greenScreen,
      "early_access": earlyAccess,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "publishedAt": publishedAt,
      "bucketId": bucketId,
      "tags": tags,
    };
  }
}

class InfoJson {
  final bool downloadAvailable;
  final List<dynamic> assetDetails;
  final String createdAt;
  final String modifiedAt;

  InfoJson({
    required this.downloadAvailable,
    required this.assetDetails,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory InfoJson.fromJson(Map<String, dynamic> json) {
    return InfoJson(
      downloadAvailable: json['download_available'] ?? false,
      assetDetails: json['asset_details'] ?? [],
      createdAt: json['created_at'],
      modifiedAt: json['modified_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "download_available": downloadAvailable,
      "asset_details": assetDetails,
      "created_at": createdAt,
      "modified_at": modifiedAt,
    };
  }
}

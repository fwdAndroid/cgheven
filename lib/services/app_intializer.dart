import 'dart:async';
import 'package:cgheven/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/provider/promo_provider.dart';
import 'package:cgheven/provider/announcement_provider.dart';
import 'package:cgheven/services/api_services.dart';

class AppInitializer {
  // Starts preloading but does not wait for completion.
  static void startPreload(BuildContext context) {
    // Start but don't await — good for onboarding UI
    _preload(context);
  }

  // Awaits completion of preload (with timeout). Useful if you want to ensure loaded
  static Future<void> ensurePreloaded(
    BuildContext context, {
    Duration timeout = const Duration(seconds: 5),
  }) {
    return _preload(context).timeout(
      timeout,
      onTimeout: () {
        debugPrint('⚠️ Preload timed out after ${timeout.inSeconds}s');
        // We don't throw; return so app can proceed.
        return;
      },
    );
  }

  static Future<void> _preload(BuildContext context) async {
    final assetProvider = Provider.of<AssetProvider>(context, listen: false);
    final promoProvider = Provider.of<PromoProvider>(context, listen: false);
    final announcementProvider = Provider.of<AnnouncementProvider>(
      context,
      listen: false,
    );
    final apiService = AssetApiService();

    try {
      // Run in parallel. Each provider method has guards to skip if already loaded.
      await Future.wait([
        assetProvider.getNewAssets(),
        assetProvider.getLatestEditedAssets(limit: 10),
        promoProvider.fetchPromos(),
        announcementProvider.loadAnnouncements(),
        // fetch categories directly from ApiService (maybe cached inside service)
        apiService.fetchCategories(),
      ]);
      debugPrint('✅ AppInitializer: preload complete');
    } catch (e) {
      debugPrint('⚠️ AppInitializer: preload error: $e');
      // swallow errors — avoid blocking user flow. Providers will show fallback UI.
    }
  }
}

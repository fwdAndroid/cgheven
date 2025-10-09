import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsProvider extends ChangeNotifier {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final AnalyticsRouteObserver routeObserver = AnalyticsRouteObserver();

  /// Log when a user opens an asset
  Future<void> logAssetView(String assetId, String title) async {
    await analytics.logEvent(
      name: 'asset_view',
      parameters: {'asset_id': assetId, 'asset_title': title},
    );
  }

  /// Log when the profile page is opened
  Future<void> logProfileVisit() async {
    await analytics.logEvent(name: 'profile_visit');
  }

  /// Log generic custom events (buttons, actions, etc.)
  Future<void> logCustomEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    await analytics.logEvent(
      name: name,
      parameters: parameters == null
          ? null
          : parameters.map((key, value) => MapEntry(key, value as Object)),
    );
  }

  /// Manual screen logging (optional — automatically handled by observer)
  Future<void> logScreen(String screenName) async {
    await analytics.logScreenView(screenName: screenName);
  }
}

/// Automatically track screen views & engagement time
class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final Map<String, DateTime> _screenStartTimes = {};

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) _onScreenOpened(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute) _onScreenClosed(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) _onScreenOpened(newRoute);
    if (oldRoute is PageRoute) _onScreenClosed(oldRoute);
  }

  void _onScreenOpened(PageRoute route) {
    final screenName = route.settings.name ?? route.runtimeType.toString();
    _screenStartTimes[screenName] = DateTime.now();

    FirebaseAnalytics.instance.logScreenView(screenName: screenName);
  }

  void _onScreenClosed(PageRoute route) {
    final screenName = route.settings.name ?? route.runtimeType.toString();
    final start = _screenStartTimes.remove(screenName);
    if (start != null) {
      final duration = DateTime.now().difference(start).inSeconds;
      FirebaseAnalytics.instance.logEvent(
        name: 'user_engagement_duration',
        parameters: {'screen_name': screenName, 'duration_seconds': duration},
      );
    }
  }
}

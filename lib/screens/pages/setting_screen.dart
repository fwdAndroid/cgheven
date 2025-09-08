import 'package:cgheven/screens/utils/color.dart';
import 'package:cgheven/screens/utils/gradient_color_utils.dart';
import 'package:cgheven/widget/gradient_background_widget.dart';
import 'package:cgheven/widget/gradient_switch.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notifications = true;
  bool wifiOnly = false;
  bool autoDownloadPreviews = true;
  bool adFree = false;
  String defaultQuality = '2K';
  String language = 'English';

  void toggleSetting(String key) {
    setState(() {
      if (key == 'notifications') notifications = !notifications;
      if (key == 'wifiOnly') wifiOnly = !wifiOnly;
      if (key == 'autoDownloadPreviews')
        autoDownloadPreviews = !autoDownloadPreviews;
    });
  }

  void setQuality(String quality) {
    setState(() {
      defaultQuality = quality;
    });
  }

  void setLanguage(String lang) {
    setState(() {
      language = lang;
    });
  }

  void handleClearCache() {
    debugPrint("Clearing cache...");
  }

  void handleLogout() {
    debugPrint("Logging out...");
  }

  Widget buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: GradientSwitch(value: value, onChanged: (_) => onTap()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GradientText(
                  "Settings",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2A7B9B),
                      Color(0xFF57C785),
                      Color(0xFFEDDD53),
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notifications, color: teal),
                            SizedBox(width: 8),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                color: colorWhite,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        buildSwitchTile(
                          title: "Announcements",
                          subtitle:
                              "Get notified about new challenges and updates",
                          value: notifications,
                          onTap: () => toggleSetting('notifications'),
                        ),
                      ],
                    ),
                  ),
                ),

                // Downloads
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.download, color: Colors.teal),
                            SizedBox(width: 8),
                            Text(
                              "Downloads",
                              style: TextStyle(
                                fontSize: 22,
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        buildSwitchTile(
                          title: "Wi-Fi Only",
                          subtitle: "Download only when connected to \nWi-Fi",
                          value: wifiOnly,
                          onTap: () => toggleSetting('wifiOnly'),
                        ),
                        buildSwitchTile(
                          title: "Auto-download Previews",
                          subtitle: "Automatically cache preview thumbnails",
                          value: autoDownloadPreviews,
                          onTap: () => toggleSetting('autoDownloadPreviews'),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          "Default Download Quality",
                          style: TextStyle(
                            color: colorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sets the default suggestion only. Ad gating still applies for 2K/4K and ProRes formats.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: ["1K", "2K", "4K"].map((q) {
                            final selected = defaultQuality == q;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: selected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF2A7B9B),
                                            Color(0xFF57C785),
                                            Color(0xFFEDDD53),
                                          ],
                                          stops: [0.0, 0.5, 1.0],
                                        )
                                      : null,
                                  color: selected ? null : Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => setQuality(q),
                                  child: Text(
                                    q,
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Subscription
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.subscriptions, color: teal),
                                const SizedBox(width: 8),
                                Text(
                                  "Subscription",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Ad-Free Status",
                              style: TextStyle(
                                fontSize: 18,
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              adFree
                                  ? "Premium subscription active"
                                  : "Free tier - ads enabled",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF2A7B9B),
                                Color(0xFF57C785),
                                Color(0xFFEDDD53),
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              adFree ? "Manage" : "Upgrade",
                              style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Language
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.language, color: Colors.teal),
                            SizedBox(width: 8),
                            Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 22,
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: ["English", "Urdu"].map((lang) {
                            final selected = language == lang;
                            return ListTile(
                              title: Text(
                                lang,
                                style: TextStyle(
                                  color: selected ? Colors.teal : Colors.grey,
                                ),
                              ),
                              trailing: selected
                                  ? const Icon(Icons.check, color: Colors.teal)
                                  : null,
                              onTap: () => setLanguage(lang),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.grey),
                          title: const Text(
                            "Clear Cache",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: handleClearCache,
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.security,
                            color: Colors.grey,
                          ),
                          title: const Text(
                            "Privacy Policy",
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.description,
                            color: Colors.grey,
                          ),
                          title: const Text(
                            "Terms of Service",
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.support,
                            color: Colors.grey,
                          ),
                          title: const Text(
                            "Contact Support",
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.grey),
                          title: const Text(
                            "Log Out",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: handleLogout,
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

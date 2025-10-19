import 'package:cgheven/provider/language_provider.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/buid_background.dart';
import 'package:cgheven/widget/gradient_button.dart';
import 'package:cgheven/widget/gradient_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey)),
      trailing: GradientSwitch(value: value, onChanged: (_) => onTap()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🌈 Layer 1: Rich 3-color gradient background
          buildBackground(),

          // 🌟 Foreground UI content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.fireGradient.createShader(bounds),
                      child: Text(
                        languageProvider.localizedStrings['Setting'] ??
                            "Setting",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Notifications Section
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.notifications, color: Colors.teal),
                            const SizedBox(width: 8),
                            Text(
                              languageProvider
                                      .localizedStrings['Notifications'] ??
                                  "Notifications",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        buildSwitchTile(
                          title:
                              languageProvider
                                  .localizedStrings['Announcements'] ??
                              "Announcements",
                          subtitle:
                              languageProvider
                                  .localizedStrings['Get notified about new challenges and updates'] ??
                              "Get notified about new challenges and updates",
                          value: notifications,
                          onTap: () => toggleSetting('notifications'),
                        ),
                      ],
                    ),
                  ),

                  // Downloads Section
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.download, color: Colors.teal),
                            const SizedBox(width: 8),
                            Text(
                              languageProvider.localizedStrings['Downloads'] ??
                                  "Downloads",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        buildSwitchTile(
                          title:
                              languageProvider.localizedStrings['Wi-Fi Only'] ??
                              "Wi-Fi Only",
                          subtitle:
                              languageProvider
                                  .localizedStrings['Download only when connected to \nWi-Fi'] ??
                              "Download only when connected to \nWi-Fi",
                          value: wifiOnly,
                          onTap: () => toggleSetting('wifiOnly'),
                        ),
                        buildSwitchTile(
                          title:
                              languageProvider
                                  .localizedStrings['Auto-download Previews'] ??
                              "Auto-download Previews",
                          subtitle:
                              languageProvider
                                  .localizedStrings['Automatically cache preview thumbnails'] ??
                              "Automatically cache preview thumbnails",
                          value: autoDownloadPreviews,
                          onTap: () => toggleSetting('autoDownloadPreviews'),
                        ),
                      ],
                    ),
                  ),

                  // Subscription Section
                  _buildSectionContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.money, color: Colors.teal),
                                const SizedBox(width: 8),
                                Text(
                                  languageProvider
                                          .localizedStrings['Subscription'] ??
                                      "Subscription",
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              languageProvider
                                      .localizedStrings['Ad-Free Status'] ??
                                  "Ad-Free Status",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              adFree
                                  ? languageProvider
                                            .localizedStrings['Premium subscription active'] ??
                                        "Premium subscription active"
                                  : languageProvider
                                            .localizedStrings['Free tier - ads enabled'] ??
                                        "Free tier - ads enabled",
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                          ],
                        ),
                        GradientButton(
                          gradient: AppTheme.fireGradient,
                          onPressed: () {},
                          child: Text(
                            "Upgrade",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Language Section
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.language, color: Colors.teal),
                            const SizedBox(width: 8),
                            Text(
                              languageProvider.localizedStrings['Language'] ??
                                  "Language",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildLanguageTile(
                          langCode: 'en',
                          label: 'English',
                          languageProvider: languageProvider,
                        ),
                        _buildLanguageTile(
                          langCode: 'ur',
                          label: 'Urdu',
                          languageProvider: languageProvider,
                        ),
                      ],
                    ),
                  ),

                  // System Section
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            languageProvider.localizedStrings['System'] ??
                                "System",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildBorderedTile(
                          icon: Icons.delete,
                          title:
                              languageProvider
                                  .localizedStrings['Clear Cache'] ??
                              "Clear Cache",
                          onTap: handleClearCache,
                        ),
                        _buildBorderedTile(
                          icon: Icons.security,
                          title:
                              languageProvider
                                  .localizedStrings['Privacy Policy'] ??
                              "Privacy Policy",
                          onTap: () {},
                        ),
                        _buildBorderedTile(
                          icon: Icons.description,
                          title:
                              languageProvider
                                  .localizedStrings['Terms of Service'] ??
                              "Terms of Service",
                          onTap: () {},
                        ),
                        _buildBorderedTile(
                          icon: Icons.support,
                          title:
                              languageProvider
                                  .localizedStrings['Contact Support'] ??
                              "Contact Support",
                          onTap: () {},
                        ),
                        _buildBorderedTile(
                          icon: Icons.logout,
                          title:
                              languageProvider.localizedStrings['Log Out'] ??
                              "Log Out",
                          onTap: handleLogout,
                          isLogout: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Helper for reusable section containers
  Widget _buildSectionContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF00BCD4).withOpacity(.4),
            width: 1,
          ),
        ),
        child: child,
      ),
    );
  }

  // 🔹 Helper for language options
  Widget _buildLanguageTile({
    required String langCode,
    required String label,
    required LanguageProvider languageProvider,
  }) {
    final isActive = languageProvider.currentLanguage == langCode;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(.3)),
      ),
      child: ListTile(
        onTap: () => languageProvider.changeLanguage(langCode),
        trailing: Icon(
          isActive ? Icons.radio_button_checked : Icons.radio_button_off,
          color: Colors.teal,
          size: 20,
        ),
        title: Text(
          label,
          style: GoogleFonts.poppins(
            color: isActive ? Colors.teal : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 🔹 Helper for system action tiles
  Widget _buildBorderedTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(.3)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isLogout ? Colors.redAccent : Colors.grey,
            fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

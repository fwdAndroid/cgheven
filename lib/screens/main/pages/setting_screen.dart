import 'package:cgheven/provider/language_provider.dart';
import 'package:cgheven/utils/app_theme.dart';
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
    final languageProvider = Provider.of<LanguageProvider>(
      context,
    ); // Access the provider

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // 135 degrees = top-left → bottom-right
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B1C24), // #0b1c24 at 0%
              Color(0xFF1A0F0D), // #1a0f0d at 100%
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Inside build()
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF2A7B9B), // teal-ish
                        Color(0xFF57C785), // green-ish
                        Color(0xFFEDDD53), // yellow-ish
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      languageProvider.localizedStrings['Setting'] ?? "Setting",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white, // important! this becomes mask
                      ),
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
                      border: Border.all(
                        color: const Color(0xFF00bcd4).withOpacity(.4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notifications, color: Colors.teal),
                            SizedBox(width: 8),
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
                ),

                // Downloads
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF00bcd4).withOpacity(.4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.download, color: Colors.teal),
                            SizedBox(width: 8),
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

                        const SizedBox(height: 8),
                        Text(
                          languageProvider
                                  .localizedStrings['Default Download Quality'] ??
                              "Default Download Quality",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          languageProvider
                                  .localizedStrings['Sets the default suggestion only. Ad gating still applies for 2K/4K and ProRes formats.'] ??
                              "Sets the default suggestion only. Ad gating still applies for 2K/4K and ProRes formats.",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: ["1K", "2K", "4K"].map((q) {
                            final selected = defaultQuality == q;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GradientButton(
                                gradient: selected
                                    ? AppTheme.fireGradient
                                    : AppTheme.greyGradeubt,
                                onPressed: () => setQuality(q),
                                child: Text(
                                  q,
                                  style: GoogleFonts.poppins(
                                    color: selected
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.w600,
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
                      border: Border.all(
                        color: const Color(0xFF00bcd4).withOpacity(.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.money, color: Colors.teal),
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
                ),
                // Language
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF00bcd4).withOpacity(.4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.language, color: Colors.teal),
                            SizedBox(width: 8),
                            Text(
                              languageProvider.localizedStrings['Lanuage'] ??
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
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.withOpacity(.3),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              languageProvider.changeLanguage(
                                'en',
                              ); // Switch to English
                            },
                            trailing: Icon(
                              languageProvider.currentLanguage == 'en'
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: Colors
                                  .teal, // use teal for active consistency
                              size: 20,
                            ),
                            title: Text(
                              languageProvider.localizedStrings['English'] ??
                                  "English",
                              style: GoogleFonts.poppins(
                                color: languageProvider.currentLanguage == 'en'
                                    ? Colors
                                          .teal // highlight active lang
                                    : Colors.grey, // inactive lang
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.withOpacity(.3),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              languageProvider.changeLanguage(
                                'ur',
                              ); // Switch to Urdu
                            },
                            trailing: Icon(
                              languageProvider.currentLanguage == 'ur'
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: Colors.teal,
                              size: 20,
                            ),
                            title: Text(
                              languageProvider.localizedStrings['Urdu'] ??
                                  "Urdu",
                              style: GoogleFonts.poppins(
                                color: languageProvider.currentLanguage == 'ur'
                                    ? Colors
                                          .teal // active
                                    : Colors.grey, // inactive
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
                      border: Border.all(
                        color: const Color(0xFF00bcd4).withOpacity(.4),
                        width: 1,
                      ),
                    ),
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
                        // 🔴 Logout with red border
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
            color: Colors.grey,
            fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

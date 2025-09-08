import 'package:cgheven/model/user_asset.dart';
import 'package:cgheven/screens/utils/color.dart';
import 'package:cgheven/screens/utils/gradient_color_utils.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;
  String activeTab = 'assets';

  late final List<UserAsset> userAssets;
  late final List<Map<String, String>> stats;

  @override
  void initState() {
    super.initState();
    userAssets = [
      UserAsset(
        id: 1,
        title: 'Epic Fire Blast',
        thumbnail:
            'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '2.3K',
        likes: '456',
      ),
      UserAsset(
        id: 2,
        title: 'Lightning Strike',
        thumbnail:
            'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '1.8K',
        likes: '321',
      ),
      UserAsset(
        id: 3,
        title: 'Smoke Plume',
        thumbnail:
            'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '3.1K',
        likes: '678',
      ),
      UserAsset(
        id: 4,
        title: 'Magic Sparkles',
        thumbnail:
            'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '1.5K',
        likes: '234',
      ),
      UserAsset(
        id: 5,
        title: 'Dust Cloud',
        thumbnail:
            'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '2.7K',
        likes: '543',
      ),
      UserAsset(
        id: 6,
        title: 'Debris Scatter',
        thumbnail:
            'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '1.9K',
        likes: '387',
      ),
    ];

    stats = [
      {'label': 'Assets', 'value': '127'},
      {'label': 'Downloads', 'value': '45.2K'},
      {'label': 'Followers', 'value': '8.9K'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.teal, Colors.orange],
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=300',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GradientText(
                "Ammar Khan",
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
              const SizedBox(height: 4),
              const Text(
                'Creator of CGHEVEN VFX',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 12),

              // Follow Button and Socials
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() => isFollowing = !isFollowing);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      icon: Icon(Icons.person_add, color: colorWhite),
                      label: Text(
                        isFollowing ? 'Following' : 'Follow',
                        style: TextStyle(color: colorWhite),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff1F2A33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        size: 30.0, // Optional: Adjust the size
                        color: Colors.grey, // Optional: Set a color
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff1F2A33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.youtube,
                        size: 30.0, // Optional: Adjust the size
                        color: Colors.grey, // Optional: Set a color
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: stats
                    .map(
                      (s) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            GradientText(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF2A7B9B),
                                  Color(0xFF57C785),
                                  Color(0xFFEDDD53),
                                ],
                                stops: [0.0, 0.5, 1.0],
                              ),
                              s['value']!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s['label']!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                  child: const Text(
                    'Professional VFX artist and creator with over 8 years of experience in cinematic effects. '
                    'Specializing in explosions, fire, smoke, and magical elements for film and television productions. '
                    'Passionate about creating high-quality assets that bring stories to life.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              //    Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              // child: GridView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 12,
              //     mainAxisSpacing: 12,
              //     childAspectRatio: 0.8,
              //   ),
              //   itemCount: userAssets.length,
              //   itemBuilder: (context, index) {
              //     final asset = userAssets[index];
              //     return AssetCard(asset: asset);
              //   },
              // ),
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}

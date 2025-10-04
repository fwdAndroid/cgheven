import 'package:cgheven/screens/auth/login_screen.dart';
import 'package:cgheven/screens/main/main_dashboard.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/animated_background.dart';
import 'package:cgheven/widget/featured_card.dart';
import 'package:cgheven/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentScreen = 0;
  int currentSlide = 0;
  PageController pageController = PageController();
  PageController featureController = PageController();

  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.movie_filter,
      'title': 'Explore Free VFX Assets',
      'description':
          'Hundreds of professional explosion, fire, and energy effects ready for your projects',
      'image':
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=600',
      'gradient': LinearGradient(
        colors: [Color(0x4DFF6B00), Color(0x4DFF3C00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'icon': Icons.download,
      'title': 'Download & Manage Easily',
      'description':
          'Seamless downloads in multiple formats with built-in library management',
      'image':
          'https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=600',
      'gradient': LinearGradient(
        colors: [Color(0x4D6B7280), Color(0x4D374151)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'icon': Icons.auto_awesome,
      'title': 'Stay Updated with News & Community',
      'description':
          'Join the community, participate in challenges, and get the latest VFX updates',
      'image':
          'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=600',
      'gradient': LinearGradient(
        colors: [Color(0x4D8B5CF6), Color(0x4DEC4899)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
  ];

  void nextScreen() {
    if (currentScreen < 3) {
      setState(() {
        currentScreen++;
      });
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextSlide() {
    if (currentSlide < features.length - 1) {
      setState(() {
        currentSlide++;
      });
      featureController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() {
        currentSlide = 0;
      });
      featureController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevSlide() {
    if (currentSlide > 0) {
      setState(() {
        currentSlide--;
      });
      featureController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() {
        currentSlide = features.length - 1;
      });
      featureController.animateToPage(
        features.length - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildWelcomeScreen(),
          _buildFeaturesScreen(),
          _buildHowItWorksScreen(),
          _buildLoginScreen(),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return AnimatedBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: AppTheme.fireGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppTheme.fireGlowShadow,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppTheme.darkBackground,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: AppTheme.tealStart.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'CG',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = AppTheme.logoGradient.createShader(
                                Rect.fromLTWH(0, 0, 100, 100),
                              ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .scale(duration: 800.ms, curve: Curves.elasticOut)
                  .fadeIn(duration: 600.ms),

              // Brand Name
              ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.logoGradient.createShader(bounds),
                    child: Text(
                      'CGHEVEN',
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 600.ms, delay: 200.ms),

              SizedBox(height: 16),

              // Tagline
              Text(
                    'Free VFX Assets for Creators',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 600.ms, delay: 400.ms),

              SizedBox(height: 48),

              // VFX Preview Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    [
                      'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=200',
                      'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=200',
                      'https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=200',
                    ].asMap().entries.map((entry) {
                      return Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppTheme.tealStart.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: AppTheme.cardShadow,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Image.network(
                                    entry.value,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.4),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .animate(delay: (entry.key * 200).ms)
                          .scale(duration: 600.ms, curve: Curves.elasticOut)
                          .fadeIn(duration: 400.ms);
                    }).toList(),
              ),

              SizedBox(height: 78),

              // Get Started Button
              GradientButton(
                    onPressed: nextScreen,
                    gradient: AppTheme.fireGradient,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 600.ms, delay: 800.ms),

              SizedBox(height: 32),

              // Subtitle
              Text(
                'Professional VFX • Always Free • No Watermarks',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textSecondary.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesScreen() {
    return AnimatedBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              SizedBox(height: 48),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.logoGradient.createShader(bounds),
                child: Text(
                  'Why Choose CGHEVEN?',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Professional VFX assets at your fingertips',
                style: GoogleFonts.poppins(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),

              // Feature Carousel
              Expanded(
                child: PageView.builder(
                  controller: featureController,
                  onPageChanged: (index) {
                    setState(() {
                      currentSlide = index;
                    });
                  },
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return FeatureCard(
                      feature: features[index],
                      onPrevious: prevSlide,
                      onNext: nextSlide,
                      currentIndex: currentSlide,
                      totalCount: features.length,
                    );
                  },
                ),
              ),

              SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: GradientButton(
                  onPressed: nextScreen,
                  gradient: AppTheme.fireGradient,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Continue',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHowItWorksScreen() {
    final steps = [
      {
        'number': '1',
        'icon': Icons.search,
        'title': 'Discover assets',
        'description': 'Browse our collection of professional VFX elements',
      },
      {
        'number': '2',
        'icon': Icons.favorite,
        'title': 'Save favorites',
        'description': 'Build your personal library of go-to effects',
      },
      {
        'number': '3',
        'icon': Icons.download,
        'title': 'Download & create',
        'description': 'Use in your projects with no restrictions',
      },
    ];

    return AnimatedBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              SizedBox(height: 48),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.logoGradient.createShader(bounds),
                child: Text(
                  'How It Works',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Get started in 3 simple steps',
                style: GoogleFonts.poppins(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),

              // Steps
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 600),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppTheme.darkBackground.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppTheme.tealStart.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: AppTheme.cardShadow,
                              ),
                              child: Row(
                                children: [
                                  // Step Icon
                                  Stack(
                                    children: [
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          gradient: AppTheme.fireGradient,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: AppTheme.fireGlowShadow,
                                        ),
                                        child: Icon(
                                          step['icon'] as IconData,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: -8,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            gradient: AppTheme.tealGradient,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: AppTheme.glowShadow,
                                          ),
                                          child: Center(
                                            child: Text(
                                              step['number'] as String,
                                              style: GoogleFonts.poppins(
                                                color: AppTheme.darkBackground,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  // Step Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          step['title'] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          step['description'] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: AppTheme.textSecondary
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Continue Button
              GradientButton(
                onPressed: nextScreen,
                gradient: AppTheme.fireGradient,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginScreen() {
    return AnimatedBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              SizedBox(height: 48),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.logoGradient.createShader(bounds),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Choose how you\'d like to continue',
                style: GoogleFonts.poppins(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              Spacer(),

              // Login Options
              Column(
                children: [
                  // Google Login
                  _buildLoginButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => LoginScreen()),
                      );
                    },
                    backgroundColor: Colors.white,
                    textColor: AppTheme.darkBackground,
                    icon: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: AppTheme.fireGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    text: 'Continue with Google',
                  ),

                  SizedBox(height: 16),

                  // Email Login
                  _buildLoginButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => LoginScreen()),
                      ),
                    },
                    backgroundColor: AppTheme.darkBackground.withOpacity(0.6),
                    textColor: AppTheme.textPrimary,
                    icon: Icon(Icons.mail, color: AppTheme.tealStart, size: 24),
                    text: 'Continue with Email',
                    borderColor: AppTheme.tealStart.withOpacity(0.3),
                  ),

                  SizedBox(height: 16),

                  // Guest Mode
                  SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => MainDashboard(),
                          ),
                        );
                      },
                      gradient: AppTheme.fireGradient,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            'Continue as Guest',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(),

              // Footer Note
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textSecondary.withOpacity(0.4),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    required Widget icon,
    required String text,
    Color? borderColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 1)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

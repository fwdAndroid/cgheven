import 'package:cgheven/screens/auth/login_screen.dart';
import 'package:cgheven/screens/utils/color.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _current = 0;

  final pages = const [
    _OnboardPageData(
      title: 'Download CG Assets',
      subtitle: 'Download free CG assets (fire, explosion, Lightning, etc)',
      asset: 'assets/logo.png',
    ),
    _OnboardPageData(
      title: 'Use CG Assets',
      subtitle:
          'Use them in Cap Cut, In Shot, VN Video Editor, and Kine Master',
      asset: 'assets/logo.png',
    ),
    _OnboardPageData(
      title: 'CG PREMIUM',
      subtitle: 'Free forever. CC0 License. Upgrade for ad-free & early access',
      asset: 'assets/logo.png',
    ),
  ];

  Future<void> _finish() async {
    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  void _next() {
    if (_current < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    } else {
      _finish();
    }
  }

  void _skip() => _finish();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar: Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Pages
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _current = i),
                  itemBuilder: (context, index) {
                    final p = pages[index];
                    return _OnboardPage(
                      title: p.title,
                      subtitle: p.subtitle,
                      asset: p.asset,
                    );
                  },
                ),
              ),

              // Dots + next / get started
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _DotsIndicator(
                        count: pages.length,
                        index: _current,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _next,
                      icon: Icon(
                        _current == pages.length - 1
                            ? Icons.check
                            : Icons.arrow_forward_rounded,
                      ),
                      label: Text(
                        _current == pages.length - 1 ? 'Login' : 'Next',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String title;
  final String subtitle;
  final String asset;
  const _OnboardPageData({
    required this.title,
    required this.subtitle,
    required this.asset,
  });
}

class _OnboardPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  const _OnboardPage({
    required this.title,
    required this.subtitle,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: Color(0xff242424),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      asset,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.image_outlined,
                        size: 88,
                        color: Color(0xff2F8C86),
                      ),
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: btnColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int index;
  const _DotsIndicator({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 10,
          width: active ? 24 : 10,
          decoration: BoxDecoration(
            color: active
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withOpacity(0.25),
            borderRadius: BorderRadius.circular(16),
          ),
        );
      }),
    );
  }
}

// =========================
// Quick Usage Notes
// =========================
// 1) Add 3 images to assets/onboarding as 1.png, 2.png, 3.png or change paths.
// 2) Add shared_preferences to pubspec and run `flutter pub get`.
// 3) Replace _DemoHome with your real HomeScreen, or navigate to your routes.
// 4) For Lottie animations, swap Image.asset with a Lottie.asset widget.

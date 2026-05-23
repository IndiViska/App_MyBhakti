import 'package:flutter/material.dart';
import 'dart:ui';
/*import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';*/
import 'package:app_mybhakti/pages/login.dart';

// ─────────────────────────────────────────────
// Onboarding 1 – Splash / Logo screen
// Full red background, centered logo
// ─────────────────────────────────────────────
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding2()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // background merah
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFB1121B),
          ),

          // layer putih meleleh
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  lerpDouble(-height, height, _animation.value)!,
                ),
                child: ClipPath(
                 // clipper: WaveClipperOne(flip: true),
                  child: Container(
                    width: double.infinity,
                    height: height,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Onboarding 2 – Full-screen background image
// (decorative / transition screen)
// ─────────────────────────────────────────────
class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});
  @override
  Onboarding2State createState() => Onboarding2State();
}

class Onboarding2State extends State<Onboarding2> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding3()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Image.asset('lib/assets/mybhakti2.png', height: 70),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Onboarding 3 – Full-screen illustration
// Red background, full-bleed character image
// ─────────────────────────────────────────────
class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => Onboarding3State();
}

class Onboarding3State extends State<Onboarding3> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding4()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOutCubic,

          builder: (context, value, child) {
            // posisi logo
            final double top = lerpDouble(
              MediaQuery.of(context).size.height / 2 - 35,
              98,
              Curves.easeInOut.transform(value),
            )!;

            // scale logo (lebih smooth)
            final double scale = lerpDouble(
              1.0,
              0.57,
              Curves.easeOutExpo.transform(value),
            )!;

            return Stack(
              children: [
                Positioned(
                  top: top,
                  left: 0,
                  right: 0,

                  child: Center(
                    child: Transform.scale(
                      scale: scale,
                      child: Image.asset(
                        'lib/assets/mybhakti2.png',
                        height: 70,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Onboarding 4 – Slide 1 (page indicator dot 1 active)
// Background image, logo, skip button, illustration,
// "WELCOME to MyBhakti" text, dots + next arrow
// ─────────────────────────────────────────────
class Onboarding4 extends StatefulWidget {
  const Onboarding4({super.key});
  @override
  Onboarding4State createState() => Onboarding4State();
}

class Onboarding4State extends State<Onboarding4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 120,
                child: SizedBox(
                  width: 300,
                  child: Image.asset(
                    'lib/assets/on11.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 120,
                child: SizedBox(
                  width: 300,
                  child: Image.asset('lib/assets/on1.png', fit: BoxFit.contain),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 112),
                child: Column(
                  children: [
                    // Logo
                    Container(
                      margin: const EdgeInsets.only(bottom: 38),
                      child: Image.asset(
                        'lib/assets/mybhakti2.png',
                        height: 40,
                      ),
                    ),

                    // Skip button – top right
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF9E9E9E),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(right: 42),
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Welcome text
                    Container(
                      margin: const EdgeInsets.only(bottom: 81),
                      child: const Text(
                        "WELCOME to MyBhakti",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Dots + Next arrow
                    _buildBottomNav(
                      activeDot: 0,
                      onNext: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Onboarding5(),
                          ),
                        );
                      },
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

// ─────────────────────────────────────────────
// Onboarding 5 – Slide 2 (page indicator dot 2 active)
// Same layout as Onboarding4, different background
// and illustration, no welcome text
// ─────────────────────────────────────────────
class Onboarding5 extends StatefulWidget {
  const Onboarding5({super.key});
  @override
  Onboarding5State createState() => Onboarding5State();
}

class Onboarding5State extends State<Onboarding5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/onboarding5_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                // Logo
                Container(
                  margin: const EdgeInsets.only(bottom: 38),
                  child: Image.asset('lib/assets/mybhakti2.png', height: 40),
                ),

                // Skip button – top right
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF9E9E9E),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 18,
                      ),
                      margin: const EdgeInsets.only(right: 42, bottom: 121),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),

                // Illustration
                Container(
                  height: 448,
                  width: double.infinity,
                  child: Image.asset(
                    'lib/assets/onboarding5_char.png',
                    fit: BoxFit.fill,
                  ),
                ),

                const SizedBox(height: 16),

                // Dots + Next arrow
                _buildBottomNav(
                  activeDot: 1,
                  onNext: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Shared bottom navigation: dots + next arrow
// activeDot: 0 = first dot active, 1 = second, 2 = third
// ─────────────────────────────────────────────
Widget _buildBottomNav({required int activeDot, required VoidCallback onNext}) {
  const Color activeColor = Color(0xFF9E9E9E);
  const Color inactiveColor = Color(0xFFD9D9D9);
  const int totalDots = 3;

  return Container(
    margin: const EdgeInsets.only(bottom: 62, left: 48, right: 48),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left spacer (placeholder for back button if needed)
        const SizedBox(width: 55, height: 55),

        // Page indicator dots
        Row(
          children: List.generate(totalDots, (index) {
            final bool isActive = index == activeDot;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isActive ? activeColor : inactiveColor,
              ),
              margin: index < totalDots - 1
                  ? const EdgeInsets.only(right: 8)
                  : EdgeInsets.zero,
              width: 26,
              height: 5,
            );
          }),
        ),

        // Next arrow button
        SizedBox(
          width: 55,
          height: 55,
          child: InkWell(
            onTap: onNext,
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'lib/assets/onboarding_next_arrow.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}

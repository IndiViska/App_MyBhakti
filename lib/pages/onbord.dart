import 'package:app_mybhakti/pages/login.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// Onboarding 1 – Splash / Logo screen
// Full red background, centered logo
// ─────────────────────────────────────────────
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFB1121B),
          child: Center(
            child: Image.asset('lib/assets/mybhakti1.png', height: 70),
          ),
        ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Image.asset(
            'lib/assets/onboarding2_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
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
  Onboarding3State createState() => Onboarding3State();
}

class Onboarding3State extends State<Onboarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFB1121B),
          child: Image.asset(
            'lib/assets/onboarding3_illustration.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
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
  get g => null;

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
                padding: const EdgeInsets.only(top: 98),
                child: Column(
                  children: [
                    // Logo
                    Container(
                      margin: const EdgeInsets.only(bottom: 38),
                      child: Image.asset(
                        'lib/assets/mybhakti1.png',
                        height: 70,
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

                    // Illustration
                    Container(
                      height: 464,
                      width: double.infinity,
                      child: Image.asset(
                        'lib/assets/onboarding4_char.png',
                        fit: BoxFit.fill,
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
            padding: const EdgeInsets.only(top: 98),
            child: Column(
              children: [
                // Logo
                Container(
                  margin: const EdgeInsets.only(bottom: 38),
                  child: Image.asset('lib/assets/mybhakti1.png', height: 70),
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

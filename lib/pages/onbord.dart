<<<<<<< HEAD
import 'package:app_mybhakti/pages/login.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:app_mybhakti/pages/login.dart';


// ─────────────────────────────────────────────
// Onboarding 1 – Splash / Logo screen
// Full red background, centered logo
// ─────────────────────────────────────────────
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
<<<<<<< HEAD
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
=======

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
      duration: const Duration(milliseconds: 2200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
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
          // BACKGROUND TRANSISI MERAH -> PUTIH
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double fadeValue = ((_animation.value - 0.7) / 0.3).clamp(
                0.0,
                1.0,
              );

              return Column(
                children: [
                  // hampir seluruh layar jadi putih
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Color.lerp(
                        const Color(0xFFB1121B),
                        Colors.white,
                        fadeValue,
                      ),
                    ),
                  ),

                  // sisa kecil bawah tetap merah
                  Expanded(
                    flex: 1,
                    child: Container(color: const Color(0xFFB1121B)),
                  ),
                ],
              );
            },
          ),
          // LAYER PUTIH MELELEH
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  lerpDouble(-height * 1.8, height * 0.87, _animation.value)!,
                ),
                child: ClipPath(
                  clipper: MeltClipper(),
                  child: Container(
                    width: double.infinity,
                    height: height * 70,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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
<<<<<<< HEAD
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
=======
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
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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
<<<<<<< HEAD
  @override
  Onboarding3State createState() => Onboarding3State();
=======

  @override
  State<Onboarding3> createState() => Onboarding3State();
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
}

class Onboarding3State extends State<Onboarding3> {
  @override
<<<<<<< HEAD
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
=======
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
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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
<<<<<<< HEAD
  get g => null;

=======
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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
<<<<<<< HEAD
                top: 120,
=======
                top: 250,
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
                child: SizedBox(
                  width: 300,
                  child: Image.asset(
                    'lib/assets/on11.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
<<<<<<< HEAD
                top: 120,
=======
                top: 200,
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
                child: SizedBox(
                  width: 300,
                  child: Image.asset('lib/assets/on1.png', fit: BoxFit.contain),
                ),
              ),
              SingleChildScrollView(
<<<<<<< HEAD
                padding: const EdgeInsets.only(top: 98),
=======
                padding: const EdgeInsets.only(top: 112),
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
                child: Column(
                  children: [
                    // Logo
                    Container(
                      margin: const EdgeInsets.only(bottom: 38),
                      child: Image.asset(
<<<<<<< HEAD
                        'lib/assets/mybhakti1.png',
                        height: 70,
=======
                        'lib/assets/mybhakti2.png',
                        height: 40,
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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

<<<<<<< HEAD
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
=======
                    // Welcome text
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 330),
                        child: const Text(
                          "WELCOME to MyBhakti",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
                        ),
                      ),
                    ),

                    // Dots + Next arrow
<<<<<<< HEAD
                    _buildBottomNav(
                      activeDot: 0,
=======
                    buildBottomNav(
                      context: context,
                      activeIndex: 0,
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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
<<<<<<< HEAD
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
=======
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 225,
                child: SizedBox(
                  width: 300,
                  child: Image.asset(
                    'lib/assets/on22.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: SizedBox(
                  width: 300,
                  child: Image.asset('lib/assets/on2.png', fit: BoxFit.contain),
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
                      margin: const EdgeInsets.only(bottom: 60),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 330),
                        child: const Text(
                          "Explore more about this MyBhakti",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Dots + Next arrow
                    buildBottomNav(
                      context: context,
                      activeIndex: 1,
                      onNext: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Onboarding6(),
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

class Onboarding6 extends StatefulWidget {
  const Onboarding6({super.key});
  @override
  Onboarding6State createState() => Onboarding6State();
}

class Onboarding6State extends State<Onboarding6> {
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
                top: 225,
                child: SizedBox(
                  width: 250,
                  child: Image.asset(
                    'lib/assets/on33.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: SizedBox(
                  width: 300,
                  child: Image.asset('lib/assets/on3.png', fit: BoxFit.contain),
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
                    // Button Continue to Login
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(top: 355),
                      child: SizedBox(
                        width: 220,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9D9D9),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            "Continue to Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Dots + Next arrow
                    buildBottomNav(
                      context: context,
                      activeIndex: 2,
                      onNext: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Onboarding6(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
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
<<<<<<< HEAD
Widget _buildBottomNav({required int activeDot, required VoidCallback onNext}) {
=======
Widget buildBottomNav({
  required BuildContext context,
  required int activeIndex,
  required VoidCallback onNext,
}) {
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
  const Color activeColor = Color(0xFF9E9E9E);
  const Color inactiveColor = Color(0xFFD9D9D9);
  const int totalDots = 3;

  return Container(
<<<<<<< HEAD
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
=======
    margin: const EdgeInsets.only(bottom: 40, right: 40, top: 20),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // DOTS CENTER
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(totalDots, (index) {
              final bool isActive = index == activeIndex;

              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Onboarding4()),
                    );
                  }

                  if (index == 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Onboarding5()),
                    );
                  }

                  if (index == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Onboarding6()),
                    );
                  }
                },

                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  width: isActive ? 24 : 12,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? activeColor : inactiveColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
          ),
        ),

        // BUTTON RIGHT
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onNext,
            child: Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFC8102E),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
            ),
          ),
        ),
      ],
    ),
  );
}
<<<<<<< HEAD
=======

//efek MeltClipper
class MeltClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // mulai lebih atas supaya gelombang panjang
    path.lineTo(0, size.height * 0.55);

    // gelombang 1
    path.quadraticBezierTo(
      size.width * 0.10,
      size.height * 0.35,
      size.width * 0.28,
      size.height * 0.80,
    );

    // gelombang 2
    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 1.10,
      size.width * 0.58,
      size.height * 0.72,
    );

    // gelombang 3
    path.quadraticBezierTo(
      size.width * 0.72,
      size.height * 0.20,
      size.width * 0.82,
      size.height * 1.18,
    );

    // gelombang 4
    path.quadraticBezierTo(
      size.width * 0.92,
      size.height * 1.45,
      size.width,
      size.height * 0.68,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95

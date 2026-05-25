import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/login.dart';

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
      duration: const Duration(milliseconds: 2200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

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
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double fadeValue = ((_animation.value - 0.7) / 0.3).clamp(
                0.0,
                1.0,
              );

              return Column(
                children: [
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
                  Expanded(
                    flex: 1,
                    child: Container(color: const Color(0xFFB1121B)),
                  ),
                ],
              );
            },
          ),
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
      ),
    );
  }
}

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => Onboarding2State();
}

class Onboarding2State extends State<Onboarding2> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

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
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding4()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOutCubic,
          builder: (context, value, child) {
            final double top = lerpDouble(
              MediaQuery.of(context).size.height / 2 - 35,
              98,
              Curves.easeInOut.transform(value),
            )!;

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

class Onboarding4 extends StatefulWidget {
  const Onboarding4({super.key});

  @override
  State<Onboarding4> createState() => Onboarding4State();
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
                top: 250,
                child: SizedBox(
                  width: 300,
                  child: Image.asset(
                    'lib/assets/on11.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: SizedBox(
                  width: 300,
                  child: Image.asset('lib/assets/on1.png', fit: BoxFit.contain),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 112),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 38),
                      child: Image.asset(
                        'lib/assets/mybhakti2.png',
                        height: 40,
                      ),
                    ),
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
                            'Skip',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 330),
                        child: Text(
                          'WELCOME to MyBhakti',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    buildBottomNav(
                      context: context,
                      activeIndex: 0,
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

class Onboarding5 extends StatefulWidget {
  const Onboarding5({super.key});

  @override
  State<Onboarding5> createState() => Onboarding5State();
}

class Onboarding5State extends State<Onboarding5> {
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 38),
                      child: Image.asset(
                        'lib/assets/mybhakti2.png',
                        height: 40,
                      ),
                    ),
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
                            'Skip',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 330),
                        child: Text(
                          'Explore more about this MyBhakti',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
  State<Onboarding6> createState() => Onboarding6State();
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 38),
                      child: Image.asset(
                        'lib/assets/mybhakti2.png',
                        height: 40,
                      ),
                    ),
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
                            'Skip',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            'Continue to Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildBottomNav(
                      context: context,
                      activeIndex: 2,
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
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBottomNav({
  required BuildContext context,
  required int activeIndex,
  required VoidCallback onNext,
}) {
  const Color activeColor = Color(0xFF9E9E9E);
  const Color inactiveColor = Color(0xFFD9D9D9);
  const int totalDots = 3;

  return Container(
    margin: const EdgeInsets.only(bottom: 40, right: 40, top: 20),
    child: Stack(
      alignment: Alignment.center,
      children: [
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
            ),
          ),
        ),
      ],
    ),
  );
}

class MeltClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.55);

    path.quadraticBezierTo(
      size.width * 0.10,
      size.height * 0.35,
      size.width * 0.28,
      size.height * 0.80,
    );

    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 1.10,
      size.width * 0.58,
      size.height * 0.72,
    );

    path.quadraticBezierTo(
      size.width * 0.72,
      size.height * 0.20,
      size.width * 0.82,
      size.height * 1.18,
    );

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

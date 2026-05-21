import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/login.dart';
//import 'package:app_mybhakti/home.dart'



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _whitePanelAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // background putih turun dari atas
    _whitePanelAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // logo mengecil
    _logoScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.45,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // logo muncul setelah animasi mulai
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // pindah ke login
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // background merah awal
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFFB1121B),
              ),

              // panel putih turun dari atas
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: size.width,
                  height: size.height * _whitePanelAnimation.value,
                  color: const Color(0xFFF2F2F7),
                ),
              ),

              // logo tetap center
              Center(
                child: Opacity(
                  opacity: _logoOpacityAnimation.value,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Image.asset('lib/assets/mybhakti1.png', width: 180),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

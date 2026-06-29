import 'package:flutter/material.dart';
import 'package:app_mybhakti/pages/home.dart';
import 'package:app_mybhakti/services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;

  final ApiService _apiService = ApiService();

  // ================= LOGIN =================
  Future<void> _handleLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Username dan Password harus diisi",
          ),
          backgroundColor: Color(0xFFB1121B),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Bypass API untuk login dummy admin/admin
    if (username == "admin" && password == "admin") {
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeView(
            username: username,
          ),
        ),
      );
      return;
    }

    final result = await _apiService.login(
      username: username,
      password: password,
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (result['success'] == true) {
      // Login berhasil, ambil data user
      String displayName = username;

      // Coba ambil data profil dari /auth/me/
      final meResult = await _apiService.getMe();

      if (meResult['success'] == true) {
        final userData = meResult['data'];
        displayName = userData['username'] ??
            userData['first_name'] ??
            userData['email'] ??
            username;
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeView(
            username: displayName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message'] ??
                "Login gagal",
          ),
          backgroundColor: const Color(0xFFB1121B),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),

          child: Column(
            children: [
              const SizedBox(height: 60),

              Image.asset(
                'lib/assets/mybhakti1.png',
                height: 120,
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// USERNAME
                    const Text(
                      "Username",
                      style: TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: usernameController,
                      enabled: !isLoading,

                      decoration: InputDecoration(
                        hintText: "Enter Username",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        prefixIcon:
                            const Icon(Icons.person_outline),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// PASSWORD
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,
                      enabled: !isLoading,

                      onSubmitted: (_) => _handleLogin(),

                      decoration: InputDecoration(
                        hintText: "Enter Password",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        prefixIcon:
                            const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),

                          onPressed: () {
                            setState(() {
                              isPasswordHidden =
                                  !isPasswordHidden;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// LUPA PASSWORD
                    const Align(
                      alignment: Alignment.centerRight,

                      child: Text(
                        "Lupa Password?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration:
                              TextDecoration.underline,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// BUTTON LOGIN
                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed:
                            isLoading ? null : _handleLogin,

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFB1121B),

                          disabledBackgroundColor:
                              const Color(0xFFB1121B)
                                  .withOpacity(0.6),

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25),
                          ),
                        ),

                        child: isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child:
                                    CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
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
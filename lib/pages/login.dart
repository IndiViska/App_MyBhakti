import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:app_mybhakti/pages/home_page.dart';
=======
import 'package:app_mybhakti/pages/home.dart';
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xffF8F9FB),
=======
      backgroundColor: Colors.white,

>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
<<<<<<< HEAD
              const SizedBox(height: 55),
=======
              const SizedBox(height: 60),

              Image.asset('lib/assets/mybhakti1.png', height: 120),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text("Username", style: TextStyle(fontSize: 14)),

                    const SizedBox(height: 8),

                    TextField(
                      controller: usernameController,

                      decoration: InputDecoration(
                        hintText: "Enter Username",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95

              Image.asset(
                'lib/assets/mybhakti1.png',
                height: 160,
              ),

<<<<<<< HEAD
              const SizedBox(height: 45),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff111827),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Masuk untuk melanjutkan ke aplikasi',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff8C96A8),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Username',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE6EAF0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE6EAF0)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE6EAF0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE6EAF0)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa Password?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff8C96A8),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
=======
                    const Text("Password", style: TextStyle(fontSize: 14)),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,

                      decoration: InputDecoration(
                        hintText: "Enter Password",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        prefixIcon: const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),

                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                        ),
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB1121B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
<<<<<<< HEAD
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
=======

                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerRight,

                      child: Text(
                        "Lupa Password?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          String username = usernameController.text;

                          String password = passwordController.text;

                          if (username == "admin" && password == "admin") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeView(username: username),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Username atau Password salah"),
                              ),
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB1121B),

                          padding: const EdgeInsets.symmetric(vertical: 14),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),

                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
>>>>>>> 218de983ed5e04b01266bb6881744675af8d9e95
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
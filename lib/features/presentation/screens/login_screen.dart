import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../router/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    // TODO: Implement authentication logic here
    // If login success:
    context.go(AppRoutes.navbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: -10,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: SvgPicture.asset(
                  'assets/svg/login_background.svg',
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'Masuk ke akun\nAnda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Masukkan alamat email dan kata sandi Anda untuk masuk.',
                      style: TextStyle(
                        color: Color(0xB2FFFFFF),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Email Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: Color(0xFF141414),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD8CDE4),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFF3F2C53),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8C8C8C),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF141414),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Kata Sandi',
                            style: TextStyle(
                              color: Color(0xFF141414),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD8CDE4),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFF3F2C53),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Kata sandi',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8C8C8C),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF141414),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Lupa kata sandi?',
                        style: TextStyle(
                          color: Color(0xFF141414),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Login Button
                    GestureDetector(
                      onTap: _login,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3F2C53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'Atau',
                        style: TextStyle(
                          color: Color(0xFF8A8A8A),
                          fontSize: 16,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Google Login Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD8CDE4),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF3F2C53),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C000000),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Lanjutkan dengan Google',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Facebook Login Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD8CDE4),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF3F2C53),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1877F2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C000000),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'f',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Lanjutkan dengan Facebook',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun? ',
                          style: TextStyle(
                            color: Color(0xFF2E2E2E),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go(AppRoutes.register);
                          },
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              color: Color(0xFF141414),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

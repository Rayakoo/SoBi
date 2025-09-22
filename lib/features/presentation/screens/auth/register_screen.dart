import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../router/app_routes.dart';
import '../../provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController setPasswordController = TextEditingController();

  void _register() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signUp(
      emailController.text,
      namaController.text,
      telpController.text,
      passwordController.text,
    );
    if (authProvider.error == null) {
      // Operkan email ke verif screen sebagai path param
      context.go('${AppRoutes.verif}/${emailController.text}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.error ?? 'Register gagal')),
      );
    }
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
              top: -80,
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
                    const SizedBox(height: 40),
                    const Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Buat akun untuk melanjutkan!',
                      style: TextStyle(
                        color: Color(0xB2FFFFFF),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Nama
                    _RegisterField(
                      label: 'Nama',
                      controller: namaController,
                      hint: 'Nama',
                    ),
                    const SizedBox(height: 16),
                    // Email
                    _RegisterField(
                      label: 'Email',
                      controller: emailController,
                      hint: 'Email',
                    ),
                    const SizedBox(height: 16),
                    // Nomor Telepon
                    _RegisterField(
                      label: 'Nomor Telepon',
                      controller: telpController,
                      hint: 'Masukkan nomor',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    // Kata Sandi
                    _RegisterField(
                      label: 'Kata Sandi',
                      controller: passwordController,
                      hint: 'Kata sandi',
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    // Set Kata Sandi
                    _RegisterField(
                      label: 'Set Kata Sandi',
                      controller: setPasswordController,
                      hint: 'Kata sandi',
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: _register,
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
                            'Daftar',
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
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah memiliki akun? ',
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
                            context.go(AppRoutes.login);
                          },
                          child: const Text(
                            'Masuk',
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

class _RegisterField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;

  const _RegisterField({
    required this.label,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            label,
            style: const TextStyle(
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
              side: const BorderSide(width: 1, color: Color(0xFF3F2C53)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: const TextStyle(
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
    );
  }
}

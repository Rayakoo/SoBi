import 'package:flutter/material.dart';

class VerifScreen extends StatelessWidget {
  const VerifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi Akun')),
      body: const Center(
        child: Text(
          'Silakan cek email Anda untuk verifikasi akun.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

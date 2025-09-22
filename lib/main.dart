import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/presentation/router/app_router.dart';
import 'di/injection_container.dart';
import 'features/presentation/provider/auth_provider.dart';
import 'features/data/datasources/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load(); // <-- pastikan .env sudah di-load
  setupDependencyInjection();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        // ...provider lain...
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SoBi',
      routerConfig: AppRouter.router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Ini halaman utama 🚀")));
  }
}

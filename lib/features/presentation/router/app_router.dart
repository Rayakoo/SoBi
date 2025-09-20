import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sobi/features/presentation/router/app_routes.dart';
import 'package:sobi/features/presentation/screens/navbar_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/verif_screen.dart';
import '../../../splash_screen.dart';
import '../screens/homepage_screen.dart';
import '../screens/sobi_quran_screen.dart';
import '../screens/sobi_goals_screen.dart';
import '../screens/sobi_time_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/profile_view_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/about_screen.dart';
import '../screens/sobi_ai_screen.dart';
import '../screens/chat_ahli_screen.dart';
import '../screens/chat_anonim_screen.dart';
import '../screens/pendengar_curhat_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/detail_pembayaran_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (BuildContext context, GoRouterState state) async {
      // final user = Supabase.instance.client.auth.currentUser;
      // final loggingIn =
      //     state.subloc == AppRoutes.login || state.subloc == AppRoutes.register;
      // final isSplash = state.subloc == AppRoutes.splash;

      // if (isSplash) {
      //   return null;
      // }
      // if (user == null && !loggingIn) {
      //   return AppRoutes.login;
      // }
      // if (user != null && loggingIn) {
      //   // Setelah register, arahkan ke sekolah form
      //   return AppRoutes.navbar;
      // }
      // return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const AnimatedSplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.verif,
        builder: (context, state) => const VerifScreen(),
      ),
      GoRoute(
        path: AppRoutes.homepage,
        builder: (context, state) => const HomepageScreen(),
      ),
      GoRoute(
        path: AppRoutes.sobiQuran,
        builder: (context, state) => const SobiQuranScreen(),
      ),
      GoRoute(
        path: AppRoutes.sobiGoals,
        builder: (context, state) => const SobiGoalsScreen(),
      ),
      GoRoute(
        path: AppRoutes.sobiTime,
        builder: (context, state) => const SobiTimeScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.navbar,
        builder: (context, state) => const NavbarScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.view_profile,
        builder: (context, state) => const ProfileViewScreen(),
      ),
      GoRoute(
        path: AppRoutes.edit_profile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.faq,
        builder: (context, state) => const FAQScreen(),
      ),
      GoRoute(
        path: AppRoutes.about,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: AppRoutes.sobiAi,
        builder: (context, state) => const SobiAiScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatAhli,
        builder: (context, state) => const ChatAhliScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatAnonim,
        builder: (context, state) => const ChatAnonimScreen(),
      ),
      GoRoute(
        path: AppRoutes.pendengarCurhat,
        builder: (context, state) => const PendengarCurhatScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatRoom,
        builder: (context, state) {
          final role = state.params['role'] ?? 'pencerita';
          return ChatScreen(role: role);
        },
      ),
      GoRoute(
        path: AppRoutes.detailPembayaran,
        builder: (context, state) {
          final ahli = state.extra as Map<String, dynamic>?;
          return DetailPembayaranScreen(ahli: ahli);
        },
      ),

      // GoRoute(
      //   // path: AppRoutes.homepage,
      //   // builder: (context, state) => const HomePage(),
      // ),

      // GoRoute(
      //   path: AppRoutes.activity,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const ActivityScreen();
      //   },
      // ),
      //       GoRoute(
      //         path: AppRoutes.notification,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const NotificationScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.profile,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const ProfileScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.homepage,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const HomeScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.forgotPassword,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const ForgotPassScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.resetPassword,
      //         builder: (BuildContext context, GoRouterState state) {
      //           final email = state.extra as String;
      //           return ResetPasswordScreen(email: email);
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.laporekBar,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const LaporekBar();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.admin,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const AdminScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.beritaAdmin,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const BeritaAdminScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.laporanAdmin,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const LaporanAdminScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.detailLaporanAdmin,
      //         builder: (BuildContext context, GoRouterState state) {
      //           final laporan = state.extra as Laporan;
      //           return DetailLaporanAdminScreen(laporan: laporan);
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.detailStatus,
      //         builder: (BuildContext context, GoRouterState state) {
      //           final laporan = state.extra as Laporan;
      //           return DetailStatusScreen(laporan: laporan);
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.panggilanOption,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const PanggilanOptionScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.pantauMalang,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const PantauMalangScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.ketentuanKebijakan,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const KetentuanKebijakanScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.gantiPassword,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const GantiPasswordScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: '/deskripsiStatus',
      //         builder: (context, state) {
      //           final extra = state.extra as Map<String, dynamic>;
      //           return DeskripsiStatusScreen(
      //             imageUrl: extra['imageUrl'],
      //             date: extra['date'],
      //             description: extra['description'],
      //             status: extra['status'],
      //           );
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.popUpUlasan,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const PopUpUlasanScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.popUpAlamat,
      //         builder: (context, state) {
      //           return const PopUpAlamatScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.popUpPanggilan,
      //         builder: (BuildContext context, GoRouterState state) {
      //           final args = state.extra as Map<String, dynamic>;
      //           return PopUpPanggilan(
      //             imagePath: args['imagePath'],
      //             title: args['title'],
      //             phoneNumber: args['phoneNumber'],
      //           );
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.adminPantauMalang,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const AdminPantauMalangScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.detailBerita,
      //         builder: (context, state) {
      //           final berita = state.extra as Berita;
      //           return DetailBeritaScreen(berita: berita);
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.editProfile,
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const EditProfileScreen();
      //         },
      //       ),
    ],
    //     errorBuilder: (context, state) {
    //       print('Page not found: ${state.subloc}');
    //       return Scaffold(body: Center(child: Text('Page not found')));
    // },
  );
}

      //         path: AppRoutes.popUpPanggilan,
      //         name: 'popUpPanggilan',
      //         builder: (BuildContext context, GoRouterState state) {
      //           final args = state.extra as Map<String, dynamic>;
      //           return PopUpPanggilan(
      //             imagePath: args['imagePath'],
      //             title: args['title'],
      //             phoneNumber: args['phoneNumber'],
      //           );
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.adminPantauMalang,
      //         name: 'adminPantauMalang',
      //         builder: (BuildContext context, GoRouterState state) {
      //           print('Navigating to AdminPantauMalangScreen');
      //           return const AdminPantauMalangScreen();
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.detailBerita,
      //         builder: (context, state) {
      //           final berita = state.extra as Berita;
      //           return DetailBeritaScreen(berita: berita);
      //         },
      //       ),
      //       GoRoute(
      //         path: AppRoutes.editProfile,
      //         name: 'editProfile',
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const EditProfileScreen();
      //         },
      //       ),

    //     errorBuilder: (context, state) {
    //       print('Page not found: ${state.subloc}');
    //       return Scaffold(body: Center(child: Text('Page not found')));
    // },
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sobi/features/presentation/router/app_routes.dart';
import '../style/colors.dart';
import '../style/typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final profilePicSize = 100.0;

    final List<_SettingsMenuItem> menuItems = [
      _SettingsMenuItem(
        icon: 'assets/icons/profile.svg',
        title: 'Profil',
        onTap: () => context.push(AppRoutes.view_profile),
      ),
      _SettingsMenuItem(
        icon: 'assets/icons/edit.svg',
        title: 'Edit Profil',
        onTap: () {
          context.push(AppRoutes.edit_profile);
        },
      ),
      _SettingsMenuItem(
        icon: 'assets/icons/faq.svg',
        title: 'FAQ',
        onTap: () => context.push(AppRoutes.faq),
      ),
      _SettingsMenuItem(
        icon: 'assets/icons/info.svg',
        title: 'Tentang Aplikasi',
        onTap: () => context.push(AppRoutes.about),
      ),
      _SettingsMenuItem(
        icon: 'assets/icons/logout.svg',
        title: 'Keluar',
        onTap: () {},
        isLogout: true,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ScrollView isi menu
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 350),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        ...menuItems.map(
                          (item) => Column(
                            children: [
                              _SettingsMenuCard(item: item),
                              if (!item.isLogout)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Divider(
                                    color: AppColors.default_30,
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ),
                              if (item.isLogout) const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SVG profil background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/svg/profil_background.svg',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          // Foto profil + nama + tombol edit
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: profilePicSize / 2,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          'assets/svg/avatar.svg',
                          width: profilePicSize * 0.7,
                          height: profilePicSize * 0.7,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => context.push(AppRoutes.edit_profile),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary_30,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Fatimah Azzahra',
                  style: AppTextStyles.heading_5_bold.copyWith(
                    color: AppColors.default_10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Tombol back di kiri atas
          Positioned(
            top: 38,
            left: 28,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary_10.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsMenuItem {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  const _SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });
}

class _SettingsMenuCard extends StatelessWidget {
  final _SettingsMenuItem item;
  const _SettingsMenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary_90,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  item.icon,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyles.body_3_bold.copyWith(
                  color: AppColors.primary_90,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black, size: 28),
          ],
        ),
      ),
    );
  }
}

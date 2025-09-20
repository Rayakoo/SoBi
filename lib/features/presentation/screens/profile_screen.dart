import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sobi/features/presentation/screens/navbar_screen.dart';
import '../style/colors.dart';
import '../style/typography.dart';
import 'package:go_router/go_router.dart';
import '../router/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _goToNavbar(int index) {
    NavbarController.currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bentoHeight = 160.0;
    final profilePicSize = 100.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. ScrollView (isi utama)
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 300),
                  // Capaian Ibadah
                  Text(
                    'Capaian Ibadah',
                    style: AppTextStyles.heading_5_bold.copyWith(
                      color: AppColors.primary_90,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Bento Layout
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        // Progress Harian (Pie Chart)
                        Container(
                          width: screenWidth * 0.52,
                          height: bentoHeight,
                          decoration: BoxDecoration(
                            color: AppColors.primary_10,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Pie Chart Dummy
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value: 0.65,
                                      strokeWidth: 8,
                                      backgroundColor: AppColors.primary_30,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primary_90,
                                      ),
                                    ),
                                    Text(
                                      'Yuk, lengkapi \n ibadahmu!',
                                      style: AppTextStyles.body_4_bold.copyWith(
                                        color: AppColors.primary_90,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),

                              Text(
                                'Progres Harian',
                                style: AppTextStyles.body_4_bold.copyWith(
                                  color: AppColors.primary_90,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Box kanan (surat terakhir & titik belajar)
                        Expanded(
                          child: Column(
                            children: [
                              // Surat terakhir
                              GestureDetector(
                                onTap: () => _goToNavbar(1),
                                child: Container(
                                  height: bentoHeight * 0.48,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary_10,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(width: 12),
                                      Icon(
                                        Icons.menu_book,
                                        color: AppColors.primary_90,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Al-Maidah : 48',
                                              style: AppTextStyles.body_4_bold
                                                  .copyWith(
                                                    color: AppColors.primary_90,
                                                  ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary_30,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'Lanjutkan membaca',
                                                style: AppTextStyles
                                                    .body_5_regular
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Titik Belajar
                              GestureDetector(
                                onTap: () => _goToNavbar(3),
                                child: Container(
                                  height: bentoHeight * 0.48,
                                  width: screenWidth * 0.48,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary_10,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 5),
                                            Text(
                                              'Titik Belajar',
                                              style: AppTextStyles.body_4_bold
                                                  .copyWith(
                                                    color: AppColors.primary_90,
                                                  ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.primary_30,
                                                  size: 18,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.primary_30,
                                                  size: 18,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.primary_30,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  '64 materi',
                                                  style: AppTextStyles
                                                      .body_5_regular
                                                      .copyWith(
                                                        color:
                                                            AppColors
                                                                .primary_90,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Riwayat Belajar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Riwayat Belajar',
                        style: AppTextStyles.heading_6_bold.copyWith(
                          color: AppColors.primary_90,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Card List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        _RiwayatCard(
                          image: 'assets/logo/Logo.png',
                          title: 'Cukup Aku, Kamu, dan Halal !!!',
                          desc:
                              'Sahabat Cahaya, mendekati zina saja kita sudah dilarang, apalagi melakukannya. Dalam hal ini berpacaran bisa menjadi salah satu pintu untuk...',
                          date: '12 Mar 2025',
                        ),
                        const SizedBox(height: 12),
                        _RiwayatCard(
                          image: 'assets/logo/Logo.png',
                          title: 'Hilang Untuk Healing',
                          desc:
                              'Dalam Islam, ketenangan sejati tak datang dari pelarian, tapi dari taqarrub-mendekat dengan Allah.',
                          date: '2 Mar 2025',
                        ),
                        const SizedBox(height: 12),
                        _RiwayatCard(
                          image: 'assets/logo/Logo.png',
                          title: 'Kamu Sibuk, Tapi Gak Jelas Arahnya',
                          desc:
                              'Waktu sibuk tapi gak jelas arahnya - apakah itu yang juga kamu rasakan? Dalam Islam, kesibukan tanpa tujuan yang jelas adalah sesuatu yang sia-sia.',
                          date: '2 Mar 2025',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 140),
                ],
              ),
            ),
          ),
          // 2. SVG profil background
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
          // 3. Foto profil + tombol edit
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
                          onTap: () {
                            context.push(AppRoutes.edit_profile);
                          },
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
          // 4. Tombol setting di pojok kanan atas
          Positioned(
            top: 38,
            right: 28,
            child: GestureDetector(
              onTap: () {
                context.push(AppRoutes.settings);
              },
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
                child: Icon(
                  Icons.settings,
                  color: AppColors.primary_90,
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

class _RiwayatCard extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final String date;

  const _RiwayatCard({
    required this.image,
    required this.title,
    required this.desc,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary_30, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary_10.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.body_3_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        date,
                        style: AppTextStyles.body_5_regular.copyWith(
                          color: AppColors.default_90,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: AppTextStyles.body_5_regular.copyWith(
                      color: AppColors.primary_90,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

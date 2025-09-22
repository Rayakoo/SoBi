import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../style/colors.dart';
import '../../style/typography.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController namaController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController telpController;
  String gender = 'Akhwat';

  int selectedAvatar = 0;

  final List<IconData> avatarIcons = [
    Icons.person,
    Icons.person_outline,
    Icons.account_circle,
    Icons.face,
    Icons.tag_faces,
  ];

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    namaController = TextEditingController(text: user?.username ?? '');
    usernameController = TextEditingController(text: user?.username ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    telpController = TextEditingController(
      text: '',
    ); // update jika ada field telp di user
    // gender = user?.gender ?? 'Akhwat'; // jika ada field gender
  }

  @override
  void dispose() {
    namaController.dispose();
    usernameController.dispose();
    emailController.dispose();
    telpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const profilePicSize = 100.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ScrollView isi form edit
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 320),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _EditProfileField(
                          label: 'Nama',
                          controller: namaController,
                        ),
                        const SizedBox(height: 16),
                        _EditProfileField(
                          label: 'Nama Pengguna',
                          controller: usernameController,
                        ),
                        const SizedBox(height: 16),
                        _GenderEditField(
                          gender: gender,
                          onChanged: (val) => setState(() => gender = val),
                        ),
                        const SizedBox(height: 16),
                        _EditProfileField(
                          label: 'Email',
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        _EditProfileField(
                          label: 'Nomor Telepon',
                          controller: telpController,
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primary_90,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Simpan',
                                style: AppTextStyles.body_3_bold.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
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
          // Foto profil + pilihan avatar
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
                        child: Icon(
                          avatarIcons[selectedAvatar],
                          size: profilePicSize * 0.7,
                          color: AppColors.primary_90,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Pilihan avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(avatarIcons.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                selectedAvatar == index
                                    ? AppColors.primary_90
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            avatarIcons[index],
                            size: 28,
                            color: AppColors.primary_90,
                          ),
                        ),
                      ),
                    );
                  }),
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

class _EditProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _EditProfileField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body_3_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.default_10,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: controller,
            style: AppTextStyles.body_3_regular.copyWith(
              color: AppColors.primary_90,
            ),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}

class _GenderEditField extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onChanged;
  const _GenderEditField({required this.gender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged('Akhwat'),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color:
                    gender == 'Akhwat'
                        ? AppColors.primary_10
                        : Colors.transparent,
                border: Border.all(
                  color:
                      gender == 'Akhwat'
                          ? AppColors.primary_90
                          : AppColors.default_30,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Akhwat👧',
                  style: AppTextStyles.body_3_bold.copyWith(
                    color: AppColors.primary_90,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged('Ikhwan'),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color:
                    gender == 'Ikhwan'
                        ? AppColors.primary_10
                        : Colors.transparent,
                border: Border.all(
                  color:
                      gender == 'Ikhwan'
                          ? AppColors.primary_90
                          : AppColors.default_30,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Ikhwan👦',
                  style: AppTextStyles.body_3_bold.copyWith(
                    color: AppColors.primary_90,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

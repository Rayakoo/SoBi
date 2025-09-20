import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../style/colors.dart';
import '../style/typography.dart';

class ChatAhliScreen extends StatefulWidget {
  const ChatAhliScreen({super.key});

  @override
  State<ChatAhliScreen> createState() => _ChatAhliScreenState();
}

class _ChatAhliScreenState extends State<ChatAhliScreen> {
  String searchText = '';
  String selectedCategory = 'all';
  bool showFilter = false;

  final List<Map<String, dynamic>> ahliList = [
    {
      'name': 'Ustz. Aaliyah',
      'profesi': 'Penceramah Agama',
      'jam': '10:00 - 10:30',
      'harga': 'Rp 25.000',
      'rating': 4.8,
      'kategori': 'agama',
      'image': 'assets/logo/Logo.png',
    },
    {
      'name': 'Ustz. Aaliyah',
      'profesi': 'Penceramah Agama',
      'jam': '13:00 - 13:30',
      'harga': 'Rp 25.000',
      'rating': 4.8,
      'kategori': 'agama',
      'image': 'assets/logo/Logo.png',
    },
    {
      'name': 'Qonita Lc.',
      'profesi': 'Psikolog',
      'jam': '13:00 - 13:30',
      'harga': 'Rp 35.000',
      'rating': 4.9,
      'kategori': 'psikolog',
      'image': 'assets/logo/Logo.png',
    },
    {
      'name': 'Ust. Ramdan',
      'profesi': 'Penceramah Agama',
      'jam': '13:00 - 13:30',
      'harga': 'Rp 30.000',
      'rating': 4.8,
      'kategori': 'agama',
      'image': 'assets/logo/Logo.png',
    },
    {
      'name': 'Annisa S.Psi, M.Psi',
      'profesi': 'Psikolog',
      'jam': '14:00 - 14:30',
      'harga': 'Rp 25.000',
      'rating': 4.7,
      'kategori': 'psikolog',
      'image': 'assets/logo/Logo.png',
    },
    {
      'name': 'Ust. Ramdan',
      'profesi': 'Penceramah Agama',
      'jam': '14:00 - 14:30',
      'harga': 'Rp 30.000',
      'rating': 4.8,
      'kategori': 'agama',
      'image': 'assets/logo/Logo.png',
    },
  ];

  List<Map<String, dynamic>> get filteredList {
    var list =
        ahliList.where((item) {
          final matchSearch =
              item['name'].toLowerCase().contains(searchText.toLowerCase()) ||
              item['profesi'].toLowerCase().contains(searchText.toLowerCase());
          final matchCategory =
              selectedCategory == 'all' ||
              (selectedCategory == 'agama' && item['kategori'] == 'agama') ||
              (selectedCategory == 'psikolog' &&
                  item['kategori'] == 'psikolog');
          return matchSearch && matchCategory;
        }).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chat Ahli',
          style: AppTextStyles.heading_5_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) => setState(() => searchText = val),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.default_30,
                      hintText: 'search text',
                      hintStyle: AppTextStyles.body_3_regular.copyWith(
                        color: AppColors.primary_90,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primary_90,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary_90,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () async {
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: AppColors.default_30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.play_arrow,
                                      color: AppColors.primary_90,
                                    ),
                                    title: Text(
                                      'Ahli Agama',
                                      style: AppTextStyles.body_3_bold.copyWith(
                                        color: AppColors.primary_90,
                                      ),
                                    ),
                                    onTap:
                                        () =>
                                            Navigator.of(context).pop('agama'),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.play_arrow,
                                      color: AppColors.primary_90,
                                    ),
                                    title: Text(
                                      'Ahli Psikologi',
                                      style: AppTextStyles.body_3_bold.copyWith(
                                        color: AppColors.primary_90,
                                      ),
                                    ),
                                    onTap:
                                        () => Navigator.of(
                                          context,
                                        ).pop('psikolog'),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.close,
                                      color: AppColors.primary_90,
                                    ),
                                    title: Text(
                                      'Tampilkan Semua',
                                      style: AppTextStyles.body_3_bold.copyWith(
                                        color: AppColors.primary_90,
                                      ),
                                    ),
                                    onTap:
                                        () => Navigator.of(context).pop('all'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      if (result != null) {
                        setState(() {
                          selectedCategory = result;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: filteredList.length,
              itemBuilder: (context, idx) {
                final ahli = filteredList[idx];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    height: 100, // card lebih tinggi
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Gambar/logo full tinggi card + harga overlay
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                              ),
                              child: Image.asset(
                                ahli['image'],
                                width: 90,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary_30.withOpacity(0.85),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(18),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  ahli['harga'],
                                  style: AppTextStyles.body_4_bold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ahli['name'],
                                  style: AppTextStyles.heading_6_bold.copyWith(
                                    color: AppColors.primary_90,
                                  ),
                                ),
                                Text(
                                  ahli['profesi'],
                                  style: AppTextStyles.body_4_regular.copyWith(
                                    color: AppColors.primary_90,
                                  ),
                                ),
                                Text(
                                  ahli['jam'],
                                  style: AppTextStyles.body_5_regular.copyWith(
                                    color: AppColors.primary_90,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                right: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    ahli['rating'].toString(),
                                    style: AppTextStyles.body_4_bold.copyWith(
                                      color: AppColors.primary_90,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                                right: 12,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigasi ke detail pembayaran, kirim data ahli
                                  context.push(
                                    '/detail-pembayaran',
                                    extra: ahli,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary_90,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 8,
                                  ),
                                  minimumSize: const Size(100, 32),
                                ),
                                child: Text(
                                  'Chat',
                                  style: AppTextStyles.body_4_bold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

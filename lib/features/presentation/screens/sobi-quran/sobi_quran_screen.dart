import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobi/features/presentation/provider/sobi-quran_provider.dart';
import 'package:go_router/go_router.dart';
import 'detail-sobi-quran_screens.dart';
import '../../style/colors.dart';
import '../../style/typography.dart';

class SobiQuranScreen extends StatefulWidget {
  const SobiQuranScreen({super.key});

  @override
  State<SobiQuranScreen> createState() => _SobiQuranScreenState();
}

class _SobiQuranScreenState extends State<SobiQuranScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: tabIndex,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
    });
    // Fetch surat dari provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SobiQuranProvider>(context, listen: false).fetchSurat();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SobiQuranProvider>(context);
    final suratList = provider.suratList;
    final isLoading = provider.isLoading;

    // Kelompokkan surat per juz (List<int>)
    final Map<int, List<dynamic>> juzMap = {};
    for (var surat in suratList) {
      for (var juz in surat.juz) {
        juzMap.putIfAbsent(juz, () => []);
        juzMap[juz]!.add(surat);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              'Sahabat Quran',
              style: AppTextStyles.heading_5_bold.copyWith(
                color: AppColors.primary_90,
              ),
            ),
            const SizedBox(height: 12),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.default_10,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search text',
                    hintStyle: AppTextStyles.body_3_regular.copyWith(
                      color: AppColors.default_70,
                    ),
                    prefixIcon: Icon(Icons.search, color: AppColors.default_70),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(0);
                      },
                      child: Column(
                        children: [
                          Text(
                            'Juz',
                            style: AppTextStyles.body_3_bold.copyWith(
                              color:
                                  tabIndex == 0
                                      ? AppColors.primary_90
                                      : AppColors.default_70,
                            ),
                          ),
                          Container(
                            height: 2,
                            margin: const EdgeInsets.only(top: 6),
                            color:
                                tabIndex == 0
                                    ? AppColors.primary_90
                                    : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(1);
                      },
                      child: Column(
                        children: [
                          Text(
                            'Surah',
                            style: AppTextStyles.body_3_bold.copyWith(
                              color:
                                  tabIndex == 1
                                      ? AppColors.primary_90
                                      : AppColors.default_70,
                            ),
                          ),
                          Container(
                            height: 2,
                            margin: const EdgeInsets.only(top: 6),
                            color:
                                tabIndex == 1
                                    ? AppColors.primary_90
                                    : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Tab content
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // Juz Tab
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            itemCount: juzMap.keys.length,
                            itemBuilder: (context, i) {
                              final juz = juzMap.keys.toList()..sort();
                              final currentJuz = juz[i];
                              final surahs = juzMap[currentJuz]!;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary_10.withOpacity(
                                        0.18,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Juz Title
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary_90,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Juz $currentJuz',
                                          style: AppTextStyles.heading_6_bold
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    // Surah List in Juz
                                    ...List.generate(surahs.length, (j) {
                                      final surah = surahs[j];
                                      return GestureDetector(
                                        onTap: () {
                                          // GoRouter push ke detail surat
                                          context.push(
                                            '/sobi-quran-detail/${surah.nomor}',
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.primary_10
                                                    .withOpacity(0.10),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Number
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 38,
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            AppColors
                                                                .primary_30,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    surah.nomor.toString(),
                                                    style: AppTextStyles
                                                        .body_3_bold
                                                        .copyWith(
                                                          color:
                                                              AppColors
                                                                  .primary_90,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 14),
                                              // Name & desc
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          surah.namaLatin,
                                                          style: AppTextStyles
                                                              .body_3_bold
                                                              .copyWith(
                                                                color:
                                                                    AppColors
                                                                        .primary_90,
                                                              ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          '(${surah.arti})',
                                                          style: AppTextStyles
                                                              .body_5_regular
                                                              .copyWith(
                                                                color:
                                                                    AppColors
                                                                        .default_90,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color:
                                                                AppColors
                                                                    .primary_10,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                surah.tempatTurun ==
                                                                        'Mekah'
                                                                    ? Icons
                                                                        .location_on_outlined
                                                                    : Icons
                                                                        .location_city_outlined,
                                                                size: 14,
                                                                color:
                                                                    AppColors
                                                                        .primary_90,
                                                              ),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                surah
                                                                    .tempatTurun,
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
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color:
                                                                AppColors
                                                                    .primary_10,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            children: const [
                                                              Icon(
                                                                Icons.menu_book,
                                                                size: 14,
                                                                color:
                                                                    AppColors
                                                                        .primary_90,
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          '${surah.jumlahAyat} Ayat',
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
                                              // Arabic
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                ),
                                                child: Text(
                                                  surah.nama,
                                                  style: AppTextStyles
                                                      .heading_6_bold
                                                      .copyWith(
                                                        color:
                                                            AppColors
                                                                .primary_90,
                                                        fontFamily:
                                                            'ScheherazadeNew',
                                                        fontSize: 22,
                                                      ),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                          // Surah Tab
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            itemCount: suratList.length,
                            itemBuilder: (context, i) {
                              final surah = suratList[i];
                              return GestureDetector(
                                onTap: () {
                                  // GoRouter push ke detail surat
                                  context.push(
                                    '/sobi-quran-detail/${surah.nomor}',
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 18),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary_10.withOpacity(
                                          0.18,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        // Number
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 38,
                                              height: 38,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColors.primary_30,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              surah.nomor.toString(),
                                              style: AppTextStyles.body_3_bold
                                                  .copyWith(
                                                    color: AppColors.primary_90,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 14),
                                        // Name & desc
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    surah.namaLatin,
                                                    style: AppTextStyles
                                                        .body_3_bold
                                                        .copyWith(
                                                          color:
                                                              AppColors
                                                                  .primary_90,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '(${surah.arti})',
                                                    style: AppTextStyles
                                                        .body_5_regular
                                                        .copyWith(
                                                          color:
                                                              AppColors
                                                                  .default_90,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.primary_10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          surah.tempatTurun ==
                                                                  'Mekah'
                                                              ? Icons
                                                                  .location_on_outlined
                                                              : Icons
                                                                  .location_city_outlined,
                                                          size: 14,
                                                          color:
                                                              AppColors
                                                                  .primary_90,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          surah.tempatTurun,
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
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.primary_10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.menu_book,
                                                          size: 14,
                                                          color:
                                                              AppColors
                                                                  .primary_90,
                                                        ),
                                                        SizedBox(width: 2),
                                                        Text(
                                                          '${surah.jumlahAyat} Ayat',
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
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Arabic
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Text(
                                            surah.nama,
                                            style: AppTextStyles.heading_6_bold
                                                .copyWith(
                                                  color: AppColors.primary_90,
                                                  fontFamily: 'ScheherazadeNew',
                                                  fontSize: 22,
                                                ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

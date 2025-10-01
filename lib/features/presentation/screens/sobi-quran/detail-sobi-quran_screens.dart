import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobi/features/presentation/provider/sobi-quran_provider.dart';
import '../../style/colors.dart';
import '../../style/typography.dart';

class DetailSobiQuranScreen extends StatefulWidget {
  final int suratId;
  const DetailSobiQuranScreen({required this.suratId, Key? key})
    : super(key: key);

  @override
  State<DetailSobiQuranScreen> createState() => _DetailSobiQuranScreenState();
}

class _DetailSobiQuranScreenState extends State<DetailSobiQuranScreen> {
  int pageIndex = 0;

  List<List<dynamic>> _splitPerPage(List<dynamic> list, int perPage) {
    List<List<dynamic>> pages = [];
    for (var i = 0; i < list.length; i += perPage) {
      pages.add(
        list.sublist(
          i,
          (i + perPage > list.length) ? list.length : i + perPage,
        ),
      );
    }
    return pages;
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SobiQuranProvider>(context, listen: false);
    provider.fetchSuratDetail(widget.suratId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SobiQuranProvider>(context);
    final detail = provider.suratDetail;

    // Split ayat per halaman (5 per halaman)
    final ayatPages = detail == null ? [] : _splitPerPage(detail.ayat, 5);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                detail?.nama ?? '',
                style: AppTextStyles.heading_4_bold.copyWith(
                  color: AppColors.primary_90,
                  fontFamily: 'ScheherazadeNew',
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '${detail?.namaLatin ?? ''} (${detail?.arti ?? ''})',
                style: AppTextStyles.body_3_regular.copyWith(
                  color: AppColors.primary_90,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      body:
          detail == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  const SizedBox(height: 12),
                  // Ayat arab bersambung (per halaman, desain box per ayat) dalam scroll view
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var ayat
                                in ayatPages.isNotEmpty
                                    ? ayatPages[pageIndex]
                                    : [])
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary_30,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary_10.withOpacity(
                                        0.08,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  ayat.teksArab,
                                  style: AppTextStyles.heading_6_bold.copyWith(
                                    color: AppColors.primary_90,
                                    fontFamily: 'ScheherazadeNew',
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Navigasi halaman custom (seperti gambar, tanpa info halaman)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol kiri = prev (halaman sebelumnya)
                        ElevatedButton(
                          onPressed:
                              pageIndex > 0
                                  ? () => setState(() => pageIndex--)
                                  : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: AppColors.primary_30,
                            padding: const EdgeInsets.all(16),
                            elevation: 0,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Tombol kanan = next (halaman selanjutnya)
                        ElevatedButton(
                          onPressed:
                              pageIndex < ayatPages.length - 1
                                  ? () => setState(() => pageIndex++)
                                  : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: AppColors.primary_30,
                            padding: const EdgeInsets.all(16),
                            elevation: 0,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
    
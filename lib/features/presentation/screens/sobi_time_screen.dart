import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../style/typography.dart';

class SobiTimeScreen extends StatelessWidget {
  const SobiTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edukasi',
          style: AppTextStyles.heading_5_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.primary_10,
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
            // Grid video & photo
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.8,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  // Dummy: even index = video, odd index = photo
                  final isVideo = index % 2 == 0;
                  return GestureDetector(
                    onTap: () {
                      // TODO: handle click
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.default_30,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          // Dummy image/video area
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.default_30,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          if (isVideo)
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_fill,
                                color: AppColors.primary_50,
                                size: 48,
                              ),
                            ),
                          // Title & subtitle
                          Positioned(
                            left: 12,
                            right: 12,
                            bottom: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isVideo ? 'Judul Video' : 'Judul Foto',
                                  style: AppTextStyles.body_3_bold.copyWith(
                                    color: AppColors.primary_90,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isVideo
                                      ? 'Deskripsi Video'
                                      : 'Deskripsi Foto',
                                  style: AppTextStyles.body_5_regular.copyWith(
                                    color: AppColors.default_90,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

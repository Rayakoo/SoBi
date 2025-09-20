import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../style/colors.dart';
import '../style/typography.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int currentQuestion = 0;
  int totalPoint = 0;
  int selectedEmotion = -1; // -1 means no selection
  TextEditingController journalController = TextEditingController();

  final List<String> emotionQuestions = [
    'Bagaimana perasaanmu hari ini?',
    'Apakah kamu sempat sholat berjamaah?',
    'Sudah membaca Al-Quran hari ini?',
    'Apakah kamu membantu orang lain hari ini?',
    'Sudah berdoa sebelum beraktivitas?',
    'Apakah kamu bersyukur hari ini?',
    'Sudah berbuat baik kepada teman?',
    'Sudah menjaga kebersihan lingkungan?',
    'Sudah belajar hal baru hari ini?',
    'Sudah meminta maaf jika berbuat salah?',
    'Sudah memaafkan orang lain?',
    'Sudah menjaga adab berbicara?',
    'Sudah menjaga waktu sholat?',
    'Sudah berterima kasih kepada orang tua?',
    'Sudah berusaha sabar hari ini?',
  ];

  // 5 emoticon SVG asset paths
  final List<String> emoticonSvgAssets = [
    'assets/svg/emoticon_1.svg', // point 1
    'assets/svg/emoticon_2.svg', // point 2
    'assets/svg/emoticon_3.svg', // point 3
    'assets/svg/emoticon_4.svg', // point 4
    'assets/svg/emoticon_5.svg', // point 5
  ];

  // Pohon SVG asset paths, index = totalPoint
  final List<String> treeSvgAssets = [
    'assets/homepage/pohon.png', // 0 point
    'assets/homepage/bunga/bunga (1).png', // 2 point
    'assets/homepage/bunga/bunga (2).png', // 3 point
    'assets/homepage/bunga/bunga (3).png', // 4 point
    'assets/homepage/bunga/bunga (4).png', // 5 point
    'assets/homepage/bunga/bunga (5).png', // 6 point
    'assets/homepage/bunga/bunga (6).png', // 7 point
    'assets/homepage/bunga/bunga (7).png', // 8 point
    'assets/homepage/bunga/bunga (8).png', // 9 point
    'assets/homepage/bunga/bunga (9).png', // 10 point
    'assets/homepage/bunga/bunga (10).png', // 11 point
    'assets/homepage/bunga/bunga (11).png', // 12 point
    'assets/homepage/bunga/bunga (12).png', // 13 point
    'assets/homepage/bunga/bunga (13).png', // 14 point
    'assets/homepage/bunga/bunga (14).png', // 15 point
    'assets/homepage/bunga/bunga (15).png', // 16 point
    'assets/homepage/bunga/bunga (16).png', // 17 point
    'assets/homepage/bunga/bunga (17).png', // 18 point
    'assets/homepage/bunga/bunga (18).png', // 19 point
    'assets/homepage/bunga/bunga (19).png', // 20 point
    'assets/homepage/bunga/bunga (20).png', // 21 point
    'assets/homepage/bunga/bunga (21).png', // 22 point
    'assets/homepage/bunga/bunga (22).png', // 23 point
    'assets/homepage/bunga/bunga (23).png', // 24 point
    'assets/homepage/bunga/bunga (24).png', // 25 point
    'assets/homepage/bunga/bunga (25).png', // 26 point
    'assets/homepage/bunga/bunga (26).png', // 27 point
    'assets/homepage/bunga/bunga (27).png', // 28 point
    'assets/homepage/bunga/bunga (28).png', // 29 point
    'assets/homepage/bunga/bunga (29).png', // 30 point
    'assets/homepage/bunga/bunga (30).png', // 31 point
    'assets/homepage/bunga/bunga (31).png', // 32 point
    'assets/homepage/bunga/bunga (32).png', // 33 point
    'assets/homepage/bunga/bunga (33).png', // 34 point
    'assets/homepage/bunga/bunga (34).png', // 35 point
    'assets/homepage/bunga/bunga (35).png', // 36 point
    'assets/homepage/bunga/bunga (36).png', // 37 point
    'assets/homepage/bunga/bunga (37).png', // 38 point
    'assets/homepage/bunga/bunga (38).png', // 39 point
    'assets/homepage/bunga/bunga (39).png', // 40 point
    'assets/homepage/bunga/bunga (40).png', // 41 point
    'assets/homepage/bunga/bunga (41).png', // 42 point
    'assets/homepage/bunga/bunga (42).png', // 43 point
    'assets/homepage/bunga/bunga (43).png', // 44 point
    'assets/homepage/bunga/bunga (44).png', // 45 point
    'assets/homepage/bunga/bunga (45).png', // 46 point
    'assets/homepage/bunga/bunga (46).png', // 47 point
    'assets/homepage/bunga/bunga (47).png', // 48 point
  ];

  bool isFabMenuOpen = false;

  void _onEmotionSelected(int index) {
    // index: 0..4, point: index+1
    if (selectedEmotion == -1 && currentQuestion < emotionQuestions.length) {
      setState(() {
        totalPoint += (index + 1);
        selectedEmotion = index;
        if (currentQuestion < emotionQuestions.length - 1) {
          currentQuestion++;
          selectedEmotion = -1;
        }
      });
    }
  }

  void _toggleFabMenu() {
    setState(() {
      isFabMenuOpen = !isFabMenuOpen;
    });
  }

  void _goToSobiAi() {
    context.push('/sobi-ai');
    setState(() {
      isFabMenuOpen = false;
    });
  }

  void _goToChatAhli() {
    context.push('/chat-ahli');
    setState(() {
      isFabMenuOpen = false;
    });
  }

  void _goToChatAnonim() {
    context.push('/chat-anonim');
    setState(() {
      isFabMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(screenWidth),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Slider Section (dummy)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                      height: 122,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.primary_10,
                      ),
                      child: Center(
                        child: Text(
                          'Slider Section',
                          style: AppTextStyles.body_2_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Judul + pertanyaan
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanam Amal Hari Ini',
                          style: AppTextStyles.heading_4_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                        Text(
                          emotionQuestions[currentQuestion],
                          style: AppTextStyles.body_3_medium.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Emotion Selector (5 emoticon)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(emoticonSvgAssets.length, (
                            index,
                          ) {
                            final isAnswered =
                                selectedEmotion != -1 ||
                                currentQuestion ==
                                        emotionQuestions.length - 1 &&
                                    selectedEmotion != -1;
                            return GestureDetector(
                              onTap:
                                  isAnswered
                                      ? null
                                      : () => _onEmotionSelected(index),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      selectedEmotion == index
                                          ? AppColors.primary_30
                                          : AppColors.default_10,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        selectedEmotion == index
                                            ? AppColors.primary_90
                                            : AppColors.default_30,
                                    width: 2,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  emoticonSvgAssets[index],
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),

                        // Pohon utama (stack gambar sesuai point, dengan fade in)
                        Center(
                          child: Container(
                            width: screenWidth * 0.85,
                            height: screenWidth * 0.65,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: AppColors.primary_30,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.default_30.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (totalPoint == 0)
                                  _AnimatedFlower(
                                    asset: treeSvgAssets[0],
                                    width: screenWidth * 0.7,
                                    height: screenWidth * 0.6,
                                    delayMs: 0,
                                  ),
                                if (totalPoint > 0)
                                  ...List.generate(
                                    totalPoint.clamp(
                                          0,
                                          treeSvgAssets.length - 1,
                                        ) +
                                        1,
                                    (i) => _AnimatedFlower(
                                      asset: treeSvgAssets[i],
                                      width: screenWidth * 0.7,
                                      height: screenWidth * 0.6,
                                      delayMs: i * 200, // bunga mekar berurutan
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Jurnal Section
                        Text(
                          'Jurnal Hari Ini',
                          style: AppTextStyles.heading_6_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.default_10,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary_30),
                          ),
                          child: TextField(
                            controller: journalController,
                            maxLines: 5,
                            style: AppTextStyles.body_3_regular.copyWith(
                              color: AppColors.primary_90,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Type here...',
                              hintStyle: AppTextStyles.body_3_regular.copyWith(
                                color: AppColors.default_90,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                  // ...existing code...
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary_50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          // Avatar + Greeting
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 28, right: 28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  child: SvgPicture.asset(
                    'assets/svg/avatar.svg',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(right: 14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Assalammualaikum,',
                        style: AppTextStyles.body_5_regular.copyWith(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Fatimah Azzahra',
                        style: AppTextStyles.heading_6_bold.copyWith(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
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

class _AnimatedFlower extends StatefulWidget {
  final String asset;
  final double width;
  final double height;
  final int delayMs;

  const _AnimatedFlower({
    required this.asset,
    required this.width,
    required this.height,
    required this.delayMs,
    super.key,
  });

  @override
  State<_AnimatedFlower> createState() => _AnimatedFlowerState();
}

class _AnimatedFlowerState extends State<_AnimatedFlower>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Image.asset(
        widget.asset,
        fit: BoxFit.contain,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}

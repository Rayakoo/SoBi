import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../provider/auth_provider.dart';
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

  // Nama-nama emoticon sesuai urutan
  final List<String> emotionNames = [
    'marah',
    'sedih',
    'biasa',
    'senyum',
    'bahagia_sekali',
  ];

  // Path emoticon utama (frame pertama)
  List<String> get emoticonWebpAssets =>
      List.generate(5, (i) => 'assets/emoji/${emotionNames[i]}.webp');

  // Untuk animasi frame
  bool isAnimatingEmotion = false;
  int animFrame = 1;

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

  void _onEmotionSelected(int index) async {
    if (selectedEmotion == -1 && currentQuestion < emotionQuestions.length) {
      setState(() {
        selectedEmotion = index;
        isAnimatingEmotion = true;
        animFrame = 1;
      });

      // 5 frame, 120ms per frame (lebih lambat dan smooth)
      for (int i = 1; i <= 6; i++) {
        await Future.delayed(const Duration(milliseconds: 120));
        if (!mounted) return;
        setState(() {
          animFrame = i;
        });
      }

      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        isAnimatingEmotion = false;
        totalPoint += (index + 1);
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
    final authProvider = Provider.of<AuthProvider>(context);
    // Ambil user profile dari cache, jika tidak ada dan token ada, fetch user dari API
    if (authProvider.user == null && authProvider.token != null) {
      authProvider.fetchUser();
    }
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(screenWidth, authProvider),
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
                          children: List.generate(emotionNames.length, (index) {
                            final isAnswered =
                                selectedEmotion != -1 ||
                                (currentQuestion ==
                                        emotionQuestions.length - 1 &&
                                    selectedEmotion != -1);
                            final isSelected = selectedEmotion == index;
                            return GestureDetector(
                              onTap:
                                  isAnswered || isAnimatingEmotion
                                      ? null
                                      : () => _onEmotionSelected(index),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? AppColors.primary_30
                                          : AppColors.default_10,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? AppColors.primary_90
                                            : AppColors.default_30,
                                    width: 2,
                                  ),
                                ),
                                child: _EmotionAnimatedImage(
                                  emotion: emotionNames[index],
                                  isSelected: isSelected,
                                  isAnimating: isSelected && isAnimatingEmotion,
                                  animFrame:
                                      isSelected && isAnimatingEmotion
                                          ? animFrame
                                          : 1,
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

  Widget _buildHeader(double screenWidth, AuthProvider authProvider) {
    final username = authProvider.user?.username ?? '...';
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
                        username,
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

// Widget untuk menampilkan animasi frame webp + efek scale
class _EmotionAnimatedImage extends StatefulWidget {
  final String emotion;
  final bool isSelected;
  final bool isAnimating;
  final int animFrame;

  const _EmotionAnimatedImage({
    required this.emotion,
    required this.isSelected,
    required this.isAnimating,
    required this.animFrame,
    super.key,
  });

  @override
  State<_EmotionAnimatedImage> createState() => _EmotionAnimatedImageState();
}

class _EmotionAnimatedImageState extends State<_EmotionAnimatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.25,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.25,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_scaleController);
    if (widget.isAnimating) {
      _scaleController.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(covariant _EmotionAnimatedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !oldWidget.isAnimating) {
      _scaleController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  double _getScale(int frame) {
    // Membesar di frame ke-3 (index 3), normal di awal & akhir
    // Frame: 1 2 3 4 5
    // Scale: 1.0 -> 1.15 -> 1.25 -> 1.15 -> 1.0
    switch (frame) {
      case 1:
        return 1.0;
      case 2:
        return 1.35;
      case 3:
        return 1.25;
      case 4:
        return 1.15;
      case 5:
        return 1.0;
      default:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    String assetPath;
    if (widget.isSelected && widget.isAnimating) {
      assetPath =
          widget.animFrame == 1
              ? 'assets/emoji/${widget.emotion}.webp'
              : 'assets/emoji/${widget.emotion} (${widget.animFrame - 1}).webp';
    } else {
      assetPath = 'assets/emoji/${widget.emotion}.webp';
    }

    final scale =
        widget.isSelected && widget.isAnimating
            ? _getScale(widget.animFrame)
            : 1.0;

    // AnimatedSwitcher + FadeTransition untuk transisi frame lebih mulus
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 120), // lebih lambat dan smooth
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder:
          (child, animation) =>
              FadeTransition(opacity: animation, child: child),
      child: Transform.scale(
        key: ValueKey(assetPath),
        scale: scale,
        child: Image.asset(
          assetPath,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

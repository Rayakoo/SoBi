import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../style/colors.dart';
import '../../../style/typography.dart';

class SobiAiScreen extends StatefulWidget {
  const SobiAiScreen({super.key});

  @override
  State<SobiAiScreen> createState() => _SobiAiScreenState();
}

class _SobiAiScreenState extends State<SobiAiScreen> {
  bool started = false;
  int chatStep = 0;
  List<Map<String, dynamic>> chatHistory = [];

  final List<Map<String, dynamic>> aiChats = [
    {
      'ai': [
        'Assalammualaikum Fatimmah, aku Sobat Bimbing kamu hari ini.',
        'Gimana kabar kamu hari ini, akhir-akhir ini kamu ngerasa gimana?',
      ],
      'choices': [
        'Senang banget sih',
        'Sedikit cemas',
        'Capek banget secara mental',
        'Sedih tanpa alasan',
        'Naik-turun, nggak jelas',
      ],
    },
    {
      'ai': ['Kira kira hal apa yang paling ngaruh ke perasaanmu sekarang?'],
      'choices': [
        'Diri sendiri',
        'Keluarga',
        'Teman',
        'Lingkungan',
        'Aktivitas',
      ],
    },
    // Tambah step berikutnya jika perlu
  ];

  void _startChat() {
    setState(() {
      started = true;
      chatStep = 0;
      chatHistory = [];
    });
  }

  void _selectChoice(String choice) {
    setState(() {
      chatHistory.add({'sender': 'me', 'text': choice, 'time': '10.00'});
      if (chatStep < aiChats.length) {
        chatHistory.add({
          'sender': 'ai',
          'text': aiChats[chatStep]['ai'][0],
          'time': '10.00',
        });
      }
      chatStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary_10,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primary_90,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(
                      'assets/illustration/Fatimah-menyapa.svg',
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sobi AI',
                        style: AppTextStyles.heading_6_bold.copyWith(
                          color: AppColors.primary_90,
                        ),
                      ),
                      Text(
                        'Online',
                        style: AppTextStyles.body_5_regular.copyWith(
                          color: AppColors.primary_90,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: started ? _buildChatAi(context) : _buildLanding(context),
    );
  }

  Widget _buildLanding(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: SvgPicture.asset(
              'assets/illustration/Fatimah-menyapa.svg',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Tambahkan SizedBox(height: ...) agar card turun ke bawah
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 200), // card lebih turun
                Card(
                  color: AppColors.primary_10,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cerita nggak harus selalu ke manusia',
                          style: AppTextStyles.heading_4_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Di fitur ini, AI bakal mulai ngobrol dulu lewat beberapa pertanyaan ringan buat ngerti perasaan kamu—biar curhatnya lebih terarah dan insyaAllah bisa bantu kamu ngerasa lebih lega.',
                          style: AppTextStyles.body_4_regular.copyWith(
                            color: AppColors.primary_90,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _startChat,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary_90,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Mulai',
                              style: AppTextStyles.body_3_bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatAi(BuildContext context) {
    final currentStep = chatStep < aiChats.length ? aiChats[chatStep] : null;
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Today',
              style: AppTextStyles.body_4_bold.copyWith(
                color: AppColors.primary_90,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            children: [
              // AI bubble awal
              if (chatHistory.isEmpty)
                ...aiChats[0]['ai']
                    .map<Widget>((text) => _bubbleAi(text))
                    .toList(),
              // History
              ...chatHistory.map((msg) {
                if (msg['sender'] == 'me') {
                  return _bubbleMe(msg['text']);
                } else {
                  return _bubbleAi(msg['text']);
                }
              }).toList(),
            ],
          ),
        ),
        if (currentStep != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                ...currentStep['choices'].map<Widget>((choice) {
                  final isSelected =
                      chatHistory.isNotEmpty &&
                      chatHistory.last['sender'] == 'me' &&
                      chatHistory.last['text'] == choice;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton(
                      onPressed:
                          isSelected ? null : () => _selectChoice(choice),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? AppColors.primary_30 : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: AppColors.default_30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        choice,
                        style: AppTextStyles.body_4_regular.copyWith(
                          color:
                              isSelected ? Colors.white : AppColors.primary_90,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _bubbleAi(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primary_10,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTextStyles.body_4_regular.copyWith(
                color: AppColors.primary_90,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '10.00',
              style: AppTextStyles.body_5_regular.copyWith(
                color: AppColors.default_90,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bubbleMe(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primary_30,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: AppTextStyles.body_4_regular.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              '10.00',
              style: AppTextStyles.body_5_regular.copyWith(
                color: AppColors.default_90,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

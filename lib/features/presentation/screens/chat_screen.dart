import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../style/colors.dart';
import '../style/typography.dart';

class ChatScreen extends StatelessWidget {
  final String role;
  const ChatScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    // Dummy data sesuai role
    final List<Map<String, dynamic>> messages =
        role == 'pencerita'
            ? [
              {
                'sender': 'other',
                'avatar': 'assets/svg/avatar.svg',
                // 'name': 'User_41',
                // 'online': true,
                'text': 'Assalamualaikum! Gimana kabarnya hari ini?',
                'time': '10.00',
              },
              {
                'sender': 'me',
                'text':
                    'Waalaikumsalam, alhamdulillah aku baik. Tapi emang lagi pengen cerita sih.',
                'time': '10.00',
              },
              {
                'sender': 'me',
                'text':
                    'Akhir-akhir ini aku ngerasa capek banget, tapi bukan karena aktivitas doang, lebih ke hati dan pikiran. Kayak... semuanya numpuk aja gitu. Ada momen di mana aku pengen cerita, tapi nggak tahu harus mulai dari mana, atau takut malah dikira drama. Padahal aku cuma butuh didengerin tanpa dihakimi. Kadang aku mikir, apa aku terlalu mikirin semuanya terlalu dalam?',
                'time': '10.00',
              },
              {
                'sender': 'other',
                'text':
                    'Paham banget rasanya kayak gitu, dan itu valid ya—capek nggak harus selalu soal fisik, kadang hati yang paling berat bawaannya. Kadang kita cuma butuh teman buat cerita, tanpa harus mikir “berlebihan” atau nggak. Kamu udah keren banget mau buka suara dan nyoba cerita. Pelan-pelan, terus semangat ya!',
                'time': '10.00',
              },
            ]
            : [
              {
                'sender': 'other',
                'avatar': 'assets/svg/avatar.svg',
                // 'name': 'User_41',
                // 'online': true,
                'text': 'Assalamualaikum! Gimana kabarnya hari ini?',
                'time': '10.00',
              },
            ];

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
                      'assets/svg/avatar.svg',
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
                        'User_41',
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
      body: Column(
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, idx) {
                final msg = messages[idx];
                final isMe = msg['sender'] == 'me';
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment:
                        isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      if (!isMe && idx == 0)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(
                                  msg['avatar'],
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                msg['name'],
                                style: AppTextStyles.body_4_bold.copyWith(
                                  color: AppColors.primary_90,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.success_50,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 260),
                        margin: EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isMe
                                  ? AppColors.primary_30
                                  : AppColors.primary_10,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isMe ? 16 : 0),
                            topRight: Radius.circular(isMe ? 0 : 16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          msg['text'],
                          style: AppTextStyles.body_4_regular.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 4,
                        ),
                        child: Text(
                          msg['time'],
                          style: AppTextStyles.body_5_regular.copyWith(
                            color: AppColors.default_90,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.primary_10, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined, color: AppColors.primary_90),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Message...',
                      hintStyle: AppTextStyles.body_4_regular.copyWith(
                        color: AppColors.default_90,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.link, color: AppColors.primary_90),
                const SizedBox(width: 8),
                Icon(Icons.image_outlined, color: AppColors.primary_90),
                const SizedBox(width: 8),
                Icon(Icons.mic_none_outlined, color: AppColors.primary_90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

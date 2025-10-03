import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sobi/features/data/datasources/auth_datasources.dart';
import 'package:sobi/features/presentation/provider/chat_provider.dart';
import '../../../style/colors.dart';
import '../../../style/typography.dart';

class PembayaranLoadingScreen extends StatefulWidget {
  final Map<String, dynamic>? ahli;
  const PembayaranLoadingScreen({super.key, this.ahli});

  @override
  State<PembayaranLoadingScreen> createState() =>
      _PembayaranLoadingScreenState();
}

class _PembayaranLoadingScreenState extends State<PembayaranLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint('[PEMBAYARAN LOADING] ahli.id: ${widget.ahli?['id']}');
      context.go('/pembayaran-berhasil', extra: widget.ahli);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ahli = widget.ahli;
    debugPrint('[PEMBAYARAN LOADING] ahli object: ${ahli.toString()}');
    debugPrint('[PEMBAYARAN LOADING] ahli.id: ${ahli?['id']}');
    debugPrint('[PEMBAYARAN LOADING] ahli.username: ${ahli?['username']}');
    debugPrint('[PEMBAYARAN LOADING] ahli.avatar: ${ahli?['avatar']}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menunggu Pembayaran',
          style: AppTextStyles.heading_5_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          // Ganti dengan Lottie.asset jika sudah ada file lottie
          SizedBox(
            height: 120,
            child: Image.asset(
              'assets/illustration/hourglass.png',
            ), // dummy, ganti dengan lottie jika ada
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Mohon untuk segera melakukan pembayaran sebelum batas waktu pembayaran.',
              style: AppTextStyles.body_4_regular.copyWith(
                color: AppColors.primary_90,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Card(
              color: AppColors.primary_10,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(label: 'Kode Booking', value: 'AA230425'),
                    _DetailRow(label: 'Batas Waktu', value: '23 April 2025'),
                    _DetailRow(label: 'Pembayaran', value: '10:41'),
                    _DetailRow(label: 'Metode Pembayaran', value: 'Shopeepay'),
                    _DetailRow(label: 'Total Pembayaran', value: 'Rp 27.000'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body_4_regular.copyWith(
                color: AppColors.primary_90,
              ),
            ),
          ),
          Text(
            ':',
            style: AppTextStyles.body_4_regular.copyWith(
              color: AppColors.primary_90,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body_4_bold.copyWith(
                color: AppColors.primary_90,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PembayaranBerhasilScreen extends StatelessWidget {
  final Map<String, dynamic>? ahli;
  const PembayaranBerhasilScreen({super.key, this.ahli});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran Berhasil',
          style: AppTextStyles.heading_5_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 64),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary_30, width: 4),
              ),
              child: Center(
                child: Icon(Icons.check, size: 64, color: AppColors.primary_30),
                // Ganti dengan SvgPicture.asset jika ada svg
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Selanjutnya kamu akan diarahkan ke sesi curhat bersama ahli',
              style: AppTextStyles.body_4_regular.copyWith(
                color: AppColors.primary_90,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final ahliData =
                      ahli ??
                      (GoRouter.of(
                            context,
                          ).routerDelegate.currentConfiguration.extra
                          as Map<String, dynamic>?);
                  final targetId = ahliData?['id'] ?? '';
                  debugPrint(
                    '[PEMBAYARAN BERHASIL] createRoom targetId: $targetId',
                  );
                  final token = await AuthDatasources().getToken() ?? '';
                  final chatProvider = Provider.of<ChatProvider>(
                    context,
                    listen: false,
                  );
                  await chatProvider.createRoom(
                    token: token,
                    category: 'curhat',
                    visible: true,
                    targetId: targetId,
                  );
                  final roomId = chatProvider.createdRoom?.id ?? '';
                  debugPrint('[PEMBAYARAN BERHASIL] roomId: $roomId');
                  await chatProvider.fetchRoomMessages(
                    token: token,
                    roomId: roomId,
                  );
                  context.go(
                    '/chat-room/ahli',
                    extra: {'roomId': roomId, 'ahli': ahliData},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary_70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Lanjut Sesi Chat',
                  style: AppTextStyles.body_3_bold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

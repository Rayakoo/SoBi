import 'package:flutter/material.dart';
import '../../../style/colors.dart';
import '../../../style/typography.dart';

class DetailPembayaranScreen extends StatefulWidget {
  final Map<String, dynamic>? ahli;
  const DetailPembayaranScreen({super.key, this.ahli});

  @override
  State<DetailPembayaranScreen> createState() => _DetailPembayaranScreenState();
}

class _DetailPembayaranScreenState extends State<DetailPembayaranScreen> {
  int selectedMethod = 0;

  final List<Map<String, dynamic>> metodePembayaran = [
    {'logo': 'assets/icons/shopeepay.png', 'label': 'Shopeepay'},
    {'logo': 'assets/icons/gopay.png', 'label': 'Gopay'},
    {'logo': 'assets/icons/qris.png', 'label': 'Qris'},
    {'logo': 'assets/icons/bca.png', 'label': 'BCA'},
    {'logo': 'assets/icons/mandiri.png', 'label': 'Bank Mandiri'},
  ];

  @override
  Widget build(BuildContext context) {
    final ahli = widget.ahli;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Pembayaran',
          style: AppTextStyles.heading_5_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Card
            Card(
              color: AppColors.primary_10,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        ahli?['image'] ?? 'assets/logo/Logo.png',
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ahli?['name'] ?? 'Ustz. Aaliyah Izzati',
                            style: AppTextStyles.heading_6_bold.copyWith(
                              color: AppColors.primary_90,
                            ),
                          ),
                          Text(
                            ahli?['profesi'] ?? 'Penceramah Agama',
                            style: AppTextStyles.body_4_regular.copyWith(
                              color: AppColors.primary_90,
                            ),
                          ),
                          Text(
                            ahli?['jam'] ?? '10:00 - 10:30',
                            style: AppTextStyles.body_5_regular.copyWith(
                              color: AppColors.primary_90,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Rincian Pembayaran Card
            Card(
              color: AppColors.primary_10,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rincian Pembayaran',
                      style: AppTextStyles.heading_6_bold.copyWith(
                        color: AppColors.primary_90,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya sesi 30 menit',
                          style: AppTextStyles.body_4_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                        Text(
                          ahli?['harga'] ?? 'Rp 25.000',
                          style: AppTextStyles.body_4_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya layanan',
                          style: AppTextStyles.body_4_regular.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                        Text(
                          'Rp 2.000',
                          style: AppTextStyles.body_4_regular.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pembayaran',
                          style: AppTextStyles.body_4_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                        Text(
                          _getTotalPembayaran(ahli?['harga']),
                          style: AppTextStyles.body_4_bold.copyWith(
                            color: AppColors.primary_90,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Metode Pembayaran
            Text(
              'Metode Pembayaran',
              style: AppTextStyles.heading_6_bold.copyWith(
                color: AppColors.primary_90,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(metodePembayaran.length, (idx) {
                final method = metodePembayaran[idx];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => setState(() => selectedMethod = idx),
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      color: AppColors.primary_10,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Image.asset(method['logo'], width: 32, height: 32),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                method['label'],
                                style: AppTextStyles.body_4_bold.copyWith(
                                  color: AppColors.primary_90,
                                ),
                              ),
                            ),
                            Radio<int>(
                              value: idx,
                              groupValue: selectedMethod,
                              onChanged:
                                  (val) =>
                                      setState(() => selectedMethod = val ?? 0),
                              activeColor: AppColors.primary_90,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            // Tombol Lanjut Pembayaran
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: lanjut pembayaran
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary_30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Lanjut Pembayaran',
                  style: AppTextStyles.body_3_bold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTotalPembayaran(String? harga) {
    // Ambil angka dari harga, tambahkan 2000
    if (harga == null) return 'Rp 27.000';
    final angka =
        int.tryParse(harga.replaceAll(RegExp(r'[^0-9]'), '')) ?? 25000;
    final total = angka + 2000;
    return 'Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (m) => '${m[1]}.')}';
  }
}

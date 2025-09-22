import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../style/colors.dart';
import '../style/typography.dart';

class SobiGoalsScreen extends StatefulWidget {
  const SobiGoalsScreen({super.key});

  @override
  State<SobiGoalsScreen> createState() => _SobiGoalsScreenState();
}

class _SobiGoalsScreenState extends State<SobiGoalsScreen> {
  final List<String> goals = [
    'Berhenti pacaran',
    'Berpakaian sesuai syariat',
    'Menghafal Alquran',
    'Tinggalkan teman toxic',
    'Lainnya',
  ];

  String? selectedGoal;
  DateTime? selectedDate;
  bool showDatePicker = false;
  bool hasActiveGoal = false; // Tambahkan state ini

  // Dummy data untuk misi harian
  final List<Map<String, dynamic>> dailyTasks = [
    {
      'icon': Icons.edit,
      'title': 'Tuliskan 5 alasan kenapa harus berhenti pacaran',
      'checked': false,
    },
    {
      'icon': Icons.play_circle_outline,
      'title': 'Mendengarkan kajian singkat tentang cinta & zina',
      'checked': false,
    },
    {
      'icon': Icons.wallpaper,
      'title': 'Pasang niat hijrah sebagai wallpaper HP',
      'checked': false,
    },
    {
      'icon': Icons.menu_book,
      'title': 'Membaca QS. An-Nur ayat 30-31 dan artinya',
      'checked': false,
    },
    {
      'icon': Icons.chat_bubble_outline,
      'title': 'Curhat ke Allah lewat shalat dan doa panjang',
      'checked': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedGoal = null;
    selectedDate = null;
    // Inisialisasi data lokal untuk DateFormat
    initializeDateFormatting('id_ID', null);
  }

  void _showDatePicker() async {
    setState(() {
      showDatePicker = true;
    });
    final now = DateTime.now();
    final picked = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempDate = selectedDate ?? now;
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: SizedBox(
            width: 320,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: StatefulBuilder(
                builder: (context, setStateDialog) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {
                              setStateDialog(() {
                                tempDate = DateTime(
                                  tempDate.year,
                                  tempDate.month - 1,
                                  tempDate.day,
                                );
                              });
                            },
                          ),
                          Text(
                            DateFormat('MMMM yyyy').format(tempDate),
                            style: AppTextStyles.heading_6_bold.copyWith(
                              color: AppColors.primary_90,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              setStateDialog(() {
                                tempDate = DateTime(
                                  tempDate.year,
                                  tempDate.month + 1,
                                  tempDate.day,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      CalendarDatePicker(
                        initialDate: tempDate,
                        firstDate: DateTime(now.year, now.month, now.day),
                        lastDate: DateTime(now.year + 2),
                        onDateChanged: (date) {
                          setStateDialog(() {
                            tempDate = date;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.default_10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Batal',
                                style: AppTextStyles.body_3_bold.copyWith(
                                  color: AppColors.primary_90,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextButton(
                              onPressed:
                                  () => Navigator.of(context).pop(tempDate),
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primary_50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Pilih Tanggal',
                                style: AppTextStyles.body_3_bold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    setState(() {
      showDatePicker = false;
      if (picked != null) {
        selectedDate = picked;
      }
    });
  }

  int getDaysLeft() {
    if (selectedDate == null) return 0;
    final today = DateTime.now();
    final diff =
        selectedDate!
            .difference(DateTime(today.year, today.month, today.day))
            .inDays;
    return diff;
  }

  int getTotalDays() {
    if (selectedDate == null) return 0;
    final today = DateTime.now();
    final total =
        selectedDate!
            .difference(DateTime(today.year, today.month, today.day))
            .inDays +
        1;
    return total;
  }

  int getCurrentDayIndex() {
    if (selectedDate == null) return 0;
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final total = selectedDate!.difference(start).inDays + 1;
    final done = getTotalDays() - getDaysLeft();
    return done;
  }

  double getProgress() {
    final checked = dailyTasks.where((t) => t['checked'] == true).length;
    return checked / dailyTasks.length;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final selected = selectedDate ?? today;
    final days =
        selectedDate != null
            ? selectedDate!
                    .difference(DateTime(today.year, today.month, today.day))
                    .inDays +
                1
            : 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sobi Goals',
          style: AppTextStyles.heading_5_bold.copyWith(
            color: AppColors.primary_90,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            hasActiveGoal
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kiri: judul dan dropdown
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  'Fokus pada satu perubahan,\nistiqomah pada satu tujuan',
                                  style: AppTextStyles.body_3_bold.copyWith(
                                    color: AppColors.primary_90,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Dropdown (disabled)
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.default_10,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary_30,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedGoal,
                                    isExpanded: true,
                                    hint: Text(
                                      'Masukkan Target',
                                      style: AppTextStyles.body_3_regular
                                          .copyWith(
                                            color: AppColors.default_90,
                                          ),
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: selectedGoal,
                                        child: Text(
                                          selectedGoal ?? '',
                                          style: AppTextStyles.body_3_regular
                                              .copyWith(
                                                color: AppColors.primary_90,
                                              ),
                                        ),
                                      ),
                                    ],
                                    onChanged: null, // disable
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Kanan: Card ungu dengan sisa hari dan SVG
                        Container(
                          width: 90,
                          height: 125,
                          decoration: BoxDecoration(
                            color: AppColors.primary_50,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${getDaysLeft()} hari tersisa',
                                style: AppTextStyles.heading_6_bold.copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // Ganti dengan asset yang pasti ada
                              SvgPicture.asset(
                                'assets/illustration/Fatimah-Senang.svg',
                                width: 48,
                                height: 48,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Progress section
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary_10,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sudah Sampai Mana?',
                            style: AppTextStyles.body_4_bold.copyWith(
                              color: AppColors.primary_90,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Bulatan slider bisa di slide dan overflow di-hide
                          ClipRect(
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(getTotalDays(), (
                                    index,
                                  ) {
                                    final isChecked =
                                        index < getCurrentDayIndex();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.white,
                                        child:
                                            isChecked
                                                ? Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.primary_30,
                                                  size: 28,
                                                )
                                                : Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          AppColors.primary_30,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  width: 28,
                                                  height: 28,
                                                ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Progress bar
                          Stack(
                            children: [
                              Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary_30,
                                    width: 1,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.7 *
                                    getProgress(),
                                decoration: BoxDecoration(
                                  color: AppColors.primary_30,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              Positioned(
                                right: 4,
                                top: 2,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Misi hari ini
                    Text(
                      'Misi Hari ini',
                      style: AppTextStyles.heading_6_bold.copyWith(
                        color: AppColors.primary_90,
                      ),
                    ),
                    Text(
                      'Fokus : Menyadari kesalahan dan membangun niat hijrah',
                      style: AppTextStyles.body_4_regular.copyWith(
                        color: AppColors.primary_90,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // List tugas harian
                    ...dailyTasks.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final task = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary_30),
                          ),
                          child: ListTile(
                            leading: Icon(
                              task['icon'],
                              color: AppColors.primary_30,
                            ),
                            title: Text(
                              task['title'],
                              style:
                                  idx == 2
                                      ? AppTextStyles.body_4_bold.copyWith(
                                        color: AppColors.primary_90,
                                      )
                                      : AppTextStyles.body_4_regular.copyWith(
                                        color: AppColors.primary_90,
                                      ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  task['checked'] = !(task['checked'] as bool);
                                });
                              },
                              child: Icon(
                                task['checked']
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: AppColors.primary_30,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],
                )
                : Column(
                  children: [
                    const SizedBox(height: 12),
                    // Atas: judul, dropdown, svg
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kiri: judul dan dropdown
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  'Fokus pada satu perubahan,\nistiqomah pada satu tujuan',
                                  style: AppTextStyles.body_3_bold.copyWith(
                                    color: AppColors.primary_90,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Dropdown
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.default_10,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary_30,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedGoal,
                                    isExpanded: true,
                                    hint: Text(
                                      'Masukkan Target',
                                      style: AppTextStyles.body_3_regular
                                          .copyWith(
                                            color: AppColors.default_90,
                                          ),
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    items:
                                        goals
                                            .map(
                                              (goal) =>
                                                  DropdownMenuItem<String>(
                                                    value: goal,
                                                    child: Text(
                                                      goal,
                                                      style: AppTextStyles
                                                          .body_3_regular
                                                          .copyWith(
                                                            color:
                                                                AppColors
                                                                    .primary_90,
                                                          ),
                                                    ),
                                                  ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGoal = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Tanggal atau tombol atur waktu
                              GestureDetector(
                                onTap: _showDatePicker,
                                child: Container(
                                  width: double.infinity,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.default_10,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primary_30,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      selectedDate == null
                                          ? 'Atur Waktu Pencapaian'
                                          : DateFormat(
                                            'd MMMM yyyy',
                                            'id_ID',
                                          ).format(selectedDate!),
                                      style: AppTextStyles.body_3_regular
                                          .copyWith(
                                            color: AppColors.primary_90,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Kanan: SVG
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 0,
                            right: 0,
                          ),
                          child: SvgPicture.asset(
                            'assets/illustration/Fatimah-semangat.svg',
                            width: 128,
                            height: 128,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Ilustrasi bawah
                    SvgPicture.asset(
                      'assets/illustration/Fatimah-Senang.svg',
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),
                    // Motivasi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Waktu terbaik untuk taat adalah saat kamu memilih untuk memulainya.',
                        style: AppTextStyles.body_3_bold.copyWith(
                          color: AppColors.primary_90,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (selectedGoal != null && selectedDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                hasActiveGoal = true;
                              });
                            },
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
                      ),
                    const Spacer(),
                    const SizedBox(height: 24),
                  ],
                ),
      ),
    );
  }
}

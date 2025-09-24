import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../provider/sobi-goals_provider.dart';
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

  @override
  void initState() {
    super.initState();
    selectedGoal = null;
    selectedDate = null;
    initializeDateFormatting('id_ID', null);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<SobiGoalsProvider>(context, listen: false);
      provider.isLoading = true;
      provider.notifyListeners();
      await provider.fetchTodayMission();
      provider.isLoading = false;
      provider.notifyListeners();
    });
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SobiGoalsProvider>(context);
    print('[screen] todayMissions: ${provider.todayMissions}');
    // Debug detail isi todayMissions
    for (var i = 0; i < provider.todayMissions.length; i++) {
      final m = provider.todayMissions[i];
      print(
        '[screen] todayMissions[$i]: userGoal=${m.userGoal}, dayIndex=${m.dayIndex}, missions=${m.missions}',
      );
      if (m.userGoal != null) {
        print(
          '[screen] todayMissions[$i].userGoal.status: ${m.userGoal.status}',
        );
      }
    }
    final isLoading = provider.isLoading;
    final goalStatus = provider.goalStatus;
    final goalEntity = provider.goalEntity;
    final todayMissions = provider.todayMissions;
    final hasActiveGoal = goalStatus == 'active';
    final error = provider.error;

    // Debug status
    print('[screen] goalStatus: $goalStatus');
    print('[screen] hasActiveGoal: $hasActiveGoal');
    final missionData = (todayMissions.isNotEmpty) ? todayMissions.first : null;
    print('[screen] missionData: $missionData');
    print('[screen] missionData != null: ${missionData != null}');

    // Ambil data dari mission jika ada
    // final missionData = (todayMissions.isNotEmpty) ? todayMissions.first : null;
    final mission =
        (missionData != null && missionData.missions.isNotEmpty)
            ? missionData.missions.first
            : null;

    final userGoal = missionData?.userGoal;
    final dayNumber = mission?.mission.dayNumber ?? 0;
    final focus = mission?.mission.focus ?? '';
    final category = userGoal?.goalCategory ?? selectedGoal;
    final startDate = userGoal?.startDate;
    final targetEndDate = userGoal?.targetEndDate;

    int daysLeft = 0;
    int totalDays = 0;
    if (startDate != null && targetEndDate != null && dayNumber > 0) {
      totalDays = targetEndDate.difference(startDate).inDays + 1;
      daysLeft = totalDays - dayNumber;
    }

    double progress =
        mission?.progress.completionPercentage != null
            ? (mission!.progress.completionPercentage! / 100)
            : 0.0;

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
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                ? Center(child: Text(error))
                : hasActiveGoal && missionData != null
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
                                    value: category,
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
                                        value: category,
                                        child: Text(
                                          category ?? '',
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
                                '$daysLeft hari tersisa',
                                style: AppTextStyles.heading_6_bold.copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
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
                                  children: List.generate(totalDays, (index) {
                                    final isChecked = index < dayNumber;
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
                                    progress,
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
                      'Fokus : $focus',
                      style: AppTextStyles.body_4_regular.copyWith(
                        color: AppColors.primary_90,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // List tugas harian dari tasks
                    if (mission != null)
                      ...mission.tasks.map((taskWithProgress) {
                        final task = taskWithProgress.task;
                        final progress = taskWithProgress.progress;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.primary_30),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.checklist,
                                color: AppColors.primary_30,
                              ),
                              title: Text(
                                task.text,
                                style: AppTextStyles.body_4_regular.copyWith(
                                  color: AppColors.primary_90,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap:
                                    progress.isCompleted
                                        ? null
                                        : () async {
                                          debugPrint(
                                            '[DEBUG] completeTask: userGoalId=${userGoal!.id}, taskId=${task.id}',
                                          );
                                          await provider.completeTask(
                                            userGoal.id,
                                            task.id,
                                          );
                                        },
                                child: Icon(
                                  progress.isCompleted
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
                            onPressed:
                                isLoading
                                    ? null
                                    : () async {
                                      final isoDate = DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(selectedDate!);
                                      debugPrint(
                                        '[DEBUG] createGoal request: {goal_category: $selectedGoal, target_end_date: $isoDate}',
                                      );
                                      await provider.createGoal(
                                        selectedGoal!,
                                        isoDate,
                                      );
                                      await provider
                                          .fetchGoalStatusAndMission();
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary_90,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child:
                                provider.isLoading
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : Text(
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

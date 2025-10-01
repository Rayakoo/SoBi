import 'package:flutter/material.dart';
import '../../domain/entities/surat_entity.dart';
import '../../domain/entities/surat_detail_entity.dart';
import '../../domain/entities/tafsir_entity.dart';
import '../../domain/usecases/sobi-quran/get_surat.dart';
import '../../domain/usecases/sobi-quran/get_surat_detail.dart';
import '../../domain/usecases/sobi-quran/get_tafsir.dart';

class SobiQuranProvider extends ChangeNotifier {
  final GetSurat getSuratUsecase;
  final GetSuratDetail? getSuratDetailUsecase;
  final GetTafsir? getTafsirUsecase;

  List<SuratEntity> suratList = [];
  SuratDetailEntity? suratDetail;
  TafsirEntity? tafsir;
  bool isLoading = false;
  String? error;

  SobiQuranProvider({
    required this.getSuratUsecase,
    this.getSuratDetailUsecase,
    this.getTafsirUsecase,
  });

  Future<void> fetchSurat() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      suratList = await getSuratUsecase();
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSuratDetail(int nomor) async {
    if (getSuratDetailUsecase == null) return;
    isLoading = true;
    error = null;
    print('[PROVIDER] fetchSuratDetail request nomor=$nomor');
    notifyListeners();
    try {
      suratDetail = await getSuratDetailUsecase!(nomor);
      print('[PROVIDER] fetchSuratDetail response: ${suratDetail?.namaLatin}');
      error = null;
    } catch (e) {
      error = e.toString();
      print('[PROVIDER] fetchSuratDetail error: $error');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTafsir(int nomor) async {
    if (getTafsirUsecase == null) return;
    isLoading = true;
    error = null;
    print('[PROVIDER] fetchTafsir request nomor=$nomor');
    notifyListeners();
    try {
      tafsir = await getTafsirUsecase!(nomor);
      print('[PROVIDER] fetchTafsir response: ${tafsir?.namaLatin}');
      error = null;
    } catch (e) {
      error = e.toString();
      print('[PROVIDER] fetchTafsir error: $error');
    }
    isLoading = false;
    notifyListeners();
  }
}

import 'package:dio/dio.dart';
import '../models/surat_model.dart';
import '../models/surat_detail_model.dart';
import '../models/tafsir_model.dart';

class SobiQuranDatasource {
  final Dio dio;
  final String baseUrl;

  SobiQuranDatasource({Dio? dioClient, String? baseUrlOverride})
    : dio = dioClient ?? Dio(),
      baseUrl = baseUrlOverride ?? 'https://equran.id/api/v2';

  Future<List<SuratModel>> getSurat() async {
    final res = await dio.get('$baseUrl/surat');
    if (res.data != null && res.data['data'] is List) {
      return (res.data['data'] as List)
          .map((e) => SuratModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<SuratDetailModel?> getSuratDetail(int nomor) async {
    print('[DATASOURCE] getSuratDetail request: $baseUrl/surat/$nomor');
    final res = await dio.get('$baseUrl/surat/$nomor');
    print('[DATASOURCE] getSuratDetail response: ${res.data}');
    if (res.data != null && res.data['data'] != null) {
      return SuratDetailModel.fromJson(res.data);
    }
    return null;
  }

  Future<TafsirModel?> getTafsir(int nomor) async {
    print('[DATASOURCE] getTafsir request: $baseUrl/tafsir/$nomor');
    final res = await dio.get('$baseUrl/tafsir/$nomor');
    print('[DATASOURCE] getTafsir response: ${res.data}');
    if (res.data != null && res.data['data'] != null) {
      return TafsirModel.fromJson(res.data);
    }
    return null;
  }
}

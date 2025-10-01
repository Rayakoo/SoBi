import '../entities/surat_entity.dart';
import '../entities/surat_detail_entity.dart';
import '../entities/tafsir_entity.dart';

abstract class SobiQuranRepository {
  Future<List<SuratEntity>> getSurat();
  Future<SuratDetailEntity?> getSuratDetail(int nomor);
  Future<TafsirEntity?> getTafsir(int nomor);
}

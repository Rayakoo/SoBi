import '../../repositories/sobi-quran_repository.dart';
import '../../entities/tafsir_entity.dart';

class GetTafsir {
  final SobiQuranRepository repository;
  GetTafsir(this.repository);

  Future<TafsirEntity?> call(int nomor) {
    return repository.getTafsir(nomor);
  }
}

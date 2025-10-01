import '../../domain/entities/tafsir_entity.dart';

class TafsirAyatModel {
  final int ayat;
  final String teks;

  TafsirAyatModel({required this.ayat, required this.teks});

  factory TafsirAyatModel.fromJson(Map<String, dynamic> json) {
    return TafsirAyatModel(ayat: json['ayat'], teks: json['teks']);
  }

  TafsirAyatEntity toEntity() {
    return TafsirAyatEntity(ayat: ayat, teks: teks);
  }
}

class TafsirModel {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final List<TafsirAyatModel> tafsir;

  TafsirModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.tafsir,
  });

  factory TafsirModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return TafsirModel(
      nomor: data['nomor'],
      nama: data['nama'],
      namaLatin: data['namaLatin'],
      jumlahAyat: data['jumlahAyat'],
      tempatTurun: data['tempatTurun'],
      arti: data['arti'],
      deskripsi: data['deskripsi'],
      tafsir:
          (data['tafsir'] as List)
              .map((e) => TafsirAyatModel.fromJson(e))
              .toList(),
    );
  }

  TafsirEntity toEntity() {
    return TafsirEntity(
      nomor: nomor,
      nama: nama,
      namaLatin: namaLatin,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurun,
      arti: arti,
      deskripsi: deskripsi,
      tafsir: tafsir.map((t) => t.toEntity()).toList(),
    );
  }
}

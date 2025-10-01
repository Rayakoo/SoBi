class TafsirAyatEntity {
  final int ayat;
  final String teks;

  TafsirAyatEntity({required this.ayat, required this.teks});
}

class TafsirEntity {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final List<TafsirAyatEntity> tafsir;

  TafsirEntity({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.tafsir,
  });
}

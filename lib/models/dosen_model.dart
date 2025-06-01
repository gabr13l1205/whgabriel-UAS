class HistoriChat {
  final int alur;
  final String pesan;

  HistoriChat({required this.alur, required this.pesan});

  factory HistoriChat.fromJson(Map<String, dynamic> json) {
    return HistoriChat(
      alur: json['alur'],
      pesan: json['pesan'],
    );
  }
}

class Dosen {
  final int id;
  final String nama;
  final String gambar;
  final List<HistoriChat> historiChat;

  Dosen({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.historiChat,
  });

  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      id: json['id'],
      nama: json['nama'],
      gambar: json['gambar'],
      historiChat: (json['histori_chat'] as List)
          .map((e) => HistoriChat.fromJson(e))
          .toList(),
    );
  }
}

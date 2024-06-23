class model_history {
  final int id;
  final dynamic userId;
  final String idPembayaran;
  final String tanggal;
  final String rekClient;
  final String jumlah;
  final String totalPembayaran;
  final String namaBank;
  final String nama;
  final String buktiPembayaran;
  final String buktiTf;
  final String product;
  final dynamic namaBlockchain;
  final String priceRate;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String type;

  model_history({
    required this.id,
    required this.userId,
    required this.idPembayaran,
    required this.tanggal,
    required this.rekClient,
    required this.jumlah,
    required this.totalPembayaran,
    required this.namaBank,
    required this.nama,
    required this.buktiPembayaran,
    required this.buktiTf,
    required this.product,
    required this.namaBlockchain,
    required this.priceRate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory model_history.fromJson(Map<String, dynamic> json) {
    return model_history(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      idPembayaran: json['id_pembayaran'] ?? '',
      tanggal: json['tanggal'] ?? '',
      rekClient: json['rek_client'] ?? '',
      jumlah: json['jumlah'] ?? '',
      totalPembayaran: json['total_pembayaran'] ?? '',
      namaBank: json['nama_bank'] ?? '',
      nama: json['nama'] ?? '',
      buktiPembayaran: json['bukti_pembayaran'] ?? '',
      buktiTf: json['bukti_tf'] ?? '',
      product: json['product'] ?? '',
      namaBlockchain: json['nama_blockchain'] ?? '',
      priceRate: json['price_rate'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      type: json['type'] ?? '',
    );
  }

}
class model_history {
  int? id;
  int? userId;
  String? idPembayaran;
  String? tanggal;
  String? rekClient;
  String? jumlah;
  String? totalPembayaran;
  String? nama;
  String? buktiPembayaran;
  String? namaBank;
  String? product;
  String? priceRate;
  String? status;
  String? createdAt;
  String? updatedAt;

  model_history(
      {this.id,
        this.userId,
        this.idPembayaran,
        this.tanggal,
        this.rekClient,
        this.jumlah,
        this.totalPembayaran,
        this.nama,
        this.buktiPembayaran,
        this.namaBank,
        this.product,
        this.priceRate,
        this.status,
        this.createdAt,
        this.updatedAt});

  model_history.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    idPembayaran = json['id_pembayaran'];
    tanggal = json['tanggal'];
    rekClient = json['rek_client'];
    jumlah = json['jumlah'];
    totalPembayaran = json['total_pembayaran'];
    nama = json['nama'];
    buktiPembayaran = json['bukti_pembayaran'];
    namaBank = json['nama_bank'];
    product = json['product'];
    priceRate = json['price_rate'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['id_pembayaran'] = this.idPembayaran;
    data['tanggal'] = this.tanggal;
    data['rek_client'] = this.rekClient;
    data['jumlah'] = this.jumlah;
    data['total_pembayaran'] = this.totalPembayaran;
    data['nama'] = this.nama;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['nama_bank'] = this.namaBank;
    data['product'] = this.product;
    data['price_rate'] = this.priceRate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class pembayaran_model {
  dynamic id;
  dynamic userId;
  dynamic idPembayaran;
  dynamic tanggal;
  dynamic rekClient;
  dynamic jumlah;
  dynamic totalPembayaran;
  dynamic namaBank;
  dynamic nama;
  dynamic buktiPembayaran;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  pembayaran_model(
      {this.id,
        this.userId,
        this.idPembayaran,
        this.tanggal,
        this.rekClient,
        this.jumlah,
        this.totalPembayaran,
        this.namaBank,
        this.nama,
        this.buktiPembayaran,
        this.status,
        this.createdAt,
        this.updatedAt});

  pembayaran_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    idPembayaran = json['id_pembayaran'];
    tanggal = json['tanggal'];
    rekClient = json['rek_client'];
    jumlah = json['jumlah'];
    totalPembayaran = json['total_pembayaran'];
    namaBank = json['nama_bank'];
    nama = json['nama'];
    buktiPembayaran = json['bukti_pembayaran'];
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
    data['nama_bank'] = this.namaBank;
    data['nama'] = this.nama;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class model_topup {
  dynamic userId;
  dynamic product;
  dynamic priceRate;
  dynamic rekClient;
  dynamic jumlah;
  dynamic totalPembayaran;
  dynamic namaBank;
  dynamic namaBlockchain;

  model_topup(
      {this.userId,
        this.product,
        this.priceRate,
        this.rekClient,
        this.jumlah,
        this.totalPembayaran,
        this.namaBank,
        this.namaBlockchain});

  model_topup.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    product = json['product'];
    priceRate = json['price_rate'];
    rekClient = json['rek_client'];
    jumlah = json['jumlah'];
    totalPembayaran = json['total_pembayaran'];
    namaBank = json['nama_bank'];
    namaBlockchain = json['nama_blockchain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['product'] = this.product;
    data['price_rate'] = this.priceRate;
    data['rek_client'] = this.rekClient;
    data['jumlah'] = this.jumlah;
    data['total_pembayaran'] = this.totalPembayaran;
    data['nama_bank'] = this.namaBank;
    data['nama_blockchain'] = this.namaBlockchain;
    return data;
  }
}

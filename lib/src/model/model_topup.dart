class model_topup {
  dynamic userId;
  dynamic rekClient;
  dynamic jumlah;
  dynamic totalPembayaran;
  dynamic namaBank;
  dynamic product;
  dynamic priceRate;

  model_topup(
      {this.userId,
        this.rekClient,
        this.jumlah,
        this.totalPembayaran,
        this.namaBank,
        this.product,
        this.priceRate});

  model_topup.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    rekClient = json['rek_client'];
    jumlah = json['jumlah'];
    totalPembayaran = json['total_pembayaran'];
    namaBank = json['nama_bank'];
    product = json['product'];
    priceRate = json['price_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['rek_client'] = this.rekClient;
    data['jumlah'] = this.jumlah;
    data['total_pembayaran'] = this.totalPembayaran;
    data['nama_bank'] = this.namaBank;
    data['product'] = this.product;
    data['price_rate'] = this.priceRate;
    return data;
  }
}

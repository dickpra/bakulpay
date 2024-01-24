class blockchain_model {
  dynamic id;
  dynamic idRate;
  String? namaBank;
  dynamic namaBlockchain;
  dynamic rekeningWallet;
  dynamic type;
  dynamic price;
  dynamic active;
  String? createdAt;
  String? updatedAt;

  blockchain_model(
      {this.id,
        this.idRate,
        this.namaBank,
        this.namaBlockchain,
        this.rekeningWallet,
        this.type,
        this.price,
        this.active,
        this.createdAt,
        this.updatedAt});

  blockchain_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRate = json['id_rate'];
    namaBank = json['nama_bank'];
    namaBlockchain = json['nama_blockchain'];
    rekeningWallet = json['rekening_wallet'];
    type = json['type'];
    price = json['price'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_rate'] = this.idRate;
    data['nama_bank'] = this.namaBank;
    data['nama_blockchain'] = this.namaBlockchain;
    data['rekening_wallet'] = this.rekeningWallet;
    data['type'] = this.type;
    data['price'] = this.price;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

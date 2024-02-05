class rate_model {
  dynamic id;
  dynamic namaBank;
  dynamic icons;
  dynamic type;
  dynamic price;
  dynamic biayaTransaksi;
  dynamic nama;
  dynamic noRekening;
  dynamic active;
  String? createdAt;
  String? updatedAt;
  List<BlockchainData>? blockchainData;

  rate_model(
      {this.id,
        this.namaBank,
        this.icons,
        this.type,
        this.price,
        this.biayaTransaksi,
        this.nama,
        this.noRekening,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.blockchainData});

  rate_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBank = json['nama_bank'];
    icons = json['icons'];
    type = json['type'];
    price = json['price'];
    biayaTransaksi = json['biaya_transaksi'];
    nama = json['nama'];
    noRekening = json['no_rekening'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['blockchain_data'] != null) {
      blockchainData = <BlockchainData>[];
      json['blockchain_data'].forEach((v) {
        blockchainData!.add(new BlockchainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_bank'] = this.namaBank;
    data['icons'] = this.icons;
    data['type'] = this.type;
    data['price'] = this.price;
    data['biaya_transaksi'] = this.biayaTransaksi;
    data['nama'] = this.nama;
    data['no_rekening'] = this.noRekening;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.blockchainData != null) {
      data['blockchain_data'] =
          this.blockchainData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlockchainData {
  dynamic id;
  dynamic idRate;
  dynamic namaBank;
  dynamic namaBlockchain;
  dynamic rekeningWallet;
  dynamic type;
  dynamic price;
  dynamic biayaTransaksi;
  dynamic active;
  dynamic createdAt;
  String? updatedAt;

  BlockchainData(
      {this.id,
        this.idRate,
        this.namaBank,
        this.namaBlockchain,
        this.rekeningWallet,
        this.type,
        this.price,
        this.biayaTransaksi,
        this.active,
        this.createdAt,
        this.updatedAt});

  BlockchainData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRate = json['id_rate'];
    namaBank = json['nama_bank'];
    namaBlockchain = json['nama_blockchain'];
    rekeningWallet = json['rekening_wallet'];
    type = json['type'];
    price = json['price'];
    biayaTransaksi = json['biaya_transaksi'];
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
    data['biaya_transaksi'] = this.biayaTransaksi;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

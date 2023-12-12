class payment_model {
  dynamic id;
  dynamic namaBank;
  dynamic icons;
  String? nama;
  dynamic noRekening;
  String? createdAt;
  String? updatedAt;

  payment_model(
      {this.id,
        this.namaBank,
        this.icons,
        this.nama,
        this.noRekening,
        this.createdAt,
        this.updatedAt});

  payment_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBank = json['nama_bank'];
    icons = json['icons'];
    nama = json['nama'];
    noRekening = json['no_rekening'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_bank'] = this.namaBank;
    data['icons'] = this.icons;
    data['nama'] = this.nama;
    data['no_rekening'] = this.noRekening;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

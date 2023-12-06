class rate_model {
  dynamic id;
  String? namaBank;
  String? icons;
  String? type;
  dynamic price;
  String? createdAt;
  String? updatedAt;

  rate_model(
      {this.id,
        this.namaBank,
        this.icons,
        this.type,
        this.price,
        this.createdAt,
        this.updatedAt});

  rate_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBank = json['nama_bank'];
    icons = json['icons'];
    type = json['type'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_bank'] = this.namaBank;
    data['icons'] = this.icons;
    data['type'] = this.type;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

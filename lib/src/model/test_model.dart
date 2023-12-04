class test_model {
  String? produk;
  String? status;
  String? id;

  test_model({this.produk, this.status, this.id});

  test_model.fromJson(Map<String, dynamic> json) {
    produk = json['produk'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produk'] = this.produk;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}

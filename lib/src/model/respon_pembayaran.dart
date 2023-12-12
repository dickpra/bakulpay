class respon_pembayaran {
  bool? status;
  String? message;
  String? idPembayaran;

  respon_pembayaran({this.status, this.message, this.idPembayaran});

  respon_pembayaran.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    idPembayaran = json['id_pembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id_pembayaran'] = this.idPembayaran;
    return data;
  }
}

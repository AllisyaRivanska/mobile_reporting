class HomeModel {
  bool? success;
  String? message;
  List<Data>? data;

  HomeModel({this.success, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? kategori;
  String? deskripsi;
  Null fotoUrl;
  String? status;
  String? notesBalasan;
  int? lokasiKampusId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.kategori,
      this.deskripsi,
      this.fotoUrl,
      this.status,
      this.notesBalasan,
      this.lokasiKampusId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    kategori = json['kategori'];
    deskripsi = json['deskripsi'];
    fotoUrl = json['foto_url'];
    status = json['status'];
    notesBalasan = json['notes_balasan'];
    lokasiKampusId = json['lokasi_kampus_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['kategori'] = kategori;
    data['deskripsi'] = deskripsi;
    data['foto_url'] = fotoUrl;
    data['status'] = status;
    data['notes_balasan'] = notesBalasan;
    data['lokasi_kampus_id'] = lokasiKampusId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

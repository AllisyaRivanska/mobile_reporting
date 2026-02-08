class ReportingModel {
  bool? success;
  String? message;
  Data? data;

  String? kategori;    
  String? deskripsi;
  String? imagePath;
  int? lokasiKampusId;
  

  ReportingModel({this.success, this.message, this.data, this.kategori, this.deskripsi, this.imagePath, this.lokasiKampusId,});

  ReportingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? kategori;
  String? deskripsi;
  String? fotoUrl;
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
    fotoUrl = json['foto_url']?.toString(); //convert to string jd avoid error saat API kirim link gambar
    status = json['status'];
    notesBalasan = json['notes_balasan']?.toString();
    lokasiKampusId = json['lokasi_kampus_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

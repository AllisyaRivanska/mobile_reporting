import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nama = "Mahasiswa Gothic";
  String tanggalLahir = "10 - 10 - 2000";
  String nim = "1234567890";
  String prodi = "Teknik Nuklir S1";
  String kelas = "03SIFE006";
  String email = "melankolis123@gmail.com";
  String photoUrl = "https://via.placeholder.com/150";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2168E3),
        title: const Text(
          'Profil Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: const Color(0xFF67B0D1),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(photoUrl),
              ),
            ),
            const SizedBox(height: 30),

            buildProfileField("Nama Lengkap", nama),
            buildProfileField("Tanggal lahir", tanggalLahir),
            buildProfileField("NIM", nim),
            buildProfileField("Program Studi", prodi),
            buildProfileField("Kelas", kelas),
            buildProfileField("Email", email),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black54, width: 0.8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';

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


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: ColorConstant.creamCard,
    body: Column(
      children: [
        const CustomBackHeader(title: 'Profil Saya'),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: ColorConstant.darkBlue,
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/logo-unpam.png'),
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
        ),
      ],
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
            style: TextConfig.inputHint,
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
              style: TextConfig.logoutButton,
            ),
          ),
        ],
      ),
    );
  }
}

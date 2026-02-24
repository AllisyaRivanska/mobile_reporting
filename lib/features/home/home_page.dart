import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/features/home/cubit/home_bloc.dart';
import 'package:mobile_reporting/features/notification/notification_page.dart';
import 'package:mobile_reporting/features/profile/presentation/profile_menu_page.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';
import 'package:mobile_reporting/features/reporting/presentation/success_page.dart';
// import 'package:mobile_reporting/features/home/cubit/home_state.dart';
// import 'package:mobile_reporting/features/home/model/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final reportAktif = Data(
  id: 1,
  kategori: "Fasilitas",
  deskripsi: "Lampu Kelas 101 Mati\nsering nyala dan tiba-tiba redup.",
  status: "Proses",
  createdAt: "17 Jan 2026",
);

  bool showFakeCard = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().getHome();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstant.primaryColor,
          elevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Image.asset('assets/icons/logo-unpam.png', height: 50),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Campus Report',
                      style: TextConfig.headerHomePage),
                    Text(
                      'Universitas Pamulang',
                      style: TextConfig.subHeaderHomePage,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.yellow,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute (builder: (context) => const ProfileMenuPage()));
                },
              
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white30,
                backgroundImage: AssetImage('assets/icons/logo-unpam.png'),
              ),
            ),
            ),
          ],
        ),
      ),
      body: 
      Stack(
        children: [
          // Background logo
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/icons/logo-unpam.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),
          ),

          SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 85), 
              child: Builder(
                builder: (context) {
                  if (showFakeCard) {
                    return ListView(
                      children: [
                        _buildReportCard(reportAktif),
                        // Tambah konten lain di sini jika ada
                      ],
                    );
                  }
                  
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/image_70.svg'),
                        const SizedBox(height: 5),
                        const Text(
                          'Belum Ada Laporan',
                          style: TextConfig.textIcon,
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Laporkan masalah yang kamu temui \ndi sekitar kampus',
                          textAlign: TextAlign.center,
                          style: TextConfig.subTextIcon,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(Data data) {
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorConstant.creamCard,
          borderRadius: BorderRadius.circular(12),
          
        ),
        child: Row(
          
          children: [
            const Icon(Icons.notifications, color: ColorConstant.primaryColor, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                

                children: [
                  const Text(
                    "Laporanmu (17 Jan 2026) sedang di proses",
                    style: TextConfig.information,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        "Diperbarui 2 jam lalu  •  ",
                        style: TextConfig.subInformation,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessPage(reportData: data)));
                        },
                        child: const Text(
                          "Lihat Detail →",
                          style: TextConfig.seeDetailHomePage
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
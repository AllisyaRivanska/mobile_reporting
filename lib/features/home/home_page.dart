import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/features/home/cubit/home_bloc.dart';
import 'package:mobile_reporting/features/reporting/presentation/detail_page.dart';
// import 'package:mobile_reporting/features/home/cubit/home_state.dart';
// import 'package:mobile_reporting/features/home/model/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFakeCard = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().getHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      style: TextConfig.headerHomePage,
                    ),
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
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.yellow,
                size: 28,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white30,
                backgroundImage: AssetImage('assets/icons/logo-unpam.png'),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/icons/logo-unpam.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),

          Builder(
            builder: (context) {
              if (showFakeCard) {
                return _buildReportCard();
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
        ],
      ),
    );
  }

  Widget _buildReportCard() {
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const DetailPage()));
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
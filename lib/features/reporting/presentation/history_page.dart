import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
// import 'package:mobile_reporting/constant/text_config/text_config.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = false; 

    return Scaffold(
      backgroundColor: ColorConstant.lightBlue,
      body: Column(
        children: [
          CustomBackHeader(title: 'Riwayat Laporan', backIcon: false),
          
          Expanded(
            child: isEmpty 
      ? _buildEmptyState() 
      : _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3, 
      itemBuilder: (context, index) {
        List<String> statuses = ['Pending', 'Proses', 'Selesai'];
        List<Color> statusColors = [Colors.orangeAccent, Colors.blue.shade900, Colors.green];

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey,
          width: 1)),

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AC kelas 920 gedung B mati',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('17 Jan 2026', style: TextConfig.subInformation),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColors[index],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        statuses[index],
                        style: TextConfig.status
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/emp.svg', width: 200), 
            const SizedBox(height: 20),
            const Text(
              'Riwayat Laporan kosong',
              style: TextConfig.textIcon,
            ),
            const SizedBox(height: 8),
            const Text(
              'Laporan yang kamu buat akan \nmuncul di sini beserta \nstatus dan detailnya.',
              textAlign: TextAlign.center,
              style: TextConfig.subTextIcon
            ),
          ],
        ),
      ),
    );
  }
}
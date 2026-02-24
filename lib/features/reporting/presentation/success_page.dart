import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/bottom_bar/bottom_main.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';

class SuccessPage extends StatefulWidget {
  final Data reportData;
  final bool showBanner;

  const SuccessPage({super.key, required this.reportData, this.showBanner = false});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool _showSuccessBanner = true;

  @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 6), () {
    if (mounted) {
      setState(() {
        _showSuccessBanner = false;
      });
    }
  });
}

  @override
  Widget build(BuildContext context) {
    final report = widget.reportData;
    final judul = report.title ?? 'Tanpa Judul';
    final deskripsiLengkap = report.deskripsi ?? 'Tanpa Deskripsi';

    return Scaffold(
      backgroundColor: ColorConstant.lightBlue,
      body: Column(
        children: [
          const CustomBackHeader(title: 'Detail Laporan', backIcon: false),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (widget.showBanner && _showSuccessBanner) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorConstant.lightGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: ColorConstant.emeraldGreen, size: 30),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Laporan Berhasil dikirim", 
                                style: TextConfig.textTitle,),
                              Text("Admin akan menindak lanjuti laporanmu", 
                                style: TextConfig.snackBarSubMessage),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ],

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: BoxBorder.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(judul, style: TextConfig.textTitle),
                        const SizedBox(height: 8),
                        Text("Kategori : ${report.kategori}", style: TextConfig.labelIcon),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text("Status : ", style: TextConfig.labelIcon),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(report.status ?? "Proses", style: TextConfig.status),
                            ),
                          ],
                        ),
                        const Divider(height: 30),
                        Text("Tanggal : ${report.createdAt}", style: TextConfig.labelIcon),
                        const Divider(height: 30),
                        const SizedBox(height: 5),
                        Text(deskripsiLengkap, style: TextConfig.descriptionCard),
                        const SizedBox(height: 16),
                        
                        if (widget.reportData.fotoUrl != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(widget.reportData.fotoUrl!),
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        
                        const Divider(height: 40),
                        const Text("Riwayat pembaruan", style: TextConfig.information),
                        const SizedBox(height: 12),
                        
                        _buildTimelineItem("15 Jan 2026", "Laporan Dibuat", isLast: false,),
                        _buildTimelineItem(report.createdAt ?? "17 Jan 2026", "Laporan Sedang Diproses", isLast: true, color: ColorConstant.mediumYellow),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomMain()),
                          (route) => false,
                        );
                      },
                      child: const Text("Kembali ke beranda", style: TextConfig.textButton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String date, String label, {required bool isLast, Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.circle, size: 8, color: color ?? ColorConstant.primaryColor,),
            if (!isLast)
              Container(width: 1, height: 20, color: Colors.grey.shade400),
          ],
        ),
        const SizedBox(width: 12),
        Text("$date   $label", style: TextConfig.subInformation),
      ],
    );
  }
}
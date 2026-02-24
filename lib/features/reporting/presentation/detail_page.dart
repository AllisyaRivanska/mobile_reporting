import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';

class DetailPage extends StatefulWidget {
  final Data reportData;
  const DetailPage({super.key, required this.reportData});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final String deskripsiLengkap = widget.reportData.deskripsi?.split('\n').last ?? "";

    return Scaffold(
      backgroundColor: ColorConstant.lightBlue,
      body: Column(
        children: [
          const CustomBackHeader(title: 'Detail Laporan'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                        Text(
                          " ${widget.reportData.title}", style: TextConfig.textTitle,
                        ),
                        const SizedBox(height: 8),

                        _buildInfoRow("Kategori", widget.reportData.kategori ?? "-"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text("Status : ", style: TextConfig.labelIcon),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B5B8A),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(widget.reportData.status ?? "Proses", style: TextConfig.status,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 30),

                        Text(
                          "Tanggal : ${widget.reportData.createdAt}",
                          style: TextConfig.labelIcon,
                        ),
                        const Divider(height: 30),
                        Text(
                          deskripsiLengkap,
                          style: TextConfig.descriptionCard,
                        ),
                        const SizedBox(height: 16),

                        if(widget.reportData.fotoUrl != null)

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

                        const Text(
                          "Riwayat pembaruan",
                          style: TextConfig.information,
                        ),
                        const SizedBox(height: 12),
                        _buildTimelineItem("15 Jan 2026", "Laporan Dibuat", isLast: false, color: Colors.orange),
                        _buildTimelineItem("17 Jan 2026", "Laporan Sedang Diproses", isLast: true, color: Colors.blue),
                      ],
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text("$label :", style: TextConfig.labelIcon),
        Text(value, style: TextConfig.labelIcon),
      ],
    );
  }

  Widget _buildTimelineItem(String date, String status, {required bool isLast, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.circle, size: 10, color: color),
            if (!isLast)
              Container(
                width: 1.5,
                height: 20,
                color: Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 12),
        Text(
          "$date  $status ",
          style: TextConfig.labelIcon,
        ),
        Text(
          status,
          style: TextConfig.labelIcon,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
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
                        const Text(
                          "AC kelas 920 gedung B mati",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        _buildInfoRow("Kategori :", "Fasilitas Kampus"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text("Status : ", style: TextStyle(fontSize: 13)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B5B8A),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "Proses",
                                style: TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 30),

                        const Text(
                          "Tanggal : 17 Jan 2026",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        const Divider(height: 30),

                        const Text(
                          "AC di kelas 920 gedung B tidak berfungsi nih ngab, Tolong di cek dan ditindak yaa soalnya kita sekelas udah kayak deket matahari. Terima kasih.",
                          style: TextStyle(fontSize: 13, height: 1.5),
                        ),
                        const SizedBox(height: 16),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/victor.png', 
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 150,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                          ),
                        ),
                        const Divider(height: 40),

                        const Text(
                          "Riwayat pembaruan",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
        Text("$label ", style: const TextStyle(fontSize: 13)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
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
          "$date   ",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        Text(
          status,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
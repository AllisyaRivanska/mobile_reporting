import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.lightBlue,
        body: Column(
        children: [const CustomBackHeader(title: 'Notifikasi'),

        Expanded(
          child:  SingleChildScrollView(
            padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                     'Terbaru',
                        style: TextConfig.notificationStatus,
                        ),
                        
                        const SizedBox(height: 12),

            _buildNotificationCard(
              title: 'Info Status',
              subtitle: 'Laporan anda pada tanggal 17 januari...',
              icon: Icons.work_history_rounded,
              iconColor:ColorConstant.darkBlue,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              title: 'Info Status',
              subtitle: 'Laporan anda pada tanggal 17 januari...',
              icon: Icons.work_history_rounded,
              iconColor: ColorConstant.darkBlue,
            ),

            const SizedBox(height: 25),
            const Text(
              '2 hari lalu',
              style: TextConfig.notificationStatus,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              title: 'Info Laporan',
              subtitle: 'Laporan anda telah terselesaikan oleh...',
              icon: Icons.assignment_turned_in_rounded,
              iconColor: ColorConstant.darkBlue,
            ),
          ],
        ),
      ),
    ),
  ],
),
);
}
  Widget _buildNotificationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:ColorConstant.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextConfig.notificationTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextConfig.notificationSubtitle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
import 'package:mobile_reporting/features/reporting/cubit/reporting_bloc.dart';
import 'package:mobile_reporting/features/reporting/cubit/reporting_state.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';
import 'package:mobile_reporting/features/reporting/presentation/success_page.dart';

class HistoryPage extends StatefulWidget {
const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstant.lightBlue,
      body: Column(
        children: [
          CustomBackHeader(title: 'Riwayat Laporan', backIcon: false),
          
          Expanded(
            child: BlocBuilder<ReportingBloc, ReportingState>(builder: (context, state) {
              if (state is ReportingFetchSuccess) {
                final listLaporan = state.reporting;

                if (listLaporan.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildHistoryList(listLaporan);
              }
              if (state is ReportingLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return _buildEmptyState();
            }
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildHistoryList(List<Data> listLaporan) {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: listLaporan.length,
    itemBuilder: (context, index) {
      final item = listLaporan[index];

      Color statusColor;
      switch (item.status?.toLowerCase()) {
        case 'pending': statusColor = ColorConstant.mediumYellow;
          break;
        case 'proses': statusColor = ColorConstant.primaryColor;
          break;
        case 'selesai': statusColor = ColorConstant.darkGreen;
          break;
        default:
          statusColor = Colors.grey;
      }

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SuccessPage(reportData: item)),
          );
        },
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? "Tanpa Judul", 
                  style: TextConfig.textTitle,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.createdAt ?? "-", 
                      style: TextConfig.subInformation
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor, 
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        item.status ?? "Pending",
                        style: TextConfig.status,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
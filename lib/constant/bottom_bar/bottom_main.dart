import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/features/home/home_page.dart';
import 'package:mobile_reporting/features/reporting/presentation/history_page.dart';
import 'package:mobile_reporting/features/reporting/presentation/reporting_page.dart';

class BottomMain extends StatefulWidget {
  const BottomMain({super.key});

  @override
  State<BottomMain> createState() => _BottomMainState();
}


class _BottomMainState extends State<BottomMain> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const ReportingPage(),
  ];

  void _onTapSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: SizedBox(
        height: 80,
        width: 85,
        child: FloatingActionButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportingPage()));},
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          child: SvgPicture.asset('assets/icons/icon_add.svg'),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: SizedBox(
          height: 85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            _buildNavItem(
              index: 0,
              icon: SvgPicture.asset('assets/icons/icon-home-new.svg', width: 26, height: 26,),
              label: 'Beranda', style: TextConfig.labelBoldSmall,
              isSelected: _currentIndex == 0,
            ),
             _buildNavItem(
              index: 1,
              icon: Icon(Icons.history, size: 26), 
              label: 'Riwayat', style: TextConfig.labelIcon,
              isSelected: _currentIndex == 1),
            ],
          ),
        ),
      ),
    );
    
  }
  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
    required bool isSelected, 
    required TextStyle style,
  }) {
    return GestureDetector(
      onTap: () => _onTapSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: const Color.fromARGB(255, 218, 224, 236),
                      borderRadius: BorderRadius.circular(20),
                    )
                  : null,
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: isSelected 
                 ? TextConfig.labelIcon
                 : TextConfig.labelIcon2,),
            ],
            ),
        ),
      ); 
  }
}


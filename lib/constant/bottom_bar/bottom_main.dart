import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/features/home/home_page.dart';

class BottomMain extends StatefulWidget {
  const BottomMain({super.key});

  @override
  State<BottomMain> createState() => _BottomMainState();
}

class _BottomMainState extends State<BottomMain> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Riwayat')),
    // const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: SizedBox(
        height: 80,
        width: 85,
        child: FloatingActionButton(
          onPressed: () {},
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
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () => setState(() => _currentIndex = 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon_home.svg',
                      width: 23,
                      height: 26,
                    ),
                    Text(
                      'Beranda',
                      style: TextStyle(
                        color: Color.fromARGB(255, 74, 173, 235),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () => setState(() => _currentIndex = 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      color: _currentIndex == 1
                          ? const Color(0xFF37474F)
                          : Colors.grey,
                    ),
                    Text(
                      "Riwayat",
                      style: TextStyle(
                        color: _currentIndex == 1
                            ? const Color(0xFF37474F)
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

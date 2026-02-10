import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/features/home/home_page.dart';
import 'package:mobile_reporting/features/reporting/presentation/reporting_page.dart';
import 'package:mobile_reporting/helper/responsive_helper.dart';

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
    const ReportingPage(),
  ];

  void _onTapSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: _pages[_currentIndex],

      bottomNavigationBar: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: responsive.navBarHeight,
              child: ClipPath(
                clipper: BottomNavClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorConstant.creamCard,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildNavItem(
                          index: 0,
                          icon: SvgPicture.asset(
                            'assets/icons/icon-home-new.svg',
                            width: responsive.navIconSize,
                            height: responsive.navIconSize,
                            colorFilter: _currentIndex == 0
                                ? const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  )
                                : const ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.srcIn,
                                  ),
                          ),
                          label: 'Beranda',
                          isSelected: _currentIndex == 0,
                        ),
                      ),
                      SizedBox(width: responsive.navFabSize + 20),
                      Expanded(
                        child: _buildNavItem(
                          index: 1,
                          icon: Icon(
                            Icons.history,
                            size: responsive.navIconSize,
                            color: _currentIndex == 1
                                ? Colors.white
                                : Colors.grey,
                          ),
                          label: 'Riwayat',
                          isSelected: _currentIndex == 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: responsive.navFabTopOffset,
              left: MediaQuery.of(context).size.width / 2 - (responsive.navFabSize / 2),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportingPage(),
                    ),
                  );
                },
                child: Container(
                  width: responsive.navFabSize,
                  height: responsive.navFabSize,
                  decoration: const BoxDecoration(
                    color: ColorConstant.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/icon_add.svg',
                      width: responsive.navFabIconSize,
                      height: responsive.navFabIconSize,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
    required bool isSelected,
  }) {
    final responsive = context.responsive;
    
    return GestureDetector(
      onTap: () => _onTapSelected(index),
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(responsive.navItemPadding),
              decoration: isSelected
                  ? BoxDecoration(
                      color: ColorConstant.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    )
                  : null,
              child: icon,
            ),
            Text(
              label,
              style: (isSelected ? TextConfig.labelIcon : TextConfig.labelIcon2).copyWith(
                fontSize: responsive.extraSmallText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double w = size.width;
    double h = size.height;

    path.lineTo(0, 0);

    path.lineTo(w * 0.35, 0);

    path.quadraticBezierTo(w * 0.40, 0, w * 0.40, 20);

    path.arcToPoint(
      Offset(w * 0.60, 20),
      radius: const Radius.circular(30),
      clockwise: false,
    );

    path.quadraticBezierTo(w * 0.60, 0, w * 0.65, 0);

    path.lineTo(w, 0);

    path.lineTo(w, h);

    path.lineTo(0, h);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
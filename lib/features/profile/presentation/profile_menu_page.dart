import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_reporting/features/profile/presentation/change_password_page.dart';
import 'package:mobile_reporting/features/profile/presentation/help_support_page.dart';
import 'package:mobile_reporting/features/profile/presentation/profile_page.dart';
import 'package:mobile_reporting/features/login/presentation/login_page.dart'; 
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  final String name = 'Mahasiswa Gothic';
  final String nim = '1234567890';

void _showLogoutDialog() {
  showDialog(
    context: context,
    barrierColor: ColorConstant.backgroundTransparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Konfirmasi Keluar",
                    style: TextConfig.alertMessage,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Apakah anda yakin ingin keluar dari akun ini?",
                    style: TextConfig.alertSubMessage,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Batal",
                            style: TextConfig.alertButton,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.warningButton,
                          ),
                          child: const Text(
                            "Keluar",
                            style: TextConfig.alertWhiteButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
              top: -27,
              child: Icon(
                Icons.warning_rounded,
                color: Colors.orange,
                size: 65,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.creamCard,
    body: Column(
      children: [
        const CustomBackHeader(title: 'Profil'),

      Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/logo-unpam.png'),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextConfig.profileData,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          nim,
                          style: TextConfig.inputHint,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.account_circle_outlined,
                    title: 'Profil Saya',
                    onTap: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (_) => const ProfilePage())),
                  ),
                  const Divider(height: 1, indent: 60),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Ganti Password',
                    onTap: () => Navigator.push(context,
                     MaterialPageRoute(builder: (_) => const ChangePasswordPage())),
                  ),
                  const Divider(height: 1, indent: 60),
                  _buildMenuItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Bantuan & Dukungan',
                    onTap: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (_) => const HelpSupportPage())),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: _showLogoutDialog, 
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.logout, color: Colors.red),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Keluar Akun',
                      style: TextConfig.logoutButton,
                    ),
                  ],
                ),
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorConstant.creamCard,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: ColorConstant.primaryColor),
      ),
      title: Text(
        title,
        style: TextConfig.logoutButton,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: ColorConstant.primaryColor),
      onTap: onTap,
    );
  }
}
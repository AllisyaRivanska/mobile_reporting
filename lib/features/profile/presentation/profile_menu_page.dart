import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/features/profile/presentation/change_password_page.dart';
import 'package:mobile_reporting/features/profile/presentation/help_support_page.dart';
import 'package:mobile_reporting/features/profile/presentation/profile_page.dart';
class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({super.key});

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  // Dummy duls 
  final String name = 'Mahasiswa Gothic';
  final String nim = '1234567890';
  final String photoUrl = 'https://i.pravatar.cc/150?img=3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.transparent),
          ),

          Positioned(
            top: 80,
            right: 16,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -7,
                  right: 24,
                  child: Transform.rotate(
                    angle: 0.785398, // 45°
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 280,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(photoUrl),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        nim,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 16),

                      _menuItem(
                        icon: Icons.person,
                        text: 'Profil Saya',
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => const ProfilePage(),
                          ));
                        },
                      ),
                      _menuItem(
                        icon: Icons.lock,
                        text: 'Ganti Password',
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => const ChangePasswordPage(),
                          ));
                        },
                      ),
                      _menuItem(
                        icon: Icons.help,
                        text: 'Bantuan & Dukungan',
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => const HelpSupportPage(),
                          ));
                        },
                      ),
                      _menuItem(
                        icon: Icons.logout,
                        text: 'Log Out',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorConstant.primaryColor),
      title: Text(text),
      onTap: onTap,
    );
  }
}

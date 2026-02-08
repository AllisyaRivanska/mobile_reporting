import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';

class CustomBackHeader extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;

  const CustomBackHeader({
    super.key,
    this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: ColorConstant.primaryColor,
      child: SafeArea(
        child: Row(
      children: [
        GestureDetector(
          onTap: onBack ?? () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.white, fontWeight: FontWeight.bold,),
        ),
        const SizedBox(width: 55),
        Text(
          title ?? '',
          style: TextConfig.titleHeader,
        ),
      ],
        ),
      ),
    );
  }
}
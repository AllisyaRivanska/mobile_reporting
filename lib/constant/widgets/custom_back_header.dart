import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';

class CustomBackHeader extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final bool backIcon;

  const CustomBackHeader({
    super.key,
    this.title,
    this.onBack,
    this.backIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight + 12,
        bottom: 12,
        left: 16,
        right: 16,
      ),
      color: ColorConstant.primaryColor,
      child: Row(
        children: [
          if (backIcon) ...[
            GestureDetector(
            onTap: onBack ?? () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          ],
      Expanded(
      child: Text(
        title ?? '',
        style: TextConfig.titleHeader,
        textAlign: backIcon ? TextAlign.left : TextAlign.left,
      ),
      ),
      ],
      ),
    );
  }
}
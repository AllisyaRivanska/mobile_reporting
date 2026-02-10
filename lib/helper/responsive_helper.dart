import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  late final double screenWidth;
  late final double screenHeight;
  late final bool isSmallScreen;
  late final bool isMediumScreen;
  late final bool isLargeScreen;
  late final bool isExtraLargeScreen;

  ResponsiveHelper(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    
    isSmallScreen = screenWidth < 360;
    isMediumScreen = screenWidth >= 360 && screenWidth < 400;
    isLargeScreen = screenWidth >= 400 && screenWidth < 600;
    isExtraLargeScreen = screenWidth >= 600;
  }

  
  double get horizontalPadding => isSmallScreen ? 12.0 : 16.0;
  
  double get verticalSpacing => isSmallScreen ? 12.0 : 16.0;
  
  double get smallSpacing => isSmallScreen ? 6.0 : 8.0;
  
  double get largeSpacing => isSmallScreen ? 20.0 : 24.0;
  
  double get extraLargeSpacing => isSmallScreen ? 24.0 : 32.0;

  
  double get extraSmallText => isSmallScreen ? 10.0 : 12.0;
  
  double get smallText => isSmallScreen ? 12.0 : 14.0;
  
  double get standardText => isSmallScreen ? 14.0 : 16.0;
  
  double get largeText => isSmallScreen ? 16.0 : 18.0;
  
  double get extraLargeText => isSmallScreen ? 18.0 : 20.0;
  
  double get titleText => isSmallScreen ? 20.0 : 24.0;
  
  double get massiveText => isSmallScreen ? 32.0 : (isMediumScreen ? 36.0 : 42.0);

  
  double get smallIcon => isSmallScreen ? 16.0 : 20.0;
  
  double get standardIcon => isSmallScreen ? 20.0 : 24.0;
  
  double get largeIcon => isSmallScreen ? 28.0 : 32.0;
  
  double get extraLargeIcon => isSmallScreen ? 40.0 : 50.0;

  // Bottom Navigation Bar specific sizes
  double get navBarHeight => isSmallScreen ? 75.0 : (isMediumScreen ? 80.0 : 85.0);
  
  double get navIconSize => isSmallScreen ? 26.0 : (isMediumScreen ? 30.0 : 32.0);
  
  double get navFabSize => isSmallScreen ? 60.0 : 65.0;
  
  double get navFabIconSize => isSmallScreen ? 24.0 : 28.0;
  
  double get navFabBadgeSize => isSmallScreen ? 14.0 : 16.0;
  
  double get navItemPadding => isSmallScreen ? 8.0 : (isMediumScreen ? 10.0 : 12.0);
  
  double get navItemPaddingTop => isSmallScreen ? 10.0 : (isMediumScreen ? 12.0 : 14.0);
  
  double get navItemPaddingBottom => isSmallScreen ? 8.0 : (isMediumScreen ? 9.0 : 10.0);
  
  double get navFabTopOffset => isSmallScreen ? -20.0 : -22.0;

  
  double get smallAvatarRadius => isSmallScreen ? 16.0 : 18.0;
  
  double get standardAvatarRadius => isSmallScreen ? 18.0 : 20.0;
  
  double get largeAvatarRadius => isSmallScreen ? 25.0 : 30.0;
  
  double get extraLargeAvatarRadius => isSmallScreen ? 40.0 : 50.0;

  
  double get buttonPaddingVertical => isSmallScreen ? 10.0 : 14.0;
  
  double get buttonPaddingHorizontal => isSmallScreen ? 16.0 : 20.0;
  
  double get smallButtonPaddingVertical => isSmallScreen ? 6.0 : 8.0;
  
  double get smallButtonPaddingHorizontal => isSmallScreen ? 12.0 : 16.0;

  
  double get borderRadius => 12.0;
  
  double get largeBorderRadius => 20.0;
  
  double get cardPadding => isSmallScreen ? 12.0 : 16.0;
  
  double get largeCardPadding => isSmallScreen ? 16.0 : 24.0;

  
  double get clockCircleSize => isSmallScreen ? 65.0 : (isMediumScreen ? 70.0 : 80.0);
  
  double circleSize(double small, double medium, double large) {
    if (isSmallScreen) return small;
    if (isMediumScreen) return medium;
    return large;
  }

  
  double get dialogMaxWidth => screenWidth * 0.9;
  
  double get dialogMaxHeight => screenHeight * 0.8;
  
  double get dialogPadding => isSmallScreen ? 16.0 : 20.0;

  
  double scale(double baseSize) {
    if (isSmallScreen) return baseSize * 0.85;
    if (isMediumScreen) return baseSize * 0.95;
    return baseSize;
  }
  
  double getSize({
    required double small,
    required double medium,
    required double large,
    double? extraLarge,
  }) {
    if (isSmallScreen) return small;
    if (isMediumScreen) return medium;
    if (isExtraLargeScreen && extraLarge != null) return extraLarge;
    return large;
  }
  
  double widthPercentage(double percentage) {
    return screenWidth * (percentage / 100);
  }
  
  double heightPercentage(double percentage) {
    return screenHeight * (percentage / 100);
  }

  
  TextStyle textStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontSize: scale(fontSize),
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}

extension ResponsiveContext on BuildContext {
  ResponsiveHelper get responsive => ResponsiveHelper(this);
}


class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? customPadding;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.customPadding,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Padding(
      padding: customPadding ?? EdgeInsets.all(responsive.horizontalPadding),
      child: child,
    );
  }
}

class ResponsiveSpacing extends StatelessWidget {
  final bool isHorizontal;
  final SpacingType type;

  const ResponsiveSpacing({
    super.key,
    this.isHorizontal = false,
    this.type = SpacingType.standard,
  });

  const ResponsiveSpacing.horizontal({
    super.key,
    this.type = SpacingType.standard,
  })  : isHorizontal = true;

  const ResponsiveSpacing.vertical({
    super.key,
    this.type = SpacingType.standard,
  })  : isHorizontal = false;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    double spacing;

    switch (type) {
      case SpacingType.small:
        spacing = responsive.smallSpacing;
        break;
      case SpacingType.standard:
        spacing = responsive.verticalSpacing;
        break;
      case SpacingType.large:
        spacing = responsive.largeSpacing;
        break;
      case SpacingType.extraLarge:
        spacing = responsive.extraLargeSpacing;
        break;
    }

    return SizedBox(
      width: isHorizontal ? spacing : null,
      height: !isHorizontal ? spacing : null,
    );
  }
}

enum SpacingType { small, standard, large, extraLarge }

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextSizeType sizeType;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    this.sizeType = TextSizeType.standard,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    double fontSize;

    switch (sizeType) {
      case TextSizeType.extraSmall:
        fontSize = responsive.extraSmallText;
        break;
      case TextSizeType.small:
        fontSize = responsive.smallText;
        break;
      case TextSizeType.standard:
        fontSize = responsive.standardText;
        break;
      case TextSizeType.large:
        fontSize = responsive.largeText;
        break;
      case TextSizeType.extraLarge:
        fontSize = responsive.extraLargeText;
        break;
      case TextSizeType.title:
        fontSize = responsive.titleText;
        break;
      case TextSizeType.massive:
        fontSize = responsive.massiveText;
        break;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum TextSizeType {
  extraSmall,
  small,
  standard,
  large,
  extraLarge,
  title,
  massive
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    
    return Container(
    width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(responsive.cardPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          borderRadius ?? responsive.borderRadius,
        ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}

class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final bool isSmall;
  final IconData? icon;

  const ResponsiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
    this.isSmall = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    
    final padding = EdgeInsets.symmetric(
      vertical: isSmall
          ? responsive.smallButtonPaddingVertical
          : responsive.buttonPaddingVertical,
      horizontal: isSmall
          ? responsive.smallButtonPaddingHorizontal
          : responsive.buttonPaddingHorizontal,
    );

    final textStyle = TextStyle(
      fontSize: isSmall ? responsive.smallText : responsive.standardText,
      fontWeight: FontWeight.w600,
      color: textColor ?? (isOutlined ? Colors.grey.shade700 : Colors.white),
    );

    Widget buttonContent = Text(text, style: textStyle);
    
    if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: responsive.standardIcon,
            color: textColor ?? (isOutlined ? Colors.grey.shade700 : Colors.white),
          ),
          SizedBox(width: responsive.smallSpacing),
          Text(text, style: textStyle),
        ],
      );
    }

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          side: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.borderRadius),
          ),
        ),
        child: buttonContent,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.borderRadius),
        ),
        elevation: 0,
      ),
      child: buttonContent,
    );
  }
}
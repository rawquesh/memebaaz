// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  final Widget? child;
  final double? height;
  final double? width;
  final double? radius;
  const CustomButton({
    required this.onTap,
    Key? key,
    this.text,
    this.height = 140,
    this.radius = 10.0,
    this.child,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          elevation: 1,
          textStyle: ptSansFont(),
          backgroundColor: themeColor,
          side: const BorderSide(width: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
        ),
        onPressed: onTap,
        child: child ?? Text(text!, textAlign: TextAlign.center, style: ptSansFont().copyWith(color: Colors.white)),
      ),
    );
  }
}

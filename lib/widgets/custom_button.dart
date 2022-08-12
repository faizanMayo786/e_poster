import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final Color btnColor;
  final Color onPrimaryColor;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.btnText,
    this.btnColor = Colors.blue,
    this.onPrimaryColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          onPrimary: onPrimaryColor,
          minimumSize: Size(width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

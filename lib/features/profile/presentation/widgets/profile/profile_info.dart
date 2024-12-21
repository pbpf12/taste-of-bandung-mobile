part of '../_widgets.dart';
class ProfileInfo extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;

  const ProfileInfo({
    super.key, required this.text, 
    required this.fontWeight,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text != "" ? text : "Not Provided",
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProdetailScreen extends StatefulWidget {
  const ProdetailScreen({
    required this.dihsId,
    super.key
  });

  final int dihsId;

  @override
  State<ProdetailScreen> createState() => _ProdetailScreenState();
}

class _ProdetailScreenState extends State<ProdetailScreen> {
  late int dishId;

  @override
  void initState() {
    dishId = widget.dihsId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
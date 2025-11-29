import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common_widgets/appbar_widget.dart';

class DemoHomeScreen extends StatefulWidget {
  const DemoHomeScreen({required this.title, super.key});

  final String? title;

  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.title,
        icons: [AppbarIcon(iconData: FontAwesomeIcons.ellipsisVertical, onPressed: null)],
      ),
      body: Container(),
    );
  }
}

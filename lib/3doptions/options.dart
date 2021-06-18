import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 4,
      color: Colors.white,
      child: Column(
        // ignore: prefer_const_constructors
        // ignore: prefer_const_literals_to_create_immutables
        children: [Text("Share"), Text("Like"), Text("USer")],
      ),
    );
  }
}

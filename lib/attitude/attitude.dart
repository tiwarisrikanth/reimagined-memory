import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AttitudePage extends StatefulWidget {
  const AttitudePage({Key? key}) : super(key: key);

  @override
  _AttitudePageState createState() => _AttitudePageState();
}

class _AttitudePageState extends State<AttitudePage> {
  Future getGeneralData() async {
    final response = await http.get(
      Uri.parse(
        "https://goquotes-api.herokuapp.com/api/v1/all?type=tag&val=attitude",
      ),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['quotes'];
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body);
    } else if (response.statusCode == 412) {
      Fluttertoast.showToast(msg: response.body);
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(msg: response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder(
          future: getGeneralData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              // ignore: curly_braces_in_flow_control_structures
              return const Center(
                // ignore: unnecessary_const
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            // ignore: avoid_unnecessary_containers
            return Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // ignore: prefer_const_constructors
                        margin: EdgeInsets.only(left: 10),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      Spacer(),
                      Container(
                        // ignore: prefer_const_constructors
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        // ignore: prefer_const_constructors
                        child: Text("Attitude Catagory",
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                      Container(
                        // ignore: prefer_const_constructors
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          // ignore: prefer_const_constructors
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(
                      snapshot.data.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            // ignore: prefer_const_constructors
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 15.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        // ignore: prefer_const_constructors
                        margin: EdgeInsets.all(20),
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data[index]['text'],
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child: Container(
                                //     margin: EdgeInsets.only(top: 10),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       children: [
                                //         Container(
                                //           margin: EdgeInsets.only(left: 10),
                                //           child: IconButton(
                                //             onPressed: () {
                                //               Navigator.pop(context);
                                //             },
                                //             icon: Icon(Icons.share),
                                //           ),
                                //         ),
                                //         Container(
                                //           margin: EdgeInsets.only(left: 10),
                                //           child: IconButton(
                                //             onPressed: () {
                                //               Navigator.pop(context);
                                //             },
                                //             icon: Icon(Icons.favorite),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}

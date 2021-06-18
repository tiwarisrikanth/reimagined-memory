import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes/3doptions/options.dart';
import 'package:quotes/attitude/attitude.dart';
import 'package:quotes/beauty/beauty.dart';
import 'package:quotes/best/best.dart';
import 'package:quotes/general/general.dart';
import 'package:quotes/marriage/marriage.dart';
import 'package:quotes/medical/medical.dart';
import 'package:quotes/men/men.dart';
import 'package:quotes/mom/mom.dart';
import 'package:quotes/money/money.dart';
import 'package:quotes/morning/morning.dart';
import 'package:quotes/motivational/motivational.dart';
import 'package:quotes/movies/movies.dart';
import 'package:quotes/music/music.dart';
import 'package:quotes/nature/nature.dart';
import 'package:quotes/parenting/parenting.dart';
import 'package:quotes/patience/patience.dart';
import 'package:quotes/patriotism/patriotism.dart';
import 'package:quotes/peace/peace.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future getData() async {
      final response = await http.get(
        Uri.parse(
          "https://goquotes-api.herokuapp.com/api/v1/random/1?type=tag&val=peace",
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

    return Scaffold(
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: SingleChildScrollView(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Column(
                children: [
                  // Container(
                  //   height: MediaQuery.of(context).size.height / 12,
                  //   width: MediaQuery.of(context).size.width,
                  //   // ignore: prefer_const_constructors
                  //   decoration: BoxDecoration(
                  //     // ignore: prefer_const_constructors
                  //     borderRadius: BorderRadius.only(
                  //         // ignore: prefer_const_constructors
                  //         bottomLeft: Radius.circular(20),
                  //         // ignore: prefer_const_constructors
                  //         bottomRight: Radius.circular(20)),
                  //     color: Colors.white,
                  //     // ignore: prefer_const_literals_to_create_immutables
                  //     boxShadow: [
                  //       // ignore: prefer_const_constructors
                  //       BoxShadow(
                  //         color: Colors.grey.shade400,
                  //         offset: const Offset(
                  //           1.0,
                  //           1.0,
                  //         ),
                  //         blurRadius: 25.0,
                  //         spreadRadius: 0.5,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      // ignore: prefer_const_constructors
                      margin: EdgeInsets.only(top: 30, left: 20, bottom: 20),
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Quote of the day",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onLongPress: () {
                      Share.share('Hello,\nWelcome to Orange power...');
                    },
                    // onTap: () {
                    //   showModalBottomSheet<Null>(
                    //     context: context,
                    //     builder: (BuildContext context) =>
                    //         openBottomOTPDrawer(),
                    //   );
                    // },
                    child: Container(
                      // ignore: prefer_const_constructors
                      margin: EdgeInsets.all(20),
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
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Center(
                        child: FutureBuilder(
                          future: getData(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData)
                              // ignore: curly_braces_in_flow_control_structures
                              return const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              );
                            // ignore: avoid_unnecessary_containers
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  snapshot.data.length,
                                  (index) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            // ignore: prefer_const_constructors
                                            EdgeInsets.only(
                                                left: 20, right: 20),
                                        child: Text(
                                          snapshot.data[index]['text'],
                                          textAlign: TextAlign.center,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          // ignore: prefer_const_constructors
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 10),
                                          child: Text(
                                            "--" +
                                                snapshot.data[index]['author'],
                                            textAlign: TextAlign.end,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      // ignore: prefer_const_constructors
                      margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Catagories",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => GeneralPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("General"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => AttitudePage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Attitude"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => BeautyPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Beauty"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => BestPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Best"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MarriagePage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Marriage"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MedicalPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Medical"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MenPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Men"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MomPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Mom"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MoneyPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Money"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MorningPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Morning"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MotivationalPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Motivational"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MoviesPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            child: const Text("Movies"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => MusicPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            child: const Text("Music"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => NaturePage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Nature"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => ParentingPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Parenting"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => PatiencePage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("Patience"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => PatriotismPage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("patriotism"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            // ignore: unnecessary_new
                            new MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => PeacePage(),
                            ),
                          );
                        },
                        child: Container(
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
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2.5,
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text("peace"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // openBottomOTPDrawer() {
  //   return SingleChildScrollView(
  //     child: Container(
  //         margin:
  //             const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 260),
  //         height: 200,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(15)),
  //             boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 5)]),
  //         child: Options()),
  //   );
  // }
}

// showList() {
//   // ignore: avoid_unnecessary_containers
//   return Container(
//     height: 200,
//     width: 200,
//     color: Colors.black,
//     child: Column(
//       // ignore: prefer_const_constructors
//       // ignore: prefer_const_literals_to_create_immutables
//       children: [Text("Share"), Text("Like")],
//     ),
//   );
// }
// Patience
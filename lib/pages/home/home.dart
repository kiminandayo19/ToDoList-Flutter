import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mybook/pages/tambahdata/add.dart';

class Home extends StatefulWidget {
  static String routesName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> name = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _getDataDB();
    });
  }

  Future _getDataDB() async {
    var baseURL = "http://localhost/own_lib/data_set/get.php";
    try {
      var result = await http.post(
        Uri.parse(baseURL),
      );
      if (result.statusCode == 200) {
        var val = jsonDecode(result.body);
        setState(() {
          name = val;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _delete(context) async {
    var baseURL = "http://localhost/own_lib/data_set/delete.php";
    try {
      var result = await http.post(Uri.parse(baseURL), body: {
        "id": context,
      });
      setState(() {
        _getDataDB();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name.length != 0
          ? viewDB()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Data Available",
                    style: GoogleFonts.montserrat(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  viewDB() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
            ),
            child: Text(
              "To Do List",
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: ListView.builder(
              itemCount: name.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text(
                      "=>",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      name[index]['name'],
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        _delete(name[index]['id']);
                      },
                      child: Text(
                        "Delete",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Add.routesName);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              fixedSize: const Size(50, 50),
              shadowColor: Colors.transparent,
              backgroundColor: const Color(0xFF80489C),
            ),
            child: const Icon(
              IconData(
                0xe047,
                fontFamily: 'MaterialIcons',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

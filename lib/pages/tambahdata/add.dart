import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mybook/pages/home/home.dart';

class Add extends StatefulWidget {
  static String routesName = '/add';
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  var _addKey = GlobalKey<FormState>();
  var nameController = TextEditingController();

  Future _addData() async {
    var baseURL = "http://localhost/own_lib/data_set/add.php";
    try {
      var response = await http.post(Uri.parse(baseURL), body: {
        "name": nameController.text,
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Home.routesName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Form(
          key: _addKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _inputName(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _addData();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                        120,
                        40,
                      ),
                      backgroundColor: const Color(0xFF80489C),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      )),
                  child: Text(
                    "Add Data",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _inputName() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextFormField(
        controller: nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          filled: true,
          fillColor: const Color(0XFFF4F7F8),
          hintText: "Task",
          hintStyle: GoogleFonts.montserrat(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

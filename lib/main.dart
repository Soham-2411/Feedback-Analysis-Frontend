import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'displaydetails.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:file_picker/file_picker.dart';

Future<String> getString(String path) async {
  return await rootBundle.loadString(path);
}

void main() async {
  // var response = await Dio().post('https://datax-forumpost-clustering.herokuapp.com/',)

  runApp(const MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool isClicked = false;
String filePicked = '';

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    isClicked = false;
    print("done");
  }

  void _filePicked() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      allowedExtensions: ['txt', 'xlsx', 'docx', 'pdf', 'csv'],
      type: FileType.custom,
      allowMultiple: true,
    );
    if (result != null) {
      File file = File(result.files.single.path.toString());
      setState(() {
        filePicked = file.path;
      });
    }
  }

  void clearEmptyFields(Map cluster) {
    Map<String, String> identifier = new Map();
    List clusterKeys = cluster.keys.toList();
    for (int c = 0; c < cluster.length; c++) {
      if (cluster[clusterKeys[c]].length != 0) {
        identifier.addEntries([
          MapEntry(
              clusterKeys[c].toString(), cluster[clusterKeys[c]].toString())
        ]);
      }
    }

    setState(() {
      isClicked = false;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayClusters(
                  jsonView: JsonView.map(identifier,
                      theme: JsonViewTheme(
                        keyStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        doubleStyle: TextStyle(
                          color: Colors.yellow[800],
                          fontSize: 16,
                        ),
                        intStyle: TextStyle(
                          color: Colors.yellow[800],
                          fontSize: 16,
                        ),
                        stringStyle: TextStyle(
                          color: Colors.yellow[600],
                          fontSize: 16,
                        ),
                        boolStyle: TextStyle(
                          color: Colors.yellow[800],
                          fontSize: 16,
                        ),
                        closeIcon: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                        openIcon: Icon(
                          Icons.add,
                          color: Colors.red,
                          size: 20,
                        ),
                        separator: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.arrow_right_alt_outlined,
                            size: 20,
                            color: Colors.green,
                          ),
                        ),
                      )),
                )));
  }

  void _getAnalysedFeedback(String filename) async {
    String text = await getString(filename);
    print(text);
    var response = await Dio()
        .post('https://datax-forumpost-clustering.herokuapp.com/', data: text);
    print(response.data['distribution']);
    //print(response.data['clusters']);
    clearEmptyFields(response.data['clusters']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Feedback Analyzer"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Text(
                  "Get your feedback analysed",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 50),
                Text(
                  "Use our pre-made database",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () {
                    setState(() {
                      isClicked = true;
                    });
                    _getAnalysedFeedback('assets/set0.txt');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Text(
                        "Set 0",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () {
                    setState(() {
                      isClicked = true;
                    });
                    _getAnalysedFeedback('assets/set1.txt');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Text(
                        "Set 1",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 20),
                Text(
                  "Upload your own set of data",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () async {
                    setState(() {
                      isClicked = true;
                    });
                    _filePicked();
                    setState(() {
                      isClicked = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Text(
                        "Upload",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  (filePicked == '') ? " " : filePicked,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () {
                    setState(() {
                      isClicked = true;
                    });
                    _getAnalysedFeedback('assets/set0.txt');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          (isClicked)
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                        SizedBox(height: 20),
                        Text(
                          "Loading... Please wait",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

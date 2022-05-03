import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:testapp/main.dart';

class DisplayClusters extends StatefulWidget {
  final Widget jsonView;
  const DisplayClusters({Key? key, required this.jsonView}) : super(key: key);

  @override
  State<DisplayClusters> createState() => _DisplayClustersState();
}

class _DisplayClustersState extends State<DisplayClusters> {
  void initState() {
    super.initState();
    isClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text('Analysed Feedback'),
          backgroundColor: Colors.black54,
          elevation: 2,
        ),
        body: Container(
          width: w,
          height: h,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: widget.jsonView,
              )),
        ),
      ),
    );
  }
}

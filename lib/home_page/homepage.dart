import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/common_widgets/common_text.dart';
import 'package:testflutter/service/common_function.dart';

import '../common_widgets/commoncircleavatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<CommonFunction>(context, listen: false).genarateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List App"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: h,
        width: w,
        child: ReorderableListView.builder(
          key: UniqueKey(),
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex >=
                Provider.of<CommonFunction>(context, listen: false)
                    .userDatas
                    .length) return;
            print(oldIndex);
            print(newIndex);
            setState(() {
              var reIndex = Provider.of<CommonFunction>(context, listen: false)
                  .userDatas[oldIndex];
              Provider.of<CommonFunction>(context, listen: false)
                      .userDatas[oldIndex] =
                  Provider.of<CommonFunction>(context, listen: false)
                      .userDatas[newIndex];
              Provider.of<CommonFunction>(context, listen: false)
                  .userDatas[newIndex] = reIndex;
              print("reindex $reIndex");
            });
          },
          itemCount: Provider.of<CommonFunction>(context, listen: true)
              .userDatas
              .length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(Provider.of<CommonFunction>(context, listen: true)
                  .userDatas[index]["user_id"]),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                Provider.of<CommonFunction>(context, listen: false).removeList(
                    index: index,
                    list: Provider.of<CommonFunction>(context, listen: false)
                        .userDatas);
              },
              background: Container(
                height: h * 0.1,
                width: w,
                color: Colors.redAccent,
              ),
              child: Stack(
                children: [
                  Card(
                      child: Container(
                    height: h * 0.1,
                    width: w,
                  )),
                  Positioned(
                    top: h * 0.01,
                    left: w * 0.03,
                    child: Container(
                      height: h * 0.1,
                      width: w * 0.15,
                      // color: Colors.blue,
                      padding: EdgeInsets.all(2),
                      child: CommonCircularAvatar(
                        content: CommonText(
                          text:
                              "${Provider.of<CommonFunction>(context, listen: false).userDatas[index]["user_name"].toString().substring(0, 1)}",
                          textSize: 22,
                          textWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: h * 0.02,
                    left: w * 0.2,
                    child: CommonText(
                      text:
                          "${Provider.of<CommonFunction>(context, listen: false).userDatas[index]["user_name"]}",
                      textSize: 20,
                    ),
                  ),
                  Positioned(
                    top: h * 0.02,
                    right: w * 0.05,
                    child: CommonText(
                      text: "user_id : ${index}",
                      textSize: 14,
                      textColor: Colors.teal,
                    ),
                  ),
                  Positioned(
                    bottom: h * 0.02,
                    left: w * 0.2,
                    child: CommonText(
                      text:
                          "${Provider.of<CommonFunction>(context, listen: false).userDatas[index]["phone_number"]}",
                      textSize: 14,
                      textColor: Colors.teal,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

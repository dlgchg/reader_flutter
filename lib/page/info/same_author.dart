import 'package:flutter/material.dart';
import 'package:reader/bean/info.dart';
import 'package:reader/view/same_user_item.dart';

class SameAuthorPage extends StatelessWidget {
  final List<SameUserBooksBean> sameUserBooksBeans;

  SameAuthorPage(this.sameUserBooksBeans);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("作者还写过"),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return sameAuthorBookItem(context, index, sameUserBooksBeans[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Colors.black12,
          );
        },
        itemCount: sameUserBooksBeans.length,
      ),
    );
  }
}

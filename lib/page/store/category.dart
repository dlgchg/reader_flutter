import 'package:flutter/material.dart';
import 'package:reader/bean/category.dart';
import 'package:reader/util/http_manager.dart';
import 'package:reader/view/category_item.dart';
import 'package:reader/view/load.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<MyCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    getCategoryData().then((map) {
      setState(() {
        if (map != null && map['data'].length != 0) {
          for (int i = 0; i < map['data'].length; i++) {
            _categories.add(MyCategory.fromMap(map['data'][i]));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _categories.length == 0
        ? LoadingPage()
        : Container(
            padding: EdgeInsets.all(20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1 / 1.4,
              children: _categories.map((category) {
                return categoryItem(
                    context, _categories.indexOf(category), category);
              }).toList(),
            ),
          );
//        : ListView.builder(
//            itemBuilder: (BuildContext context, int index) {
//              return categoryItem(context, index, categories[index]);
//            },
//            itemCount: categories.length,
//          );
  }

  @override
  bool get wantKeepAlive => true;
}

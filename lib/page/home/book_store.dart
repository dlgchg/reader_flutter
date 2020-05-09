import 'package:flutter/material.dart';
import 'package:reader/page/store/category.dart';
import 'package:reader/page/store/special.dart';
import 'package:reader/page/store/sex_rec.dart';
import 'package:reader/util/constants.dart';

class BookStorePage extends StatefulWidget {
  @override
  _BookStorePageState createState() => _BookStorePageState();
}

class _BookStorePageState extends State<BookStorePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<String> _tabTitles = ["男生", "女生", "分类", "专题"];

  @override
  void initState() {
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            controller: _tabController,
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(MyIcons.searchIcon),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SexRecPage("man"),
          SexRecPage("lady"),
          CategoryPage(),
          SpecialPage(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:reader/page/home/book_rank.dart';
import 'package:reader/page/home/book_shelf.dart';
import 'package:reader/page/home/book_store.dart';
import 'package:reader/util/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey<BookShelfPageState> key = GlobalKey<BookShelfPageState>();
  var _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<Widget> _pages;
  PageController _pageController;
  var title = ["我的书架", "书架", "排行榜", "发现"];

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: '书架',
        iconData: MyIcons.shelfIcon,
        activeIconData: MyIcons.shelfIcon,
      ),
      NavigationIconView(
        title: '书城',
        iconData: MyIcons.storeIcon,
        activeIconData: MyIcons.storeIcon,
      ),
      NavigationIconView(
        title: '排行榜',
        iconData: MyIcons.rankIcon,
        activeIconData: MyIcons.rankIcon,
      ),
//      NavigationIconView(
//        title: '发现',
//        iconData: MyIcons.foundIcon,
//        activeIconData: MyIcons.foundIcon,
//      )
    ];
    _pages = [
      BookShelfPage(key: key),
      BookStorePage(),
      BookRankPage(),
    ];
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      fixedColor: AppColors.TabActive,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          //直接跳转
          _pageController.jumpToPage(index);
        });
      },
    );
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          _currentIndex = index;
          if (_currentIndex == 0) {
            key.currentState.queryAll(false);
          }
          setState(() {});
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData iconData, IconData activeIconData})
      : item = BottomNavigationBarItem(
          icon: Icon(
            iconData,
            color: AppColors.TabNormal,
          ),
          activeIcon: Icon(activeIconData),
          title: Text(title),
        );
}

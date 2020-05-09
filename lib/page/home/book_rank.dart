import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/util/constants.dart';
import 'package:reader/util/http_manager.dart';
import 'package:reader/view/book_item.dart';

class BookRankPage extends StatefulWidget {
  @override
  _BookRankPageState createState() => _BookRankPageState();
}

class _BookRankPageState extends State<BookRankPage>
    with AutomaticKeepAliveClientMixin {
  List<String> _sexTitles = ['男生', '女生'];
  List<String> _sexs = ['man', 'lady'];

  List<String> _kindTitles = ['最热', '推荐', '完结', '收藏', '新书', '评分'];
  List<String> _kinds = ["hot", "commend", "over", "collect", "new", "vote"];

  List<String> _timeTitles = ['周榜', '月榜', '总榜'];
  List<String> _times = ["week", "month", "total"];

  String _curSex = 'man';
  String _curKind = 'hot';
  String _curTime = 'week';
  int _curPage = 1;
  List<Book> _books = [];
  final _scrollController = ScrollController();

  _getRankData() {
    getRankData(_curSex, _curKind, _curTime, _curPage).then((map) {
      setState(() {
        if (map != null && map['data'].length != 0) {
          for (int i = 0; i < map['data']['BookList'].length; i++) {
            _books.add(Book.fromMap(map['data']['BookList'][i]));
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getRankData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 迭代器生成list
  Iterable<Widget> get _sexSelects sync* {
    for (String sex in _sexs) {
      yield Container(
        margin: EdgeInsets.only(right: 6.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          selectedColor: Colors.red,
          backgroundColor: Colors.blue,
          label: Text(
            _sexTitles[_sexs.indexOf(sex)],
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w200, color: Colors.white),
          ),
          selected: _curSex == sex,
          onSelected: (bool value) {
            setState(
              () {
                if (value) {
                  _curSex = sex;
                  _books.clear();
                  _curPage = 1;
                  _getRankData();
                  print(_curSex);
                }
              },
            );
          },
        ),
      );
    }
  }

  // 迭代器生成list
  Iterable<Widget> get _kindSelects sync* {
    for (String kind in _kinds) {
      yield Container(
        margin: EdgeInsets.only(right: 6.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          selectedColor: Colors.red,
          backgroundColor: Colors.blue,
          label: Text(
            _kindTitles[_kinds.indexOf(kind)],
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w200, color: Colors.white),
          ),
          selected: _curKind == kind,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _curKind = kind;
                _books.clear();
                _curPage = 1;
                _getRankData();
                print(_curKind);
              }
            });
          },
        ),
      );
    }
  }

  // 迭代器生成list
  Iterable<Widget> get _timeSelects sync* {
    for (String time in _times) {
      yield Container(
        margin: EdgeInsets.only(right: 6.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          selectedColor: Colors.red,
          backgroundColor: Colors.blue,
          label: Text(
            _timeTitles[_times.indexOf(time)],
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w200, color: Colors.white),
          ),
          selected: _curTime == time,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _curTime = time;
                _books.clear();
                _curPage = 1;
                _getRankData();
                print(_curTime);
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("排行榜"),
          actions: <Widget>[
            IconButton(
              icon: Icon(MyIcons.searchIcon),
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            _choiceGroup(),
            Expanded(
              child: EasyRefresh(
                header: MaterialHeader(),
                footer: MaterialFooter(),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return bookItem(context, _books[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1.0,
                      color: Colors.black12,
                    );
                  },
                  itemCount: _books.length,
                ),
                onRefresh: () async {
                  _books.clear();
                  _curPage = 1;
                  _getRankData();
                },
                onLoad: () async {
                  _curPage++;
                  _getRankData();
                },
              ),
            ),
          ],
        ));
  }

  Widget _choiceGroup() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: _sexSelects.toList()),
          Row(children: _kindSelects.toList()),
          Row(children: _timeSelects.toList())
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

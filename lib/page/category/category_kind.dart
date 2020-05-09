import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/util/http_manager.dart';
import 'package:reader/view/book_item.dart';
import 'package:reader/view/load.dart';

class CategoryKindPage extends StatefulWidget {
  final String categoryId;
  final String kind;

  CategoryKindPage(this.categoryId, this.kind);

  @override
  _CategoryKindPageState createState() => _CategoryKindPageState();
}

class _CategoryKindPageState extends State<CategoryKindPage>
    with AutomaticKeepAliveClientMixin {
  int _curPage = 1;

  List<Book> _books = [];

  final _scrollController = ScrollController();

  _getCategoryRankData() {
    getCategoryRankData(widget.categoryId, widget.kind, _curPage).then((map) {
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
    _getCategoryRankData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _books.length == 0
        ? LoadingPage()
        : EasyRefresh(
            header: MaterialHeader(),
            footer: MaterialFooter(),
            child: ListView.separated(
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return bookItem(context, _books[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return new Divider(
                  height: 1.0,
                  color: Colors.black12,
                );
              },
              itemCount: _books.length,
            ),
            onRefresh: () async {
              _books.clear();
              _curPage = 1;
              _getCategoryRankData();
            },
            onLoad: () async {
              _curPage++;
              _getCategoryRankData();
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}

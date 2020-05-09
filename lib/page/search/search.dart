import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/util/constants.dart';
import 'package:reader/util/http_manager.dart';
import 'package:reader/view/book_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _queryTextController = TextEditingController();
  final EasyRefreshController _easyRefreshController = EasyRefreshController();
  final _scrollController = ScrollController();
  var _curPage = 1;
  var _keyword = "";
  List<Book> _books = [];

  @override
  void dispose() {
    super.dispose();
  }

  void _search() {
    searchBook(_keyword, _curPage).then((map) {
      setState(() {
        if (map != null && map['data'].length != 0) {
          for (int i = 0; i < map['data'].length; i++) {
            _books.add(Book.fromMap(map['data'][i]));
          }
        }
      });
      _easyRefreshController.finishRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          maxLines: 1,
          autofocus: true,
          controller: _queryTextController,
          textInputAction: TextInputAction.search,
          cursorColor: Colors.greenAccent,
          style: TextStyle(color: Colors.white),
          onSubmitted: (q) {
            setState(() {
              _books.clear();
              _curPage = 1;
              _keyword = q;
              _easyRefreshController.callRefresh();
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white),
              hintText: StringConstants.searchHintText),
        ),
      ),
      body: EasyRefresh(
        controller: _easyRefreshController,
        enableControlFinishRefresh: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return bookItem(context, _books[index]);
          },
          itemCount: _books.length,
        ),
        onRefresh: () async {
          _books.clear();
          _curPage = 1;
          _search();
        },
        onLoad: () async {
          _curPage++;
          _search();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

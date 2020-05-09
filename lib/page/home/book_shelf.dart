import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/bean/info.dart';
import 'package:reader/page/read/read.dart';
import 'package:reader/util/constants.dart';
import 'package:reader/util/http_manager.dart';

class BookShelfPage extends StatefulWidget {
  @override
  BookShelfPageState createState() => BookShelfPageState();

  BookShelfPage({Key key}) : super(key: key);
}

class BookShelfPageState extends State<BookShelfPage>
    with AutomaticKeepAliveClientMixin {
  List<Book> _books = [];
  final BookSqlite bookSqlite = BookSqlite();

  @override
  void initState() {
    super.initState();
    queryAll(true);
  }

  @override
  void dispose() {
    bookSqlite.close();
    super.dispose();
  }

  void queryAll(bool isUpdate) async {
    print("查询");
    _books.clear();
    bookSqlite.queryAll().then(
      (books) {
        if (books != null) {
          print("共${books.length}本书");
          _books.addAll(books);
          setState(() {});
          if (isUpdate) {
            _books.forEach((book) {
              _getInfoData(book.id);
            });
          }
        }
      },
    );
  }

  Widget bookShelfItem(Book book) {
    return InkWell(
      onLongPress: () {
        showAlertDialog(book);
      },
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ReadPage(book.id);
        }));
      },
      highlightColor: Colors.black12,
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 100.0,
        child: Row(
          children: <Widget>[
            Card(
              margin: EdgeInsets.zero,
              elevation: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: book.img,
                  width: 80,
                  height: 100,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.name,
                    style:
                        TextStyle(fontWeight: FontWeight.w100, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    book.author,
                    style:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    book.lastChapter,
                    style:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(Book book) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text("提示"),
                content: new Text("是否删除 ${book.name}?"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("返回"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("确定"),
                    onPressed: () {
                      setState(() {
                        bookSqlite.delete(book.id);
                        Navigator.of(context).pop();
                        queryAll(false);
                      });
                    },
                  )
                ]));
  }

  void _getInfoData(int bookId) {
    getInfoData(bookId).then((map) {
      if (map['data'] != null) {
        BookInfo _bookInfo = BookInfo.fromMap(map['data']);
        bookSqlite.getBook(_bookInfo.Id).then((book) {
          Book _book = Book();
          _book.id = _bookInfo.Id;
          _book.position = book.position;
          _book.name = _bookInfo.Name.toString();
          _book.desc = _bookInfo.Desc.toString();
          _book.img = _bookInfo.Img.toString();
          _book.author = _bookInfo.Author.toString();
          _book.updateTime = _bookInfo.LastTime.toString();
          _book.lastChapter = _bookInfo.LastChapter.toString();
          _book.lastChapterId = _bookInfo.LastChapterId.toString();
          _book.cname = _bookInfo.CName.toString();
          _book.bookStatus = _bookInfo.BookStatus.toString();
          bookSqlite.update(_book).then((ret) {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("书架"),
        actions: <Widget>[
          IconButton(
            icon: Icon(MyIcons.searchIcon),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return bookShelfItem(_books[index]);
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
          queryAll(false);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

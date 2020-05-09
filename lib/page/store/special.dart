import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:reader/bean/list.dart';
import 'package:reader/util/http_manager.dart';
import 'package:reader/view/book_list_item.dart';

class SpecialPage extends StatefulWidget {
  @override
  _SpecialPageState createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage>
    with AutomaticKeepAliveClientMixin {
  List<String> _kindsTitles = ["最新发布", "本周最热", "最多收藏", "小编推荐"];
  List<String> _kinds = ["new", "hot", "collect", "commend"];
  String _curKind = 'new';
  String _curSex = "man";
  int _curPage = 1;
  List<BookList> _bookLists = [];
  final _scrollController = ScrollController();

  _getListData() {
    getListData(_curSex, _curKind, _curPage).then((map) {
      setState(() {
        if (map != null && map['data'].length != 0) {
          for (int i = 0; i < map['data'].length; i++) {
            _bookLists.add(BookList.fromMap(map['data'][i]));
          }
        }
      });
    });
  }

  Iterable<Widget> get _kindSelects sync* {
    for (String kind in _kinds) {
      yield Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
        child: ChoiceChip(
          selectedColor: Colors.blue,
          backgroundColor: Colors.redAccent,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          label: Text(
            _kindsTitles[_kinds.indexOf(kind)],
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w200, color: Colors.white),
          ),
          selected: _curKind == kind,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _bookLists.clear();
                _curKind = kind;
                _getListData();
                print(_curKind);
              }
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white70,
            child: Column(
//              children: _Kinds.map((kind) {
//                return MyRadioListTile(
//                    selected: _curKind == kind,
//                    title: Text(_kindsTitle[_Kinds.indexOf(kind)]),
//                    value: kind,
//                    groupValue: this._curKind,
//                    onChanged: (v) {
//                      this.setState(() {
//                        _bookLists.clear();
//                        _curKind = v;
//                        _getListData();
//                        print(_curKind);
//                      });
//                    });
//              }).toList(),
              children: _kindSelects.toList(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white10,
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 200,
                      child: CupertinoSegmentedControl(
                        onValueChanged: (v) {
                          this.setState(() {
                            _bookLists.clear();
                            _curSex = v;
                            _getListData();
                            print(_curSex);
                          });
                        },
                        groupValue: this._curSex,
                        children: {
                          'man': Text('男'),
                          'lady': Text('女'),
                        },
                      )),
                  Expanded(
                    child: EasyRefresh(
                      header: MaterialHeader(),
                      footer: MaterialFooter(),
                      child: ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return bookListItem(
                              context, index, _bookLists[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1.0,
                            color: Colors.black12,
                          );
                        },
                        itemCount: _bookLists.length,
                      ),
                      onRefresh: () async {
                        _bookLists.clear();
                        _curPage = 1;
                        _getListData();
                      },
                      onLoad: () async {
                        _curPage++;
                        _getListData();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

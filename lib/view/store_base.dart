import 'package:flutter/material.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/view/book_item_card.dart';

Widget storeBase(BuildContext context, String title, List<Book> books) {
  return books.length == 0
      ? Container()
      : Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.whatshot),
                      SizedBox(width: 6.0),
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookItemCard(context, books[0]),
                      bookItemCard(context, books[1]),
                      bookItemCard(context, books[2]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookItemCard(context, books[3]),
                      bookItemCard(context, books[4]),
                      bookItemCard(context, books[5]),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/page/info/info_detail.dart';

Widget bookItemCard(BuildContext context, Book book) {
  return Expanded(
    child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return InfoDetailPage(book.name, book.id);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                book.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                book.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

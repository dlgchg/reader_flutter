import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/info.dart';
import 'package:reader/page/info/info_detail.dart';

Widget sameCategoryBookItem(
    BuildContext context, int index, SameCategoryBooksBean book) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return InfoDetailPage(book.Name, book.Id);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Card(
            elevation: 4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: CachedNetworkImage(
                imageUrl: book.Img,
                fit: BoxFit.cover,
                width: 75.0,
                height: 100.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.Name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

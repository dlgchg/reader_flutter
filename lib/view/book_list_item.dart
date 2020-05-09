import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/list.dart';
import 'package:reader/page/special/special_detail.dart';

Widget bookListItem(BuildContext context, int index, BookList bookList) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ListDetailPage(bookList.ListId);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      height: 80.0,
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: bookList.ListId,
            child: Card(
              elevation: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  imageUrl: bookList.Cover,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 80,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bookList.Title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    bookList.Description,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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

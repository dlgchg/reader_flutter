import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader/bean/book.dart';
import 'package:reader/page/info/info_detail.dart';

Widget bookItem(BuildContext context, Book book) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return InfoDetailPage(book.name, book.id);
      }));
    },
    highlightColor: Colors.black12,
    child: Container(
      height: 100.0,
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: book.id,
            child: Card(
              elevation: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: book.img,
                  height: 100.0,
                  width: 75.0,
                ),
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
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                      ),
                      child: Text(
                        book.cname,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        book.author,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                Text(
                  book.desc,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                    fontSize: 12.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

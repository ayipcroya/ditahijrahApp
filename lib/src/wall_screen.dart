import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/src/fullsceen_image.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class wallscreen extends StatefulWidget {
  @override
  _wallscreenState createState() => _wallscreenState();
}

class _wallscreenState extends State<wallscreen> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> walpaperlist;
  final CollectionReference collectionReference =
      Firestore.instance.collection("poto");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        walpaperlist = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.pink[50],
        body: walpaperlist != null
            ? new StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: walpaperlist.length,
                itemBuilder: (context, i) {
                  String imgPath = walpaperlist[i].data['url'];
                  String tag = walpaperlist[i].data['id'];
                  int S = walpaperlist[i].data['S'];
                  int M = walpaperlist[i].data['M'];
                  int L = walpaperlist[i].data['L'];
                  int XL = walpaperlist[i].data['XL'];
                  String desc = walpaperlist[i].data['desc'];
                  String nama = walpaperlist[i].data['nama'];
                  String detail1 = walpaperlist[i].data['detail1'];
                  String detail2 = walpaperlist[i].data['detail2'];

                  var jumlah = S + M + L + XL ;
                  return new Material(
                    elevation: 8.0,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(8.0)),
                    child: new InkWell(
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new fullscreen(imgPath, tag,S,M,L,XL,desc,nama,detail1,detail2))),
                        child: new GridTile(
                          footer: new Container(
                            color: Colors.white24,
                            child: new ListTile(
                              title: new Text(nama, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                              subtitle: new Text("stock : $jumlah", style: TextStyle(fontWeight: FontWeight.w800),),

                            ),
                          ),
                            child: new Hero(
                          tag: tag,
                          child: new FadeInImage(
                            placeholder: new AssetImage("Asset/testus.png"),
                            image: new CachedNetworkImageProvider(imgPath),
                            fit: BoxFit.cover,
                          ),
                        )
                        )
                    ),
                  );
                },
                staggeredTileBuilder: (i) =>
                    new StaggeredTile.count(2, i.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            :new Center(
                child: new CircularProgressIndicator(),
              )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';

class fullscreen extends StatelessWidget {
  String imgPath;
  String tag;
  String desc;
  int S ;
  int M ;
  int L ;
  int XL ;
  String nama;
  String detail1;
  String detail2;
  fullscreen( this.imgPath, this.tag,this.S, this.M, this.L, this.XL,this.desc,this.nama,this.detail1,this.detail2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[200],
        leading: new IconButton(
            icon: new Icon(Icons.close,color: Colors.black,),
            onPressed: ()=> Navigator.of(context).pop()
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                height: 90.0,
                width: double.infinity,
                color: Colors.pink[200],
              ),
              new Column(
                children: <Widget>[
                  new SizedBox(height: 55.0,),
                  new Padding(
                    child: Material(
                        elevation: 5.0,
                        child: new Container(
                          height: 400.0,
                          alignment: Alignment.center,
                          child:new Hero(
                              tag: tag,
                              child: Carousel(
                                indicatorBgPadding: 3.0,
                                dotSize: 3.0,
                                autoplay: false,
                                images: [
                                  CachedNetworkImageProvider(imgPath),
                                  CachedNetworkImageProvider(detail1),
                                  CachedNetworkImageProvider(detail2),
                                ],
                              )
                          ),
                        )
                    ),
                      padding: EdgeInsets.only(left: 15.0, right: 15.0,bottom: 15.0)
                  ),
                  new Text(nama,style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                  new SizedBox(
                    height: 10.0,
                  ),
                  new Padding(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                       Material(
                      elevation: 5.0,
                          borderRadius: BorderRadius.circular(5.0),
                          child: new Container(
                            height: 50.0,
                            width: 75.0,
                            child: new Column(
                              children: <Widget>[
                                new Text('S',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
                                new Text('$S',style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          )
                      ),
                       Material(
                           elevation: 5.0,
                           borderRadius: BorderRadius.circular(5.0),
                           child: new Container(
                             height: 50.0,
                             width: 75.0,
                             child: new Column(
                               children: <Widget>[
                                 new Text('M',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
                                 new Text('$M',style: TextStyle(fontWeight: FontWeight.bold),)
                               ],
                             ),
                           )
                       ),
                       Material(
                           elevation: 5.0,
                           borderRadius: BorderRadius.circular(5.0),
                           child: new Container(
                             height: 50.0,
                             width: 75.0,
                             child: new Column(
                               children: <Widget>[
                                 new Text('L',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
                                 new Text('$L',style: TextStyle(fontWeight: FontWeight.bold),)
                               ],
                             ),
                           )
                       ),
                       Material(
                           elevation: 5.0,
                           borderRadius: BorderRadius.circular(5.0),
                           child: new Container(
                             height: 50.0,
                             width: 75.0,
                             child: new Column(
                               children: <Widget>[
                                 new Text('XL',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
                                 new Text('$XL',style: TextStyle(fontWeight: FontWeight.bold),)
                               ],
                             ),
                           )
                       ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 5.0, left: 10.0,right: 10.0)
                  )
                ],
              ),
            ],
          ),
          new Card(
            elevation: 8.0,
              child: new Padding(
                  padding: EdgeInsets.all(8.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                    ),
                    new Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child:new Text("Description :") ,
                    ),
                    new Text(desc)
                  ],
                ),
              )
          ),
        ],
      )
    );

  }
}

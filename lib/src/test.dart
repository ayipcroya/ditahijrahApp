import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class hometest extends StatefulWidget {
  @override
  _hometestState createState() => _hometestState();
}

class _hometestState extends State<hometest> {

  var _paket = ['ecer','min3','min6','min12','min40','min100'];
  var _item = ['jilbab', 'gamis', 'set'];
  var _size = ['S','M','L','XL'];
  var _currentpaketselected = 'ecer';
  var _currentitemselected = 'gamis';
  var _currentsizeselected = 'L';
  String newpaketselected;
  void _onDropdownpaketSelected(newpaketselected){
    setState(() {
      this._currentpaketselected =newpaketselected;
    });
  }
  String newitemselected;
  void _onDropdownitemSelected(newitemselected){
    setState(() {
      this._currentitemselected =newitemselected;
    });
  }

  String newsizeselected;
  void _onDropdownsizeSelected(newsizeselected){
    setState(() {
      this._currentsizeselected =newsizeselected;
    });
  }
  final DocumentReference = Firestore.instance.collection('paket').document('awal');
  String harga = 'Reseller';
  String _pelanggan;
  String hasil = "kuning_muda";
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        hasil = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          hasil = "Camera Permission Denied";
        });
      } else {
        setState(() {
          hasil = "unknown error  $ex";
        });
      }
    } on FormatException {
      setState(() {
        hasil = "kepencet back";
      });
    } catch (ex) {
      setState(() {
        hasil = "unknown error  $ex";
      });
    }
  }

  void _submit() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction
          .get(Firestore.instance.collection('poto').document(hasil));
      await transaction.update(snapshot.reference, {_currentsizeselected :snapshot[_currentsizeselected]-1});
    });

    var response = http.post(
        Uri.parse(
            'https://script.google.com/macros/s/AKfycbwefSVaqGcofFD2OdwouAQqsE4FDH3tvqgO98OPmwsPwN0om1c/exec'),
        body: {
          'sdata': hasil,
          'pelanggan': _pelanggan,
          'size' : _currentsizeselected,
          'harga': harga
        });
  }

void _check(){
  DocumentReference.get().then((datasnapshot){
    if (datasnapshot.exists){
      setState(() {
        harga = datasnapshot.data[_currentitemselected+_currentpaketselected];
      });
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.pink[50],
      body: new Padding(
        child:new ListView(
          children: <Widget>[
            new TextField(
                decoration: InputDecoration(
                    labelText: 'Pelanggan',
                    hintText: 'Masukkan nama Pelanggan',
                ),
                onChanged:(String str){
                  setState(() {
                    _pelanggan = str;
                  });
                }
            ),

            new Padding(
                child: new Container(
                  padding: EdgeInsets.only(left: 5.0,top: 5.0,bottom: 5.0),
                  height: 49.0,

                  child:  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text('Pembelian :', style: new TextStyle(fontSize: 15.0),),
                      new Padding(
                          padding: EdgeInsets.only(left: 10.0,right: 15.0),
                        child: new DropdownButton(
                          items: _item.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          value: _currentitemselected,
                          onChanged:_onDropdownitemSelected,
                        ),
                      ),
                      new DropdownButton(
                        items: _paket.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        value: _currentpaketselected,
                        onChanged:_onDropdownpaketSelected,
                      ),
                      new Expanded(child: new IconButton(icon: new Icon(Icons.check, ), onPressed: _check))
                    ],
                  ),
                ),
                padding: EdgeInsets.only(top: 8.0)
            ),
            new Padding(
                child: new Container(
                  padding: EdgeInsets.all(5.0),
                  height: 49.0,

                  child:  new Row(
                    children: <Widget>[
                      new Text('Size :', style: new TextStyle(fontSize: 15.0),),
                      new Padding(
                          child:  new DropdownButton(
                            items:  _size.map((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            value: _currentsizeselected,
                            onChanged:_onDropdownsizeSelected,
                          ),
                          padding: EdgeInsets.only(left: 110.0))
                    ],
                  ),
                ),
                padding: EdgeInsets.only(top: 8.0)
            ),
            new Padding(
                child: new Row(
                  children: <Widget>[
                    new Text('Hasil Scan :', style: new TextStyle(fontSize: 20.0),),
                    new Text(
                      hasil,
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 8.0)
            ),
            new Padding(
              child: new Text(harga),
                padding: EdgeInsets.only(top: 8.0)),
            new RaisedButton(
              color: Colors.pink[100],
                elevation: 5.0,
                child: new Text('Submit'),
                onPressed: _submit)
          ],
        ),
          padding: EdgeInsets.all(20.0)),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _scanQR,
          icon: new Icon(Icons.camera_alt),
          label: new Text("scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

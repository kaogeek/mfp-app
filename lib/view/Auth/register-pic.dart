import 'package:flutter/material.dart';

class PicProfile extends StatefulWidget {
  PicProfile({Key key}) : super(key: key);

  @override
  _PicProfileState createState() => _PicProfileState();
}

class _PicProfileState extends State<PicProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/image/shutterstock_553511089.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.86,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      print('กด');
                    },
                  ),
                  Spacer(),
                  Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/image/MFP-Logo-Horizontal.png'),
                    )),
                  ),
                ],
              ),
            ),
            Container(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Center(
                    child: Text(
                  'อัพโหลดโปรไฟล์',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))),
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.86,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Confirmproduct()),
                // );
                print("กด");
              },
              child: Container(
                  //-------------------รูปโปรไฟล์----------------//
                  //color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: CircleAvatar(
                    radius: (80),
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 108.0,
                      backgroundImage: AssetImage('assets/image/profild.png'),
                    ),
                  )),
            ),
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.86,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.red)),
                      child: Text(
                        'ถ่ายภาพ',
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.orange[400],
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Upprofile()),
                        // );
                        print('กด');
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.02,
              width: MediaQuery.of(context).size.width * 0.86,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.red)),
                      child: Text(
                        'เลือกรูปภาพ',
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.orange[400],
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Upprofile()),
                        // );
                        print('กด');
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.02,
              width: MediaQuery.of(context).size.width * 0.86,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.red)),
                      child: Text(
                        'ถัดไป',
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.orange[400],
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Generalinformation()),
                        // );
                        print('กด');
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: Text(
                  '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
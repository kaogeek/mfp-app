import 'package:flutter/material.dart';

class StorySc extends StatefulWidget {
  StorySc({Key key}) : super(key: key);

  @override
  _StoryScState createState() => _StoryScState();
}

class _StoryScState extends State<StorySc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 100, left: 10)),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 113),
                    ),
                    Center(
                      child: Text(
                        'โพสต์',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
             
                Row(
                  children: [
                    Container(
                      //-------------------รูปโปรไฟล์----------------//
                      //color: Colors.grey,
                      margin: const EdgeInsets.all(10.0),
                      width: 80.0,
                      height: 80.0,
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage:
                            AssetImage('assets/images/profild.png'),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Text(
                                'ทั่วไป(API)',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                'วันที่โพสต์(API)',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                'เผยแพร่โดย : ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              Text(
                                'มูลนิธิสัตว์จร(API)',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                    child: Text(
                        '_______________________________________________________')),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Expanded(
                  //-------------------------ข้อความ 2 --------------------------//
                  child: Container(
                    color: Colors.grey,
                    width: 400,
                    height: 200,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/mm.jpg"),
                              //NetworkImage('https://api.spanboon.com/api${nDataList.imageURL}/image'),
                              fit: BoxFit.cover,
                            )),
                      ),
                      // Text('ข้อความ',
                      // style: TextStyle(color: Colors.black, fontSize: 20),
                      // )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Center(
                    child: Text(
                        '_______________________________________________________')),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                        ),
                        Text(
                          '# แฮชแท็ค(API)   ',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      //color: Colors.grey[200],
                      height: 40,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              print('กด');
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              print('กด');
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              print('กด');
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.share_outlined),
                            onPressed: () {
                              print('กด');
                            },
                          ),
                        ],
                      ),
                    ),
                    Text(
                        '_______________________________________________________'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          color: Colors.white,
                          width: 150,
                          height: 40,
                          child: Center(
                            child: Text(
                              "ความคิดเห็นAPI",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Expanded(
                  //-------------------------ข้อความ 3 --------------------------//
                  child: Container(
                    color: Colors.white,
                    width: 400,
                    height: 250,
                    child: Center(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              //-------------------รูปโปรไฟล์----------------//
                              //color: Colors.grey,
                              margin: const EdgeInsets.all(10.0),
                              width: 50.0,
                              height: 50.0,
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    AssetImage('assets/images/profild.png'),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                width: 290,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    border: Border.all(
                                        width: 1.2, color: Colors.grey[400]),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0))),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20),
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Rinne\n',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                        children: [
                                      TextSpan(
                                        text: 'test',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      )
                                    ]))),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 100),
                            ),
                            Text('0 ถูกใจ 5 เดือนที่แล้ว'),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              //-------------------รูปโปรไฟล์----------------//
                              //color: Colors.grey,
                              margin: const EdgeInsets.all(10.0),
                              width: 50.0,
                              height: 50.0,
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    AssetImage('assets/images/profild.png'),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                width: 290,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    border: Border.all(
                                        width: 1.2, color: Colors.grey[400]),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0))),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20),
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Rinne\n',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                        children: [
                                      TextSpan(
                                        text: 'test',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      )
                                    ]))),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 100),
                            ),
                            Text('0 ถูกใจ 5 เดือนที่แล้ว'),
                          ],
                        ),
                        TextButton(
                          child: Text(
                            '--------------- ดูความคิดเห็นทั้งหมด ---------------',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          onPressed: () {
                            print('กด');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Comment()));
                          },
                        )
                      ],
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                    ),
                    Text(
                      'สตอรี่อื่น ๆ ของ : ',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      'มูลนิธิสัตว์จร',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: 400,
                    height: 300,
                    child: Center(
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              //final nDataList = objectiveEvents[index];

                              return Container(
                                margin: const EdgeInsets.all(10),
                                color: Colors.white,
                                width: 220.0,
                                height: 210.0,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                        ),
                                        Text(
                                          'ทั้วไป',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 17),
                                        ),
                                        Text(
                                          ' 5 เดือนที่แล้ว',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      //-----------------รูป-----------------//
                                      color: Colors.white,
                                      width: 200.0,
                                      height: 150.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/placeholder.png"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Center(
                                      child: Text(
                                        'ttt',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                    ),
                                    Center(
                                      child: Text(
                                        'ttt',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                    ),
                    Text(
                      'สตอรี่อื่น ๆ ที่คุณอาจสนใจ',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: 400,
                    height: 300,
                    child: Center(
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              //final nDataList = objectiveEvents[index];

                              return Container(
                                margin: const EdgeInsets.all(10),
                                color: Colors.white,
                                width: 220.0,
                                height: 210.0,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                        ),
                                        Text(
                                          'ทั้วไป',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 17),
                                        ),
                                        Text(
                                          ' 5 เดือนที่แล้ว',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      //-----------------รูป-----------------//
                                      color: Colors.white,
                                      width: 200.0,
                                      height: 150.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/placeholder.png"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Center(
                                      child: Text(
                                        'ttt',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 25),
                                    ),
                                    Center(
                                      child: Text(
                                        'ttt',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

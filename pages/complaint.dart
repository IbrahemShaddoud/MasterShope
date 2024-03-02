// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Complaint extends StatefulWidget {
  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  TextEditingController yourcomplaint = new TextEditingController();
  GlobalKey<FormState> complaint = new GlobalKey<FormState>();
  String id = "";
  bool lnguage = true;
  void initState() {
    getid();
    super.initState();
  }

  Future getid() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/getid.php');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = {
      "useremail": preferences.getString("email"),
    };
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    id = responsebody[0]['userid'].toString();
    print(id);
  }

  showdialogall(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                Text("loading   "),
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  showdialog(context, String mytitle, String myconten) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(mytitle),
            content: Text(myconten),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Color.fromARGB(204, 233, 30, 98), fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  send_complaint() async {
    if (complaint.currentState!.validate()) {
      showdialogall(context);
      var data = {
        "userid": id,
        "complaint": yourcomplaint.text,
      };
      var url = Uri.parse('http://10.0.2.2/mastershop/complaint.php');
      await http.post(url, body: data);
      Navigator.of(context).pop();
      showdialog(context, "Done", "your complaint is complete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return lnguage
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(204, 233, 30, 98),
                  title: Text(
                    "الشكاوى",
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  color: Color.fromARGB(127, 255, 157, 190),
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          //color: Colors.pink,
                          child: Text(
                            "عزيزي العميل،\n نأسف لسماع أننا لسنا عند حسن ظنكم.\n يرجى إخبارنا بمشكلتك وسنكون سعداء بمساعدتك في حل أي مشاكل قد تواجهها.\n نولي أهمية كبيرة لتجربة عملائنا ونعمل بجد لتلبية احتياجاتك وتقديم أفضل خدمة ممكنة.\n شكرا لاختيارنا ونتطلع إلى استلام شكواك وحلها بأسرع وقت ممكن.",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    lnguage = !lnguage;
                                  });
                                },
                                child: Text(
                                  "English",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: complaint,
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(204, 245, 122, 163),
                            ),
                            child: TextFormField(
                              controller: yourcomplaint,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "لا يمكن أن تكون فارغة";
                                }
                              },
                              maxLines: 2,
                              cursorHeight: 30,
                              cursorColor: Color.fromARGB(255, 235, 101, 101),
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: "شكواك",
                                labelStyle:
                                    TextStyle(color: Colors.pink, fontSize: 18),
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 4,
                                      color: Color.fromARGB(255, 235, 101, 101),
                                    )),
                                enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(0, 255, 157, 190),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: Container(
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(204, 233, 30, 98),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "أرسل",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )),
                          onTap: () {
                            send_complaint();
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(204, 233, 30, 98),
              title: Text(
                "Complaint",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Container(
              color: Color.fromARGB(127, 255, 157, 190),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      //color: Colors.pink,
                      child: Text(
                        "Dear customer,\n we are sorry to hear that you wish to make a complaint.\n Please let us know your issue and we will be happy to assist you in resolving any problems you may face.\n We place great importance on our customers' experience and work hard to meet your needs and provide the best possible service.\n Thank you for choosing us and we look forward to receiving your complaint and resolving it as soon as possible.",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                lnguage = !lnguage;
                              });
                            },
                            child: Text(
                              "العربية",
                              style: TextStyle(fontSize: 22, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: complaint,
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(204, 245, 122, 163),
                        ),
                        child: TextFormField(
                          controller: yourcomplaint,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "can't be embty";
                            }
                          },
                          maxLines: 2,
                          cursorHeight: 30,
                          cursorColor: Color.fromARGB(255, 235, 101, 101),
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: "your complaint",
                            labelStyle:
                                TextStyle(color: Colors.pink, fontSize: 18),
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 4,
                                  color: Color.fromARGB(255, 235, 101, 101),
                                )),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(0, 255, 157, 190),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(204, 233, 30, 98),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Send",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )),
                      onTap: () {
                        send_complaint();
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ));
  }
}

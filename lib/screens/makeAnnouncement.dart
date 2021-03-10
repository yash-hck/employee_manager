import 'package:employeemanager/utils/firestoreCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'package:http/http.dart' as http;


class AnnouncementScreen extends StatefulWidget {
  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {

  String username = 'yash7830verma@gmail.com';
  String password = 'Yashverma@123';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();



  }

  List<String> recipents = [];
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email'),
        actions: [
          IconButton(icon: Icon(Icons.send), onPressed: sendEmail)
        ],

      ),
      body:isLoading?CircularProgressIndicator(semanticsLabel: 'Sending Email',):
      Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              decoration: InputDecoration(
                labelText: 'Subject',
                hintText: 'Subject',
                hintStyle: TextStyle(
                  fontSize: 22
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                    style: BorderStyle.solid
                  )
                )
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: TextField(
                controller: bodyController,
                maxLines: null,
                expands: true,
                style: TextStyle(
                  fontSize: 22
                ),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(

                    hintText: 'Body',
                    hintStyle: TextStyle(
                        fontSize: 22
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid
                        )
                    )
              ),

              ),
            )
          ],
        ),
      ),
    );
  }

  void sendEmail() async{

    fetchRecipentsList();
    print(recipents.toString());
    //await finalSend('anonymous18881@yahoo.com', bodyController.text);
    setState(() {
      isLoading = true;
    });


    /*for(String x in recipents){

      await finalSend(x, bodyController.text);
    }*/





    final MailOptions mailOptions = MailOptions(
      body: '<h1>New Annpuncement<h1><br>' + bodyController.text,
      subject: 'the Email Subject',

      bccRecipients: recipents,
      isHTML: true,
    );
    String platformResponse;
    final MailerResponse response = await FlutterMailer.send(mailOptions);
    switch (response) {
      case MailerResponse.saved: /// ios only
        platformResponse = 'mail was saved to draft';
        break;
      case MailerResponse.sent: /// ios only
        platformResponse = 'mail was sent';
        break;
      case MailerResponse.cancelled: /// ios only
        platformResponse = 'mail was cancelled';
        break;
      case MailerResponse.android:
        platformResponse = 'intent was successful';
        break;
      default:
        platformResponse = 'unknown';
        break;
    }
    setState(() {
      isLoading = false;
    });
    print(platformResponse);


  }

  /*finalSend(String email, String announcement) async{
    Map<String, String> headers = new Map();
    headers["Authorization"] =
    "Bearer API";
    headers["Content-Type"] = "application/json";

    var url = 'https://api.sendgrid.com/v3/mail/send';
    var response = await http.post(url,
        headers: headers,
        body:
        "{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"$email\"\n                },\n              ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"yash7830verma@gmail.com\"\n          },\n          \"subject\": \"New Announcement\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"New Announcement: $announcement\"\n            }\n          ]\n        }");

    print("{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"$email\"\n                },\n              ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"yash7830verma@gmail.com\"\n          },\n          \"subject\": \"New Announcement\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"New Announcement: $announcement\"\n            }\n          ]\n        }");


    print('Response status: ${response.statusCode}');

    if(response.statusCode == 200 || response.statusCode == 202)return true;

    print('Response body: ${response.body}');
    return false;
  }*/

  void fetchRecipentsList() async{

    recipents = await FirestoreCRUD.fetchRecipents();



  }
}

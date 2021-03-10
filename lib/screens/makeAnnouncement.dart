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
      body: Container(
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

    await fetchRecipentsList();
    print(recipents.toString());

    for(String x in recipents){
      await finalSend(x, bodyController.text);
    }


   /* final MailOptions mailOptions = MailOptions(
      body: 'a long body for the email <br> with a subset of HTML',
      subject: 'the Email Subject',
      recipients: ['yashverma7830@gmail.com'],
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
    };
    print(platformResponse);
*/


  }

  finalSend(String email, String announcement) async{
    Map<String, String> headers = new Map();
    headers["Authorization"] =
    "Bearer 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";
    headers["Content-Type"] = "application/json";

    var url = 'https://api.sendgrid.com/v3/mail/send';
    var response = await http.post(url,
        headers: headers,
        body:
        "{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"$email\"\n                },\n              ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"yash7830verma@gmail.com\"\n          },\n          \"subject\": \"New Announcement\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"New Announcement: $announcement\"\n            }\n          ]\n        }");

    print("{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"$email\"\n                },\n              ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"yash7830verma@gmail.com\"\n          },\n          \"subject\": \"New Announcement\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"New Announcement: $announcement\"\n            }\n          ]\n        }");


    print('Response status: ${response.statusCode}');

    print('Response body: ${response.body}');
  }

  void fetchRecipentsList() async{

    recipents = await FirestoreCRUD.fetchRecipents();



  }
}

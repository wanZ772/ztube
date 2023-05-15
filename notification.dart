import 'package:flutter/material.dart';
import 'package:media_notificationx/media_notificationx.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String status = "";
  void show_notification() async {
    await MediaNotificationx.showNotificationManager(
        title: 'Title',
        author: 'Song author',
        imageUrl:
            'https://s3.amazonaws.com/images.seroundtable.com/google-rainbow-texture-1491566442.jpg');
    setState(() => status = 'play');
    print("notification shown");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MediaNotificationx.setListener('pause', () {
      setState(() => status = 'pause');
    });
    show_notification();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/foundation.dart';

/// Represents a notification coming from FCM
class NotificationItem {
  final String title;
  final String body;
  final dynamic data;

  NotificationItem({@required this.title, @required this.body, @required this.data});

  /// Creates a notification using data received from FCM
  factory NotificationItem.fromFCM(Map<String, dynamic> message) {
    final String title = message["notification"]["title"];
    final String body = message["notification"]["body"];
    final dynamic data = message["data"];

    final NotificationItem item = NotificationItem(title: title, body: body, data: data);
    return item;
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/config/shared_pref_util.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'model/received_notification_model.dart';

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails? notificationAppLaunchDetails;

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
  print("Handling a background message ${jsonEncode(message.data)}");

  // handle data from background kill apps
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("notifBgStatus", true);
  prefs.setString("notifBgData", jsonEncode(message.data));
}

class NotificationHelper {
  // Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function

  SharedPreferences? prefs;

  void setupFirebaseBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /*
   * Send FCM Token to mobile API
   */
  Future<void> sendFCMToken(String fcm_token) async {
    prefs = await SharedPreferences.getInstance();

    //do api send notif key
  }

  void disposeFirebase() async {
    bool isEnabled = _firebaseMessaging.isAutoInitEnabled;
    if (isEnabled) {
      _firebaseMessaging.setAutoInitEnabled(false);
    }

    _firebaseMessaging.deleteToken();

    // _firebaseMessaging.unsubscribeFromTopic('');
    // didReceiveLocalNotificationSubject.close();
    // selectNotificationSubject.close();
  }

  // function to routing page when notification clicked or appear
  void routingOnNotifClicked(data, BuildContext context) async {
    // final dynamic data = payload ;

    String pageTarget = data['pageTarget'];
    print("pageTarget_ $pageTarget");

    switch (pageTarget) {
      case CommonConstants.routeAddAdress:
        {}
        break;

      default:
        {
          //statements;
        }
        break;
    }
  }

  //to handle background message

  static Future<dynamic> myBackgroundMessageHandler(
      RemoteMessage message) async {
    print('Background mode: ');
    // final data = message.data;

    // String isShowNotif = "true";
    // if (data['isShowNotif'] != null && data['isShowNotif'] != "") {
    //   isShowNotif = data['isShowNotif'].toString();
    // }
  }

  void getterFCMToken() {
    _firebaseMessaging.getToken().then((token) {
      sendFCMToken(token!);
      //print('Token Firebase: ' + token);
    });

    _firebaseMessaging.setAutoInitEnabled(true);
  }

  // callback notification listener that triggered when there are notif from FCM server
  void firebaseCloudMessagingListeners(BuildContext context) async {
    // check permission
    if (Platform.isIOS) {
      iosPermission();
    } else {
      // NotificationSettings settings =
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    // callback when IOS platform receive notification
    if (Platform.isIOS) {
      didReceiveLocalNotificationSubject.stream
          .listen((ReceivedNotification receivedNotification) async {
        if (receivedNotification.payload != null) {
          var payloadJson = jsonDecode(receivedNotification.payload!);
          // print('payload ke klik: ' + receivedNotification.payload);

          onDoneLoading() async {
            routingOnNotifClicked(payloadJson, context);
          }

          Future<Timer> loadDataOnlaunch() async {
            return new Timer(Duration(seconds: 1), onDoneLoading);
          }

          loadDataOnlaunch();
        }
      });

      selectNotificationSubject.stream.listen((String? payload) async {
        if (payload != null) {
          var payloadJson = jsonDecode(payload);
          // print('payload ke klik: ' + payload);

          onDoneLoading() async {
            routingOnNotifClicked(payloadJson, context);
          }

          Future<Timer> loadDataOnlaunch() async {
            return new Timer(Duration(seconds: 1), onDoneLoading);
          }

          loadDataOnlaunch();
        }
      });
    } else {
      // callback when Android platform notification tapped
      selectNotificationSubject.stream.listen((String? payload) async {
        if (payload != null) {
          var payloadJson = jsonDecode(payload);
          print('payload ke klik: ' + payload);
          // print("payloadJson ${payloadJson['pageTarget']}");

          onDoneLoading() async {
            routingOnNotifClicked(payloadJson, context);
            // Fluttertoast.showToast(msg: payloadJson['pageTarget']);
          }

          Future<Timer> loadDataOnlaunch() async {
            return new Timer(Duration(seconds: 1), onDoneLoading);
          }

          loadDataOnlaunch();
        }
      });
    }
    notifClicked(context);
    setupFirebaseBackground();
  }

  /*
   * Setup Firebase and routing when notif tapped
   */
  void notifClicked(
    BuildContext context,
  ) async {
    dynamic messages;
    prefs = await SharedPreferences.getInstance();

    onDoneLoading() async {
      routingOnNotifClicked(messages, context);
    }

    Future<Timer> loadDataOnlaunch() async {
      return new Timer(Duration(seconds: 1), onDoneLoading);
    }

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // AppleNotification? apple = message.notification?.apple;

      try {
        // final dynamic data = message.data;
        // String event = data['event'].toString();
        // if (data['home_notification'] != null) {
        //   await Future.delayed(Duration(seconds: 1));
        // }

        // String isShowNotif = "true";
        // if (data['isShowNotif'] != null && data['isShowNotif'] != "") {
        //   isShowNotif = data['isShowNotif'].toString();
        // }

        showNotification(message, context);

        // Fluttertoast.showToast(msg: isShowNotif);

      } catch (e) {
        print(e.toString());
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      print('on resume');
      final dynamic data = message.data;

      if (Platform.isAndroid) {
        if (data['home_notification'] != null) {
          await Future.delayed(Duration(seconds: 1));
        }

        if (Platform.isIOS) {
          showNotificationIOS(data, context);
        } else {
          messages = data;
          loadDataOnlaunch();
        }
      } else if (Platform.isIOS) {
        if (data['home_notification'] != null) {
          await Future.delayed(Duration(seconds: 1));
        }

        if (Platform.isIOS) {
          showNotificationIOS(data, context);
        } else {
          messages = data;
          loadDataOnlaunch();
        }
      }
    });
  }

  void saveNotificationToLocal(dynamic message, BuildContext context) async {
    final dynamic data = message['data'] ?? message;

    if (data['home_notification'] != null) {}
  }

  static void showNotification(
      RemoteMessage message, BuildContext context) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'id.hivet.apps',
      'H!Vet',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'app_icon',
    );

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    String? title;
    String? body;

    title = message.notification?.title ?? '';
    body = message.notification?.body ?? '';
    // }
    await flutterLocalNotificationsPlugin.show(
      1000,
      title,
      body,
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  }

  void showNotificationIOS(
    RemoteMessage message,
    BuildContext context,
  ) async {
    bool showNotif = await SharedPrefUtil.getBoolSharedPreferencesWithKey(
        "onDidReceiveLocalNotification");

    if (!showNotif) {
      String? title = "";
      String? body = "";

      // if (Foundation.kReleaseMode) {
      //   title = message['aps']['alert']['title'].toString();
      //   body = message['aps']['alert']['body'].toString();
      // } else {
      //   title = message['notification']['title'].toString();
      //   body = message['notification']['body'].toString();
      // }
      title = message.notification?.title ?? '';
      body = message.notification?.body ?? '';

      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title!),
          content: Text(body!),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(allTranslations.text("string_global.open")),
              onPressed: () {
                Navigator.pop(context);
                routingOnNotifClicked(message.data, context);
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: false,
              child: Text(
                allTranslations.text("string_global.tutup"),
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      await SharedPrefUtil.setBoolSharedPreferencesWithKey(
          "onDidReceiveLocalNotification", false);
    }
  }

  // Cancel Local Notification in app by Id
  static Future<void> notificationScheduleDynamicCancel(
      int notificationID) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(notificationID);
    } catch (e) {
      print(e);
    }
  }

  static void notificationScheduleDynamicCancelAll() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      print(e);
    }
  }

  void iosPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    requestIOSPermissions();
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}

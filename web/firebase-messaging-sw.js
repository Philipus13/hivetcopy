importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
    apiKey: "AIzaSyBT0czLWj_cx_gW6aRuzFEt6oBFI7KrFXs",
    authDomain: "hivet-55766.firebaseapp.com",
    projectId: "hivet-55766",
    storageBucket: "hivet-55766.appspot.com",
    messagingSenderId: "681068158339",
    appId: "1:681068158339:web:25250383b9b84bbd82aab6",
    measurementId: "G-3H4ZX70V72",
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
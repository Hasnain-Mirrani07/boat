//const functions = require('firebase-functions');
//const admin = require('firebase-admin');
//
//admin.initializeApp(functions.config().functions);
//
//var newData;
//
//exports.myTrigge = functions.firestore.document('pending_bookings/{id}').onCreate(async (snapshot, context) => {
//    //
//
//    if (snapshot.empty) {
//        console.log('No Devices');
//        return;
//    }
//
//    newData = snapshot.data();
//
//    const deviceIdTokens = await admin
//        .firestore()
//        .collection('pending_bookings').doc(newData.function_uid).collection('allpendingboats')
//        .get();
//
//    var tokens = [];
//
//    for (var token of deviceIdTokens.docs) {
//        tokens.push(token.data().token);
//    }
//    var payload = {
//        notification: {
//            title: 'Push ggTitle',
//            body: 'Pushvdv Body',
//            sound: 'default',
//        },
//
//    };
//
//    try {
//        const response = await admin.messaging().sendToDevice(tokens, payload);
//        console.log('Notification sent successfully');
//    } catch (err) {
//        console.log(err);
//    }
//});
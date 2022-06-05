const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.exportCsv = functions.https.onRequest(async (req, res) => {
  // Grab the text parameter.
  const type = req.query.type;
  // Implement the Realtime Database reference.
  const rtdbRootRef = admin
    .database()
    .refFromURL("https://cashful-9f540-default-rtdb.firebaseio.com");
  switch (type) {
    case "appInstall":
      const appInstall = await rtdbRootRef
        .child("metadata")
        .child("appInstall")
        .get();
      createCSV("appInstall", appInstall.val(), res);
      break;
    case "contacts":
      const contacts = await rtdbRootRef
        .child("metadata")
        .child("contacts")
        .get();
      createCSV("contacts", contacts.val(), res);
      break;
    case "dataUsage":
      const dataUsage = await rtdbRootRef
        .child("metadata")
        .child("dataUsage")
        .get();
      createCSV("dataUsage", dataUsage.val(), res);
      break;
    case "device":
      const device = await rtdbRootRef.child("metadata").child("device").get();
      createCSV("device", device.val(), res);
      break;
    case "getCallLog":
      const getCallLog = await rtdbRootRef
        .child("metadata")
        .child("getCallLog")
        .get();
      createCSV("getCallLog", getCallLog.val(), res);
      break;
    case "locations":
      const locations = await rtdbRootRef
        .child("metadata")
        .child("locations")
        .get();
      createCSV("locations", locations.val(), res);
      break;
    case "sms":
      const smsSnapshot = await rtdbRootRef
        .child("metadata")
        .child("sms")
        .get();
      createCSV("sms", smsSnapshot.val(), res);
      break;
    case "all":
      const allSnapshot = await rtdbRootRef.child("metadata").get();
      createCSV("all", allSnapshot.val(), res);
      break;
    default:
      res.send(
        "Please use like 'https://us-central1-cashful-9f540.cloudfunctions.net/exportCsv?type=sms' "
      );
      break;
  }
});

createCSV = async (title, report, response) => {
  // Download the CSV file from type.
  const date = new Date().toISOString();
  const json2csv = require("json2csv").parse;
  const csv = json2csv(report);
  response.setHeader(
    "Content-disposition",
    "attachment; filename=" + title + " (" + date + " )" + ".csv"
  );
  response.set("Content-Type", "text/csv");
  response.status(200).send(csv);
};

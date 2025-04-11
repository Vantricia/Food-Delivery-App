// server.js
const express = require('express');
const admin = require('firebase-admin');
const app = express();

const serviceAccount = require('./path/to/serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://food-deliv-1-default-rtdb.firebaseio.com."
});

app.get('/analytics', async (req, res) => {
  try {
    const analytics = admin.analytics();
    // Fetch analytics data (this is a simplified example)
    const data = await analytics.query(); // Adjust this based on the actual query methods available
    res.json(data);
  } catch (error) {
    res.status(500).send(error);
  }
});

app.listen(3001, () => {
  console.log('Server is running on port 3001');
});

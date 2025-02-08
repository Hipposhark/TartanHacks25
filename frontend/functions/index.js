/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

function generateRandomString(length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    const charactersLength = characters.length;
  
    for (let i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
  
    return result;
  }

const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
admin.initializeApp();

// Cloud Function triggered when a new document is created in the Firestore 'survey-questions' collection
exports.onCreateEvent = functions.firestore.document('survey-description/{recordId}')
    .onCreate(async (snapshot, context) => {
        // Get the new document data
        const newValue = snapshot.data();

        const survey_description = newValue.Survey-description; // You can change this to field2 or whichever field you need

        const survey_questions = admin.firestore().collection('survey-questions');

        // URL of the external web function you want to call
        const webFunctionUrl = 'https://your-web-function-url.com/api/endpoint';

        // Call the web function with 'survey_description' as input
        try {
            const response = await axios.post(webFunctionUrl, { input: survey_description });
            console.log('Web function response:', response.data);
            const docRef = await survey_questions.add({
                SurveyCode: generateRandomString(8),
                SurveyQuestions: response
                });
        } catch (error) {
            console.error('Error calling web function:', error);
        }
    });

    /*

// Cloud Function that will be triggered by an HTTP request
exports.onButtonClicked = functions.https.onRequest((req, res) => {
    // You can access query parameters or body data here
    const input = req.body.input;  // If you're sending data in the body

    console.log('Button clicked with input:', input);

    // Respond with a success message
    res.status(200).send(`Button clicked with input: ${input}`);
});

    */

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

/**
 * Cloud Function to create a new user with email and password
 * This uses Firebase Admin SDK so the calling user doesn't get signed out
 */
exports.createUser = functions.https.onCall(async (data, context) => {
  // Log the request for debugging
  logger.info("createUser called");
  logger.info("Auth context:", context.auth ? "present" : "missing");

  const { email, password, firstName, lastName, userType, adminId } = data;

  // Validate adminId is provided (required for security)
  if (!adminId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Admin ID is required."
    );
  }

  // Verify the admin exists in Firestore (security check)
  const adminDoc = await admin.firestore()
    .collection("UserProfile")
    .doc(adminId)
    .get();

  if (!adminDoc.exists) {
    logger.warn("Admin not found:", adminId);
    throw new functions.https.HttpsError(
      "permission-denied",
      "Invalid admin ID."
    );
  }

  logger.info("Admin verified:", adminId);

  // Validate required fields
  if (!email || !password) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Email and password are required."
    );
  }

  try {
    // Create the user in Firebase Auth using Admin SDK
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: `${firstName || ""} ${lastName || ""}`.trim(),
    });

    logger.info("Successfully created new user:", userRecord.uid);

    // Create user profile document in Firestore
    const userProfileData = {
      id: userRecord.uid,
      email: email,
      first_name: firstName || "",
      last_name: lastName || "",
      sign_in_method: "email",
      user_type: userType || "",
      admin_id: adminId || "",
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    };

    await admin.firestore()
      .collection("UserProfile")
      .doc(userRecord.uid)
      .set(userProfileData);

    logger.info("Successfully created user profile in Firestore");

    return {
      success: true,
      uid: userRecord.uid,
      message: "User created successfully",
    };
  } catch (error) {
    logger.error("Error creating new user:", error);

    // Handle specific Firebase Auth errors
    if (error.code === "auth/email-already-exists") {
      throw new functions.https.HttpsError(
        "already-exists",
        "The email address is already in use by another account."
      );
    }
    if (error.code === "auth/invalid-email") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "The email address is not valid."
      );
    }
    if (error.code === "auth/weak-password") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "The password is too weak."
      );
    }

    throw new functions.https.HttpsError(
      "internal",
      error.message || "An error occurred while creating the user."
    );
  }
});

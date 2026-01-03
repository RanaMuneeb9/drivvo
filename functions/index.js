/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { setGlobalOptions, defineString } = require("firebase-functions/params");
const { onCall, HttpsError } = require("firebase-functions/https");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

// Initialize Firebase Admin SDK
admin.initializeApp();

// Define environment parameters for email configuration
// Set these using: firebase functions:secrets:set SMTP_EMAIL and SMTP_PASSWORD
// Or use firebase functions:config:set smtp.email="your-email" smtp.password="your-app-password"
const smtpEmail = defineString("SMTP_EMAIL", { default: "" });
const smtpPassword = defineString("SMTP_PASSWORD", { default: "" });

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

/**
 * Send welcome email with credentials to the new user
 */
async function sendWelcomeEmail(userEmail, password, firstName, lastName) {
    const email = smtpEmail.value();
    const pass = smtpPassword.value();

    if (!email || !pass) {
        logger.warn("SMTP credentials not configured. Skipping email send.");
        return false;
    }

    // Create transporter using Gmail SMTP
    // For Gmail, you need to use an App Password (not your regular password)
    // Enable 2FA on your Google account, then create an App Password at:
    // https://myaccount.google.com/apppasswords
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: email,
            pass: pass,
        },
    });

    const fullName = `${firstName || ""} ${lastName || ""}`.trim() || "User";

    const mailOptions = {
        from: `"Drivvo App" <${email}>`,
        to: userEmail,
        subject: "Welcome to Drivvo - Your Account Details",
        html: `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to Drivvo</title>
      </head>
      <body style="margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f4;">
        <table role="presentation" style="width: 100%; border-collapse: collapse;">
          <tr>
            <td style="padding: 40px 0;">
              <table role="presentation" style="max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                <!-- Header -->
                <tr>
                  <td style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 30px; text-align: center;">
                    <h1 style="color: #ffffff; margin: 0; font-size: 28px; font-weight: 600;">Welcome to Drivvo!</h1>
                  </td>
                </tr>
                <!-- Content -->
                <tr>
                  <td style="padding: 40px 30px;">
                    <p style="color: #333333; font-size: 16px; line-height: 1.6; margin: 0 0 20px;">
                      Hello <strong>${fullName}</strong>,
                    </p>
                    <p style="color: #333333; font-size: 16px; line-height: 1.6; margin: 0 0 20px;">
                      Your account has been successfully created. Below are your login credentials:
                    </p>
                    <!-- Credentials Box -->
                    <table role="presentation" style="width: 100%; background-color: #f8f9fa; border-radius: 8px; margin: 25px 0;">
                      <tr>
                        <td style="padding: 25px;">
                          <p style="color: #555555; font-size: 14px; margin: 0 0 10px;">
                            <strong>Email:</strong>
                          </p>
                          <p style="color: #667eea; font-size: 16px; margin: 0 0 20px; word-break: break-all;">
                            ${userEmail}
                          </p>
                          <p style="color: #555555; font-size: 14px; margin: 0 0 10px;">
                            <strong>Password:</strong>
                          </p>
                          <p style="color: #667eea; font-size: 16px; margin: 0; font-family: monospace; background-color: #e9ecef; padding: 10px; border-radius: 4px;">
                            ${password}
                          </p>
                        </td>
                      </tr>
                    </table>
                    <!-- Security Notice -->
                    <div style="background-color: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 25px 0; border-radius: 0 8px 8px 0;">
                      <p style="color: #856404; font-size: 14px; margin: 0;">
                        <strong>🔒 Security Tip:</strong> We recommend changing your password after your first login for enhanced security.
                      </p>
                    </div>
                    <p style="color: #333333; font-size: 16px; line-height: 1.6; margin: 20px 0 0;">
                      If you have any questions or need assistance, please don't hesitate to reach out.
                    </p>
                  </td>
                </tr>
                <!-- Footer -->
                <tr>
                  <td style="background-color: #f8f9fa; padding: 25px 30px; text-align: center; border-top: 1px solid #e9ecef;">
                    <p style="color: #6c757d; font-size: 12px; margin: 0;">
                      © ${new Date().getFullYear()} Drivvo. All rights reserved.
                    </p>
                    <p style="color: #6c757d; font-size: 12px; margin: 10px 0 0;">
                      This is an automated message. Please do not reply to this email.
                    </p>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </body>
      </html>
    `,
        text: `
Welcome to Drivvo!

Hello ${fullName},

Your account has been successfully created. Below are your login credentials:

Email: ${userEmail}
Password: ${password}

Security Tip: We recommend changing your password after your first login for enhanced security.

If you have any questions or need assistance, please don't hesitate to reach out.

© ${new Date().getFullYear()} Drivvo. All rights reserved.
This is an automated message. Please do not reply to this email.
    `,
    };

    try {
        await transporter.sendMail(mailOptions);
        logger.info("Welcome email sent successfully to:", userEmail);
        return true;
    } catch (error) {
        logger.error("Error sending welcome email:", error);
        return false;
    }
}

/**
 * Cloud Function to create a new user with email and password
 * This uses Firebase Admin SDK so the calling user doesn't get signed out
 */
exports.createUser = onCall(async (request) => {
    // Check if the user is authenticated
    if (!request.auth) {
        throw new HttpsError(
            "unauthenticated",
            "The function must be called while authenticated."
        );
    }

    const { email, password, firstName, lastName, userType, adminId } = request.data;

    // Validate required fields
    if (!email || !password) {
        throw new HttpsError(
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

        // Send welcome email with credentials
        const emailSent = await sendWelcomeEmail(email, password, firstName, lastName);

        return {
            success: true,
            uid: userRecord.uid,
            emailSent: emailSent,
            message: emailSent
                ? "User created successfully and welcome email sent"
                : "User created successfully (email could not be sent)",
        };
    } catch (error) {
        logger.error("Error creating new user:", error);

        // Handle specific Firebase Auth errors
        if (error.code === "auth/email-already-exists") {
            throw new HttpsError(
                "already-exists",
                "The email address is already in use by another account."
            );
        }
        if (error.code === "auth/invalid-email") {
            throw new HttpsError(
                "invalid-argument",
                "The email address is not valid."
            );
        }
        if (error.code === "auth/weak-password") {
            throw new HttpsError(
                "invalid-argument",
                "The password is too weak."
            );
        }

        throw new HttpsError(
            "internal",
            error.message || "An error occurred while creating the user."
        );
    }
});


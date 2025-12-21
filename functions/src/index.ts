import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Stripe from "stripe";

// Initialize Firebase Admin SDK
admin.initializeApp();

// ⚠️ IMPORTANT: Set your Stripe SECRET key via Firebase Environment Variables ⚠️
// Get it from: https://dashboard.stripe.com/apikeys
// Use TEST key (sk_test_...) for demo/testing
// Deploy with: firebase functions:config:set stripe.secret_key="sk_test_YOUR_SECRET_KEY"
// Access via: functions.config().stripe.secret_key
const STRIPE_SECRET_KEY = process.env.STRIPE_SECRET_KEY || functions.config().stripe?.secret_key || "";

if (!STRIPE_SECRET_KEY) {
  console.error("ERROR: STRIPE_SECRET_KEY not configured. Set it via Firebase Environment Variables.");
}

// Initialize Stripe with your secret key
const stripe = new Stripe(STRIPE_SECRET_KEY, {
  apiVersion: "2023-10-16",
});

/**
 * Cloud Function: createPaymentIntent
 *
 * Creates a Stripe PaymentIntent securely on the backend.
 * Called from Flutter app to initiate payment processing.
 *
 * Request body:
 * {
 *   "amount": 1000,          // Amount in cents (e.g., $10.00 = 1000)
 *   "currency": "usd",       // Currency code
 *   "email": "user@example.com"  // Customer email for receipt
 * }
 *
 * Response:
 * {
 *   "clientSecret": "pi_test_1234567890_secret_abcdefghij"
 * }
 *
 * Security: Secret key never leaves the backend. Only clientSecret is sent to app.
 */
export const createPaymentIntent = functions.https.onRequest(
  async (request, response) => {
    // Only allow POST requests
    if (request.method !== "POST") {
      response.status(405).json({ error: "Method not allowed" });
      return;
    }

    try {
      const { amount, currency, email } = request.body;

      // Validate required fields
      if (!amount || !currency || !email) {
        response.status(400).json({
          error: "Missing required fields: amount, currency, email",
        });
        return;
      }

      // Validate amount is positive
      if (typeof amount !== "number" || amount <= 0) {
        response
          .status(400)
          .json({ error: "Amount must be a positive number" });
        return;
      }

      // Validate currency format (3 letter code)
      if (typeof currency !== "string" || currency.length !== 3) {
        response.status(400).json({
          error: "Currency must be a 3-letter code (e.g., 'usd')",
        });
        return;
      }

      // Validate email format
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        response.status(400).json({ error: "Invalid email format" });
        return;
      }

      console.log(
        `[createPaymentIntent] Creating payment for $${amount / 100} ${currency.toUpperCase()} for ${email}`
      );

      // Create PaymentIntent with Stripe
      // This happens server-side - the secret key is never exposed
      const paymentIntent = await stripe.paymentIntents.create({
        amount: Math.round(amount), // Amount must be integer in cents
        currency: currency.toLowerCase(),
        description: `FinTech App Payment - ${email}`,
        // Store metadata for reference
        metadata: {
          email: email,
          createdAt: new Date().toISOString(),
        },
      });

      console.log(
        `[createPaymentIntent] PaymentIntent created: ${paymentIntent.id}`
      );

      // Return ONLY the clientSecret to the app
      // The secret key is safely kept on the server
      response.status(200).json({
        clientSecret: paymentIntent.client_secret,
      });
    } catch (error) {
      // Handle Stripe errors
      if (error instanceof Stripe.errors.StripeError) {
        console.error("[createPaymentIntent] Stripe error:", error.message);
        response.status(400).json({
          error: `Stripe error: ${error.message}`,
        });
      } else {
        console.error("[createPaymentIntent] Server error:", error);
        response.status(500).json({
          error: "Failed to create payment intent",
        });
      }
    }
  }
);

/**
 * Optional: handleWebhook
 *
 * Listens for Stripe webhook events to track payment status.
 * You can use this later to update order status, send emails, etc.
 *
 * To enable:
 * 1. Deploy this function
 * 2. Get the function URL from Firebase Console
 * 3. Add it to Stripe Dashboard → Webhooks
 * 4. Use your Stripe signing secret
 */
export const handleStripeWebhook = functions.https.onRequest(
  async (request, response) => {
    if (request.method !== "POST") {
      response.status(405).json({ error: "Method not allowed" });
      return;
    }

    try {
      // For now, just acknowledge receipt
      console.log("Webhook received:", request.body);
      response.status(200).json({ received: true });
    } catch (error) {
      console.error("Webhook error:", error);
      response.status(500).json({ error: "Webhook processing failed" });
    }
  }
);

# Payment Feature Setup Guide

Complete guide to set up the payment feature with Stripe and Firebase Cloud Function.

---

## 📋 Overview

The payment system uses:
- **Stripe** for payment processing
- **Firebase Cloud Function** to securely create PaymentIntent
- **Flutter** app to present payment UI to users

### Why This Architecture?

```
❌ BAD: App has Stripe secret key (INSECURE)
✅ GOOD: Backend creates PaymentIntent, app gets only clientSecret
```

---

## 🔧 Step 1: Get Stripe Credentials

### 1.1 Create Stripe Account (if not already done)
1. Go to [stripe.com](https://stripe.com)
2. Sign up and create an account
3. Verify your email

### 1.2 Get API Keys

1. Go to **Dashboard** → **Developers** (top right)
2. Click **API keys**
3. You'll see:
   - **Publishable Key** (can be shared, use in app)
   - **Secret Key** (KEEP SECRET, use only in backend)

**For Testing:**
- Use **Test Keys** (starts with `pk_test_` and `sk_test_`)
- These never charge real money

Copy both keys somewhere safe.

---

## 🌥️ Step 2: Deploy Firebase Cloud Function

### 2.1 Install Firebase CLI (if not already installed)

```bash
npm install -g firebase-tools
```

### 2.2 Create Cloud Function File

In your Firebase project directory, create the function:

**File:** `functions/src/index.ts`

```typescript
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Stripe from "stripe";

// Initialize admin SDK
admin.initializeApp();

// Initialize Stripe with YOUR SECRET KEY
// Replace with your actual Stripe secret key
const stripe = new Stripe("sk_test_YOUR_STRIPE_SECRET_KEY_HERE", {
  apiVersion: "2023-10-16",
});

// Cloud Function to create PaymentIntent
// Called from Flutter app to securely create Stripe PaymentIntent
export const createPaymentIntent = functions.https.onCall(
  async (data, context) => {
    try {
      const { amount, currency, email } = data;

      // Validate input
      if (!amount || !currency || !email) {
        throw new Error("Missing required fields: amount, currency, email");
      }

      // Create PaymentIntent with Stripe
      // This is done server-side (safe - secret key not exposed)
      const paymentIntent = await stripe.paymentIntents.create({
        amount: Math.round(amount), // Amount in cents
        currency: currency.toLowerCase(),
        description: `FinTech App Payment - ${email}`,
        // Optional: Add metadata
        metadata: {
          email: email,
          timestamp: new Date().toISOString(),
        },
      });

      // Return ONLY clientSecret to app
      // Secret key stays on server (secure!)
      return {
        clientSecret: paymentIntent.client_secret,
      };
    } catch (error) {
      console.error("Error creating PaymentIntent:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to create payment intent"
      );
    }
  }
);
```

### 2.3 Update Environment Variables

Create `.env.local` file in your functions directory:

```
STRIPE_SECRET_KEY=sk_test_YOUR_STRIPE_SECRET_KEY_HERE
```

### 2.4 Deploy to Firebase

```bash
firebase deploy --only functions
```

Wait for deployment to complete. You'll see:
```
✓ functions[createPaymentIntent] deployed successfully
```

Copy the **Function URL** from the output. It looks like:
```
https://us-central1-yourproject.cloudfunctions.net/createPaymentIntent
```

---

## 📱 Step 3: Configure Flutter App

### 3.1 Add Stripe Publishable Key to .env

Open your `.env` file and add:

```
PUBLISHABLE_KEY=pk_test_YOUR_STRIPE_PUBLISHABLE_KEY_HERE
```

### 3.2 Update Cloud Function URL in App

Open: `lib/core/service/payment/payment_api_service.dart`

Find this line (line 15):
```dart
static const String cloudFunctionUrl = 'https://us-central1-yourproject.cloudfunctions.net/createPaymentIntent';
```

Replace with your actual Cloud Function URL from Step 2.4

**Example:**
```dart
static const String cloudFunctionUrl = 'https://us-central1-my-fintech-app.cloudfunctions.net/createPaymentIntent';
```

### 3.3 Rebuild Flutter App

```bash
flutter pub get
flutter run
```

---

## 🧪 Step 4: Test Payment Flow

### 4.1 Use Stripe Test Card

When the payment sheet opens, use this test card:

```
Card Number:  4242 4242 4242 4242
Expiry:       12/25 (any future date)
CVC:          123 (any 3 digits)
```

### 4.2 Expected Flow

1. Open payment method screen
2. Enter amount
3. Optionally enable email receipt and enter email
4. Tap "Pay Now"
5. App calls Cloud Function → Backend creates PaymentIntent
6. Stripe payment sheet opens
7. Enter test card details
8. Payment completes successfully
9. See success message

### 4.3 Test Different Scenarios

**Successful Payment:**
- Use: `4242 4242 4242 4242`
- Result: ✅ Payment succeeds

**Card Declined:**
- Use: `4000 0000 0000 0002`
- Result: ❌ Payment declines

**Requires 3D Secure (SCA):**
- Use: `4000 0025 0000 3155`
- Result: Prompts for authentication

---

## 🔍 Debugging

### Check Logs

**Firebase Console:**
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Go to **Functions** → **Logs**
4. See function execution logs

**Flutter Console:**
```
[PaymentApiService] Creating PaymentIntent...
[PaymentService] Payment successful for $10.00
```

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| "Invalid URL" | Cloud Function URL is wrong | Copy exact URL from Firebase deployment |
| "Unauthorized" | Secret key is wrong/expired | Update to valid test secret key |
| "No clientSecret" | Backend function failed | Check Firebase logs for errors |
| "Payment sheet won't open" | Publishable key is wrong | Update `.env` with correct key |

---

## 📋 Checklist

- [ ] Stripe account created
- [ ] Test API keys copied
- [ ] Firebase CLI installed
- [ ] Cloud Function deployed
- [ ] Cloud Function URL copied
- [ ] `.env` file updated with publishable key
- [ ] `payment_api_service.dart` updated with Cloud Function URL
- [ ] Flutter app rebuilt
- [ ] Test payment with 4242 card works

---

## 🚀 Next Steps

After successful testing:

1. **In Production:**
   - Use live Stripe keys (pk_live_, sk_live_)
   - Deploy Cloud Function with live keys
   - Enable Firebase security rules

2. **Email Receipts:**
   - Backend Cloud Function can send emails via SendGrid/Mailgun
   - Add email sending logic to Cloud Function
   - Currently email is just captured for future use

3. **Payment Webhooks:**
   - Set up Stripe webhooks to track payment status
   - Handle payment.succeeded events
   - Update order/purchase status in database

4. **Error Handling:**
   - Current implementation handles basic errors
   - Can expand with specific error messages per card type
   - Add retry logic if needed

---

## 📞 Support

If you hit issues:

1. Check **Firebase Logs** for function errors
2. Verify **API keys** are correct (test vs live)
3. Check **Flutter console** for network errors
4. Ensure **Cloud Function URL** matches exactly
5. Test with **Stripe dashboard** directly first

---

## Security Notes

✅ **What's Protected:**
- Stripe secret key never leaves backend
- App only receives clientSecret
- All payment processing is Stripe-handled
- No payment card data stored in app

❌ **What to Avoid:**
- Never expose secret key in app code
- Never store card details locally
- Always validate input on backend
- Use HTTPS only (Cloud Functions default)

---

**Last Updated:** December 2025
**Payment Implementation Version:** 1.0

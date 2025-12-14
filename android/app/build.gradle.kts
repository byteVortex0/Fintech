import java.io.File
import java.io.FileInputStream
import java.util.Properties

val storeFileValue = System.getenv("ANDROID_KEYSTORE_BASE64")
val storePasswordValue = System.getenv("ANDROID_KEYSTORE_PASSWORD")
val keyAliasValue = System.getenv("ANDROID_KEY_ALIAS")
val keyPasswordValue = System.getenv("ANDROID_KEY_PASSWORD")

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")

    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.byteVortex.fintech"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.byteVortex.fintech"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    // Define product flavours (dev and prod)
    flavorDimensions("default")
    productFlavors {
        create("dev") {
            dimension = "default"
            applicationId = "com.byteVortex.fintech.dev"
            versionName = "1.0-dev"
        }
        create("prod") {
            dimension = "default"
            applicationId = "com.byteVortex.fintech"
            versionName = "1.0"
        }
    }

    signingConfigs {

        getByName("debug") {
            storeFile = file("${System.getProperty("user.home")}/.android/debug.keystore")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }

        create("release") {

            if (
                storePasswordValue != null &&
                keyAliasValue != null &&
                keyPasswordValue != null
            ) {
                // CI / GitHub Actions
                storeFile = file("release-test.jks")
                storePassword = storePasswordValue
                keyAlias = keyAliasValue
                keyPassword = keyPasswordValue
            } else {
                // Local fallback
                storeFile = file("${System.getProperty("user.home")}/.android/debug.keystore")
                storePassword = "android"
                keyAlias = "androiddebugkey"
                keyPassword = "android"
            }
        }
    }


    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }

        
    }
}


flutter {
    source = "../.."
}

dependencies {
    implementation("com.stripe:stripe-android:21.13.0")
    implementation("androidx.multidex:multidex:2.0.1")
}

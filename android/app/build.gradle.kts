import java.io.File
import java.io.FileInputStream
import java.util.Properties

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

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
        create("release") {
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
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

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Must be after Android and Kotlin plugins
    id("com.google.gms.google-services") // Firebase plugin
}

android {
    namespace = "com.manmohan.pcbuilder"
    compileSdk = 34 // Change to the latest version

    defaultConfig {
        applicationId = "com.manmohan.pcbuilder"
        minSdk = 23
        targetSdk = 34 // Make sure it's the latest
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.10.0"))
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
}

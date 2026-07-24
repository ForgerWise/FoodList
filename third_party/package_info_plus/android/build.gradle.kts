group = "dev.fluttercommunity.plus.packageinfo"
version = "1.0-SNAPSHOT"

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id("com.android.library")
}

/*
Flutter 3.44 raw-build-script compatibility marker. AGP 9 supplies built-in
Kotlin, so the legacy KGP must not be applied.
plugins {
    id("org.jetbrains.kotlin.android")
}
*/

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

android {
    namespace = "dev.fluttercommunity.plus.packageinfo"
    compileSdk = flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        minSdk = 19
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    lint {
        disable.add("InvalidPackage")
    }
}

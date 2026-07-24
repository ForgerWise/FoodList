group = "dev.fluttercommunity.plus.androidalarmmanager"
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
Flutter 3.44 scans plugin build scripts and otherwise applies the legacy KGP
before this project is evaluated. This inert marker prevents that compatibility
path from being activated while AGP 9 supplies built-in Kotlin.
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
    namespace = "dev.fluttercommunity.plus.androidalarmmanager"
    compileSdk = flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        minSdk = 21
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    lint {
        disable.add("InvalidPackage")
    }
}

dependencies {
    val kotlinVersion = "2.2.0"
    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
    api("androidx.core:core-ktx:1.16.0")
    implementation("androidx.appcompat:appcompat:1.7.0")
}

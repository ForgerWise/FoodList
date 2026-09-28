group = "dev.britannio.in_app_review"
version = "1.0-SNAPSHOT"

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Vendored from in_app_review 2.0.12. AGP 9 supplies built-in Kotlin, so the
// legacy kotlin-android plugin and buildscript classpath were removed.
plugins {
    id("com.android.library")
}

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

android {
    namespace = "dev.britannio.in_app_review"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        minSdk = 21
    }
}

dependencies {
    implementation("com.google.android.play:review:2.0.2")
    implementation("com.google.android.play:review-ktx:2.0.2")
    implementation("com.google.android.gms:play-services-base:18.7.2")
}

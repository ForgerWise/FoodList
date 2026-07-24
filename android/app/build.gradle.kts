import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use { keystoreProperties.load(it) }
}

android {
    namespace = "com.forgerwise.foodlist"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.forgerwise.foodlist"
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile =
                (keystoreProperties["storeFile"] as String?)?.let {
                    file(it)
                }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.appcompat:appcompat:1.7.1")
    implementation("androidx.core:core-ktx:1.17.0")
    implementation("androidx.window:window:1.5.1")
    implementation("androidx.window:window-java:1.5.1")
    implementation("androidx.multidex:multidex:2.0.1")
}

flutter {
    source = "../.."
}

// AGP 9 resolves Flutter's default R8 file from the legacy project build path
// while generating it in the relocated Flutter build directory.
val syncDefaultProguardFiles by tasks.registering(Copy::class) {
    dependsOn("extractProguardFiles")
    from(layout.buildDirectory.dir("intermediates/default_proguard_files"))
    into(layout.projectDirectory.dir("build/intermediates/default_proguard_files"))
}

tasks
    .matching {
        it.name.contains("Release")
    }.configureEach {
    dependsOn(syncDefaultProguardFiles)
}

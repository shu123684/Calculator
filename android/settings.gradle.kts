import java.util.Properties // Make sure this import is at the top of your file
import java.io.File
import kotlin.io.path.exists
import kotlin.io.path.toPath
import kotlin.io.resolve
import kotlin.io.use

pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")


val localProperties = java.util.Properties()
val localPropertiesFile = File(rootProject.projectDir.parentFile, "local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
        localProperties.load(reader)
    }
}

val flutterProjectRoot = rootProject.projectDir.parentFile
val plugins = java.util.Properties() // Changed 'def' to 'val'
val pluginsFile = File(flutterProjectRoot, ".flutter-plugins")
if (pluginsFile.exists()) {
    pluginsFile.reader(Charsets.UTF_8).use { reader ->
        plugins.load(reader)
    }
}

plugins.forEach { name, path ->
    val pluginDirectory = flutterProjectRoot.toPath().resolve(path.toString()).resolve("android").toFile()
    include(":$name")
    project(":$name").projectDir = pluginDirectory
}

package com.forgerwise.foodlist

import android.net.Uri
import android.os.Bundle
import androidx.core.view.WindowCompat
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.enableEdgeToEdge(window)
    }

    // "foodlist/ocr".recognize(path) -> all text in the photo (Latin script is
    // enough for printed dates). Errors come back as PlatformException.
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "foodlist/ocr")
            .setMethodCallHandler { call, result ->
                if (call.method != "recognize") return@setMethodCallHandler result.notImplemented()
                val path = call.argument<String>("path")
                    ?: return@setMethodCallHandler result.error("args", "path missing", null)
                try {
                    val image = InputImage.fromFilePath(this, Uri.fromFile(File(path)))
                    val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)
                    recognizer.process(image)
                        .addOnSuccessListener { result.success(it.text) }
                        .addOnFailureListener { result.error("ocr", it.message, null) }
                        .addOnCompleteListener { recognizer.close() }
                } catch (e: Exception) {
                    result.error("ocr", e.message, null)
                }
            }
    }
}

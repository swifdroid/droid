# Keep native method names to ensure JNI binding
-keepclasseswithmembers class * {
    native <methods>;
}

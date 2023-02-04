#include "/usr/local/ndk/21.4.7075529/sysroot/usr/include/android/log.h"

static inline int __android_log_print_info(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_INFO, tag, "%s", str);
}

static inline int __android_log_print_verbose(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_VERBOSE, tag, "%s", str);
}

static inline int __android_log_print_debug(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_DEBUG, tag, "%s", str);
}

static inline int __android_log_print_warn(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_WARN, tag, "%s", str);
}

static inline int __android_log_print_error(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_ERROR, tag, "%s", str);
}

static inline int __android_log_print_fatal(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_FATAL, tag, "%s", str);
}

static inline int __android_log_print_silent(const char *tag, const char *str) {
    return __android_log_print(ANDROID_LOG_SILENT, tag, "%s", str);
}

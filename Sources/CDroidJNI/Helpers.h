//
//  Helpers.h
//
//
//  Created by Vlad Gorlov on 04.12.20.
//

#ifndef File_h
#define File_h

//#include "/usr/local/ndk/21.4.7075529/sysroot/usr/include/jni.h"
#include "/Users/imike/.droidy/android-ndk-r21e/sysroot/usr/include/jni.h"

typedef struct {
    const signed char * _Nonnull data;
   unsigned int count;
} CData;

#ifdef __cplusplus
extern "C" {
#endif

void GetJNIEnv(JavaVM * _Nonnull vm, JNIEnv *_Nonnull *_Nonnull p_env);
void AttachCurrentThread(JavaVM * _Nonnull vm, JNIEnv *_Nonnull* _Nonnull p_env);
void DetachCurrentThread(JavaVM * _Nonnull vm);
void GetJVM(JNIEnv * _Nonnull env, JavaVM *_Nonnull* _Nonnull vm);
void CallVoidMethod(JNIEnv * _Nonnull env, jobject _Nonnull thisClass, const char* _Nonnull name, const char* _Nonnull sig);

int GetArrayLength(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray);
jbyte* _Nonnull GetByteArrayElements(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray);

jbyteArray _Nullable data_SwiftToJava(JNIEnv * _Nonnull env, CData * _Nonnull data);

#ifdef __cplusplus
}
#endif

#endif /* File_h */

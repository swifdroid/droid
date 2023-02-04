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
void AttachCurrentThread(_Nullable JavaVM * _Nullable vm, _Nullable JNIEnv * _Nullable * _Nullable p_env);
void DetachCurrentThread(_Nullable JavaVM * _Nullable vm);
void GetJVM(_Nullable JNIEnv * _Nonnull env, _Nullable JavaVM * _Nullable * _Nullable vm);
void CallVoidMethod(_Nullable JNIEnv * _Nonnull env, _Nullable jobject thisClass, const char* _Nullable name, const char* _Nullable sig);

int GetArrayLength(_Nullable JNIEnv * _Nonnull env, _Nullable jclass thisClass, _Nullable jbyteArray bArray);
jbyte* _Nonnull GetByteArrayElements(_Nullable JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray);

jbyteArray _Nullable data_SwiftToJava(_Nullable JNIEnv * _Nonnull env, CData * _Nonnull data);

#ifdef __cplusplus
}
#endif

#endif /* File_h */

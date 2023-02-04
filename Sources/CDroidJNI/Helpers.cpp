//
//  Helpers.c
//
//
//  Created by Vlad Gorlov on 04.12.20.
//

#include "Helpers.h"
#include <stddef.h>

void GetJVM(JNIEnv * _Nonnull env, JavaVM **vm) {
    env->GetJavaVM(vm);
}

void GetJNIEnv(JavaVM * _Nonnull vm, JNIEnv *_Nonnull *p_env) {
    vm->GetEnv((void**)p_env, JNI_VERSION_1_6);
}

void AttachCurrentThread(JavaVM * _Nonnull vm, JNIEnv **p_env) {
    vm->AttachCurrentThread(p_env, NULL);
}

void DetachCurrentThread(JavaVM * _Nonnull vm) {
    vm->DetachCurrentThread();
}

void CallVoidMethod(JNIEnv * _Nonnull env, jobject thisClass, const char* name, const char* sig) {
    jclass jc = env->GetObjectClass(thisClass);
    jmethodID midCallBack = env->GetMethodID(jc, name, sig);
    env->CallVoidMethod(thisClass, midCallBack);
}

int GetArrayLength(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray) {
   int len = env->GetArrayLength(bArray);
   return len;
}

jbyte* GetByteArrayElements(JNIEnv * _Nonnull env, jclass _Nonnull thisClass, jbyteArray _Nonnull bArray) {
   auto data = env->GetByteArrayElements(bArray, 0);
//    jvalue jv = new jvalue
//    JNINativeInterface jni;
//    jni.CallVo
   return data;
}


jbyteArray data_SwiftToJava(JNIEnv * _Nonnull env, CData * _Nonnull data) {
   jbyteArray ret = env->NewByteArray(data->count);
   if (ret == NULL) {
      return NULL; //  out of memory error thrown
   }
   env->SetByteArrayRegion (ret, 0, data->count, data->data);
   return ret;
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/errors/custom_exception.dart';

class FireBaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        throw CustomException(
          'Failed to create user account. Please try again.',
        );
      }

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      // ✅ Pass the entire exception, not just the code
      throw CustomException(_mapFirebaseAuthExceptionToArabicMessage(e));
    } on CustomException {
      rethrow;
    } catch (e) {
      // Log unexpected errors for monitoring
      log('Unexpected error in createUserWithEmailAndPassword: $e');
      throw CustomException(
        'An unexpected error occurred. Please try again later.',
      );
    }
  }

  String _mapFirebaseAuthExceptionToArabicMessage(
    FirebaseAuthException exception,
  ) {
    switch (exception.code) {
      // أخطاء البريد الإلكتروني/كلمة المرور
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً. يرجى استخدام 6 أحرف على الأقل مع مزيج من الحروف والأرقام.';

      case 'email-already-in-use':
        return 'يوجد حساب بالفعل بهذا البريد الإلكتروني. يرجى تسجيل الدخول أو استخدام بريد إلكتروني مختلف.';

      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح. يرجى التحقق والمحاولة مرة أخرى.';

      case 'user-not-found':
        return 'لا يوجد حساب بهذا البريد الإلكتروني. يرجى إنشاء حساب جديد أولاً.';

      case 'wrong-password':
        return 'كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى أو إعادة تعيين كلمة المرور.';

      case 'user-disabled':
        return 'تم تعطيل هذا الحساب. يرجى التواصل مع الدعم الفني للمساعدة.';

      case 'missing-email':
        return 'يرجى إدخال البريد الإلكتروني.';

      case 'missing-password':
        return 'يرجى إدخال كلمة المرور.';

      // أخطاء العمليات
      case 'operation-not-allowed':
        return 'طريقة المصادقة هذه غير مفعّلة. يرجى التواصل مع الدعم الفني.';

      case 'requires-recent-login':
        return 'تتطلب هذه العملية تسجيل دخول حديث. يرجى تسجيل الدخول مرة أخرى.';

      // أخطاء الشبكة
      case 'network-request-failed':
        return 'خطأ في الاتصال بالإنترنت. يرجى التحقق من الاتصال والمحاولة مرة أخرى.';

      case 'too-many-requests':
        return 'عدد كبير جداً من المحاولات الفاشلة. يرجى المحاولة لاحقاً أو إعادة تعيين كلمة المرور.';

      // أخطاء بيانات الاعتماد
      case 'invalid-credential':
        return 'بيانات الاعتماد غير صالحة أو منتهية الصلاحية.';

      case 'credential-already-in-use':
        return 'بيانات الاعتماد هذه مرتبطة بالفعل بحساب آخر.';

      case 'account-exists-with-different-credential':
        return 'يوجد حساب بالفعل بهذا البريد الإلكتروني ولكن بطريقة تسجيل دخول مختلفة.';

      // أخطاء الجلسة
      case 'session-expired':
        return 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.';

      case 'user-token-expired':
        return 'انتهت صلاحية بيانات الاعتماد. يرجى تسجيل الدخول مرة أخرى.';

      case 'invalid-user-token':
        return 'بيانات الاعتماد غير صالحة. يرجى تسجيل الدخول مرة أخرى.';

      // أخطاء داخلية
      case 'internal-error':
        return 'حدث خطأ داخلي. يرجى المحاولة مرة أخرى.';

      // الافتراضي - للمراقبة والتسجيل
      default:
        debugPrint('كود خطأ Firebase غير معالج: ${exception.code}');
        debugPrint('رسالة الخطأ من Firebase: ${exception.message}');

        // ✅ استخدام رسالة Firebase كخيار احتياطي (تجربة مستخدم أفضل)
        return exception.message ??
            'فشلت عملية المصادقة. يرجى المحاولة مرة أخرى.';
    }
  }

  /// Maps FirebaseAuthException to user-friendly messages
  /// ✅ Takes the entire exception for maximum flexibility
  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      // EMAIL/PASSWORD AUTHENTICATION ERRORS
      case 'weak-password':
        return 'The password is too weak. Please use at least 6 characters with a mix of letters and numbers.';

      case 'email-already-in-use':
        return 'An account already exists with this email address. Please sign in or use a different email.';

      case 'invalid-email':
        return 'The email address is not valid. Please check and try again.';

      case 'user-not-found':
        return 'No account found with this email address. Please sign up first.';

      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';

      case 'user-disabled':
        return 'This account has been disabled. Please contact support for assistance.';

      case 'missing-email':
        return 'Please provide an email address.';

      case 'missing-password':
        return 'Please provide a password.';

      // OPERATION ERRORS
      case 'operation-not-allowed':
        return 'This authentication method is not enabled. Please contact support.';

      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please sign in again.';

      // NETWORK ERRORS
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';

      case 'too-many-requests':
        return 'Too many unsuccessful attempts. Please try again later or reset your password.';

      // CREDENTIAL ERRORS
      case 'invalid-credential':
        return 'The authentication credentials are invalid or have expired.';

      case 'credential-already-in-use':
        return 'This credential is already associated with a different account.';

      case 'account-exists-with-different-credential':
        return 'An account already exists with this email but uses a different sign-in method.';

      // SESSION ERRORS
      case 'session-expired':
        return 'Your session has expired. Please sign in again.';

      case 'user-token-expired':
        return 'Your credentials have expired. Please sign in again.';

      case 'invalid-user-token':
        return 'Your credentials are invalid. Please sign in again.';

      // INTERNAL ERRORS
      case 'internal-error':
        return 'An internal error occurred. Please try again.';

      // DEFAULT - Log for monitoring
      default:
        debugPrint('Unhandled Firebase Auth Error Code: ${exception.code}');
        debugPrint('Firebase Error Message: ${exception.message}');

        // ✅ Include Firebase's message as fallback (better UX)
        return exception.message ?? 'Authentication failed. Please try again.';
    }
  }
}

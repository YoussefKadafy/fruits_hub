import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fruits_hub/core/errors/custom_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FireBaseAuthService {
  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  /// Creates a new user account using email and password.
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

  ///log in user with email and password
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw CustomException(_mapFirebaseAuthExceptionToArabicMessage(e));
    } on CustomException {
      rethrow;
    } catch (e) {
      // Log unexpected errors for monitoring
      log('Unexpected error in signInWithEmailAndPassword: $e');
      throw CustomException(
        'An unexpected error occurred. Please try again later.',
      );
    }
  }

  /// log in with google
  /// log in with google

  Future<User> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize();
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return userCredential.user!;
    } on PlatformException catch (e) {
      // Handle Google Sign-In specific errors
      log('PlatformException in signInWithGoogle: ${e.code} - ${e.message}');
      throw CustomException(_mapPlatformExceptionToArabicMessage(e));
    } on CustomException {
      // Re-throw custom exceptions as-is
      rethrow;
    } catch (e) {
      // Log truly unexpected errors
      log('Unexpected error in signInWithGoogle: $e');
      throw CustomException('حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.');
    }
  }

  /// log in with facebook
  Future<User> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // User cancelled Facebook sign-in
      if (loginResult.status == LoginStatus.cancelled) {
        throw CustomException('تم إلغاء تسجيل الدخول باستخدام Facebook.');
      }

      // Login failed
      if (loginResult.status == LoginStatus.failed) {
        throw CustomException(
          loginResult.message ?? 'فشل تسجيل الدخول باستخدام Facebook.',
        );
      }

      final accessToken = loginResult.accessToken;

      if (accessToken == null) {
        throw CustomException('فشل الحصول على رمز الوصول من Facebook.');
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Sign in with Firebase
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential,
      );

      if (userCredential.user == null) {
        throw CustomException(
          'فشل تسجيل الدخول باستخدام Facebook. حاول مرة أخرى.',
        );
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw CustomException(_mapFirebaseAuthExceptionToArabicMessage(e));
    } on CustomException {
      rethrow;
    } catch (e) {
      log('Unexpected error in FIREBASE SERVICE signInWithFacebook: $e');
      throw CustomException(
        'حدث خطأ غير متوقع أثناء تسجيل الدخول باستخدام Facebook.',
      );
    }
  }

  /////////////////////////////////////////////
  /////////////////////////////////////////////
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

  /// PlatformException to user-friendly messages

  String _mapPlatformExceptionToArabicMessage(PlatformException e) {
    switch (e.code) {
      case 'sign_in_canceled_by_user':
        return 'تم إلغاء تسجيل الدخول باستخدام Google.';

      case 'sign_in_canceled':
        return 'تم إلغاء تسجيل الدخول باستخدام Google.';
      case 'network_error':
        return 'خطأ في الاتصال بالإنترنت. تحقق من اتصالك وحاول مرة أخرى.';
      case 'sign_in_failed':
        return 'فشل تسجيل الدخول. برجاء المحاولة مرة أخرى.';

      case 'account_exists_with_different_credential':
        return 'حساب موجود بالفعل باستخدام بيانات اخرى.';
      case 'invalid_credential':
        return 'بيانات التسجيل غير صالحة.';

      default:
        return 'حدث خطأ في Google Sign-In.';
    }
  }
}

import 'package:day_task/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  const String userPassword = 'Test123456@';
  const String userEmail = 'test@example.com';
  const String userName = 'Test Example';

  group('AuthService#singUp', () {
    test('Creates user account', () {
      final mockFirebaseAuth = MockFirebaseAuth();

      AuthService(instance: mockFirebaseAuth).signUp(
        userEmail,
        userPassword,
        userName,
      );

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });
  });

  group('AuthService#singIn', () {
    test('Creates user session', () {
      final mockUser = MockUser(
        uid: '123456',
        email: userEmail,
        displayName: userName,
      );

      mockUser.updatePassword(userPassword);

      final mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
      AuthService(instance: mockFirebaseAuth).signIn(
        mockUser.email!,
        userPassword,
      );

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });
  });

  group('AuthService#singOut', () {
    test('Closes user session', () {
      final mockUser = MockUser(
        uid: '123456',
        email: userEmail,
        displayName: userName,
      );

      mockUser.updatePassword(userPassword);

      final mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: mockUser.email!,
        password: userPassword,
      );

      AuthService(instance: mockFirebaseAuth).signOut();
      expect(mockFirebaseAuth.currentUser, isNull);
    });
  });
}

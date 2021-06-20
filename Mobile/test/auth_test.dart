import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cash_waqf/cubit/login/login_cubit.dart';
import 'package:flutter_cash_waqf/cubit/register/register_cubit.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Registration Test", () {
    blocTest(
      "Success Register",
      build: () {
        final MockAuthService mockService = MockAuthService();
        when(() => mockService.register(any(), any(), any()))
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil registrasi wakif.",
                  "data": {
                    "id": 1,
                    "nama": "Praditya Nafiis Muhammad",
                    "email": "pradityanafiis@gmail.com",
                    "password": "password",
                    "updated_at": "2021-03-19T01:01:21.357Z",
                    "created_at": "2021-03-19T01:01:21.357Z",
                  },
                }));
        return RegisterCubit(mockService);
      },
      act: (bloc) async => await (bloc as RegisterCubit)
          .tryRegister("name", "email", "password"),
      expect: () => [
        isA<RegisterLoadingState>(),
        isA<RegisterSuccessState>(),
      ],
    );
  });

  group("Login Test", () {
    blocTest(
      "Success Login",
      build: () {
        final MockAuthService mockService = MockAuthService();
        when(() => mockService.login(any(), any()))
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil masuk akun wakif",
                  "data": {
                    "id": 0,
                    "nik": "nik",
                    "nama": "nama",
                    "email": "email",
                    "password": "password",
                    "nomor_ponsel": "nomor_ponsel",
                    "alamat": "alamat",
                    "foto": "foto",
                    "created_at": "created_at",
                    "updated_at": "updated_at"
                  },
                  "accessToken": "accessToken"
                }));
        return LoginCubit(mockService);
      },
      act: (bloc) async =>
          await (bloc as LoginCubit).login("email", "password"),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginSuccessState>(),
      ],
    );

    blocTest(
      "Failure Login",
      build: () {
        final MockAuthService mockService = MockAuthService();
        when(() => mockService.login(any(), any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Akun wakif tidak ditemukan.",
                }));
        return LoginCubit(mockService);
      },
      act: (bloc) async =>
          await (bloc as LoginCubit).login("email", "password"),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginFailureState>(),
      ],
    );

    blocTest(
      "Exception Login",
      build: () {
        final MockAuthService mockService = MockAuthService();
        when(() => mockService.login(any(), any())).thenThrow(Exception());
        return LoginCubit(mockService);
      },
      act: (bloc) async =>
          await (bloc as LoginCubit).login("email", "password"),
      errors: () => [
        isA<Exception>(),
      ],
    );
  });
}

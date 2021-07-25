import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cash_waqf/cubit/login/login_cubit.dart';
import 'package:flutter_cash_waqf/cubit/register/register_cubit.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late final MockAuthService mockAuthService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockAuthService = MockAuthService();
  });

  setUp(() {
    reset(mockAuthService);
  });

  group("Registration Test", () {
    blocTest<RegisterCubit, RegisterState>(
      "Success",
      build: () {
        when(() => mockAuthService.register(any(), any(), any()))
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
        return RegisterCubit(mockAuthService);
      },
      act: (bloc) async => await bloc.tryRegister("name", "email", "password"),
      expect: () => [
        isA<RegisterLoadingState>(),
        isA<RegisterSuccessState>(),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      "Failure",
      build: () {
        when(() => mockAuthService.register(any(), any(), any())).thenAnswer(
            (_) async => Future.value({
                  "error": true,
                  "message": "Alamat email sudah pernah digunakan"
                }));
        return RegisterCubit(mockAuthService);
      },
      act: (bloc) async => await bloc.tryRegister("name", "email", "password"),
      expect: () => [
        isA<RegisterLoadingState>(),
        isA<RegisterFailureState>(),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      "Exception",
      build: () {
        when(() => mockAuthService.register(any(), any(), any()))
            .thenAnswer((_) async => Exception());
        return RegisterCubit(mockAuthService);
      },
      act: (bloc) async => await bloc.tryRegister("name", "email", "password"),
      expect: () => [
        isA<RegisterLoadingState>(),
        isA<RegisterFailureState>(),
      ],
    );
  });

  group("Login Test", () {
    blocTest<LoginCubit, LoginState>(
      "Success",
      build: () {
        when(() => mockAuthService.login(any(), any()))
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
        return LoginCubit(mockAuthService);
      },
      act: (bloc) async => await bloc.login("email", "password"),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginSuccessState>(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "Failure",
      build: () {
        when(() => mockAuthService.login(any(), any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Akun wakif tidak ditemukan.",
                }));
        return LoginCubit(mockAuthService);
      },
      act: (bloc) async => await bloc.login("email", "password"),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginFailureState>(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "Exception",
      build: () {
        when(() => mockAuthService.login(any(), any()))
            .thenAnswer((_) async => Exception());
        return LoginCubit(mockAuthService);
      },
      act: (bloc) async => await bloc.login("email", "password"),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginFailureState>(),
      ],
    );
  });
}

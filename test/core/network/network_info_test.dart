import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bia_flutter_test/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDataConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(() => mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        // NOTICE: We're NOT awaiting the result
        final result = networkInfo.isConnected;
        // assert
        verify(() => mockDataConnectionChecker.hasConnection);
        // Utilizing Dart's default referential equality.
        // Only references to the same object are equal.
        expect(result, tHasConnectionFuture);
      },
    );
  });
}

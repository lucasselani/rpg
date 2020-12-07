import 'package:rpg/base/functional/either.dart';
import 'package:rpg/base/functional/failure.dart';

abstract class AsyncUseCase<Out> {
  Future<Either<Failure, Out>> run();
}

abstract class UseCase<Out> {
  Out run();
}

import 'package:fpdart/fpdart.dart';
import 'package:komikoo/domain/models/core/failure.dart';
import 'package:komikoo/domain/models/core/paginated_data.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
typedef PaginatedResponse<T> = FutureEither<PaginatedData<T>>;

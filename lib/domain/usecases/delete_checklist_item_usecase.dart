import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

///
/// Abstract class defining the use case for deleting a checklist item.
///
abstract class IDeleteCheckListItemUsecase {
  ///
  /// Deletes a checklist item.
  ///
  Future<Either<Failure, Unit>> call({required CheckListItem item});
}

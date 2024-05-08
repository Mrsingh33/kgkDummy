abstract class UseCase<Type,Params>{
  Future<Type> call();
}

abstract class BaseUseCase<Type,Params>{
  Type call({ required Params params});
}
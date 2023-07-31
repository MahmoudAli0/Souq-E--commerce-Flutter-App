abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSucessStates extends ShopRegisterStates {
  final ShopLoginModel;

  ShopRegisterSucessStates(this.ShopLoginModel);
}

class ShopRegisterChangePasswordStates extends ShopRegisterStates {}

class ShopRegisterErorrStates extends ShopRegisterStates {
  final String error;

  ShopRegisterErorrStates(this.error);
}

class AuthGeneric {
  bool isLoading;
  bool isSuccess;

  AuthGeneric({this.isLoading = false, this.isSuccess = false});

  AuthGeneric update({bool? isLoading, bool? isSuccess}) {
    return AuthGeneric(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}

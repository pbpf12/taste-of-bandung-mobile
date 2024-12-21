part of '_logic.dart';

class EditProfileState extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  final bool isOffline;
  final UserModel? user;

  const EditProfileState({
    this.isLoading = true,
    this.isLoaded = false,
    this.isError = false,
    this.isOffline = false,
    this.user,
  });

  EditProfileState copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isError,
    bool? isOffline,
    UserModel? user,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isError: isError ?? this.isError,
      isOffline: isOffline ?? this.isOffline,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoaded,
    isError,
    isOffline,
    user,
  ];
}

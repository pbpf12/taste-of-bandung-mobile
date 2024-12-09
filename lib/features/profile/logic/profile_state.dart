part of '_logic.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  final bool isOffline;
  final UserModel? user;
  final List<HistoryModel> history;

  const ProfileState({
    this.isLoading = true,
    this.isLoaded = false,
    this.isError = false,
    this.isOffline = false,
    this.user,
    this.history = const [],
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isError,
    bool? isOffline,
    UserModel? user,
    List<HistoryModel>? history,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isError: isError ?? this.isError,
      isOffline: isOffline ?? this.isOffline,
      user: user ?? this.user,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoaded,
    isError,
    isOffline,
    user,
    history,
  ];
}

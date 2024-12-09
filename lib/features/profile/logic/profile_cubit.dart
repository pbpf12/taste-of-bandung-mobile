// ignore_for_file: use_build_context_synchronously

part of '_logic.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileCubit(
    this._remoteDataSource
  ) : super(const ProfileState());

  void setApiRequestStatus(String status) async {
    if (kDebugMode) {
      print('Current API Request Status : $status');
    }

    emit(
      state.copyWith(
        isLoading: status == 'LOADING',
        isLoaded: status == 'LOADED',
        isError: status == 'ERROR',
      ),
    );
  }

  void setHistoryData(List<HistoryModel> newHistorydata) {
    emit(state.copyWith(history: newHistorydata));
  }

  void setProfileData(UserModel newUserData) {
    emit(state.copyWith(user: newUserData));
  }

  Future<void> retrieveData(BuildContext context) async {
    try {
      setApiRequestStatus('LOADING');
      final resp = await _remoteDataSource.getHistory();
      final resp2 = await _remoteDataSource.getUserData(context);

      await resp.fold((failure) async {
        setApiRequestStatus('ERROR');
      }, (success) async {
        setApiRequestStatus('LOADED');
        final data = success;
        setHistoryData(data);
      });

      await resp2.fold((failure) async {
        setApiRequestStatus('ERROR');
      }, (success) async {
        setApiRequestStatus('LOADED');
        final data = success;
        setProfileData(data);
      });
    } catch (e) {
      setApiRequestStatus('ERROR');
    }
  }
}

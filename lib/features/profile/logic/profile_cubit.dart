// ignore_for_file: use_build_context_synchronously

part of '_logic.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileCubit(this._remoteDataSource) : super(const ProfileState());

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
    print(newHistorydata);
    emit(state.copyWith(history: newHistorydata));
  }

  void setProfileData(UserModel newUserData) {
    print(newUserData);
    emit(state.copyWith(user: newUserData));
  }

  Future<void> retrieveData() async {
    try {
      setApiRequestStatus('LOADING');
      final resp = await _remoteDataSource.getUserData();
      final resp2 = await _remoteDataSource.getHistory();

      await resp.fold((failure) async {
        print('Error loading user data: $failure');
        setApiRequestStatus('ERROR LOADING USER');
      }, (success) async {
        setApiRequestStatus('LOADED USER');
        final data = success;
        setProfileData(data);
      });

      await resp2.fold((failure) async {
        setApiRequestStatus('ERROR LOADING HISTORY');
      }, (success) async {
        setApiRequestStatus('LOADED HISTORY');
        final data = success;
        setHistoryData(data);
      });
    } catch (e) {
      setApiRequestStatus('ERROR LOADING DATA');
    }
  }
}

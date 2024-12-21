part of '_logic.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRemoteDataSource _remoteDataSource;

  EditProfileCubit(this._remoteDataSource) : super(const EditProfileState());

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

  void setProfileData(UserModel newUserData) {
    emit(state.copyWith(user: newUserData));
  }

  Future<void> retrieveData() async {
    try {
      setApiRequestStatus('LOADING');
      final resp = await _remoteDataSource.getUserData();

      await resp.fold((failure) async {
        setApiRequestStatus('ERROR LOADING USER');
      }, (success) async {
        setApiRequestStatus('LOADED USER');
        final data = success;
        print('User Data: ${data.username}');  
        setProfileData(data);
      });

      setApiRequestStatus('LOADED');
    } catch (e) {
      setApiRequestStatus('ERROR');
    }
  }

  Future<void> updateUserData(dynamic data) async {
    try {
      setApiRequestStatus('LOADING');
      final resp = await _remoteDataSource.updateUserData(data);

      await resp.fold((failure) async {
        setApiRequestStatus('ERROR UPDATING USER');
      }, (success) async {
        setApiRequestStatus('LOADED USER');
        final data = success;
        setProfileData(data);
      });

      setApiRequestStatus('LOADED');
    } catch (e) {
      setApiRequestStatus('ERROR');
    }
  }
}

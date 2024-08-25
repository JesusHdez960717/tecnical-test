import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tecnical_test/api/api_response.dart';
import 'package:tecnical_test/api/api_test.dart';

final userProvider = StateNotifierProvider<UserProvider,
    AsyncValue<PagingController<int, UserResponse>>>((ref) {
  return UserProvider();
});

class UserProvider
    extends StateNotifier<AsyncValue<PagingController<int, UserResponse>>> {
  late PagingController<int, UserResponse> pagingController;

  static const int defaultPageSize = 15;
  final ApiTest _apiService = ApiTest();

  UserProvider() : super(const AsyncValue.loading()) {
    _resetPageController();
    fetchUsers();
  }

  void _resetPageController() {
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener(
      (pageKey) => fetchUsers(page: pageKey),
    );
  }

  Future<void> fetchUsers({
    int page = 0,
  }) async {
    try {
      //si es el primer page, reinicio el estado y el paging a cero
      //muestro loading (asi con el refresh-page tambien se muestra loading)
      if (page == 0) {
        _resetPageController();
        state = const AsyncValue.loading();
      }

      //cargo los usuarios nuevos
      final users = await _apiService.fetch(page: page, size: defaultPageSize);

      //veo si lo agrego porque hay mas o xq es el ultimo
      if (users.length < defaultPageSize) {
        pagingController.appendLastPage(users);
      } else {
        pagingController.appendPage(users, page + 1);
      }

      //valido el estado que voy a emitir, si NO es data lo emito de cero
      //si no, se agrega la info a la vieja
      if (state is! AsyncData) {
        state = AsyncValue.data(pagingController);
      } else {
        state = state.whenData((value) {
          return pagingController;
        });
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

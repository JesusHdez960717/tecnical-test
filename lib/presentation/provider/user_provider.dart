import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tecnical_test/data/repo/repo_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';

final userProvider = StateNotifierProvider<UserProvider,
    AsyncValue<PagingController<int, UserDomain>>>((ref) {
  return UserProvider();
});

class UserProvider
    extends StateNotifier<AsyncValue<PagingController<int, UserDomain>>> {
  late PagingController<int, UserDomain> pagingController;

  static const int defaultPageSize = 15;
  final UserRepo _repo = UserRepo();

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
      final users = await _repo.fetch(page: page, size: defaultPageSize);

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

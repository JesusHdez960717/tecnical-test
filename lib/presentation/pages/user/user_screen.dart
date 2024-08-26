import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tecnical_test/app_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';
import 'package:tecnical_test/presentation/pages/user/widget/user_tile.dart';
import 'package:tecnical_test/presentation/provider/provider_exporter.dart';

import 'details/details_screen.dart';

class GeneralScreen extends ConsumerWidget {
  //#region navigation-config
  static const String routeName = 'users';
  static const String routePath = '/$routeName';

  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const GeneralScreen();

  static void go() {
    Global.context.goNamed(GeneralScreen.routeName);
  }

  //#endregion navigation-config

  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PagingController<int, UserDomain>> activity =
        ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(intl.userList),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(userProvider.notifier).fetchUsers(),
        child: activity.when(
          data: (data) => PagedListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            pagingController: data,
            builderDelegate: PagedChildBuilderDelegate<UserDomain>(
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text(intl.noData),
              ),
              noMoreItemsIndicatorBuilder: (context) => Center(
                child: Text(
                  intl.noMoreUsers,
                ),
              ),
              itemBuilder: (context, item, index) => UserTile(
                item: item,
                onTap: () => DetailsScreen.push(item),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 0,
              indent: 0,
              thickness: 1,
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(intl.errorLoadingUsersFromApi),
                ElevatedButton(
                  onPressed: () {
                    ref.read(userProvider.notifier).fetchUsers();
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

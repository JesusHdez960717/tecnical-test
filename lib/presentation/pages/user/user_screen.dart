import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tecnical_test/app_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';
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
        title: Text(intl.technicalTest),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(userProvider.notifier).fetchUsers(),
        child: activity.when(
          data: (data) => PagedListView<int, UserDomain>(
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
              itemBuilder: (context, item, index) => _buildSingleItem(item),
            ),
          ),
          error: (error, stackTrace) => Text(intl.errorLoadingUsersFromApi),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildSingleItem(UserDomain item) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () => DetailsScreen.push(item),
        child: ListTile(
          leading: Image.network(item.picture.thumbnail),
          title: Text(
            '${item.name.title} ${item.name.first} ${item.name.last}',
          ),
          subtitle: Text(item.email),
        ),
      ),
    );
  }
}

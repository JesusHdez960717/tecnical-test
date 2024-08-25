import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:tecnical_test/config/config_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';
import 'package:tecnical_test/app_exporter.dart';

class DetailsScreen extends StatelessWidget {
  //#region navigation-config
  static const String routeName = 'details';
  static const String routePath = '/$routeName';

  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return DetailsScreen(
      userDomain: state.extra as UserDomain,
    );
  }

  static void push(UserDomain user) {
    Global.context.pushNamed(
      DetailsScreen.routeName,
      extra: user,
    );
  }

  //#endregion navigation-config
  //#region map-default-config
  static const double markerSize = 50.0;

  //#endregion map-default-config
  final UserDomain userDomain;
  late final LatLng userLocation;

  final MapController controller = MapController();

  DetailsScreen({
    required this.userDomain,
    super.key,
  }) {
    userLocation = LatLng(
      userDomain.location.coordinates.latitude,
      userDomain.location.coordinates.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(intl.details),
        actions: [
          Tooltip(
            message: intl.goToMarker,
            child: IconButton(
              onPressed: () {
                controller.move(
                  userLocation,
                  MapConfig.defaultZoom,
                );
              },
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AssetsConfig.myLocationUrl,
                  semanticsLabel: AssetsConfig.myLocationUrl,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: userLocation,
              initialZoom: MapConfig.defaultZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: MapConfig.urlTemplate,
                userAgentPackageName: MapConfig.pckName,
                minNativeZoom: MapConfig.minZoom,
                maxNativeZoom: MapConfig.maxZoom,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    alignment: Alignment.topCenter,
                    point: userLocation,
                    width: markerSize,
                    height: markerSize,
                    child: SvgPicture.asset(
                      AssetsConfig.markerUrl,
                      semanticsLabel: AssetsConfig.markerUrl,
                      width: markerSize,
                      height: markerSize,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

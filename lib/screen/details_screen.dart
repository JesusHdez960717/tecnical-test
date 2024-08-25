import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:tecnical_test/api/api_response.dart';
import 'package:tecnical_test/main.dart';

class DetailsScreen extends StatelessWidget {
  //#region navigation-config
  static const String routeName = 'details';
  static const String routePath = '/$routeName';

  static Widget routeBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return DetailsScreen(
      user: state.extra as UserResponse,
    );
  }

  static void push(UserResponse user) {
    Global.context.pushNamed(
      DetailsScreen.routeName,
      extra: user,
    );
  }

  //#endregion navigation-config
  //#region map-default-config
  static const double defaultZoom = 15.0;
  static const int minZoom = 10;
  static const int maxZoom = 20;

  static const String urlTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String pckName = 'dev.root101.tecnical_test';

  static const String markerUrl = 'assets/map/marker.svg';
  static const double markerSize = 50.0;

  static const String myLocationUrl = 'assets/map/my-location.svg';

  //#endregion map-default-config
  final UserResponse user;
  late final LatLng userLocation;

  final MapController controller = MapController();

  DetailsScreen({
    required this.user,
    super.key,
  }) {
    userLocation = LatLng(
      user.location.coordinates.latitude,
      user.location.coordinates.longitude,
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
                  defaultZoom,
                );
              },
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  myLocationUrl,
                  semanticsLabel: myLocationUrl,
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
              initialZoom: defaultZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: urlTemplate,
                userAgentPackageName: pckName,
                minNativeZoom: minZoom,
                maxNativeZoom: maxZoom,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    alignment: Alignment.topCenter,
                    point: userLocation,
                    width: markerSize,
                    height: markerSize,
                    child: SvgPicture.asset(
                      markerUrl,
                      semanticsLabel: markerUrl,
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

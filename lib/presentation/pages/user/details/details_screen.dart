import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:tecnical_test/app_exporter.dart';
import 'package:tecnical_test/config/config_exporter.dart';
import 'package:tecnical_test/domain/domain_exporter.dart';
import 'package:tecnical_test/presentation/pages/user/widget/user_tile.dart';

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
  late final LatLng cameraLocation;

  final MapController controller = MapController();

  DetailsScreen({
    required this.userDomain,
    super.key,
  }) {
    userLocation = LatLng(
      userDomain.location.coordinates.latitude,
      userDomain.location.coordinates.longitude,
    );
    //la vista de la camara va a estar deplegada un poco hacia arriba (de manera que el marker quede por debajo)
    //para que haya espacio en la parte superior para la info del usuario
    cameraLocation = LatLng(
      userDomain.location.coordinates.latitude + 0.001,
      userDomain.location.coordinates.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message: intl.goToMarker,
        child: FloatingActionButton(
          onPressed: () {
            controller.move(
              cameraLocation,
              MapConfig.defaultZoom,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AssetsConfig.myLocationUrl,
              semanticsLabel: AssetsConfig.myLocationUrl,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(intl.details),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildMap(),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: _buildUserInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: cameraLocation,
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
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: SizedBox(
          height: 75,
          width: double.infinity,
          child: UserTile(
            item: userDomain,
            showGender: true,
          ),
        ),
      ),
    );
  }
}

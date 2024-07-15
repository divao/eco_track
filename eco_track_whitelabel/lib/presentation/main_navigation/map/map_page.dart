import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/dialog_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/flushbar_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/state_response_view.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/map/bloc/map_bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/map/bloc/map_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/map/bloc/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({
    required this.bloc,
    super.key,
  });

  final MapBloc bloc;

  static Widget create() => Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(mapBlocProvider);
          return MapPage(bloc: bloc);
        },
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  MapBloc get _bloc => widget.bloc;

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(GetMap());
  }

  void _requestPermission() async {
    DialogHandler.instance.showLocationPermissionInfoDialog(context, ref,
        onConfirmPressed: () {
      Permission.location.request().then(
        (status) {
          if (status == PermissionStatus.granted) {
            _bloc.add(GetMap());
          } else if (status == PermissionStatus.permanentlyDenied) {
            openAppSettings();
          } else {
            FlushbarHandler.instance
                .permissionsDeniedFlushbar(context, ref: ref);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
      title: ref.s.mapPageTitle,
      body: BlocBuilder<MapBloc, MapState>(
          bloc: _bloc,
          builder: (context, state) {
            return StateResponseView<Loading, Error, Success>(
                state: state,
                onTryAgainTap: () async {
                  _requestPermission();
                },
                errorWidgetBuilder: (context, error, onTryAgain) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ref.s.flushbarPermissionsErrorMessage,
                            style: ref.textStyles.errorText,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          TextButton(
                              onPressed: onTryAgain,
                              style: TextButton.styleFrom(
                                foregroundColor: ref.colors.primaryColor,
                              ),
                              child: Text(ref.s.tryAgain)),
                        ],
                      ),
                    ),
                  );
                },
                successWidgetBuilder: (context, success) {
                  final postList = success.feedPostList;
                  final geolocation = success.geolocation;
                  final center = LatLng(
                    geolocation.latitude,
                    geolocation.longitude,
                  );
                  final Map<String, Marker> _markers = {};
                  for (final (index, post) in postList.indexed) {
                    final marker = Marker(
                      markerId: MarkerId(index.toString()),
                      position: LatLng(
                        post.geolocation.latitude,
                        post.geolocation.longitude,
                      ),
                      infoWindow: InfoWindow(
                        title: post.name,
                        snippet: post.description,
                      ),
                    );
                    _markers[index.toString()] = marker;
                  }
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: center,
                          zoom: 9.0,
                        ),
                        markers: _markers.values.toSet(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: IconButton(
                            icon: const Icon(Icons.refresh),
                            iconSize: 36,
                            style: IconButton.styleFrom(
                              foregroundColor: ref.colors.surfaceColor,
                              backgroundColor: ref.colors.primaryColor,
                            ),
                            onPressed: () {
                              _bloc.add(GetMap());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}

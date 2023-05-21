import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/components/loader.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/models/user.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/auth/auth.provider.dart';
import 'package:traveller/states/history/history.provider.dart';
import 'package:traveller/utils/colors.dart';
import 'package:traveller/utils/distance.dart';

class ProfileHome extends ConsumerStatefulWidget {
  const ProfileHome({
    Key? key,
    required this.user,
  });

  final User user;

  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends ConsumerState<ProfileHome> {
  final _loadingProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context) {
    final _loading = ref.watch(_loadingProvider);
    final destinations = ref.watch(historyProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(historyProvider.notifier).initialize();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 325.0,
              width: double.infinity,
              color: AppColors.primary,
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 15.0),
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(widget.user.avatar),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        widget.user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.user.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppColors.dark,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: Size(50, 30),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () async {
                      if (_loading) return;

                      ref.read(_loadingProvider.notifier).state = true;
                      await ref.read(authProvider.notifier).logoutUser();
                      ref.read(_loadingProvider.notifier).state = false;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: _loading
                          ? Loader()
                          : Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Previously viewed destinations:",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for (final Destination destination
                          in destinations.allData)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DestinationScreen(
                                  destinationId: destination.id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CachedImage(
                                        imageUrl: destination.imageUrl,
                                        height: 60,
                                        width: 60,
                                        radius: 20,
                                      ),
                                      Container(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(height: 5),
                                            Text(
                                              destination.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: GoogleFonts.lato(
                                                color: AppColors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Container(height: 5),
                                            Text(
                                              getDistance(
                                                ref,
                                                latitude: destination.latitude,
                                                longitude:
                                                    destination.longitude,
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.grey[700],
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

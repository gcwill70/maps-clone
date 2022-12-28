import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_clone/home_map/home_map.dart';
import 'package:maps_clone/map/map.dart';
import 'package:maps_clone/nav/view/nav_form.dart';
import 'package:maps_clone/profile/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('maps-clone')),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.directions_outlined),
        onPressed: () => Navigator.push(context, NavForm.route()),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 150,
                  child: DrawerHeader(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Icon(Icons.map_outlined),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  subtitle: Text(
                    (BlocProvider.of<ProfileBloc>(context).state
                                as ProfileLoaded)
                            .profile
                            .email ??
                        '',
                  ),
                  onTap: () => Navigator.push(context, ProfilePage.route()),
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => MapBloc(),
        child: const HomeMapView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/bloc/worker_bloc.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AppBar(
            titleSpacing: 24,
            automaticallyImplyLeading: false, // Remove back button
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Q',
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 32),
                      ),
                      TextSpan(
                        text: 'uik',
                        style: TextStyle(fontFamily: 'Moonhouse', fontSize: 24),
                      ),
                      TextSpan(
                        text: 'Hyr',
                        style: TextStyle(
                            fontFamily: 'Trap',
                            fontSize: 24,
                            letterSpacing: -1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.bellNotificationActiveSvg,
                  onTap: () {
                    //HANDLE GO TO NOTIFICATIONS
                  }),
              QuikSpacing.hS10(),
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.logoutSvg,
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              QuikSpacing.hS24(),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: BlocBuilder<WorkerBloc, WorkerState>(
                builder: (context, state) {
                  if (state is WorkerLoaded) {
                    return Column(
                      children: [
                        Text(
                          state.worker.id,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.email,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.phone,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Image.network(
                          state.worker.avatar,
                          width: 240,
                          height: 240,
                        ),
                        Text(
                          state.worker.location.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.gender,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.pincode,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.age.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.worker.available.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Subservices: ${state.worker.subserviceIds}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Services: ${state.worker.serviceIds}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.pushNamed(QuikRoutes.homeDetailsName);
                          },
                          child: const Text("Go To Home Detail"),
                        ),
                      ],
                    );
                  } else if (state is WorkerError) {
                    return Text(state.error);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Update Pincode'),
                content: TextField(
                  controller: _pincodeController,
                  decoration: InputDecoration(hintText: "Enter new pincode"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Update'),
                    onPressed: () {
                      context
                          .read<WorkerBloc>()
                          .add(UpdatePincode(_pincodeController.text));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

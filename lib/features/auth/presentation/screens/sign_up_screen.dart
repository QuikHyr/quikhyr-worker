import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quikhyr_worker/common/bloc/worker_bloc.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_dialogs.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';
import 'package:quikhyr_worker/features/auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/bloc/service_and_subservice_list_bloc.dart';
import 'package:quikhyr_worker/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:quikhyr_worker/features/auth/presentation/components/my_text_field.dart';
import 'package:quikhyr_worker/features/chat/firebase_storage_service.dart';
import 'package:quikhyr_worker/features/chat/media_service.dart';
import 'package:quikhyr_worker/features/chat/notification_service.dart';
import 'package:quikhyr_worker/models/location_model.dart';
import 'package:quikhyr_worker/models/service_model.dart';
import 'package:quikhyr_worker/models/subservices_model.dart';
import 'package:quikhyr_worker/models/worker_model.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController pageController = PageController();
  // int _curr = 0;
  final TextEditingController _passwordController = TextEditingController();
  static final notifications = NotificationsService();

  @override
  void initState() {
    super.initState();
    context
        .read<ServiceAndSubserviceListBloc>()
        .add(GetServicesAndSubservices());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page!.toInt() == 0) {
          bool shouldClose = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmation'),
                  content:
                      const Text('Are you sure you want to close the app?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ) ??
              false;
          return shouldClose;
        } else {
          pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            buildAddDetails(),
            buildSignUp(),
            buildSetPassword(),
            buildProfileInfo(),
          ],
          // onPageChanged: (num) {
          //   setState(() {
          //     _curr = num;
          //   });
          // },
        ),
      ),
    );
  }

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _workerDetailsProfileFormKey =
      GlobalKey<FormState>();

  final GlobalKey<FormState> _setPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _profileInfoFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _genderController = TextEditingController();

  Pages buildProfileInfo() {
    return Pages(
      formKey: _profileInfoFormKey,
      pageController: pageController,
      onButtonPressed: () {
        if (_profileInfoFormKey.currentState!.validate()) {
          // // Calculate age based on dob
          // int calculateAge(DateTime dob) {
          //   final now = DateTime.now();
          //   int age = now.year - dob.year;
          //   if (now.month < dob.month ||
          //       (now.month == dob.month && now.day < dob.day)) {
          //     age--;
          //   }
          //   return age;
          // }

          // int age = calculateAge(DateTime.parse(_dobController.text));

          // WorkerModel user = WorkerModel(
          //   summary: 'WORKER DEMO SUMMARY',
          //   id: '', // This will be generated by Firebase
          //   email: _emailController.text.trim(),
          //   name: _nameController.text.trim(),
          //   phone: _phoneController.text.trim(),
          //   gender: _genderController.text.trim(),
          //   avatar: _avatar,
          //   age: age,
          //   available: false,
          //   location: LocationModel(
          //     latitude: _position.latitude,
          //     longitude: _position.latitude,
          //   ),
          //   pincode: _pincodeController.text.trim(),
          //   fcmToken: "testWorker1fcmToken",
          //   isVerified: false,
          //   isActive: false,
          //   subserviceIds: _selectedSubServicesList.map((e) => e.id).toList(),
          //   serviceIds: _selectedServicesList.map((e) => e.id).toList(),
          // );
          showAccountCreationSuccessSnackBar(context);
          // context.read<SignUpBloc>().add(
          //     SignUpRequired(worker: user, password: _passwordController.text));
        }
      },
      color: Colors.grey,
      buttonText: "Continue",
      children: [
        const SizedBox(
          height: 64.0,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Profile Information",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF313131),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                fillColor: const Color.fromRGBO(51, 153, 204, 0.12),
                filled: true,
                hintText: "Select Gender",
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(233, 234, 236, 0.50),
                  fontFamily: 'Trap',
                  fontSize: 13,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              style: const TextStyle(
                color: Color(
                    0xFFFAFFFF), // This is the color used when an item is selected
                fontFamily: 'Trap', // This is the font used
              ),
              items: <String>['Male', 'Female', 'Other', 'Rather not say']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Color(
                          0xFFFAFFFF), // This is the color used when an item is selected
                      fontFamily: 'Trap', // This is the font used
                      fontSize: 14.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Update the gender controller with the selected value
                _genderController.text = newValue ?? '';
              },
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: _dobController,
          hintText: "Enter date of birth*",
          obscureText: false,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your date of birth';
            }
            return null;
          },
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              _dobController.text = "${picked.toLocal()}".split(' ')[0];
            }
          },
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: _pincodeController,
          hintText: "Enter Pincode*",
          obscureText: false,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your pincode';
            } else if (value.length != 6) {
              return 'Pincode must be 6 digits';
            }
            return null;
          },
        ),
      ],
    );
  }

  Pages buildSetPassword() {
    TextEditingController confirmPasswordController = TextEditingController();
    return Pages(
      formKey: _setPasswordFormKey,
      pageController: pageController,
      onButtonPressed: () {
        if (_setPasswordFormKey.currentState!.validate()) {
          // Navigate to the next page
          pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }
      },
      color: Colors.red.shade100,
      buttonText: "Profile Info",
      children: [
        const SizedBox(
          height: 64.0,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Set Password",
              style: TextStyle(
                color: Color(0xFFE9EAEC),
                fontFamily: 'Trap',
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              )),
        ),
        const SizedBox(
          height: 24.0,
        ),
        MyTextField(
          controller: _passwordController,
          hintText: "Enter password*",
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: confirmPasswordController,
          hintText: "Confirm password*",
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  List<ServiceModel> _selectedServicesList = [];
  List<SubserviceModel> _selectedSubServicesList = [];
  List<ServiceModel> _allServicesList = [];
  List<SubserviceModel> _allSubservicesList = [];
  Position _position = Position(
    headingAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    latitude: 10.353987,
    longitude: 76.210751,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );
  String _avatar = QuikAssetConstants.placeholderImage;
  Future<void> handleImagePickingAndUploadingFromGallery() async {
    final image = await MediaService.pickImage();
    if (image != null) {
      //!! GIVE SUITABLE NAME TO STORAGE SERVICE
      _avatar =
          await FirebaseStorageService.uploadImage(image, '${DateTime.now()}');
      setState(() {});
    }
  }

  Future<void> handleImagePickingAndUploadingFromCamera() async {
    final image = await MediaService.pickImageFromCamera();
    if (image != null) {
      //!! GIVE SUITABLE NAME TO STORAGE SERVICE
      _avatar =
          await FirebaseStorageService.uploadImage(image, '${DateTime.now()}');
      setState(() {});
    }
  }

  Pages buildAddDetails() {
    return Pages(
        formKey: _workerDetailsProfileFormKey,
        showLogo: false,
        pageController: pageController,
        onButtonPressed: () async {
          if (_workerDetailsProfileFormKey.currentState!.validate()) {
            bool serviceEnabled;
            LocationPermission permissionGranted;

            serviceEnabled = await Geolocator.isLocationServiceEnabled();
            if (!serviceEnabled) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enable location services'),
                  ),
                );
              }
              return;
            }

            permissionGranted = await Geolocator.checkPermission();
            if (permissionGranted == LocationPermission.denied) {
              permissionGranted = await Geolocator.requestPermission();
              if (permissionGranted != LocationPermission.always &&
                  permissionGranted != LocationPermission.whileInUse) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Location permission is denied'),
                    ),
                  );
                }
                return;
              }
            }

            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            context.read<WorkerBloc>().add(UpdateLocation(LocationModel(
                latitude: position.latitude, longitude: position.longitude)));
            bool isValid = true;
            for (var service in _selectedServicesList) {
              if (!_selectedSubServicesList
                  .any((subservice) => subservice.serviceId == service.id)) {
                isValid = false;
                break;
              }
            }
            if (!isValid) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Please select at least one subservice for each selected service')),
              );
              return;
            }
            // Navigate to the next page
            pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          }
        },
        color: Colors.teal,
        buttonText: "Profile Info",
        children: [
          QuikSpacing.vS24(),
          ClipOval(
            child: Image.network(
              _avatar,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          QuikSpacing.vS12(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => handleImagePickingAndUploadingFromGallery(),
                child: const Text(
                  'Select from Gallery',
                  style: chatSubTitleRead,
                ),
              ),
              ElevatedButton(
                onPressed: () => handleImagePickingAndUploadingFromCamera(),
                child: const Text(
                  'Take a Photo',
                  style: chatSubTitleRead,
                ),
              ),
            ],
          ),
          QuikSpacing.vS24(),
          BlocConsumer<ServiceAndSubserviceListBloc,
              ServiceAndSubserviceListState>(
            listener: (context, state) {
              if (state is ServiceAndSubserviceListLoaded) {
                _allServicesList = state.serviceModels;
                _allSubservicesList = state
                    .subserviceModels; // assuming services is a list in ServiceModel
              }
            },
            builder: (context, state) {
              if (state is ServiceAndSubserviceListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ServiceAndSubserviceListLoaded) {
                debugPrint(_allSubservicesList.toString());
                debugPrint(_allServicesList.toString());

                return Column(
                  children: [
                    QuikSpacing.vS32(),
                    MultiSelectDialogField<ServiceModel>(
                      decoration: BoxDecoration(
                        color: textInputBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      buttonText: const Text("Select Services"),
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      itemsTextStyle: chatSubTitleRead,
                      selectedItemsTextStyle: chatSubTitleRead,
                      items: _allServicesList
                          .map((service) => MultiSelectItem<ServiceModel>(
                              service, service.name))
                          .toList(),
                      title: const Text(
                        "Services",
                        style: chatSubTitleRead,
                      ),
                      selectedColor: primary,
                      onConfirm: (values) {
                        setState(() {
                          _selectedServicesList = values;
                        });
                      },
                    ),
                    QuikSpacing.vS20(),
                    MultiSelectDialogField<SubserviceModel>(
                      buttonText: const Text("Select Subservices"),
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      decoration: BoxDecoration(
                        color: textInputBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      itemsTextStyle: chatSubTitleRead,
                      selectedItemsTextStyle: chatSubTitleRead,
                      items: _allSubservicesList
                          .where((subservice) => (_selectedServicesList).any(
                              (service) => service.id == subservice.serviceId))
                          .map((subservice) => MultiSelectItem<SubserviceModel>(
                              subservice, subservice.name))
                          .toList(),
                      title: const Text(
                        "Sub Services",
                        style: chatSubTitleRead,
                      ),
                      selectedColor: primary,
                      onConfirm: (values) {
                        setState(() {
                          _selectedSubServicesList = values;
                        });
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('Error loading services'));
              }

              // Add dropdown menus for service and subservice selection in the appropriate place
              // return DropdownButtonFormField<String>(
              //   items: _services.map((service) {
              //     return DropdownMenuItem<String>(
              //       value: service.id, // assuming id is a field in ServiceModel
              //       child: Text(service.name), // assuming name is a field in ServiceModel
              //     );
              //   }).toList(),
              //   onChanged: (serviceId) {
              //     context.read<ServiceAndSubserviceListBloc>().add(GetSubserviceList(serviceId: serviceId!));
              //   },
              // );
              // Similarly for subservices
            },
          ),
        ]);
  }

  Pages buildSignUp() {
    return Pages(
      formKey: _signUpFormKey,
      pageController: pageController, // Added pageController here
      onButtonPressed: () {
        if (_signUpFormKey.currentState!.validate()) {
          // Navigate to the next page
          pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }
      },
      color: Colors.teal,
      buttonText: "Set Password",
      children: [
        const SizedBox(
          height: 32.0,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Name",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: _nameController,
          hintText: "Enter name*",
          obscureText: false,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 24.0,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Phone and Email",
            style: TextStyle(
              color: Color(0xFFE9EAEC),
              fontFamily: 'Trap',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: _phoneController,
          hintText: "Enter phone*",
          obscureText: false,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            // String for phone number validation
            String pattern = r'^(\+?\d{1,4}[\s-])?(?!0+\s+,?$)\d{10}\s*,?$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value)) {
              return 'Enter a valid phone number';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12.0,
        ),
        MyTextField(
          controller: _emailController,
          hintText: "Enter email*",
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            // Regular expression for email validation
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = RegExp(pattern.toString());
            if (!regex.hasMatch(value)) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class Pages extends StatelessWidget {
  final Color color;
  final String buttonText;
  final List<Widget> children;
  final PageController pageController;
  final VoidCallback onButtonPressed;
  final GlobalKey<FormState> formKey;
  final bool? showLogo;

  const Pages(
      {super.key,
      required this.color,
      required this.buttonText,
      required this.children,
      required this.pageController,
      required this.onButtonPressed,
      required this.formKey,
      this.showLogo = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(QuikAssetConstants.welcomeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // if (showLogo == true)
                      SvgPicture.asset(
                        QuikAssetConstants.logoSvg,
                        width: 200,
                      ),
                      ...children,
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (showLogo == true)
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "*Required",
                            style: TextStyle(
                              color: Color.fromRGBO(233, 234, 236, 0.50),
                              fontFamily: 'Trap',
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  MultiBlocListener(
                    listeners: [
                      BlocListener<SignInBloc, SignInState>(
                        listener: (context, state) {
                          if (state is SignUpSuccess) {
                            showAccountCreationSuccessSnackBar(context);

                            context.read<AuthenticationBloc>().add(
                                const AuthenticationCheckUserLoggedInEvent());
                            // context.read<WorkerBloc>().add(FetchWorker());
                            // context.goNamed(QuikRoutes.homeName);
                          }
                        },
                      ),
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        // listenWhen: (previous, current) {
                        //   return previous.status != current.status;
                        // },
                        listener: (context, state) {
                          if (state.status == AuthenticationStatus.registered) {
                            context.read<WorkerBloc>().add(FetchWorker());
                          }
                        },
                      ),
                    ],
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        //!!BETTER WAY TO INCLUDE SIGNUPSUCCESS MAY BE TO RESET STATES ON USER LOGOUT
                        if (state is SignUpInitial || state is SignUpSuccess) {
                          return LongIconButton(
                            text: buttonText,
                            onPressed: onButtonPressed,
                            svgPath: QuikAssetConstants.rightArrowSvg,
                          );
                        } else if (state is SignUpProcess) {
                          return LongIconButton(
                            isLoading: true,
                            text: "Please wait...",
                            onPressed: () {},
                            svgPath: QuikAssetConstants.rightArrowSvg,
                          );
                        } else {
                          return LongIconButton(
                            text: "Please wait...",
                            onPressed: () {},
                            svgPath: QuikAssetConstants.rightArrowSvg,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(QuikRoutes.signInName);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: " Log in ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// final List<Widget> _list = <Widget>[];

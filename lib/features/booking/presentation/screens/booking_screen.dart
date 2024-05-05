import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/quik_asset_constants.dart';
import '../../../../common/quik_colors.dart';
import '../../../../common/quik_spacings.dart';
import '../../../../common/quik_themes.dart';
import '../../../../common/widgets/quik_app_bar.dart';
import '../../../../common/widgets/quik_booking_list_tile.dart';
import '../../../../common/widgets/quik_search_bar.dart';
import '../../cubit/booking_cubit.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const QuikAppBar(
          showBackButton: false,
          showPageName: true,
          pageName: 'Book',
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                QuikSearchBar(
                  onChanged: (String value) {}, // Default value for onChanged
                  hintText: "Search for bookings...",
                  onMicPressed: () {},
                  onSearch: (String onSearch) {},
                  controller: TextEditingController(),
                ),
                QuikSpacing.vS36(),
                const BookingHeader(),
                QuikSpacing.vS16(),
                Expanded(
                  child: BlocBuilder<BookingCubit, BookingState>(
                    builder: (context, state) {
                      if (state is BookingLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is BookingLoaded &&
                          state.booking.currentBookings.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              QuikSpacing.vS16(),
                          itemCount: state.booking.currentBookings.length,
                          itemBuilder: (context, index) {
                            final booking =
                                state.booking.currentBookings[index];
                            return QuikBookingListTile(booking: booking);
                          },
                        );
                      } else if (state is BookingLoaded &&
                          state.booking.currentBookings.isEmpty) {
                        return const Center(
                          child: Text(
                            'No current bookings',
                            style: bodyLargeBoldTextStyle,
                          ),
                        );
                      } else {
                        return const Text('Error loading bookings');
                      }
                    },
                  ),
                ),
                QuikSpacing.vS24(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "PAST ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "BOOKINGS",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "This Week",
                          style: filterDropDownMediumTextStyle,
                        ),
                        SvgPicture.asset(
                          QuikAssetConstants.dropDownArrowSvg,
                          width: 16,
                          height: 16,
                        )
                      ],
                    )
                  ],
                ),
                QuikSpacing.vS16(),
                Expanded(
                  child: BlocBuilder<BookingCubit, BookingState>(
                    builder: (context, state) {
                      if (state is BookingLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is BookingLoaded &&
                          state.booking.pastBookings.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              QuikSpacing.vS16(),
                          itemCount: state.booking.pastBookings.length,
                          itemBuilder: (context, index) {
                            final booking = state.booking.pastBookings[index];
                            return QuikBookingListTile(booking: booking);
                          },
                        );
                      } else if (state is BookingLoaded &&
                          state.booking.pastBookings.isEmpty) {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              'No past bookings',
                              style: bodyLargeBoldTextStyle,
                            ),
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              'Error loading bookings',
                              style: bodyLargeBoldTextStyle,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}

class BookingHeader extends StatelessWidget {
  const BookingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: "CURRENT ",
            style: Theme.of(context).textTheme.titleMedium,
            children: [
              TextSpan(
                text: "BOOKINGS",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: primary,
                    ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Text(
              "Arrival Time",
              style: filterDropDownMediumTextStyle,
            ),
            SvgPicture.asset(
              QuikAssetConstants.dropDownArrowSvg,
              width: 16,
              height: 16,
            )
          ],
        )
      ],
    );
  }
}

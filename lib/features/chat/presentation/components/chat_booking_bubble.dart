import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';

class BookingRequestBubble extends StatefulWidget {
  final bool isMe;
  final ChatMessageModel message;

  const BookingRequestBubble({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  State<BookingRequestBubble> createState() => _BookingRequestBubbleState();
}

class _BookingRequestBubbleState extends State<BookingRequestBubble> {
  bool hasResponded = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: widget.isMe ? primary : Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  'Booking Request sent to ${widget.message.receiverId}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: secondary, fontSize: 12),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Price per Unit: ${widget.message.ratePerUnit.toString()}',
                style: const TextStyle(color: secondary, fontSize: 12),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Unit: ${widget.message.unit.toString()}',
                style: const TextStyle(color: secondary, fontSize: 12),
              ),
              // if (!isMe) ...[
              //   SizedBox(height: 10.0),
              //   Row(
              //     children: [
              //       ElevatedButton(
              //         onPressed: () {
              //           // Handle accept booking request here
              //         },
              //         child: Text('Accept'),
              //       ),
              //       SizedBox(width: 10.0),
              //       ElevatedButton(
              //         onPressed: () {
              //           // Handle reject booking request here
              //         },
              //         child: Text('Reject'),
              //         style: ElevatedButton.styleFrom(
              //           primary: Colors.red, // background
              //           onPrimary: Colors.white, // foreground
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
              if (widget.isMe) ...[
                const SizedBox(height: 10.0),
                Text(
                  widget.message.hasResponded == null
                      ? 'Waiting for acceptance from client'
                      : widget.message.isAccepted ?? false
                          ? 'Accepted'
                          : 'Rejected',
                  style: TextStyle(
                    color: widget.message.isAccepted ?? false
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

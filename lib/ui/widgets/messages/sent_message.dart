import 'package:flutter/material.dart';
import 'package:fermer/ui/kit/colors.dart' as colors;

class SentMessageWidget extends StatelessWidget {
  final String content;
  final String? imageAddress;
  final String? time;
  final bool isImage;

  const SentMessageWidget({
    Key? key,
    required this.content,
    this.time,
    this.imageAddress,
    required this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 8.0, left: 50.0, top: 4.0, bottom: 4.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Container(
          color: colors.CustomColors.deepYellow,
          // margin: const EdgeInsets.only(left: 10.0),
          child: Stack(children: <Widget>[
            !isImage
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
                    child: Text(
                      content,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          // child: Image.asset(
                          //   imageAddress,
                          //   height: 130,
                          //   width: 130,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          content,
                        )
                      ],
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}

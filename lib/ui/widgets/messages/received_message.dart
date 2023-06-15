import 'package:flutter/material.dart';
import 'package:fermer/ui/kit/colors.dart' as colors;

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String? imageAddress;
  final bool isImage;

  const ReceivedMessageWidget({
    Key? key,
    required this.content,
    required this.isImage,
    this.imageAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 75.0, left: 8.0, top: 8.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Container(
          color: colors.CustomColors.deepGreen,
          child: Stack(
            children: <Widget>[
              !isImage
                  ? Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
                      child: Text(
                        content,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

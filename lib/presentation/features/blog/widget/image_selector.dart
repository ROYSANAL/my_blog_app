import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/core/res/svgs.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/pick_image_usecase.dart';

class ImageSelector extends StatefulWidget {
  final Function(XFile?) onImageSelected;
  final String? url;

  const ImageSelector({super.key, required this.onImageSelected, this.url});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final res = await PickImageUseCase().call();
        if (res is Success<XFile>) {
          image = res.data;
        } else {
          image = null;
        }
        widget.onImageSelected(res.data);
        setState(() {});
      },
      child: Container(
          width: double.infinity,
          height: 200,
          padding: image != null
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: image == null
              ? widget.url == null
                  ? Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Svgs.image,
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "select an image",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.network(
                        widget.url!,
                        fit: BoxFit.fill,
                      ))
              : ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.fill,
                  ))),
    );
  }
}

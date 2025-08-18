import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';
import 'package:flutter_app/core/utils/image_picker.dart';
import 'package:flutter_app/core/utils/snackbar.dart';
import 'package:flutter_app/features/blog/presentation/widgets/blog_editor.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());

  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<String> selectedTags = [];
  File? _image;

  void selectImage() async {
    final selectedImage = await pickImage();

    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  // dispose controllers to avoid memory leaks
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new post'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),

      // image, title, content. Wrap in SingleChildScrollView to avoid overflow and allow scrolling on smaller screens
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // image picker
              _image == null
                  ? GestureDetector(
                      onTap: () {
                        selectImage();
                        snackBar(context, 'Image picker tapped');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey.shade400.withValues(alpha: 0.75),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Opacity(
                            opacity: 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo, size: 40),
                                SizedBox(height: 10),
                                Text('Tap to add image'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 160,
                        width: double.infinity,

                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),

              const SizedBox(height: 20),

              // tag selection
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      [
                            'Technology',
                            'Health',
                            'Lifestyle',
                            'Education',
                            'Programming',
                            'Productivity',
                          ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedTags.contains(e)) {
                                      selectedTags.remove(e);
                                    } else {
                                      selectedTags.add(e);
                                    }
                                  });
                                },
                                child: Chip(
                                  label: Text(e),
                                  side: const BorderSide(
                                    color: AppPallete.borderColor,
                                  ),
                                  color: selectedTags.contains(e)
                                      ? const WidgetStatePropertyAll<Color>(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),

              const SizedBox(height: 20),

              // title input
              BlogEditor(controller: titleController, hintText: 'Title'),

              const SizedBox(height: 20),

              BlogEditor(controller: contentController, hintText: 'Content'),
            ],
          ),
        ),
      ),
    );
  }
}

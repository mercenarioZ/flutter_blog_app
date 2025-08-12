import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_pallete.dart';
import 'package:flutter_app/core/utils/snackbar.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new post'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),

      // image, title, content
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // image picker
            GestureDetector(
              onTap: () {
                // Implement image picker logic here
                snackBar(context, 'Image picker tapped');
              },
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
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
                            child: Chip(
                              label: Text(e),
                              side: const BorderSide(
                                color: AppPallete.borderColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: 20),
            
            // title input

          ],
        ),
      ),
    );
  }
}

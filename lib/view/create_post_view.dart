import 'dart:typed_data';

import '../controller/user_controller.dart';
import '../services/post_service.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/drawer.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  State<CreatePostView> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<CreatePostView> {
// Local Vairables
  Uint8List? _file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  // Disposing varibales
  @override
  dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

// Posting Blog
  postImage(String uid, String username) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await PostService().uploadPost(
        uid,
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        username,
        _file!,
      );
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        clearImage();
        snackBar('Posted!');
      } else {
        setState(() {
          _isLoading = false;
        });
        snackBar(res);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      snackBar(e.toString());
    }
  }

// Selecting Blog Image
  _selectImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create Post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file =
                    await pickImage(ImageSource.camera, 1500, 1500, 100);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

// Clear Blog Image
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return _file == null
        // checking if image is chosen and rendering respectively
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Create Blog'),
            ),
            drawer: const CustomDrawer(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create a Blog post',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.upload),
                    splashRadius: 50,
                    iconSize: 40,
                    onPressed: _isLoading
                        ? () {}
                        : () {
                            _selectImage(context);
                          },
                  ),
                  const Text(
                    'Upload Image First',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                splashRadius: 25,
              ),
              title: const Text('Post to'),
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(
                      controller.userModel.value.phoneNumber,
                      controller.userModel.value.firstName,
                    );
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.zero),
                const Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4,
                      ),
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4,
                      ),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}

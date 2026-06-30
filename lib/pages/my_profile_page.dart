import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyProfilePage extends StatefulWidget {
  final bool isEditMode;
  final String username;

  const MyProfilePage({
    super.key,
    required this.isEditMode,
    required this.username,
  });

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _isEditMode = false;
  File? _profileImage;
  Uint8List? _webImage;
  final picker = ImagePicker();

  late TextEditingController fullNameController;
  late TextEditingController usernameController;
  late TextEditingController locationController;
  late TextEditingController birthController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.isEditMode;
    fullNameController = TextEditingController(text: "Ayu Setiawan");
    usernameController = TextEditingController(text: widget.username);
    locationController = TextEditingController(text: "Bandung");
    birthController = TextEditingController(text: "Bandung, 22 Aug 1995");
    emailController = TextEditingController(text: "ayusetiawan@gmail.com");
    phoneController = TextEditingController(text: "085497770127");
    passwordController = TextEditingController(text: widget.username);
  }

  Future<void> _pickImage() async {
    if (!_isEditMode) return;
    try {
      final XFile? xfile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (xfile == null) return;

      if (kIsWeb) {
        final Uint8List bytes = await xfile.readAsBytes();
        setState(() => _webImage = bytes);
      } else {
        setState(() => _profileImage = File(xfile.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffB1121B),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text(
                    _isEditMode ? "Edit My Profile" : "My Profile",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.username.isNotEmpty
                            ? widget.username[0].toUpperCase()
                            : "A",
                        style: const TextStyle(
                          color: Color(0xffB1121B),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Body Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar Area
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffE1F5FE),
                                      shape: BoxShape.circle,
                                    ),
                                    child: _buildAvatarImage(),
                                  ),
                                  if (_isEditMode)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Color(0xffB1121B),
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
  fullNameController.text,
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
                            const SizedBox(height: 4),
                            Text(
  usernameController.text,
  style: const TextStyle(
    fontSize: 14,
    color: Colors.grey,
  ),
),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 16),

                      // Warning Box
                      if (_isEditMode)
                        Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffB1121B)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Perubahan username dan password akan langsung berlaku untuk login berikutnya.",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        ),

                      // Sections
                      _buildSectionTitle("PERSONAL INFO"),
                      _buildInfoGroup([
                        _buildField(
                          icon: Icons.person,
                          iconColor: Colors.blue,
                          iconBg: Colors.blue.withOpacity(0.1),
                          label: "Full Name",
                          controller: fullNameController,
                        ),
                        _buildField(
                          icon: Icons.person,
                          iconColor: Colors.blue,
                          iconBg: Colors.blue.withOpacity(0.1),
                          label: "Username",
                          controller: usernameController,
                        ),
                        _buildField(
                          icon: Icons.location_on,
                          iconColor: Colors.red,
                          iconBg: Colors.red.withOpacity(0.1),
                          label: "Location",
                          controller: locationController,
                        ),
                        _buildField(
                          icon: Icons.calendar_today,
                          iconColor: Colors.red,
                          iconBg: Colors.red.withOpacity(0.1),
                          label: "TTL",
                          controller: birthController,
                        ),
                      ]),

                      const SizedBox(height: 24),
                      _buildSectionTitle("CONTACT"),
                      _buildInfoGroup([
                        _buildField(
                          icon: Icons.email,
                          iconColor: Colors.red,
                          iconBg: Colors.red.withOpacity(0.1),
                          label: "Email",
                          controller: emailController,
                        ),
                        _buildField(
                          icon: Icons.phone,
                          iconColor: Colors.grey.shade700,
                          iconBg: Colors.grey.withOpacity(0.2),
                          label: "No. HP",
                          controller: phoneController,
                        ),
                      ]),

                      const SizedBox(height: 24),
                      _buildSectionTitle("PASSWORD"),
                      _buildInfoGroup([
                        _buildField(
                          icon: Icons.lock, // Used phone icon in screenshot, but lock makes more sense. I will use phone to match screenshot, wait, it looks like a phone in the screenshot but it says password? No, it's a key or something? Actually in screenshot it's a phone icon. Let's use lock icon to be logical.
                          iconColor: Colors.grey.shade700,
                          iconBg: Colors.grey.withOpacity(0.2),
                          label: "Password",
                          controller: passwordController,
                          obscureText: true,
                        ),
                      ]),
                      
                      const SizedBox(height: 40),
                      
                      if (_isEditMode)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffB1121B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Save Logic
                              setState(() {
                                fullNameController.text = fullNameController.text;
                                usernameController.text = usernameController.text;
                                locationController.text = locationController.text;
                                birthController.text = birthController.text;
                                emailController.text = emailController.text;
                                phoneController.text = phoneController.text;
                                passwordController.text = passwordController.text;
                                _isEditMode = false;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Profile berhasil diperbarui"),
                                ),
                              );
                            },
                            child: const Text(
                              "Simpan Perubahan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarImage() {
    if (kIsWeb && _webImage != null) {
      return ClipOval(
        child: Image.memory(_webImage!, fit: BoxFit.cover),
      );
    } else if (!kIsWeb && _profileImage != null) {
      return ClipOval(
        child: Image.file(_profileImage!, fit: BoxFit.cover),
      );
    } else {
      return const Icon(
        Icons.person_outline,
        color: Colors.blue,
        size: 50,
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: children.map((child) {
          int index = children.indexOf(child);
          return Column(
            children: [
              child,
              if (index < children.length - 1)
                Divider(
                  color: Colors.grey.shade200,
                  height: 1,
                  thickness: 1,
                  indent: 60,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildField({
  required IconData icon,
  required Color iconColor,
  required Color iconBg,
  required String label,
  required TextEditingController controller,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 6),

              if (_isEditMode)
                TextField(
                  controller: controller,
                  autofocus: false,
                  obscureText: obscureText && !_isEditMode,
                  cursorColor: const Color(0xffB1121B),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: label,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xffB1121B),
                        width: 2,
                      ),
                    ),
                  ),
                )
              else
                Text(
                  obscureText
                      ? "••••••••••"
                      : controller.text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
}

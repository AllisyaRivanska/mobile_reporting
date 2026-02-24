import 'dart:io';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart'; 
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
import 'package:mobile_reporting/constant/widgets/custom_dropdown.dart';
import 'package:mobile_reporting/constant/widgets/custom_text_field.dart';
import 'package:mobile_reporting/features/reporting/cubit/reporting_bloc.dart';
import 'package:mobile_reporting/features/reporting/cubit/reporting_state.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';
import 'package:mobile_reporting/features/reporting/presentation/success_page.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({super.key});

  @override
  State<ReportingPage> createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final otherCategoryController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _isLoading = false; 
  String? _selectedCategory;
  File? _selectedImage;
  Data? _inputData;

  final List<String> _categories = [
    'Fasilitas',
    'Keamanan',
    'Administrasi',
    'Lainnya',
  ];
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  bool _isFormEmpty() {
    return titleController.text.isEmpty &&
        _selectedCategory == null &&
        descriptionController.text.isEmpty &&
        _selectedImage == null;
  }

  void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    required Widget actions,
  }) {
    showDialog(
      context: context,
      barrierColor: ColorConstant.backgroundTransparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: TextConfig.alertMessage, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    Text(message, style: TextConfig.alertSubMessage, textAlign: TextAlign.center),
                    const SizedBox(height: 25),
                    actions,
                  ],
                ),
              ),
              const Positioned(
                top: -27,
                child: Icon(Icons.warning_rounded, color: Colors.orange, size: 65),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExitConfirmation() {
    if (_isFormEmpty()) {
      Navigator.pop(context);
    } else {
      _showCustomDialog(
        context: context,
        title: "Laporan Belum Dikirim",
        message: "Yakin keluar? semua data yang anda isi akan hilang",
        actions: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal", style: TextConfig.alertButton),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  Navigator.pop(context); 
                },
                style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.warningButton),
                child: const Text("Keluar", style: TextConfig.alertWhiteButton),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _showIncompleteAlert() {
    _showCustomDialog(
      context: context,
      title: "Laporan Belum Lengkap",
      message: "Mohon lengkapi data yang wajib diisi sebelum mengirim laporan",
      actions: Center(
        child: SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.warningButton,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Oke", style: TextConfig.alertWhiteButton),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    otherCategoryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 70);
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () { _pickImage(ImageSource.gallery); Navigator.pop(context); },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () { _pickImage(ImageSource.camera); Navigator.pop(context); },
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    if (titleController.text.isEmpty || _selectedCategory == null || _selectedCategory == 'Lainnya' && otherCategoryController.text.isEmpty || descriptionController.text.isEmpty) {
      _showIncompleteAlert();
      return;
    }

  if (formKey.currentState!.validate()) {
    String finalCategory = _selectedCategory == 'Lainnya' ? otherCategoryController.text : _selectedCategory ?? '';
    _inputData = Data(
      id: 1,
      title: titleController.text,
      kategori: finalCategory,
      deskripsi: descriptionController.text,
      fotoUrl: _selectedImage?.path,
      createdAt: '17 Jan 2026',
    );

    context.read<ReportingBloc>().submitReporting(_inputData!);
  }
  }
  
    // if (formKey.currentState!.validate()) {
    //   String finalCategory = _selectedCategory == 'Lainnya' ? otherCategoryController.text : _selectedCategory ?? '';
    //   final reportData = ReportingModel(
    //     kategori: finalCategory,
    //     deskripsi: descriptionController.text,
    //     imagePath: _selectedImage?.path,
    //   );
    //   context.read<ReportingBloc>().submitReporting(reportData);
    // }
  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (!_isLoading) {
          _showExitConfirmation();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ColorConstant.lightBlue,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackHeader(
                      title: 'Formulir Laporan',
                      onBack: _isLoading ? null : _showExitConfirmation,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          _buildTitleSection(),
                          const SizedBox(height: 12),
                          _buildCategorySection(),
                          const SizedBox(height: 12),
                          _buildDescriptionSection(),
                          const SizedBox(height: 12),
                          _buildPhotoSection(),
                          const SizedBox(height: 12),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          if (_isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_animation.json',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Judul Laporan', style: TextConfig.labelForm),
        const SizedBox(height: 8),
        CustomTextField(
          controller: titleController,
          hintText: 'Contoh: AC kelas 920 gedung B mati.',
          fillColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kategori Laporan', style: TextConfig.labelForm),
        const SizedBox(height: 8),
        Stack(
          children: [
            CustomDropdown<String>(
              name: 'category',
              hint: '',
              items: CustomDropdown.buildMenuItems<String>(
                items: _categories,
                getLabel: (value) => value,
              ),
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
            if (_selectedCategory == null)
              const Positioned.fill(
                child: IgnorePointer(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Pilih kategori laporan', style: TextConfig.inputHint),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (_selectedCategory == 'Lainnya') ...[
          const SizedBox(height: 12),
          const Text('Kategori Lainnya', style: TextConfig.labelForm),
          const SizedBox(height: 8),
          CustomTextField(
            controller: otherCategoryController,
            hintText: 'Tuliskan kategori lainnya di sini.',
            fillColor: Colors.white,
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Deskripsi Laporan', style: TextConfig.labelForm),
        const SizedBox(height: 8),
        CustomTextField(
          controller: descriptionController,
          hintText: 'Tuliskan deskripsi laporanmu di sini...',
          maxLines: 6,
          fillColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Foto (Opsional)', style: TextConfig.labelForm),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _showImagePickerOptions,
          child: DottedBorder(
            color: Colors.grey.shade400,
            strokeWidth: 1.5,
            dashPattern: const [6, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            child: Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                color: ColorConstant.cameraColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: _selectedImage != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.file(_selectedImage!, width: double.infinity, height: 170, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedImage = null),
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 15,
                              child: Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(child: Icon(Icons.camera_alt, color: Colors.grey, size: 40)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocListener<ReportingBloc, ReportingState>(
      listener: (context, state) {
        if (state is ReportingLoading) {
          setState(() => _isLoading = true);
        } else if (state is ReportingSubmitSuccess) {
          setState(() => _isLoading = false);
          
          if (_inputData != null) {

          
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessPage(reportData: _inputData!, showBanner: true),),);
          }

        } else if (state is ReportingError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading ? null : submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Kirim Laporan', style: TextConfig.textButton),
        ),
      ),
    );
  }
}
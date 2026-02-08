import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';
import 'package:mobile_reporting/constant/text_config/text_config.dart';
import 'package:mobile_reporting/constant/widgets/custom_back_header.dart';
import 'package:mobile_reporting/constant/widgets/custom_text_field.dart';

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

  String? _selectedCategory; 
  final List<String> _categories = ['Fasilitas', 'Keamanan', 'Administrasi', 'Lainnya'];

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    otherCategoryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: ColorConstant.lightBlue,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomBackHeader(title: 'Formulir Laporan'),
            
           Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildTitleSection(), 
                  const SizedBox(height: 24),
                  _buildCategorySection(),
                  const SizedBox(height: 24),
                  _buildDescriptionSection(),
                  const SizedBox(height: 32),
                  _buildSubmitButton(), 
                ],
              ),
         ), ],
        ),
      ),
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
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            hint: const Text('Pilih Kategori Laporan.'),
            items: _categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
          ),
        ),
      ),
      if (_selectedCategory == 'Lainnya') ...[
        const SizedBox(height: 8),
        Text('Kategori Lainnya', style: TextConfig.labelForm,),
        const SizedBox(height: 8),
        CustomTextField(
          controller: otherCategoryController,
          hintText: 'Tuliskan kategori lainnya di sini.',
          fillColor: Colors.white, 
        ),
      ]
    ],
  );
}
Widget _buildDescriptionSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Deskripsi', style: TextConfig.labelForm),
      const SizedBox(height: 8),
      CustomTextField(
        controller: descriptionController,
        hintText: 'Tuliskan deskripsi laporanmu di sini...',
        maxLines: 5,
        fillColor: Colors.white,
      ),
    ],
  );
}
Widget _buildSubmitButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstant.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text('Kirim Laporan', style: TextConfig.textButton),
    ),
  );
 }
}
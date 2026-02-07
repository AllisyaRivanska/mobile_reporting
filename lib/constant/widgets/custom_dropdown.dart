import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String name;
  final String hint;
  final String? errorText;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T? value;
  final bool isLoading;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.name,
    required this.hint,
    required this.items,
    this.errorText,
    this.validator,
    this.onChanged,
    this.value,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return FormBuilderDropdown<T>(
    name: name,
    items: items,
    validator: validator,
    onChanged: enabled ? onChanged : null,
    dropdownColor: Colors.white,
    isExpanded: true, 
    menuMaxHeight: 300,
    borderRadius: BorderRadius.circular(12),
      padding: EdgeInsets.zero,

      alignment: AlignmentDirectional.centerStart,

     icon: const Center(
     child: Icon(
     Icons.keyboard_arrow_down_rounded,
     color: Colors.black,
     size: 28,
  ),
),


    decoration: InputDecoration(
      hintStyle:  GoogleFonts.poppins(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 2.2,
      ),
      errorText: errorText,
      filled: true,
      fillColor: enabled ? Colors.white : Colors.grey.shade50,
      contentPadding: const EdgeInsets.only(
      left: 16,
      right: 10,
      bottom: 0,
      top: 0
),

        constraints: const BoxConstraints(minHeight: 48,),
      
      suffixIcon: null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
       
      ),
      
     
        
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((DropdownMenuItem<T> item) {
           return Align(
      alignment: Alignment.centerLeft,
      child: Text(item.value.toString()),
    );
  }).toList();
      },
    );
  }

  static List<DropdownMenuItem<T>> buildMenuItems<T>({
    required List<T> items,
    required String Function(T) getLabel,
    T? Function(T)? getValue,
  }) {
    return items.map((item) {
      return DropdownMenuItem<T>(
        value: getValue != null ? getValue(item) : item,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  getLabel(item),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

extension CustomDropdownMenuItems on List<DropdownMenuItem> {
  List<DropdownMenuItem<T>> withCustomStyle<T>() {
    return map((item) {
      return DropdownMenuItem<T>(
        value: item.value,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: item.child,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
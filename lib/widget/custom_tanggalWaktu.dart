// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:project_kucari/src/style.dart';

// class CustomTextField3 extends StatefulWidget {
//   const CustomTextField3({
//     required this.controller,
//     required this.textInputType,
//     required this.textInputAction,
//     Key? key,
//   }) : super(key: key);

//   final TextEditingController controller;
//   final TextInputType textInputType;
//   final TextInputAction textInputAction;

//   @override
//   _CustomTextField3State createState() => _CustomTextField3State();
// }

// class _CustomTextField3State extends State<CustomTextField3> {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: widget.controller,
//             keyboardType: widget.textInputType,
//             textInputAction: widget.textInputAction,
//             onTap: () async {
//               final selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//               );
//               if (selectedDate != null) {
//                 setState(() {
//                   this.selectedDate = selectedDate;
//                 });
//               }
//             },
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.green[200], // Mengatur warna hijau
//               hintText: selectedDate != null
//                   ? DateFormat('yyyy-MM-dd').format(selectedDate!)
//                   : 'Masukkan tanggal', // Display selected date or hint
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: TextField(
//             controller: widget.controller,
//             keyboardType: widget.textInputType,
//             textInputAction: widget.textInputAction,
//             onTap: () async {
//               final selectedTime = await showTimePicker(
//                 context: context,
//                 initialTime: TimeOfDay.now(),
//               );
//               if (selectedTime != null) {
//                 setState(() {
//                   this.selectedTime = selectedTime;
//                 });
//               }
//             },
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.green[200], // Mengatur warna hijau
//               hintText: selectedTime != null
//                   ? DateFormat('HH:mm').format(selectedTime!.toDateTime(DateTime.now()))
//                   : 'Masukkan jam', // Display selected time or hint
//             ),
//           ),
//         ), 
//       ],
//     );
//   }
// }

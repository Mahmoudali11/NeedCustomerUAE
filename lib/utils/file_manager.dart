
import 'package:image_picker/image_picker.dart';
import 'dart:io';
abstract class FileManager{


  static Future<File?> pickImage()async{


    var instance=       ImagePicker.platform;
   var file=  await instance.getImageFromSource(source: ImageSource.gallery);

   if(file!=null){

     return File(file.path);
   }
  }
}
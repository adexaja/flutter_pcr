import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:flutter_pcr/models/mahasiswa.dart';
class MahahasiswaService {
   static var apiUrl = 'https://my-json-server.typicode.com/adexaja/flutter_pcr/mahasiswa';


  /** 
   * untuk dokumentasi dio dapat dilihat disini https://pub.dev/packages/dio
   * Contoh dibawah menggunakan gambar yang disimpan di file local,
   * karena contoh API menggunakan server gratis yang tidak bisa menyimpan gambar secara online
   * Untuk penyimpanan gambar secara online dapat menggunakan kode berikut:
   * 
   * https://pub.dev/packages/dio#sending-formdata
   * 
   * Dan pada API akan ditangkap pada variable $_FILES (seperti pada umumnya)
   * Jika variable tidak ditangkap pada variable $_FILES, maka cek untuk variable $_POST
   * 
   * untuk beberapa kasus file dikirim Dio dalam variable $_POST dalam bentuk binary (bisa di save ke file dengan kode php)
   * beberapa kasus file dikirim Dio dalam variable $_FILES seperti kita mengupload file seperti biasanya
  **/
   static Future<List<Mahasiswa>> getMahasiswa() async{ // biasanya function DIO menggunakan asyncronous function
      Dio dio = new Dio();
      dio.transformer = FlutterTransformer(); // replace dio default transformer (json decoding)
      dio.interceptors.add(LogInterceptor()); // untuk log request dio pada debug console
      var result = await dio.get(apiUrl); // langsung menangkap result
      List<Mahasiswa> mahasiswa = [];
      result.data.forEach((json) => mahasiswa.add(Mahasiswa.fromJson(json)));
      return mahasiswa;
   }

   static saveMahasiswa(nim, nama, jk, foto) async{
      Dio dio = new Dio();
      dio.interceptors.add(LogInterceptor()); // untuk log request dio pada debug console

      FormData data = new FormData(); // untuk menampung file input
      // Untuk menambahkan file
      // data.files.add(MapEntry(
      //   "file", MultipartFile.fromFileSync('filePath')
      // ));

      data.fields.add(MapEntry(
        "NIM", nim
      ));

      data.fields.add(MapEntry(
        "nama", nama
      ));

      data.fields.add(MapEntry(
        "jk", jk
      ));

      data.fields.add(MapEntry(
        "foto", ""
      ));

      // jika ID tidak auto increment
      data.fields.add(MapEntry(
        "id", "1"
      ));

      var response = await dio.post(apiUrl, data: data, options: Options(
        contentType: Headers.formUrlEncodedContentType
      ));
      return response;
   }
}
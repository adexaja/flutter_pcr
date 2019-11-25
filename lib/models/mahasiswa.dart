class Mahasiswa {
  Mahasiswa(nim, nama, jk, foto){
     this.nim = nim;
     this.nama = nama;
     this.jk = jk;
     this.foto = foto;
  }
  String nama;
  String nim;
  String foto;
  String jk;

  static fromJson(json){
     return Mahasiswa(
       json['NIM'],
       json['nama'],
       json['jk'],
       json['foto']
     );
  }
}
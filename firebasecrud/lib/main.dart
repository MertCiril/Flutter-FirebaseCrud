import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();//firebase başlatıyor bu iki satır
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseCrud(),
  ));
}

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({Key key}) : super(key: key);

  @override
  _FirebaseCrudState createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  String ad,id,kategori;
  int sayfaSayisi;



  idAl(idTutucu){
    this.id=idTutucu;

  }

  adAl(adTutucu){
  this.ad=adTutucu;
  }
  kategoriAl(kategoriTutucu){
  this.kategori=kategoriTutucu;
  }
  sayfaSayisiAl(sayfaTutucu){
    this.sayfaSayisi=int.parse(sayfaTutucu);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Crud"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String idTutucu){
                idAl(idTutucu);
              },
              decoration: InputDecoration(
                labelText: "Kitap Id",
                labelStyle: TextStyle(
                  color: Colors.red,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String adTutucu){
                adAl(adTutucu);
              },
              decoration: InputDecoration(
                focusColor: Colors.purple,
                labelText: "Kitap Adı",
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String kategoriTutucu){
                kategoriAl(kategoriTutucu);
              },
              decoration: InputDecoration(
                labelText: "Kitap Kategorisi",
                labelStyle: TextStyle(
                  color: Colors.lime,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lime, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String sayfaTutucu){
                sayfaSayisiAl(sayfaTutucu);
              },
              decoration: InputDecoration(
                hintText: "Kitap Sayfası",
                hintStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    veriEkle();
                  },
                  child: Text("Ekle"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriOku();
                  },
                  child: Text("Oku"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lime,
                    onPrimary: Colors.white,
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriGuncelle();
                  },
                  child: Text("Güncelle"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                    onPrimary: Colors.white,
                    shadowColor: Colors.redAccent,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriSil();
                  },

                  child: Text("Sil"),
                  style: ElevatedButton.styleFrom(

                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    shadowColor: Colors.redAccent,
                    elevation: 5,

                  ),

                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void veriEkle() {
    //veriyolu ekleme
    DocumentReference veriYolu = FirebaseFirestore.instance.collection("Kitaplik").doc(id);

    //çoklu veri için map
    Map<String,dynamic>kitaplar= {
      "kitapId":id,
      "kitapAd":ad,
      "kitapKategori":kategori,
      "kitapSayfaSayisi":sayfaSayisi.toString(),
    };


    veriYolu.set(kitaplar).whenComplete((){
      Fluttertoast.showToast(msg: id+"ID'li kitap eklendi.");
    });


  }

  void veriOku() {

    DocumentReference veriOkumaYolu = FirebaseFirestore.instance.collection("Kitaplik").doc(id);
    
    veriOkumaYolu.get().then((alinanDeger) {

      //Çoklu veriyi mape aktarır
     // Map<String,dynamic> alinanVeri1 = alinanDeger.data();
      String idTutucu = alinanDeger["kitapId"];
      String adTutucu = alinanDeger["kitapAd"];
      String kategoriTutucu = alinanDeger["kitapKategori"];
      String sayfaTutucu = alinanDeger["kitapSayfaSayisi"];
      
      Fluttertoast.showToast(msg:"Id: "+idTutucu+" \nAd:"+adTutucu+" Kategori:"+kategoriTutucu+" Sayfa Sayısı:"+sayfaTutucu);
      
    });
  }

  void veriGuncelle() {

    DocumentReference veriGuncellemeYolu = FirebaseFirestore.instance.collection("Kitaplik").doc(id);

    Map<String,dynamic> guncellenecekVeri = {
      "kitapId":id,
      "kitapAd":ad,
      "kitapKategori":kategori,
      "kitapSayfaSayisi":sayfaSayisi.toString(),
    };
   veriGuncellemeYolu.update(guncellenecekVeri).whenComplete(() {
     Fluttertoast.showToast(msg: id+" ID'li kitap güncellendi");
   })   ;
  }

  void veriSil() {
    DocumentReference veriSilmeYolu = FirebaseFirestore.instance.collection("Kitaplik").doc(id);

    veriSilmeYolu.delete().whenComplete(() {
      Fluttertoast.showToast(msg: id+" ID'li kitap silindi!");
    });
  }
}

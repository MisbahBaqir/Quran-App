import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   AudioPlayer audioplayer= AudioPlayer();
   IconData playpauseButton= Icons.play_circle_fill_rounded;
   bool isplaying= false;

    Future<void> toggleButton() async{

      try {
      
        final audiourl= await quran.getAudioURLBySurah(widget.indexsurah+1);
        audioplayer.setUrl(audiourl);
        print(audiourl);

        if (isplaying) {
          
          audioplayer.play();

          playpauseButton=Icons.pause_circle_rounded;
          isplaying=false;

          setState(() {});
  
        } else{
           audioplayer.pause();
           playpauseButton=Icons.play_circle_fill_rounded;
           isplaying=true;

           setState(() {});
        }

      } catch (e) {
             print("my error=>$(e)");
      }
    }


    @override
  void dispose() {
    // TODO: implement dispose
    audioplayer.dispose();
    super.dispose();
  }



    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 03), () {
          
          Navigator.push(context, MaterialPageRoute(builder: (context) => Surahlist() ,));
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quran App"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

            Center(child: Image.asset("assets images/Quran.png")),

          Center(child: Text("Quran App", style: TextStyle(color: Colors.teal),)),
        ],
      ),
      backgroundColor: const Color.fromARGB(162, 201, 172, 12),
      );
  }
}

  


class Surahlist extends StatefulWidget {
  const Surahlist({super.key});

  @override
  State<Surahlist> createState() => _SurahlistState();
}

class _SurahlistState extends State<Surahlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Quran App"),),
      
      body:ListView.builder(
        
        itemCount: quran.totalSurahCount,
        itemBuilder:(context, index){

          ListTile(


            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Surah( index),));
            },
          
            title: Text(quran.getSurahNameArabic(index+1)),
            subtitle:Text(quran.getSurahNameEnglish(index+1)) ,
            leading: CircleAvatar(
              child: Text("${index+1}", style: TextStyle(color: Colors.white),),
              backgroundColor: const Color.fromARGB(162, 201, 172, 12),
            ),
            trailing: Text("${quran.getVerseCount(index+1)}"),







          );

      }),);
  }
}


class Surah extends StatefulWidget {
  int indexsurah;
   Surah(this.indexsurah ,{super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Expanded(
          child: Card(
            child: ListView.builder(
              itemCount: quran.getVerseCount(widget.indexsurah+1),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                     quran.getVerse(18, index + 1, verseEndSymbol: true),
                     textAlign: TextAlign.right,
                    ),
                  ),
                );
              }
              
              ),
          ),
        ),
        
        
        
        Card(
           
           elevation: 6,
           shadowColor: const Color.fromARGB(206, 221, 156, 178),
           child: Center(
            child: IconButton (
              icon: Icon(
                playpauseButton,
                color: const Color.fromARGB(162, 201, 172, 12),
              ),
              onPressed: toggleButtons),
           ),
          
          
          
          
          )
      ],
    ),);
  }
}
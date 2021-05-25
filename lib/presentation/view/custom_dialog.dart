import 'package:flutter/material.dart';
import 'package:retailmi/presentation/helpers/constants.dart';

class CustomMediaDialog extends StatefulWidget{
  final MediaArguments args;

  CustomMediaDialog({Key key, this.args}) : super(key: key);

  @override
  CustomMediaDialogState createState() => CustomMediaDialogState();
}

class CustomMediaDialogState extends State<CustomMediaDialog>{
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.args.url),
          fit: BoxFit.contain
        ),
        color: Colors.transparent
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 40,
              left: 60,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 320.0,
                  height: 50.0,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(237, 224, 197, 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Cancelar',
                      style: TextStyle(
                          color: Color.fromRGBO(165, 103, 69, 1.0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.4)
                  ),
                ),
              )
          ),
          Positioned(
            bottom: 40,
              right: 60,
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (_) => ImageDialog('assets/img/QR_Baileys.png')
                  );
                },
                child: Container(
                  width: 320.0,
                  height: 50.0,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 114, 135, 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Escanear',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.4)
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String _url;

  ImageDialog(this._url);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text('Felicidades', style: TextStyle(fontSize: 20),),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(_url),
                      fit: BoxFit.fitHeight
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
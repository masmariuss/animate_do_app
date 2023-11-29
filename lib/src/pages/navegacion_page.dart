
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NavegacionPage extends StatelessWidget {
  const NavegacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),

      child: Scaffold(
    
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Notifications Page'),
        ),
    
        floatingActionButton: const BotonFlotante(),
    
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}


class BotonFlotante extends StatelessWidget {
  const BotonFlotante({super.key});


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.purple,
      onPressed: () {
        
        final notiModel = Provider.of<_NotificationModel>(context, listen: false);

        int numero = notiModel.numero;
        numero++;
        notiModel.numero = numero;

        if (numero >=2 ) {
          final controller = notiModel.bounceController;
          controller.forward(from: 0.0);
        }
      },
      child: const FaIcon(FontAwesomeIcons.play),);
  }
}


class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {

    final int numero = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.purple,
      items: [
        const BottomNavigationBarItem(
          label: 'Bones',
          icon: FaIcon(FontAwesomeIcons.bone)
        ),
        BottomNavigationBarItem(
          label: 'Notifications',
          icon: Stack(
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: 0,
                right: 0,
                // child: Icon(Icons.brightness_1, size: 8, color: Colors.purple),
                child: BounceInDown(
                  from: 16,
                  animate: (numero > 0) ? true : false,
                  child: Bounce(
                    from: 8,
                    controller: (controller) => Provider.of<_NotificationModel>(context).bounceController = controller,
                    child: Container(
                      alignment: Alignment.center,
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle
                      ),
                      child: Text(
                        '$numero', 
                        style: const TextStyle(color: Colors.white, fontSize:7)
                      ),
                    ),
                  ),
                ),
              )

            ]
          )
        ),
        const BottomNavigationBarItem(
          label: 'My Dog',
          icon: FaIcon(FontAwesomeIcons.dog) )
      ],
    );
  }
}


class _NotificationModel extends ChangeNotifier {

  int _numero = 0;
  late AnimationController bounceController;

  int get numero => _numero;

  set numero(int valor) {
    _numero = valor;
    notifyListeners();
  }
  
/*   AnimationController  get bounceController => _bounceController;

  set bounceController(AnimationController controller) {
    _bounceController = controller;
    notifyListeners();
  } */

}
import 'dart:async';
import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  var endedAnimation = false;
  Timer? redirectTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });
  }

  void _redirect(String routeName) {
    if (!endedAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(const Duration(milliseconds: 300), () {
        _redirect(routeName);
      });
    } else {
      redirectTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar o login', context);
          _redirect('/auth/login');
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedAdm:
              _redirect('/home/adm');
            case SplashState.loggedEmployee:
              _redirect('/home/employee');
            case _:
              _redirect('/home/login');
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          opacity: _animationOpacityLogo,
          onEnd: () => setState(() => endedAnimation = true),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.linearToEaseOut,
              height: _logoAnimationHeight,
              width: _logoAnimationWidth,
              child: Image.asset(
                ImageConstants.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

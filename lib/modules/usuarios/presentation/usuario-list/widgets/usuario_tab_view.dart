import 'package:flutter/material.dart';

class UsuarioTabView extends StatelessWidget {
  const UsuarioTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: AppBar(
        leading: const SizedBox.shrink(),
        bottom: TabBar(
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.sync_disabled_outlined),
                  SizedBox(width: 8),
                  Text('Local'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.sync_outlined),
                  SizedBox(width: 8),
                  Text('Remoto'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

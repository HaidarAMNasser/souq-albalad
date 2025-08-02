import 'package:flutter/src/widgets/framework.dart';

abstract class ChatDestEvents {
  const ChatDestEvents();
}

class GetChatsEvent extends ChatDestEvents {
  BuildContext context;
  GetChatsEvent(this.context);
}

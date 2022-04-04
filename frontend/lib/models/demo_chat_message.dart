import 'package:flutter_application_1/models/user.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final ChatUser sender;
  final String text, image, time, lastMessage;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final int unreadCount;

  ChatMessage({
    required this.sender,
    this.text = '',
    this.image = '',
    this.time = '',
    this.lastMessage = '',
    this.messageType = ChatMessageType.text,
    this.messageStatus = MessageStatus.not_view,
    this.isSender = true,
    this.unreadCount = 0,
  });
}

final ChatUser currentUser = ChatUser(
  id: 0,
  name: "Current User",
  image: "assets/images/header_img1.png",
  isActive: false,
);

final ChatUser jenny = ChatUser(
  id: 1,
  name: "Jenny Wilson",
  image: "assets/images/header_img1.png",
  isActive: false,
);

final ChatUser esther = ChatUser(
  id: 2,
  name: "Esther Howard",
  image: "assets/images/header_img1.png",
  isActive: true,
);
final ChatUser ralph = ChatUser(
  id: 3,
  name: "Ralph Edwards",
  image: "assets/images/header_img1.png",
  isActive: false,
);
final ChatUser jacob = ChatUser(
  id: 4,
  name: "Jacob Jones",
  image: "assets/images/header_img1.png",
  isActive: true,
);
final ChatUser albert = ChatUser(
  id: 5,
  name: "Albert Flores",
  image: "assets/images/header_img1.png",
  isActive: false,
);

final List<ChatMessage> recentChats  = [
  ChatMessage(
    sender: jenny,
    lastMessage: "Hope you are doing well...",
    image: "assets/images/header_img1.png",
    time: "3m ago",
  ),
  ChatMessage(
    sender: esther,
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/header_img1.png",
    time: "8m ago",
  ),
  ChatMessage(
    sender: ralph,
    lastMessage: "Do you have update...",
    image: "assets/images/header_img1.png",
    time: "5d ago",
  ),
  ChatMessage(
    sender: jacob,
    lastMessage: "You’re welcome :)",
    image: "assets/images/header_img1.png",
    time: "5d ago",
  ),
  ChatMessage(
    sender: albert,
    lastMessage: "Thanks",
    image: "assets/images/header_img1.png",
    time: "6d ago",
  ),
];

final List<ChatMessage> demeChatMessages = [
  ChatMessage(
    sender: jenny,
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "",
    messageType: ChatMessageType.video,
    messageStatus: MessageStatus.viewed,
    isSender: true,
    unreadCount: 0,
  ),
  ChatMessage(
    sender: albert,
    text: "Error happend",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: jenny,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 4,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 7,
  ),
  ChatMessage(
    sender: albert,
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
    unreadCount: 2,
  ),
];
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/models/message.dart';

List<Ticket> db_services = [
  Ticket(
      id: 1,
      title: "PC NOT WORK",
      problemDescription: "MY PC IS NOT WORKING",
      problemItem: "COMPUTER DELL OPTIPLEX",
      status: "Pendent",
      message: []),
  Ticket(
    id: 2,
    title: "Printer does not print",
    problemDescription:
        "The printer has ink, but it doesn't print, and when I put one in, it's making a noise.",
    problemItem: "PRINTER LENOVO",
    status: "Processing",
    message:[Message(speaker:ChatUser(id:1, name:"Murillo Cardoso", email: "adm@h.c", password: "12", type: 2), message:"I've been taking a look and it doesn't seem like a big deal, just some gear stuck."),]
  ),
      id: 2,
      title: "Printer does not print",
      problemDescription:
          "The printer has ink, but it doesn't print, and when I put one in, it's making a noise.",
      problemItem: "PRINTER LENOVO",
      status: "Processing",
      message: [
        Message(
            speaker: ChatUser(
                id: 1,
                name: "Murillo Cardoso",
                email: "adm@h.c",
                password: "12",
                type: 2),
            message:
                "I've been taking a look and it doesn't seem like a big deal, just some gear stuck."),
      ]),
  Ticket(
    id: 3,
    title: "CELLPHONE DOES NOT ON",
    problemDescription: "MY CELL PHONE HAS STOPPED WORKING",
    problemItem: "CELLPHONE SAMSUNG S20fe",
    status: "Concluded",
     message:[
      Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2), 
     message:"Good morning, the department that requested this told me that they hadn't put it in the battery for a while, correct?."),
     Message(speaker:ChatUser(id: 2, name:"Junior", email: "marialuiza@h.c", password: "12", type: 1),
    message:"Hi, I have no idea, the director just gave it to me and I tried calling here and it didn't work"),
      Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2),
    message:"ok, I'll see what I can do"),
        Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2),
    message:"Well, I think that was it, the cell phone was just running out of battery, and I just left it charging for a long time"),
        Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2),
    message:"Please collect it from the TaskUse IT center")
    message: [
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message:
              "Good morning, the department that requested this told me that they hadn't put it in the battery for a while, correct?."),
      Message(
          speaker: ChatUser(
              id: 2,
              name: "Junior",
              email: "marialuiza@h.c",
              password: "12",
              type: 1),
          message:
              "Hi, I have no idea, the director just gave it to me and I tried calling here and it didn't work"),
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message: "ok, I'll see what I can do"),
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message:
              "Well, I think that was it, the cell phone was just running out of battery, and I just left it charging for a long time"),
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message: "Please collect it from the TaskUse IT center")
    ],
  ),
  Ticket(
    id: 4,
    title: "Router",
    problemDescription: "THE ROUTER HAS STOPPED WORKING AND HAS A RED LIGHT",
    problemItem: "THE ROUTER TP LINK",
    status: "Inconclusive",
     message:[
      Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2), 
     message:"Good afternoon, I've been looking at what happened, but I couldn't find anything, could you give me more details on a possible cause of the problem?"),
     Message(speaker:ChatUser(id: 2, name:"Junior", email: "junior@gmail.com", password: "maria12", type: 1),
    message:"Hi, so the department went on vacation and it seems that the support woman went to clean and disconnected some cables and it simply remained unconnected for a long time."),
      Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2), 
     message:"How strange it was that the router didn't find the network automatically, because we recently changed"),
       Message(speaker:ChatUser(id: 2, name:"Junior", email: "junior@gmail.com", password: "12", type: 1),
    message:"How will we do this?? I need you to tidy up for today, we can't go without updating the notes"),
        Message(speaker:ChatUser(id: 1, name:"Murillo Cardoso", email: "murillo@gmail.com", password: "12", type: 2), 
     message:"Let's do it like this, I'll give you a new router and I'll keep this one to fix. But I won't take it back"),
    message: [
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message:
              "Good afternoon, I've been looking at what happened, but I couldn't find anything, could you give me more details on a possible cause of the problem?"),
      Message(
          speaker: ChatUser(
              id: 2,
              name: "Junior",
              email: "junior@gmail.com",
              password: "maria12",
              type: 1),
          message:
              "Hi, so the department went on vacation and it seems that the support woman went to clean and disconnected some cables and it simply remained unconnected for a long time."),
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message:
              "How strange it was that the router didn't find the network automatically, because we recently changed"),
      Message(
          speaker: ChatUser(
              id: 2,
              name: "Junior",
              email: "junior@gmail.com",
              password: "12",
              type: 1),
          message:
              "How will we do this?? I need you to tidy up for today, we can't go without updating the notes"),
      Message(
          speaker: ChatUser(
              id: 1,
              name: "Murillo Cardoso",
              email: "murillo@gmail.com",
              password: "12",
              type: 2),
          message:
              "Let's do it like this, I'll give you a new router and I'll keep this one to fix. But I won't take it back"),
    ],
  ),
];

List<ChatUser> db_user=[

ChatUser(id: 1, name: "Murillo Cardoso", email: "murillo@gmail.com", password: "123456", type:2),
ChatUser(id: 2, name: "Junior", email: "junior@gmail.com", password: "123456", type:1),
];

List<ChatUser> db_user = [
  ChatUser(
      id: 1,
      name: "Murillo Cardoso",
      email: "murillo@gmail.com",
      password: "123456",
      type: 2),
  ChatUser(
      id: 2,
      name: "Junior",
      email: "junior@gmail.com",
      password: "123456",
      type: 1),
];

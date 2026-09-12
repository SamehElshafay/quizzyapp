// class DirectMessageDataMaodel {
//   int? id;
//   int? conversationId;
//   int? messageableId;
//   String? messageableType;
//   String? settings;
//   String? createdAt;
//   String? updatedAt;
//   int? private;
//   int? directMessage;
//   String? data;
//   Conversation? conversation;

//   DirectMessageDataMaodel(
//       {this.id,
//       this.conversationId,
//       this.messageableId,
//       this.messageableType,
//       this.settings,
//       this.createdAt,
//       this.updatedAt,
//       this.private,
//       this.directMessage,
//       this.data,
//       this.conversation});

//   DirectMessageDataMaodel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     conversationId = json['conversation_id'];
//     messageableId = json['messageable_id'];
//     messageableType = json['messageable_type'];
//     settings = json['settings'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     private = json['private'];
//     directMessage = json['direct_message'];
//     data = json['data'];
//     conversation = json['conversation'] != null
//         ? new Conversation.fromJson(json['conversation'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['conversation_id'] = this.conversationId;
//     data['messageable_id'] = this.messageableId;
//     data['messageable_type'] = this.messageableType;
//     data['settings'] = this.settings;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['private'] = this.private;
//     data['direct_message'] = this.directMessage;
//     data['data'] = this.data;
//     if (this.conversation != null) {
//       data['conversation'] = this.conversation!.toJson();
//     }
//     return data;
//   }
// }

// class Conversation {
//   int? id;
//   bool? private;
//   bool? directMessage;
//   List<Null>? data;
//   String? createdAt;
//   String? updatedAt;
//   LastMessage? lastMessage;
//   List<Participants>? participants;

//   Conversation(
//       {this.id,
//       this.private,
//       this.directMessage,
//       this.data,
//       this.createdAt,
//       this.updatedAt,
//       this.lastMessage,
//       this.participants});

//   Conversation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     private = json['private'];
//     directMessage = json['direct_message'];
//     if (json['data'] != null) {
//       data = <Null>[];
//       json['data'].forEach((v) {
//         data!.add(new Null.fromJson(v));
//       });
//     }
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     lastMessage = json['last_message'] != null
//         ? new LastMessage.fromJson(json['last_message'])
//         : null;
//     if (json['participants'] != null) {
//       participants = <Participants>[];
//       json['participants'].forEach((v) {
//         participants!.add(new Participants.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['private'] = this.private;
//     data['direct_message'] = this.directMessage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.lastMessage != null) {
//       data['last_message'] = this.lastMessage!.toJson();
//     }
//     if (this.participants != null) {
//       data['participants'] = this.participants!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class LastMessage {
//   int? id;
//   int? messageId;
//   int? messageableId;
//   String? messageableType;
//   int? conversationId;
//   int? participationId;
//   int? isSeen;
//   int? isSender;
//   bool? flagged;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   String? body;
//   String? type;
//   Data? data;
//   Sender? sender;
//   Participation? participation;

//   LastMessage(
//       {this.id,
//       this.messageId,
//       this.messageableId,
//       this.messageableType,
//       this.conversationId,
//       this.participationId,
//       this.isSeen,
//       this.isSender,
//       this.flagged,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt,
//       this.body,
//       this.type,
//       this.data,
//       this.sender,
//       this.participation});

//   LastMessage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     messageId = json['message_id'];
//     messageableId = json['messageable_id'];
//     messageableType = json['messageable_type'];
//     conversationId = json['conversation_id'];
//     participationId = json['participation_id'];
//     isSeen = json['is_seen'];
//     isSender = json['is_sender'];
//     flagged = json['flagged'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     body = json['body'];
//     type = json['type'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     sender =
//         json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
//     participation = json['participation'] != null
//         ? new Participation.fromJson(json['participation'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['message_id'] = this.messageId;
//     data['messageable_id'] = this.messageableId;
//     data['messageable_type'] = this.messageableType;
//     data['conversation_id'] = this.conversationId;
//     data['participation_id'] = this.participationId;
//     data['is_seen'] = this.isSeen;
//     data['is_sender'] = this.isSender;
//     data['flagged'] = this.flagged;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     data['body'] = this.body;
//     data['type'] = this.type;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     if (this.sender != null) {
//       data['sender'] = this.sender!.toJson();
//     }
//     if (this.participation != null) {
//       data['participation'] = this.participation!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? notificationImage;
//   String? title;
//   String? type;

//   Data({this.notificationImage, this.title, this.type});

//   Data.fromJson(Map<String, dynamic> json) {
//     notificationImage = json['notification_image'];
//     title = json['title'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['notification_image'] = this.notificationImage;
//     data['title'] = this.title;
//     data['type'] = this.type;
//     return data;
//   }
// }

// class Sender {
//   int? id;
//   String? name;
//   String? email;
//   String? password;
//   String? photo;
//   String? deviceToken;
//   bool? isActive;
//   String? createdAt;
//   String? updatedAt;
//   List<Participation>? participation;

//   Sender(
//       {this.id,
//       this.name,
//       this.email,
//       this.password,
//       this.photo,
//       this.deviceToken,
//       this.isActive,
//       this.createdAt,
//       this.updatedAt,
//       this.participation});

//   Sender.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     photo = json['photo'];
//     deviceToken = json['device_token'];
//     isActive = json['is_active'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['participation'] != null) {
//       participation = <Participation>[];
//       json['participation'].forEach((v) {
//         participation!.add(new Participation.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['photo'] = this.photo;
//     data['device_token'] = this.deviceToken;
//     data['is_active'] = this.isActive;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.participation != null) {
//       data['participation'] =
//           this.participation!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Participation {
//   int? id;
//   int? conversationId;
//   int? messageableId;
//   String? messageableType;
//   String? settings;
//   String? createdAt;
//   String? updatedAt;

//   Participation(
//       {this.id,
//       this.conversationId,
//       this.messageableId,
//       this.messageableType,
//       this.settings,
//       this.createdAt,
//       this.updatedAt});

//   Participation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     conversationId = json['conversation_id'];
//     messageableId = json['messageable_id'];
//     messageableType = json['messageable_type'];
//     settings = json['settings'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['conversation_id'] = this.conversationId;
//     data['messageable_id'] = this.messageableId;
//     data['messageable_type'] = this.messageableType;
//     data['settings'] = this.settings;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class ParticipationMessageable {
//   int? id;
//   int? conversationId;
//   int? messageableId;
//   String? messageableType;
//   Null? settings;
//   String? createdAt;
//   String? updatedAt;
//   Sender? messageable;

//   ParticipationMessageable(
//       {this.id,
//       this.conversationId,
//       this.messageableId,
//       this.messageableType,
//       this.settings,
//       this.createdAt,
//       this.updatedAt,
//       this.messageable});

//   ParticipationMessageable.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     conversationId = json['conversation_id'];
//     messageableId = json['messageable_id'];
//     messageableType = json['messageable_type'];
//     settings = json['settings'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     messageable = json['messageable'] != null
//         ? new Sender.fromJson(json['messageable'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['conversation_id'] = this.conversationId;
//     data['messageable_id'] = this.messageableId;
//     data['messageable_type'] = this.messageableType;
//     data['settings'] = this.settings;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.messageable != null) {
//       data['messageable'] = this.messageable!.toJson();
//     }
//     return data;
//   }
// }

// class Messageable {
//   int? id;
//   String? name;
//   String? email;
//   String? password;
//   String? photo;
//   Null? deviceToken;
//   bool? isActive;
//   String? createdAt;
//   String? updatedAt;
//   List<Participation>? participation;
//   Null? username;
//   String? phone;
//   Null? dateOfBirth;
//   Null? providerId;
//   Null? providerType;
//   Null? governorate;
//   Null? area;
//   Null? residenceArea;
//   Null? specialization;
//   Null? academicYearId;
//   Null? emailVerifiedAt;
//   Null? locationArea;
//   bool? phoneVerified;
//   int? balance;

//   Messageable(
//       {this.id,
//       this.name,
//       this.email,
//       this.password,
//       this.photo,
//       this.deviceToken,
//       this.isActive,
//       this.createdAt,
//       this.updatedAt,
//       this.participation,
//       this.username,
//       this.phone,
//       this.dateOfBirth,
//       this.providerId,
//       this.providerType,
//       this.governorate,
//       this.area,
//       this.residenceArea,
//       this.specialization,
//       this.academicYearId,
//       this.emailVerifiedAt,
//       this.locationArea,
//       this.phoneVerified,
//       this.balance});

//   Messageable.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     photo = json['photo'];
//     deviceToken = json['device_token'];
//     isActive = json['is_active'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['participation'] != null) {
//       participation = <Participation>[];
//       json['participation'].forEach((v) {
//         participation!.add(new Participation.fromJson(v));
//       });
//     }
//     username = json['username'];
//     phone = json['phone'];
//     dateOfBirth = json['date_of_birth'];
//     providerId = json['provider_id'];
//     providerType = json['provider_type'];
//     governorate = json['governorate'];
//     area = json['area'];
//     residenceArea = json['residence_area'];
//     specialization = json['specialization'];
//     academicYearId = json['academic_year_id'];
//     emailVerifiedAt = json['email_verified_at'];
//     locationArea = json['location_area'];
//     phoneVerified = json['phone_verified'];
//     balance = json['balance'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['photo'] = this.photo;
//     data['device_token'] = this.deviceToken;
//     data['is_active'] = this.isActive;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.participation != null) {
//       data['participation'] =
//           this.participation!.map((v) => v.toJson()).toList();
//     }
//     data['username'] = this.username;
//     data['phone'] = this.phone;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['provider_id'] = this.providerId;
//     data['provider_type'] = this.providerType;
//     data['governorate'] = this.governorate;
//     data['area'] = this.area;
//     data['residence_area'] = this.residenceArea;
//     data['specialization'] = this.specialization;
//     data['academic_year_id'] = this.academicYearId;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['location_area'] = this.locationArea;
//     data['phone_verified'] = this.phoneVerified;
//     data['balance'] = this.balance;
//     return data;
//   }
// }

// class Participants {
//   int? id;
//   int? conversationId;
//   int? messageableId;
//   String? messageableType;
//   Null? settings;
//   String? createdAt;
//   String? updatedAt;
//   Messageable? messageable;

//   Participants(
//       {this.id,
//       this.conversationId,
//       this.messageableId,
//       this.messageableType,
//       this.settings,
//       this.createdAt,
//       this.updatedAt,
//       this.messageable});

//   Participants.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     conversationId = json['conversation_id'];
//     messageableId = json['messageable_id'];
//     messageableType = json['messageable_type'];
//     settings = json['settings'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     messageable = json['messageable'] != null
//         ? new Messageable.fromJson(json['messageable'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['conversation_id'] = this.conversationId;
//     data['messageable_id'] = this.messageableId;
//     data['messageable_type'] = this.messageableType;
//     data['settings'] = this.settings;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.messageable != null) {
//       data['messageable'] = this.messageable!.toJson();
//     }
//     return data;
//   }
// }

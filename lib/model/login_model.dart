// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? type;
  String? message;
  User? user;
  Tokens? tokens;

  LoginModel({
    this.type,
    this.message,
    this.user,
    this.tokens,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        type: json["type"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class User {
  ProfileImage? profileImage;
  bool? online;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? chatToken;
  String? password;
  String? role;
  bool? isEmailVerified;
  bool? isVerifiedSeller;
  bool? isVerifiedDriver;
  String? status;
  String? address;
  SellerAttributes? sellerAttributes;
  int? taxPercentage;
  List<dynamic>? kycDocuments;
  int? subscriptionEndDate;
  bool? subscriptionDisabled;
  List<dynamic>? referredUsers;
  int? referralDiscount;

  User({
    this.profileImage,
    this.online,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.chatToken,
    this.password,
    this.role,
    this.isEmailVerified,
    this.isVerifiedSeller,
    this.isVerifiedDriver,
    this.status,
    this.address,
    this.sellerAttributes,
    this.taxPercentage,
    this.kycDocuments,
    this.subscriptionEndDate,
    this.subscriptionDisabled,
    this.referredUsers,
    this.referralDiscount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        profileImage: json["profileImage"] == null
            ? null
            : ProfileImage.fromJson(json["profileImage"]),
        online: json["online"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        chatToken: json["chat_token"],
        password: json["password"],
        role: json["role"],
        isEmailVerified: json["isEmailVerified"],
        isVerifiedSeller: json["isVerifiedSeller"],
        isVerifiedDriver: json["isVerifiedDriver"],
        status: json["status"],
        address: json["address"],
        sellerAttributes: json["sellerAttributes"] == null
            ? null
            : SellerAttributes.fromJson(json["sellerAttributes"]),
        taxPercentage: json["tax_percentage"],
        kycDocuments: json["kyc_documents"] == null
            ? []
            : List<dynamic>.from(json["kyc_documents"]!.map((x) => x)),
        subscriptionEndDate: json["subscription_end_date"],
        subscriptionDisabled: json["subscription_disabled"],
        referredUsers: json["referred_users"] == null
            ? []
            : List<dynamic>.from(json["referred_users"]!.map((x) => x)),
        referralDiscount: json["referralDiscount"],
      );

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage?.toJson(),
        "online": online,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "chat_token": chatToken,
        "password": password,
        "role": role,
        "isEmailVerified": isEmailVerified,
        "isVerifiedSeller": isVerifiedSeller,
        "isVerifiedDriver": isVerifiedDriver,
        "status": status,
        "address": address,
        "sellerAttributes": sellerAttributes?.toJson(),
        "tax_percentage": taxPercentage,
        "kyc_documents": kycDocuments == null
            ? []
            : List<dynamic>.from(kycDocuments!.map((x) => x)),
        "subscription_end_date": subscriptionEndDate,
        "subscription_disabled": subscriptionDisabled,
        "referred_users": referredUsers == null
            ? []
            : List<dynamic>.from(referredUsers!.map((x) => x)),
        "referralDiscount": referralDiscount,
      };
}

class ProfileImage {
  String? original;
  String? web;
  String? mobile;

  ProfileImage({
    this.original,
    this.web,
    this.mobile,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        original: json["original"],
        web: json["web"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "web": web,
        "mobile": mobile,
      };
}

class SellerAttributes {
  BankDetail? bankDetail;
  TaxationInformation? taxationInformation;
  SocialLinks? socialLinks;
  Branding? branding;
  List<Business>? businesses;
  List<AddressOfProof>? registrationCertificates;
  List<AddressOfProof>? addressOfProof;
  List<AddressOfProof>? bankStatments;
  String? id;
  List<dynamic>? birCertificates;
  List<dynamic>? vatDocuments;
  List<dynamic>? incomeTax;

  SellerAttributes({
    this.bankDetail,
    this.taxationInformation,
    this.socialLinks,
    this.branding,
    this.businesses,
    this.registrationCertificates,
    this.addressOfProof,
    this.bankStatments,
    this.id,
    this.birCertificates,
    this.vatDocuments,
    this.incomeTax,
  });

  factory SellerAttributes.fromJson(Map<String, dynamic> json) =>
      SellerAttributes(
        bankDetail: json["bankDetail"] == null
            ? null
            : BankDetail.fromJson(json["bankDetail"]),
        taxationInformation: json["taxationInformation"] == null
            ? null
            : TaxationInformation.fromJson(json["taxationInformation"]),
        socialLinks: json["socialLinks"] == null
            ? null
            : SocialLinks.fromJson(json["socialLinks"]),
        branding: json["branding"] == null
            ? null
            : Branding.fromJson(json["branding"]),
        businesses: json["businesses"] == null
            ? []
            : List<Business>.from(
                json["businesses"]!.map((x) => Business.fromJson(x))),
        registrationCertificates: json["registrationCertificates"] == null
            ? []
            : List<AddressOfProof>.from(json["registrationCertificates"]!
                .map((x) => AddressOfProof.fromJson(x))),
        addressOfProof: json["addressOfProof"] == null
            ? []
            : List<AddressOfProof>.from(
                json["addressOfProof"]!.map((x) => AddressOfProof.fromJson(x))),
        bankStatments: json["bankStatments"] == null
            ? []
            : List<AddressOfProof>.from(
                json["bankStatments"]!.map((x) => AddressOfProof.fromJson(x))),
        id: json["_id"],
        birCertificates: json["birCertificates"] == null
            ? []
            : List<dynamic>.from(json["birCertificates"]!.map((x) => x)),
        vatDocuments: json["VATDocuments"] == null
            ? []
            : List<dynamic>.from(json["VATDocuments"]!.map((x) => x)),
        incomeTax: json["incomeTAX"] == null
            ? []
            : List<dynamic>.from(json["incomeTAX"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bankDetail": bankDetail?.toJson(),
        "taxationInformation": taxationInformation?.toJson(),
        "socialLinks": socialLinks?.toJson(),
        "branding": branding?.toJson(),
        "businesses": businesses == null
            ? []
            : List<dynamic>.from(businesses!.map((x) => x.toJson())),
        "registrationCertificates": registrationCertificates == null
            ? []
            : List<dynamic>.from(
                registrationCertificates!.map((x) => x.toJson())),
        "addressOfProof": addressOfProof == null
            ? []
            : List<dynamic>.from(addressOfProof!.map((x) => x.toJson())),
        "bankStatments": bankStatments == null
            ? []
            : List<dynamic>.from(bankStatments!.map((x) => x.toJson())),
        "_id": id,
        "birCertificates": birCertificates == null
            ? []
            : List<dynamic>.from(birCertificates!.map((x) => x)),
        "VATDocuments": vatDocuments == null
            ? []
            : List<dynamic>.from(vatDocuments!.map((x) => x)),
        "incomeTAX": incomeTax == null
            ? []
            : List<dynamic>.from(incomeTax!.map((x) => x)),
      };
}

class AddressOfProof {
  String? link;
  String? s3Id;
  String? id;

  AddressOfProof({
    this.link,
    this.s3Id,
    this.id,
  });

  factory AddressOfProof.fromJson(Map<String, dynamic> json) => AddressOfProof(
        link: json["link"],
        s3Id: json["s3Id"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "s3Id": s3Id,
        "_id": id,
      };
}

class BankDetail {
  String? bankName;
  int? accountNumber;
  String? accountTitle;
  String? branchName;
  dynamic branchCode;
  String? ibanNumber;

  BankDetail({
    this.bankName,
    this.accountNumber,
    this.accountTitle,
    this.branchName,
    this.branchCode,
    this.ibanNumber,
  });

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        accountTitle: json["accountTitle"],
        branchName: json["branchName"],
        branchCode: json["branchCode"],
        ibanNumber: json["IBANNumber"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountTitle": accountTitle,
        "branchName": branchName,
        "branchCode": branchCode,
        "IBANNumber": ibanNumber,
      };
}

class Branding {
  List<dynamic>? bannerImage;

  Branding({
    this.bannerImage,
  });

  factory Branding.fromJson(Map<String, dynamic> json) => Branding(
        bannerImage: json["bannerImage"] == null
            ? []
            : List<dynamic>.from(json["bannerImage"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bannerImage": bannerImage == null
            ? []
            : List<dynamic>.from(bannerImage!.map((x) => x)),
      };
}

class Business {
  BillingDetails? billingDetails;
  String? category;
  String? registrationNumber;
  String? id;

  Business({
    this.billingDetails,
    this.category,
    this.registrationNumber,
    this.id,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        billingDetails: json["billingDetails"] == null
            ? null
            : BillingDetails.fromJson(json["billingDetails"]),
        category: json["category"],
        registrationNumber: json["registrationNumber"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "billingDetails": billingDetails?.toJson(),
        "category": category,
        "registrationNumber": registrationNumber,
        "_id": id,
      };
}

class BillingDetails {
  String? country;
  String? registeredAddress;

  BillingDetails({
    this.country,
    this.registeredAddress,
  });

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
        country: json["country"],
        registeredAddress: json["registeredAddress"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "registeredAddress": registeredAddress,
      };
}

class SocialLinks {
  String? facebook;
  String? instagram;
  String? youtube;
  String? twitter;
  String? linkedIn;
  String? tikTok;

  SocialLinks({
    this.facebook,
    this.instagram,
    this.youtube,
    this.twitter,
    this.linkedIn,
    this.tikTok,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        twitter: json["twitter"],
        linkedIn: json["linkedIn"],
        tikTok: json["tikTok"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "instagram": instagram,
        "youtube": youtube,
        "twitter": twitter,
        "linkedIn": linkedIn,
        "tikTok": tikTok,
      };
}

class TaxationInformation {
  String? birNumber;
  String? taxNumber;
  String? vatNumber;

  TaxationInformation({
    this.birNumber,
    this.taxNumber,
    this.vatNumber,
  });

  factory TaxationInformation.fromJson(Map<String, dynamic> json) =>
      TaxationInformation(
        birNumber: json["BIRNumber"],
        taxNumber: json["taxNumber"],
        vatNumber: json["VATNumber"],
      );

  Map<String, dynamic> toJson() => {
        "BIRNumber": birNumber,
        "taxNumber": taxNumber,
        "VATNumber": vatNumber,
      };
}

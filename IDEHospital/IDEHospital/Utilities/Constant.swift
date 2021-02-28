//
//  File.swift
//  IDEHospital
//
//  Created by ahmedElbasha on 06/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

// Storyboards
struct Storyboards {
    static let main = "Main"
    static let SearchServices = "ServiceSearch"
    static let tabScreens = "TabScreens"
    static let homeNurse = "HomeNurse"
    static let searchResultVC = "SearchResult"
    static let settings = "Settings"
    static let Auth = "Auth"
    static let PopUps = "PopUps"
    static let Review = "Review"
    static let doctorProfile = "DoctorProfile"
    static let editProfile = "EditProfile"
    static let authPopUps = "AuthPopUps"
}

// Header Keys
struct HeaderKeys {
    static let acceptLanguage = "Accept-Language"
    static let authorization = "Authorization"
    static let bearer = "Bearer "
    static let contentType = "Content-Type"
}

// View Controllers
struct ViewControllers {
    static let homeVC = "HomeVC"
    static let SearchServicesVC = "SearchServicesVC"
    static let tabBarVC = "TabBarVC"
    static let myFavoriteVC = "MyFavoriteVC"
    static let myAppointmentsVC = "MyAppointmentsVC"
    static let homeNurseVC = "HomeNurseVC"
    static let searchResultVC = "SearchResultVC"
    static let settingsVC = "SettingsVC"
    static let aboutUsAndConditionVC = "AboutUsAndTermsAndConditionVC"
    static let loginVC = "LoginVC"
    static let signUpVC = "SignUpVC"
    static let resetPasswordVC = "ResetPasswordVC"
    static let voucherPopUpVC = "VoucherPopUpVC"
    static let confirmAppointmentVC = "ConfirmAppointmentVC"
    static let cancelAppointmentVC = "CancelAppointmentVC"
    static let successfullyBookedVC = "SuccessfullyBookedVC"
    static let reviewVC = "ReviewVC"
    static let doctorProfileVC = "DoctorProfileVC"
    static let editProfileVC = "EditProfileVC"
    static let authPopUpVC = "AuthPopUpVC"
}

// Cells
struct Cells {
    static let homeCollectionViewCell = "HomeCollectionViewCell"
    static let appointmentTableViewCell = "AppointmentTableViewCell"
    static let favoriteTableViewCell = "FavoriteTableViewCell"
    static let SearchResultCell = "SearchResultCell"
    static let settingsTableViewCell = "SettingsTableViewCell"
    static let reviewsTableViewCell = "ReviewsTableViewCell"
    static let timeCollectionViewCell = "TimeCollectionViewCell"
}

// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api"
    static let mainCategory = "/main_categories"
    static let userAppointments = "/user_appointments"
    static let userFavotite = "/favorites/doctors"
    static let addOrRemoveFromFavorite = "/add_remove"
    static let nursingRequest = "/nursing_requests"
    static let findDoctorRequest = "/doctors"
    static let reviews = "/reviews"
    static let appointment = "/appointments"
    static let termsAndCondition = "/terms_and_conditions"
    static let AboutUs = "/about_us"
    static let contactUs = "/contact_us_requests"
    static let logOut = "/logout"
    static let login = "/login"
    static let register = "/register"
    static let forgetPassword = "/forget_password"
    static let appointementBook = "/user_appointments"
    static let doctors = "/doctors"
    static let review =  "/reviews"
      static let user = "/user"
    static let loginBook = "/user_appointments/with_login"
    static let signUpBook = "/user_appointments/with_register"
}

struct PrametersKeys{
    static let pages = "page"
    static let comment = "comment"
    static let id = "doctor_id"
    static let appointment = "appointment"
    static let voucher = "voucher"
    static let bookforanother = "book_for_another"
    static let patientName = "patient_name"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}




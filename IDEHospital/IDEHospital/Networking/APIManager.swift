//
//  APIManager.swift
//  IDEHospital
//
//  Created by ahmedElbasha on 06/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    class func getHomeData(completion: @escaping (Result<CategorieResponse, Error>) -> Void) {
        request(APIRouter.getDataHome) { (response) in
            completion(response)
        }
        
    }
    
    class func getCategoryData(with categoriesID: Int, completion: @escaping (Result<CategoryResonse, Error>) -> Void ) {
        request(APIRouter.CategoryResponse(id: categoriesID)) { (response) in
            
            completion(response)
        }
    }
    class func getFavoriteData(page: Int, completion: @escaping (Result<FavoriteResponse, Error>) -> Void){
        request(APIRouter.getMyFavoriteData(Page: page)) { (response) in
            completion(response)
        }
    }
    class func removeOrAddToFavorite(id: Int, completion: @escaping (Result<DeletingResponse, Error>) -> Void){
        request(APIRouter.addOrRemoveFromFavorite(id: id)) { (response)  in
            completion(response)
            
        }
    }
    class func getUserAppointment(page: Int, completion: @escaping (Result<aoppointmentResponse, Error>) -> Void) {
        request(APIRouter.getAppointmet(page: page)) { (response) in
            completion(response)
        }
    }
    class func deleteFromAppointment(id: Int, completion: @escaping (Result<DeletingResponse, Error>) -> Void){
        request(APIRouter.deleteFromAppointment(id:id)) { (response) in
            completion(response)
        }
    }
    class func getAboutUsData(completion: @escaping (Result<AboutUsResponse, Error>) -> Void){
        request(APIRouter.aboutUs) { (response) in
            completion(response)
        }
    }
    class func getTermsAndConditionData(completion: @escaping (Result<TermsAndCondtionResponse, Error>) -> Void){
        request(APIRouter.termsAndCondition) { (response) in
            completion(response)
        }
    }
    
    
    class func sendNurseRequest(_ name: String, _ email: String, _ mobile: String, _ message: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        AF.upload(multipartFormData: { (multiPartFormData) in
            multiPartFormData.append(Data(name.utf8), withName: "name")
            multiPartFormData.append(Data(email.utf8), withName: "email")
            multiPartFormData.append(Data(mobile.utf8), withName: "mobile")
            multiPartFormData.append(Data(message.utf8), withName: "message")
        }, with: APIRouter.nursingRequest).response { response in
            switch response.result {
            case .success:
                print(response.result)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    class func sendContactUsRequest(_ name: String, _ email: String, _ mobile: String, _ message: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        AF.upload(multipartFormData: { (multiPartFormData) in
            multiPartFormData.append(Data(name.utf8), withName: "name")
            multiPartFormData.append(Data(email.utf8), withName: "email")
            multiPartFormData.append(Data(mobile.utf8), withName: "mobile")
            multiPartFormData.append(Data(message.utf8), withName: "message")
        }, with: APIRouter.contactUsRequest).response { response in
            switch response.result {
            case .success:
                print(response.result)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    class func logOut(completion: @escaping (Result<DeletingResponse, Error>) -> Void){
        request(APIRouter.logOutTheUser) { (response) in
            completion(response)
        }
    }
    
    class func findDoctor(with doctorFilter: DoctorsFilter, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        request(APIRouter.findDoctor(doctorFilter: doctorFilter)) { (response) in
            completion(response)
        }
    }
    
    class func register(with user: AuthUser, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        request(APIRouter.register(user)) { (response) in
            completion(response)
        }
    }
    
    class func login(with user: AuthUser, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        request(APIRouter.login(user)) { (response) in
            completion(response)
        }
    }
    
    class func reset(with user: AuthUser, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        request(APIRouter.resetPassword(user)) { (response) in
            completion(response)
        }
    }
    
    class func bookAppointement(user: AppointmentUser, completion: @escaping (Result<AppointmentResponse, Error>) -> Void) {
        request(APIRouter.bookAppointement(user)) { (response) in
            completion(response)
        }
    }
    
    class func getDoctorData(doctorId: Int, completion: @escaping (Result<DoctorResponse, Error>) -> Void){
        request(APIRouter.getDoctorProfile(doctorId: doctorId)) { (response) in
            completion(response)
        }
    }
    
    class func getUserData(completion: @escaping (Result<getUserResponse, Error>) -> Void){
        request(APIRouter.getUserData) { (response) in
            completion(response)
        }
    }
    
    class func editUserData(userData: EditUserProfile, completion: @escaping (Result<getUserResponse, Error>) -> Void){
        request(APIRouter.editProfile(userData)) { (response) in
            completion(response)
        }
    }
    
    class func getReviews(doctorId: Int, page: Int, completion: @escaping (Result<getReviewResponse, Error>) -> Void){
        request(APIRouter.getDoctorReviews(page: page, DoctorId: doctorId)) { (response) in
            completion(response)
        }
    }
    
    class func reviewDoctor(doctorID: Int, review: ReviewDoctor, completion: @escaping (Result<ReviewResponse, Error>) -> Void) {
        request(APIRouter.reviewDoctor(review, doctorID: doctorID)) { (response) in
            completion(response)
        }
    }
    
    class func getAppointment(doctorId: Int, completion: @escaping (Result<BookingAppointmentResponse, Error>) -> Void){
        request(APIRouter.bookingAppointment(DoctorId: doctorId)) { (response) in
            completion(response)
        }
    }
    
    class func authBook(user: AuthBook, completion: @escaping (Result<UserBookResponse, Error>) -> Void) {
        request(APIRouter.loginAndBook(user)) { (response) in
            completion(response)
        }
    }
    
    class func signUpBook(user: AuthBook, completion: @escaping (Result<UserBookResponse, Error>) -> Void) {
         request(APIRouter.signUpAndBook(user)) { (response) in
             completion(response)
         }
     }
}

extension APIManager {
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
            
        .responseJSON { response in
            print(response)
        }
    }
    
    //ToDo:- for future api requests
    private static func requestData(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<Data, Error>) -> Void) {
        AF.request(urlConvertible).response { (response) in
            switch response.result {
                
            case .success(let data):
                guard let data = data else {return}
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            switch response.result {
                
            case .success(_):
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func requestBool(_ urlConvertible: URLRequestConvertible, completion: @escaping (Bool) ->  Void) {
        AF.request(urlConvertible).response { response in
            switch response.result {
                
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
        
    }
}

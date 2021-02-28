
import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // The endpoint name
    case getDataHome
    case CategoryResponse(id: Int)
    case getMyFavoriteData(Page: Int)
    case addOrRemoveFromFavorite(id: Int)
    case getAppointmet(page: Int)
    case deleteFromAppointment(id: Int)
    case nursingRequest
    case findDoctor(doctorFilter: DoctorsFilter)
    case aboutUs
    case termsAndCondition
    case contactUsRequest
    case logOutTheUser
    case login(_ user:AuthUser)
    case register(_ user: AuthUser)
    case resetPassword(_ user: AuthUser)
    case bookAppointement(_ appointment: AppointmentUser)
    case reviewDoctor(_ review: ReviewDoctor, doctorID: Int)
    case getDoctorProfile(doctorId: Int)
    case getDoctorReviews(page: Int, DoctorId: Int)
    case bookingAppointment( DoctorId: Int)
    case getUserData
    case editProfile(_ userData: EditUserProfile)
    case loginAndBook(_ user: AuthBook)
    case signUpAndBook(_ user: AuthBook)

    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getDataHome, .CategoryResponse, .getMyFavoriteData, .getAppointmet, .findDoctor, .aboutUs, .termsAndCondition, .getDoctorProfile, .getDoctorReviews, .bookingAppointment, .getUserData:
            return .get
        case .deleteFromAppointment:
            return .delete
        case .editProfile:
        return .patch
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getMyFavoriteData(let page), .getAppointmet(let page), .getDoctorReviews(let page, _):
            return[PrametersKeys.pages: page]
        case .findDoctor(let doctorFilter):
            return doctorFilter.parameters()
      
        default:
            return nil
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getDataHome:
            return URLs.mainCategory
        case .CategoryResponse(let id):
            return URLs.mainCategory + "/\(id)/" + L10n.doctorsQueryParameters
        case .getMyFavoriteData:
            return URLs.userFavotite
        case .addOrRemoveFromFavorite(let id):
            return URLs.userFavotite + "/\(id)" + URLs.addOrRemoveFromFavorite
        case.getAppointmet:
            return URLs.userAppointments
        case .deleteFromAppointment(let id):
            return URLs.userAppointments + "/\(id)"
        case .nursingRequest:
            return  URLs.nursingRequest
        case .findDoctor(let doctorFilter):
            return URLs.mainCategory + "/\(doctorFilter.categoryId!)" + URLs.findDoctorRequest
        case .aboutUs:
            return URLs.AboutUs
        case .termsAndCondition:
            return URLs.termsAndCondition
        case .contactUsRequest:
            return URLs.contactUs
        case .logOutTheUser:
            return URLs.logOut
        case .login:
            return URLs.login
        case .register:
            return URLs.register
        case .resetPassword:
            return URLs.forgetPassword
        case .bookAppointement:
            return URLs.appointementBook
        case .reviewDoctor(_, let id):
            return URLs.doctors + "/\(id)" + URLs.review
        case .getDoctorProfile(let id):
            return URLs.findDoctorRequest + "/\(id)"
        case .getDoctorReviews( _,let id):
            return URLs.findDoctorRequest + "/\(id)" + URLs.reviews
        case .bookingAppointment(let id):
            return URLs.findDoctorRequest + "/\(id)" + URLs.appointment
        case .getUserData:
            return URLs.user
        case .editProfile:
            return URLs.user
        case .loginAndBook:
            return URLs.loginBook
        case .signUpAndBook:
            return URLs.signUpBook
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getMyFavoriteData, .getAppointmet, .findDoctor,.bookAppointement, .loginAndBook, .signUpAndBook,  .reviewDoctor, .editProfile:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
            urlRequest.setValue("en", forHTTPHeaderField: HeaderKeys.acceptLanguage)
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
        case .getDoctorProfile:
            if UserDefaultsManager.shared().token != "" {
                    urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")" , forHTTPHeaderField: HeaderKeys.authorization)
                    urlRequest.setValue("application/json",
                                        forHTTPHeaderField: HeaderKeys.contentType)
            
                    urlRequest.setValue("en",
                                        forHTTPHeaderField: HeaderKeys.acceptLanguage)
            }else{
                urlRequest.setValue("application/json",
                                                    forHTTPHeaderField: HeaderKeys.contentType)
            }
        case .addOrRemoveFromFavorite, .deleteFromAppointment, .logOutTheUser, .getUserData:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")" , forHTTPHeaderField: HeaderKeys.authorization)
        case .register, .login, .resetPassword:
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
        default:
            urlRequest.setValue("en",
                                forHTTPHeaderField: HeaderKeys.acceptLanguage)
        }
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .register(let body):
                return encodeToJSON(body)
            case .login(let body):
                return encodeToJSON(body)
            case .resetPassword(let body):
                return encodeToJSON(body)
            case .bookAppointement(let body):
                return encodeToJSON(body)
            case .reviewDoctor(let body, _):
                return encodeToJSON(body)
            case .editProfile(let body):
                return encodeToJSON(body)
            case .loginAndBook(let body), .signUpAndBook(let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: parameters)
    }
}


extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
    
    // type-erasing wrapper
    struct AnyEncodable: Encodable {
        private let _encode: (Encoder) throws -> Void
        
        public init<T: Encodable>(_ wrapped: T) {
            _encode = wrapped.encode
        }
        
        func encode(to encoder: Encoder) throws {
            try _encode(encoder)
        }
    }
}

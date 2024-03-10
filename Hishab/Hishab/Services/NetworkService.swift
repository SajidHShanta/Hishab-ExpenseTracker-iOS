//
//  NetworkService.swift
//  Hishab
//
//  Created by Sajid Shanta on 10/3/24.
//

import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private init(){ }
    
    static let baseURL = "http://hishab.sajidhasan.com"
//        static let baseURL = "http://localhost:3000" //local host
    
    func login(dictionary: [String: Any], completion: @escaping ((Result<UserResponse, AppError>)->())) {
        genericNormalRequest(.post, API_K.LOGIN, parameters: dictionary, completion: completion)
    }
    
    func register(dictionary: [String: Any], completion: @escaping ((Result<UserResponse, AppError>)->())) {
        genericNormalRequest(.post, API_K.LOGIN, parameters: dictionary, completion: completion)
    }
    
//    func fetchHmeData(dictionary: [String: Any], completion: @escaping ((Result<[Category], AppError>)->())) {
//        genericNormalRequest(.get, API_K.HOME, parameters: dictionary, completion: completion)
//    }
//    
//    func fetchReportDataByTime(id: String, dictionary: [String: Any], completion: @escaping ((Result<[ReportData], AppError>)->())) {
//        genericNormalRequest(.post, API_K.REPORT_BY_TIME+id, parameters: dictionary, completion: completion)
//    }
    
    struct API_K {
        static let LOGIN = "/api/auth/login"
        static let REGISTER = "/api/auth/register"
//        static let REFRESH = "auth/oauth/token/refresh"
    }
    
    func genericNormalRequest<T: Codable>(_ method: HTTPMethod,
                                          _ urlString: String,
                                          parameters: Parameters? = nil,
                                          completion :@escaping ((Result<T, AppError>) -> ())) {
        
        NormalRequest(method, urlString, parameters: parameters, encoding: JSONEncoding.default) { result in

            switch result {
                
            case .success(let rootDict):
                
                guard  let dict = rootDict as? [String: Any] else {
                    completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                    return
                }
                
//                guard  let status = dict["status"] as? Bool else {
//                    completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
//                    return
//                }
                
//                if status == true {
                    
                    var tempResult: [String: Any]?
                    var tempResults: [[String: Any]]?
                    
                    
                    if let result = dict["result"] as? [String:Any] {
                        tempResult = result
                    }
                    
                    if let results = dict["result"] as? [[String:Any]] {
                        tempResults = results
                    }
                    
                    if let tempResult {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: tempResult, options: [])
                            let decodableObject = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(decodableObject))
                            
                        } catch let error {
                            print(error)
                            completion(.failure(.network(type: .parsing)))
                        }
                    } else if let tempResults {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: tempResults, options: [])
                            let decodableObject = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(decodableObject))
                            
                        } catch let error {
                            print(error)
                            completion(.failure(.network(type: .parsing)))
                        }
                    } else {
                        completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                    }
 //               }
                
//                else {
//                    guard  let error = dict["error"] as? [String: Any] else {
//                        completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
//                        return
//                    }
//
//                    guard  let code = error["code"] as? Int else {
//                        completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
//                        return
//                    }
//
//                    if let  message = error["message"] as? String {
//                        completion(.failure(.custom(errorCode: code, errorDescription: message)))
//                    } else {
//                        completion(.failure(.custom(errorCode: code, errorDescription: "Service can not be processed at this moment.Please try later!")))
//                    }
//
//                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func genericCodableRequest<T:Codable, Parameters:Codable>(
        _ method: HTTPMethod,
        _ urlString: String,
        parameters: Parameters? = nil,
        completion :@escaping ((Result<T, AppError>)->())) {
            
            
            RequestWithCodableData(method, urlString, parameters: parameters) { result in
                
                switch result {
                    
                case .success(let rootDict):
                    
                    guard  let dict = rootDict as? [String: Any] else {
                        completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                        return
                    }
                    
                    guard  let status = dict["status"] as? Bool else {
                        completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                        return
                    }
                    
                    
                    if status == true {
                        
                        var tempResult: [String: Any]?
                        var tempResults: [[String: Any]]?
                        
                        if let result = dict["results"] as? [String: Any] {
                            tempResult = result
                        }
                        
                        if let results = dict["results"] as? [[String: Any]] {
                            tempResults = results
                        }
                        
                        if let tempResult {
                            do {
                                let data = try JSONSerialization.data(withJSONObject: tempResult, options: [])
                                let genericResult = try JSONDecoder().decode(T.self, from: data)
                                completion(.success(genericResult))
                                
                            } catch let error {
                                print(error)
                                completion(.failure(.network(type: .parsing)))
                            }
                        } else if let tempResults {
                            do {
                                let data = try JSONSerialization.data(withJSONObject: tempResults, options: [])
                                let genericResult = try JSONDecoder().decode(T.self, from: data)
                                completion(.success(genericResult))
                                
                            } catch let error {
                                print(error)
                                completion(.failure(.network(type: .parsing)))
                            }
                        } else {
                            completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                        }
                    } else {
                        guard  let error = dict["error"] as? [String:Any] else {
                            completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                            return
                        }
                        
                        guard  let code = error["code"] as? Int else {
                            completion(.failure(.custom(errorCode: 0, errorDescription: "Service can not be processed at this moment.Please try later!")))
                            return
                        }
                        
                        if let  message = error["message"] as? String {
                            completion(.failure(.custom(errorCode: code, errorDescription: message)))
                            
                        } else {
                            completion(.failure(.custom(errorCode: code, errorDescription: "Service can not be processed at this moment.Please try later!")))
                        }
                    }
                    
                case .failure(let error):
                    
                    completion(.failure(error))
                }
            }
        }
}





enum AppError {
    case network(type: Enums.NetworkError)
    case custom(errorCode: Int?, errorDescription: String)
    class Enums { }
}

extension AppError.Enums {
    enum NetworkError  {
        case parsing
        case custom(errorCode: Int?, errorDescription: String)
    }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network(let type): return type.localizedDescription
        case .custom(_, let errorDescription): return errorDescription
        }
    }
}
extension AppError.Enums.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parsing: return "Something went wrong, Please try later."
        case .custom(_, let errorDescription): return errorDescription
            
        }
    }

    var errorCode: Int? {
        switch self {
        case .parsing: return nil
        case .custom(let errorCode, _): return errorCode
        }
    }
}



func NormalRequest(
    _ method: HTTPMethod,
    _ urlString: String,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: [String: String]? = nil,
    completion : @escaping((Result<Any,AppError>)->()))
{
    //   FlightSDKURL
//    guard let fullUrl = URL(string: urlString, relativeTo: NetworkService.baseURL.asURL()) else {
//        return completion(.failure(.network(type: .custom(errorCode: nil, errorDescription: "Wrong Url Provided"))))
//    }
    let fullUrl = NetworkService.baseURL + urlString
    
    print("URL")
    print("\(NetworkService.baseURL)\(urlString)")
    
    if let parameters = parameters {
        do {
            let checker = JSONSerialization.isValidJSONObject(parameters)
            if checker {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
                
                print("Post Data")
                print(data.prettyPrintedJSONString ?? "")
            } else {
                return completion(.failure(.network(type: .custom(errorCode: nil, errorDescription: "Can not parse parameters"))))
            }
        } catch let error {
            print(error)
            return completion(.failure(.network(type: .custom(errorCode: nil, errorDescription: "Can not parse parameters"))))
        }
    }
    
    
    var header: HTTPHeaders = [:]
//    header.add(name: "Device-Type", value: API_K.DEVICE_TYPE)
    if let currentToken = UserService.shared.access_token {
        header["Authorization"] = "Bearer \(currentToken)"
    }
    
    print(header)
    
    if Connectivity.isConnectedToInternet {
        
        AF.request( fullUrl, method: method, parameters: parameters , encoding: encoding, headers: header).responseData { responseData in
            
            print("Response")
            
            if let response = responseData.response, response.isResponseOK() {
                                
                switch responseData.result {
                case .success(let data):
                    
                    do {
                        let asJSON = try JSONSerialization.jsonObject(with: data)
                        print(data.prettyPrintedJSONString ?? "")
                        completion(.success(asJSON))
                        
                    } catch let error {
                        // Here, I like to keep a track of error if it occurs, and also print the response data if possible into String with UTF8 encoding
                        // I can't imagine the number of questions on SO where the error is because the API response simply not being a JSON and we end up asking for that "print", so be sure of it
                        print("Error while decoding response: \(error) from: \(String(data: data, encoding: .utf8))")
                        completion(.success([:]))
                       
                    }
                case .failure :
                    print(responseData.data?.converToString() ?? "")
                    completion(.failure(.network(type: .parsing)))
                }
                
            } else {
                
                print(responseData.data?.converToString() ?? "")
                print("Status Code \(responseData.response?.statusCode ?? 0)")
                completion(.failure(.network(type: .custom(errorCode: responseData.response?.statusCode, errorDescription: parse(errorCode: responseData.response?.statusCode)))))
                
            }
        }
    } else {
        completion(.failure(.network(type: .custom(errorCode: nil, errorDescription: "Internet connection not available!"))))
    }
}



func RequestWithCodableData<Parameters : Codable>(
    _ method: HTTPMethod,
    _ urlString: String,
    parameters: Parameters? = nil,
    headers: [String: String]? = nil,
    completion : @escaping((Result<Any,AppError>)->()))
   
{
    
//    guard let fullUrl = URL(string: urlString, relativeTo: NetworkService.baseURL) else {
//        return completion(.failure(.network(type: .custom(errorCode: nil, errorDescription: "Wrong Url Provided"))))
//    }
    let fullUrl = NetworkService.baseURL+"\\"+urlString
    
    print("URL")
    print("\(NetworkService.baseURL)\(urlString)")
    
    if let data = try? JSONEncoder().encode(parameters) {
        print("Post Data")
        print(data.prettyPrintedJSONString ?? "")
    }
    
    
    var header: HTTPHeaders = [:]
    
//    header.add(name: "Device-Type", value: API_K.DEVICE_TYPE)
    
    if headers == nil {
        
        if let currentToken = UserService.shared.access_token {
            header.add(name: "Authorization", value: "Bearer \(currentToken)")
        }
    } else {
        if let headers = headers {
            for (key, value) in headers {
                header[key] = value
                header.add(name: key, value: value)
                
            }
        }
    }
    
    print(header)
    
    if Connectivity.isConnectedToInternet {
        
        
        AF.request(fullUrl, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: header).responseData { responseData in
            print("Response")
            
            if let response = responseData.response, response.isResponseOK() {
                switch responseData.result {
                case .success( let data):
                    
                    
                    //  print(responseData.data?.prettyPrintedJSONString ?? "")
                    //  completion(.success(response))
                    
                    do {
                        let asJSON = try JSONSerialization.jsonObject(with: data)
                        print(data.prettyPrintedJSONString ?? "")
                        //                        if !urlString.contains("api/hotel/search/") {
                        //                            print(data.prettyPrintedJSONString ?? "")
                        //                        }
                        completion(.success(asJSON))
                        
                    } catch let error {
                        // Here, I like to keep a track of error if it occurs, and also print the response data if possible into String with UTF8 encoding
                        // I can't imagine the number of questions on SO where the error is because the API response simply not being a JSON and we end up asking for that "print", so be sure of it
                        print("Error while decoding response: \(error) from: \(String(data: data, encoding: .utf8))")
                        completion(.success([:]))
                        
                    }
                    
                case .failure :
                    print(responseData.data?.converToString() ?? "")
                    completion(.failure(.network(type: .parsing)))
                }
            } else {
                
                print(responseData.data?.converToString() ?? "")
                print("Status Code \(responseData.response?.statusCode)")
                completion(.failure(.network(type: .custom(errorCode: responseData.response?.statusCode, errorDescription: parse(errorCode: responseData.response?.statusCode)))))
            }
        }
    } else {
        completion(.failure(.network(type: .custom(errorCode: nil, errorDescription: "Internet connection not available!"))))
    }
    
}


extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
    
    func converToString() -> String{
        return String(decoding: self, as: UTF8.self)
    }
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


enum HTTPError: Error  {
    
    case httpError(message: String)
    
}

extension HTTPURLResponse {
     func isResponseOK() -> Bool {
      return (200...299).contains(self.statusCode)
     }
}

func parse(errorCode: Int?) -> String {

    switch errorCode {
    case 404:
        return "The server can not find the requested page."
    case 401:
        return "Current session has ended please login again."
    case 403:
        return "Access is forbidden to the requested page."
    case 405:
        return "The method specified in the request is not allowed."
    case 415:
        return "The server will not accept the request, because the media type is not supported."
    case 500:
        return "The request was not completed. The server met an unexpected condition."
    case 501:
        return "The request was not completed. The server did not support the functionality required."
    case 502:
        return "Bad gateway, Please check your internet connection."
    case 402:
        return "The request was not completed. The server received an invalid response from the upstream server."
    case 901:
        return "Timeout - Please check your internet connection"
    case 902:
        return "Unable to make a connection. Please check your internet"
    case 903:
        return "Connection shutdown. Please check your internet"
    case 904:
        return "Server is unreachable, please try again later."
    default:
        return "Something went wrong, Please try again."
    }
}

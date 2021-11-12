import Foundation
import SwiftyKeychainKit
import Alamofire

enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}

enum Results {
    case success
    case failure(Error)
}

class NetworkManager {
    // MARK: - Singleton
    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - Keychain storage / keys
    private let keychain = Keychain(service: "storage")
    private let accessToken = KeychainKey<String>(key: "accessToken")
    
    // MARK: - API parameters
    let authParams: Parameters = ["uuid": "hello"]
    
    public func saveAccessTokenData(_ data: String) {
        try? keychain.set(data, for: accessToken)
    }
    
    public func getAccessToken() -> String? {
        guard let accessToken = try? keychain.get(accessToken) else {
            return nil
        }
        return accessToken
    }
    
    // MARK: - AUTH request
    public func signInIntoAPI<U: Codable>(decodeType: U.Type, completion: @escaping (Result<U>) -> Void) {
        Alamofire.AF.request("https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin", method: .post, parameters: authParams).responseDecodable(of: U.self) { (response) in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: getSavedJogs request
    public func getSavedJogs<U:Codable>(decodeType: U.Type, completion: @escaping (Result<U>) -> Void) {
        guard let accessToken = getAccessToken() else {
            return
        }
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]
        AF.request("https://jogtracker.herokuapp.com/api/v1/data/sync", method: .get, headers: headers).responseDecodable(of: U.self) { (response) in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: addNewJog request
    public func addNewJog(_ jog: JogInternal, completion: @escaping (Results) -> Void) {
        guard let accessToken = getAccessToken() else {
            return
        }
        let jogParams: Parameters = ["date": jog.date,
                                     "time": jog.time,
                                     "distance": jog.distance]
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]
        AF.request("https://jogtracker.herokuapp.com/api/v1/data/jog", method: .post, parameters: jogParams, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: editSelectedJog request
    public func editSelectedJog(_ jog: JogExternal, completion: @escaping (Results) -> Void) {
        guard let accessToken = getAccessToken() else {
            return
        }
        let jogParams: Parameters = ["user_id": jog.userID,
                                     "jog_id": jog.id,
                                     "distance": jog.distance,
                                     "time": jog.time,
                                     "date": String(jog.date)]
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]
        AF.request("https://jogtracker.herokuapp.com/api/v1/data/jog", method: .put, parameters: jogParams, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

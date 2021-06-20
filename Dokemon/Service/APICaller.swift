//
//  APICaller.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    //MARK: - Get List of Games
    public func getPokemonList(completion: @escaping(Result<pokemon, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL), type: .GET) {
            baseRequest in
            print(baseRequest)
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data?.parseData(removeString: "null,"), error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(pokemon.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Private
    enum HTTPMethod: String{
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void){
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }

extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

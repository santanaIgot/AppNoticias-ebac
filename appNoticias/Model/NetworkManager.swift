//
//  NetworkManager.swift
//  appNoticias
//
//  Created by Igor Santana on 25/04/23.
//

import Foundation

enum ResultNewsError:Error{
    case badURL, noData, invalidJSON
}

class NetworkManager {
    
    //instanciando a própria classe
    static let shared  = NetworkManager()
    
    struct Constants {
        static let newsApi = URL(string: "http://127.0.0.1:8080/home")
    }
        
    private init(){}
    
    func getNews(completion: @escaping (Result <[ResultNews], ResultNewsError>) -> Void){
        //create a setup
        
        guard let url = Constants.newsApi else{
            completion(.failure(.badURL))
            return
        }
        
        //create  a configuration
        
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        
        //create a session
        let session = URLSession(configuration: configuration)
        //create a task
        
        let task = session.dataTask(with:url){ (data,response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 , let data = data else{
                completion(.failure(.invalidJSON))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(ResponseElement.self, from: data)
                completion(.success(result.home.results))
            }catch{
                print("Error info: \(error.localizedDescription) ")
                completion(.failure(.noData))
            }
        }
        task.resume()
    }

}

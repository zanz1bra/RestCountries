//
//  NetworkManager.swift
//  RestCountries
//
//  Created by erika.talberga on 15/11/2023.
//

import Foundation


class NetworkManager{
    static func fetchData(url:String,completion: @escaping ([CountryDetails]) -> ()){
        
        guard let url = URL(string:url) else {return}
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request){
            (data,response,error) in
            guard error == nil else{
                return
            }
            
            
            guard let data = data else {return}
            
            do{
                let json = try JSONDecoder().decode([CountryDetails].self, from:data)
                completion(json)
            }
            catch{
                return
            }
        }.resume()
        
        
    }
}

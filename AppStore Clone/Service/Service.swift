//
//  Service.swift
//  AppStore Clone
//
//  Created by Harleen Singh on 29/01/21.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String ,completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        guard let url = URL(string: urlString) else {return}
        // fetch data from internet
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([],err)
                return
            }
            

            guard let data = data else {return}
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
                
            } catch {
                print("Failed to decode json: ", error)
                completion([],error)
            }
            
            
            
        }.resume()
        
    }
    
}

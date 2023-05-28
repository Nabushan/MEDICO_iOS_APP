//
//  APICall.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import Foundation
import UIKit

class API {
    
    weak var delegate: APIDelegateProtocol?
    
    func printResults() {
        for i in 0..<(delegate?.medArticleData.count ?? 0) {
            print(delegate?.medArticleData[i].title! ?? "No entry in article")
        }
    }
    
    func getData(fromLink: String){
        
        guard let url = URL(string: fromLink) else {
            print("Url invalid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let data = data,error == nil else {
                print("Something went Wrong")
                return
            }
            
            print(data)
            
            var result: APIResult?
            do {
                result = try JSONDecoder().decode(APIResult.self, from: data)
            }
            catch {
                print("Failed to convert: \(error.localizedDescription)")
            }
            
            guard let json = result else {
                print("Data recieved empty.")
                return
            }
            
            print(json.status)
            print(json.totalResults)
            print(json.articles.count)
            
            for i in 0..<json.articles.count {
                self.delegate?.medArticleData.append(json.articles[i])
            }

            self.printResults()
            DispatchQueue.main.async {
                self.delegate?.medicalArticleCollectionView.reloadData()
            }
        })
        
        task.resume()
    }
}

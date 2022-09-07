//
//  APIService.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation

protocol APIServiceDelegate: AnyObject {
    func onVideoResponse(videos: [Video])
}

struct APIService {
    weak var delegate: APIServiceDelegate?
    
    func retrieveJSON(forUrl url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                                
                if let videos = try? decoder.decode([Video].self, from: data) {
                    DispatchQueue.main.async { delegate?.onVideoResponse(videos: videos) }
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
    }
}

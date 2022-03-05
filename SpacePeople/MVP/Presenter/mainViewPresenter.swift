//
//  mainViewPresenter.swift
//  SpacePeople
//
//  Created by Yegor Geronin on 04.03.2022.
//

import Foundation
import UIKit

protocol astronautsUI: AnyObject {
    func showAstronauts()
}

typealias mainViewDelegate = astronautsUI & UIViewController

class mainViewPresenter {
    weak var delegate: mainViewDelegate?
    
    private let spaceURL = "http://api.open-notify.org/astros.json"
    
    public var astronauts       = [[String]]()
    
    public func getAstronauts() {
        guard let url = URL(string: spaceURL) else {
            print("Invalid url!")
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _ , error in
            guard let dataUW = data, error == nil else {
                print("Specified: \(error?.localizedDescription ?? "No Des")")
                return
            }
            guard let spaceInfo = try? JSONDecoder().decode(apiResult.self, from: dataUW) else {
                print("Specified: \(error?.localizedDescription ?? "No Des")")
                return
            }
            self?.setAstronautModel(result: spaceInfo)
        }.resume()
    }
    
    private func setAstronautModel( result: apiResult )
    {
        guard let delegateUW = delegate else {
            print("Delegate isnt set!")
            return
        }
        let dict        = Dictionary(grouping: result.people, by: { $0.craft })
        for key in dict.keys {
            var stringArray = [key]
            stringArray += dict[key]!.map {
                $0.name
            }
            astronauts.append(stringArray)
        }
        astronauts.sort { str1, str2 in
            str1[0] > str2[0]
        }
        
        delegateUW.showAstronauts()
    }
    
    
}


// MARK: get right url
extension mainViewPresenter {
    private func convertUrlRequest( _ search: String) -> String {
        let newSearch = (search + " space").replacingOccurrences(of: " ", with: "%20")
        return "https://api.unsplash.com/search/photos?page=1&per_page=1&query=\(newSearch)&client_id=c0v9RxqF5pd1aN9U-mBA44JJvY9CMbhKg0dZprIWYVs"
    }
}


//MARK: load image
extension mainViewPresenter {
    public func loadImageURL(query: String, completion: @escaping (UIImage?) -> Void) {
        let link = convertUrlRequest(query)
        guard let url = URL(string: link) else {
            print("Invalid url!")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _ , error in
            guard let dataUW = data, error == nil else {
                print("Specified data: \(error?.localizedDescription ?? "No Des")")
                completion(nil)
                return
            }
            guard let imageURL = try? JSONDecoder().decode(searchImages.self, from: dataUW).results[0].urls.small else {
                print("Specified: \(error?.localizedDescription ?? "No Des")")
                completion(nil)
                return
            }
            self?.loadImage(link: imageURL, completion: { image in
                completion(image)
            })
        }.resume()
    }
    
    private func loadImage(link: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: link) else {
            print("Invalid url!")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let dataUW = data, error == nil else {
                print("Specified data: \(error?.localizedDescription ?? "No Des")")
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(UIImage(data: dataUW))
            }
            
        }.resume()
    }
}

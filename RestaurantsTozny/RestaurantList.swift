//
//  ViewController.swift
//  RestaurantsTozny
//
//  Created by Joshua  Rambert on 10/26/18.
//  Copyright © 2018 Joshua Rambert. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class RestaurantList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //MARK Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiRequest()
    }
    
    

    //MARK TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantNames.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCells", for: indexPath) as! RestaurantCells
        
        //A little clutterd but just wanted to get a finished example out
        cell.getRestaurantInfo(name: self.restaurantNames[indexPath.row], rating: String(self.restaurantRating[indexPath.row]))
        
        return cell
    }
    
    
    //MARK Api - Pull
    func apiRequest(){
        
        var headers: HTTPHeaders = HTTPHeaders()
        
        headers = ["Authorization":"Bearer \(API_KEY)"]
        
        let queryParams = ["location":"97204", "Categories":"Food"]
        
        Alamofire.request(JSON_API, method: .get, parameters: queryParams, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: {(response) in
            
            print(response)
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments){
                
                if let bussinesArray = (jsonObj as AnyObject).value(forKey: "businesses") as? NSArray {
                    
                    for info in bussinesArray {
                        
                        if let infoDict = info as? NSDictionary {
                            
                            if let restName = infoDict.value(forKey: "name") {
                                
                                //Add them to the array
                                self.restaurantNames.append(restName as? String ?? "")
                        
                            }
                            
                            if let restRating = infoDict.value(forKey: "rating") {
                                
                                //Add those to the other array as well
                                self.restaurantRating.append(restRating as? Double ?? 0)
                                
                                print("TESTING \(self.restaurantNames.last ?? "")")
                                
                                DispatchQueue.main.async {
                                    self.restaurantList.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    
    //MARK Properties
    public var restaurantNames = [String]()
    public var restaurantRating = [Double]()
    private let JSON_API = "https://api.yelp.com/v3/businesses/search"
    private let API_KEY = "WHCF0Botwp6daOHxpAv7PMp4Gpg7FOjAnaA8XBosTEhrDGwsQO9b9CEnZTr2y1oQU-vrhsyfNwplksbXcLDP3gLl361RrWLi1L1w7CwfvyqjJTSjBKo7qVhAR0zTW3Yx"
    @IBOutlet private weak var restaurantList: UITableView!
}


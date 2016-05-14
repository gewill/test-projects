//
//  ViewController.swift
//  test url colon parameters
//
//  Created by Will on 5/5/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        userAFNetworking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    // main.swift
    // test url colon parameters
    //
    // Created by Will on 5/5/16.
    // Copyright © 2016 gewill.org. All rights reserved.
    //

    func useNSURL() {
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "00eed842-1dcc-09f5-eca1-58c615cbb9d4"
        ]

        var request = NSMutableURLRequest(URL: NSURL(string: "http://staging.danhuang.tv/api/v1/users/1")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? NSHTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }

    func userAlamofire() {
        Alamofire.request(.GET, "http://staging.danhuang.tv/api/v1/users/:id/products", parameters: ["id": 41, "page": 1])
            .responseJSON { response in
                print(response.request) // original URL request
                print(response.response) // URL response
                print(response.data) // server data
                print(response.result) // result of response serialization

                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    func userAFNetworking() {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.GET("http://staging.danhuang.tv/api/v1/users/:id/products", parameters: ["id": 41, "page": 1], success: { (task, _) in
            print(task)
            }) { (_, error) in
                print(error.localizedDescription)
        }
    }

}


//
//  URLDownloader.swift
//  URLSession
//
//  Created by Dimasno1 on 4/19/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

class URLDownloader: NSObject{
   
    var session: URLSession?
    let formatter = NumberFormatter()
    var url: URL?
    init(with URL: URL) {
        self.url = URL
    }
    
    func download(delegate: URLSessionDelegate? = nil){
        guard let url = self.url else{ return }
        session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        let task = session?.downloadTask(with: url)
        task?.resume()
    }
 
}

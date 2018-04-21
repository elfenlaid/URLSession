//
//  ViewController.swift
//  URLSession
//
//  Created by Dimasno1 on 4/19/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

let url = URL(string: "https://cs9-16v4.vkuseraudio.net/p20/1685a0e6d49bfd.mp3?extra=tpoxexMkTaCpCGfZ2524uIdyIeV5TF-PyDYuXw5BmCXYULZNuXSxVVmI-uIoG_ROnm4ViLakkd2Vio4aFVFuxBkB5yJ99x9EYJel9IwnI6lDMu-Qw7HaPOGlaTJHkYD9AWR7dIlFIAg7")!

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate{
    
    var downloader = URLDownloader(with: url)
    var progress = Progress(totalUnitCount: 0)
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.addTarget(self, action: #selector(download), for: .touchUpInside)
        return button
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .lightGray
        progressView.observedProgress = self.progress
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(progressBar)
        view.addSubview(button)

        progressBar.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 75)
        button.frame = CGRect(x: 50, y: 400, width: 100, height: 50)
    }
    
    @objc func download(){
        downloader.download(delegate: self)
    }
    
    //MARK:URLSession delegate conforming
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        progress.completedUnitCount = 0
        progress.totalUnitCount = 0
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if progress.totalUnitCount == 0 {
            progress.totalUnitCount = totalBytesExpectedToWrite
        }

        progress.completedUnitCount = progress.completedUnitCount + bytesWritten
    }
}


//
//  ViewController.swift
//  URLSession
//
//  Created by Dimasno1 on 4/19/18.
//  Copyright © 2018 Dimasno1. All rights reserved.
//

import UIKit

let url = URL(string: "https://cs9-16v4.vkuseraudio.net/p20/1685a0e6d49bfd.mp3?extra=tpoxexMkTaCpCGfZ2524uIdyIeV5TF-PyDYuXw5BmCXYULZNuXSxVVmI-uIoG_ROnm4ViLakkd2Vio4aFVFuxBkB5yJ99x9EYJel9IwnI6lDMu-Qw7HaPOGlaTJHkYD9AWR7dIlFIAg7")

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate{
    
    var downloader: URLDownloader?
    var progress: Progress?
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 400, width: 100, height: 50))
        button.setTitleColor(.black, for: .normal)
        button.setTitle("download", for: .normal)
        
        button.addTarget(self, action: #selector(download), for: .touchUpInside)
        return button
    }()
    
    let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 75)
        progressView.trackTintColor = .red
        progressView.progress = 0
        progressView.progressTintColor = .gray
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloader = URLDownloader(with: url!)
        self.view.addSubview(progressBar)
        self.view.addSubview(button)
    }
    
    @objc func download(){
        downloader?.download()
    }
    
    //MARK:URLSession delegate conforming
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        downloadTask.cancel()
        session.finishTasksAndInvalidate()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        progress = Progress(totalUnitCount: totalBytesExpectedToWrite)
        if progress != nil{
            progress!.completedUnitCount = totalBytesWritten
            print(progress!)
            DispatchQueue.main.async { //Не обновляется прогресс =(
                self.progressBar.observedProgress = self.progress!
            }
        }
    }
    
    
}


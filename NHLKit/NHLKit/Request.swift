//
//  Request.swift
//
//
//  Created by Eric Ito on 10/2/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation
import UIKit

enum DataType {
    case Raw
    case Image
    case JSON
}

let RequestBoundary = "zzyzyx"

public class Request: NSObject, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLSessionDelegate {
    
    private var session: NSURLSession?
    private var expectedContentLength: Int64 = 0
    private var responseData: NSMutableData!
    var task: NSURLSessionTask?
    
    private (set) public var URL: NSURL
    
    public var downloadProgress: ((progress: Float) ->Void)?
    public var uploadProgress: ((progress: Float) ->Void)?
    public var completion: ((result: AnyObject?, error: NSError?) -> Void)?
    
    var dataType: DataType {
        return .Raw
    }
    
    public init(URL u: NSURL) {
        URL = u
        responseData = NSMutableData()
        super.init()
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
    }
    
    public func cancel() {
        task?.cancel()
        session?.invalidateAndCancel()
        finish()
    }
    
    private func finish() {
        NetworkActivity.stop()
    }
    
    public func start() {
        NetworkActivity.start()
        task = session?.dataTaskWithURL(URL)
        task?.resume()
    }
    
    func processResponseData() -> AnyObject? {
        return responseData
    }
    
    // MARK: NSURLSessionDelegate
    
    public func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        completion?(result: nil, error: error)
        cancel()
    }
    
    // MARK: NSURLSessionDataDelegate
    
    public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        responseData.appendData(data)
        if expectedContentLength > 0 {
            downloadProgress?(progress: (Float(responseData.length) / Float(expectedContentLength)) * Float(100.0))
        }
    }
    
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        if totalBytesExpectedToSend > 0 {
            uploadProgress?(progress: (Float(totalBytesSent) / Float(totalBytesExpectedToSend)) * Float(100.0))
        }
    }
    
    public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        expectedContentLength = response.expectedContentLength
        completionHandler(.Allow)
    }
    
    // MARK: NSURLSessionTaskDelegate
    
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        var result: AnyObject? = nil
        var processError: NSError? = nil
        
        if let error = error {
            processError = error
        } else {
            result = processResponseData()
            if let e = result as? NSError {
                processError = result as? NSError
                result = nil
            }
        }
        completion?(result: result, error: processError)
        finish()
    }
    
}

public class UploadRequest: Request {
    
    private var uploadURL: NSURL?
//    private let file: NSURL?
    private let image: UIImage
    private let fileName: String
    private let queryParams: [String:String]?
    
    init(URL: NSURL, fileName aFileName: String, image uploadImage: UIImage, queryParams qp: [String:String]?) {
        fileName = aFileName
        queryParams = qp
        image = uploadImage
        super.init(URL: URL)
    }

    override public func start() {
        NetworkActivity.start()
        
        let urlRequest = NSURLRequest(URL: URL)
        let mutReq = NSMutableURLRequest(URL: URL)
        mutReq.HTTPMethod = "POST"
        mutReq.setValue("multipart/form-data; boundary=\(RequestBoundary)", forHTTPHeaderField: "Content-Type")
        let d = requestData()
        mutReq.setValue("\(d.length)", forHTTPHeaderField: "Content-Length")
        task = session?.uploadTaskWithRequest(mutReq, fromData: d)
        task?.resume()
    }
    
    func requestData() -> NSData {
        var postBody = NSMutableData()
        
        let boundaryData = ("--\(RequestBoundary)\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        postBody.appendData(boundaryData!)
        
        let contentDispositionData = ("Content-Disposition: form-data; name=\"image_file\"; filename=\"carname.jpg\"\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        postBody.appendData(contentDispositionData!)
        
        let contentTypeData = ("Content-Type: image/jpeg\r\n\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        postBody.appendData(contentTypeData!)
        postBody.appendData(UIImageJPEGRepresentation(image, 0.75))
        postBody.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        if let queryParams = queryParams {
            for s in queryParams.keys {
                postBody.appendData(boundaryData!)
                let paramData = ("Content-Disposition: form-data; name=\"\(s)\"\r\n\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
                postBody.appendData(paramData!)
                if let value = queryParams[s] {
                    postBody.appendData(value.dataUsingEncoding(NSUTF8StringEncoding)!)
                }
                postBody.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            }
        }
        
        postBody.appendData("--\(RequestBoundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        return postBody
    }
}

public class ImageRequest: Request {
    
    override var dataType: DataType {
        return .Image
    }
    
    override func processResponseData() -> AnyObject? {
        // TODO: Need this?
        return UIImage(data: responseData)/*, scale: UIScreen.mainScreen().scale*/
    }
}

public class JSONRequest: Request {
    
    override var dataType: DataType {
        return .JSON
    }
    
    override func processResponseData() -> AnyObject? {
        var error: NSError? = nil
        if let result: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments, error: &error) {
            return result
        } else {
            return error
        }
    }
}
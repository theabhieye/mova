//
//  Webservice.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//
// src :-   "https://gist.github.com/chaitanyaSoni96/b1b9e77bf1565e3b1411bc90156e66ab"

import Foundation

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

public class Webservice {
	static let shared = Webservice()
	public func sendRequest<T: Decodable>(for: T.Type = T.self,
										  url: String,
										  method: RequestMethod,
										  headers: HTTPHeaders? = nil,
										  body: JSON? = nil,
										  completion: @escaping (Result<T>) -> Void) {
		
		return sendRequest(url: url, method: method, headers: headers, body:body, completion: completion) { decoder, data in try decoder.decode(T.self, from: data) }
	}
	
	public func sendRequest<T: Decodable>(for: [T].Type = [T].self,
										  url: String,
										  method: RequestMethod,
										  headers: HTTPHeaders? = nil,
										  body: JSON? = nil,
										  completion: @escaping (Result<[T]>) -> Void) {
		
		return sendRequest(url: url, method: method, headers: headers, body:body, completion: completion) { decoder, data in try decoder.decode([T].self, from: data) }
	}
	
	private func sendRequest(_ url: String,
							 method: RequestMethod,
							 headers: HTTPHeaders? = nil,
							 body: JSON? = nil,
							 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
		let url = URL(string: url)!
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = method.rawValue
		
		if let headers = headers {
			urlRequest.allHTTPHeaderFields = headers
			urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		}
		
		if let body = body {
			urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
		}
		
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: urlRequest) { data, response, error in
			completionHandler(data, response, error)
		}
		
		task.resume()
	}
	
	private func sendRequest<T>(url: String,
								method: RequestMethod,
								headers: HTTPHeaders? = nil,
								body: JSON? = nil,
								completion: @escaping (Result<T>) -> Void,
								decodingWith decode: @escaping (JSONDecoder, Data) throws -> T) {
		return sendRequest(url, method: method, headers: headers, body:body) { data, response, error in
			guard let data = data else {
				return completion(.failure((error ?? NSError(domain: "SomeDomain", code: -1, userInfo: nil)) as NSError))
			}
			do {
				let decoder = JSONDecoder()
				// asking the custom decoding block to do the work
				try completion(.success(decode(decoder, data)))
			} catch let decodingError {
				completion(.failure(decodingError as NSError))
			}
		}
	}
	
	
}

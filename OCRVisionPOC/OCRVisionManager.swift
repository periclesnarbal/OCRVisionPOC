//
//  OCRVisionManager.swift
//  OCRVisionPOC
//
//  Created by Péricles Narbal on 06/04/24.
//

import Foundation
import Vision

public class OCRVisionManager {
    typealias Closure<T> = ((T) -> Void)
    
    static func extractTextFromImageBy(url: String, completion: @escaping Closure<String>) {
        extractTextFromImageBy(url: url) { (recognizedArray: [String]) in
            let recognizedText = recognizedArray.reduce(""){ $0 + " " + $1 }
            completion(recognizedText)
        }
    }
    
    static private func extractTextFromImageBy(url: String, completion: @escaping Closure<[String]>) {
        guard let url = URL(string: url) else { return }
        let request = createRecognizeTextRequest(completion: completion)
        let handler = VNImageRequestHandler(url: url)
        
        request.recognitionLevel = .accurate
        performRecognizeRequest(handler: handler, request: request)
    }
    
    static private func performRecognizeRequest(handler: VNImageRequestHandler, request: VNRecognizeTextRequest) {
        do {
            try handler.perform([request])
        } catch {
            print("extractTextFromImageBy(url: String, completion: Closure<[String]>) - Não foi possivel executar a requisição")
        }
    }
    
    static private func createRecognizeTextRequest(completion: @escaping Closure<[String]>) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest(completionHandler: { request, error in

            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                return
            }
            
            let recognizedArray = observations.compactMap {$0.topCandidates(1).first?.string}
            
            completion(recognizedArray)
        })

        return request
    }
}

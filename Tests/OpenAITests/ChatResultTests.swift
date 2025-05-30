//
//  ChatResultTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import XCTest
@testable import OpenAI

final class ChatResultTests: XCTestCase {
    func testDecodeFailsForMissingId() {
        let jsonString = """
            {
                "object": "chat.completion",
                "model": "gpt-4"
            }
            """
        
        let decoder = JSONDecoder()
        // no relaxing options
        do {
            _ = try decoder.decode(ChatResult.self, from: jsonString.data(using: .utf8)!)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key as! ChatResult.CodingKeys, ChatResult.CodingKeys.id)
            default:
                XCTFail("Unexpected error")
            }
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testDecodeMissingIdSucceedsWithRelaxedOptions() throws {
        // mock json with missing id
        let jsonString = """
            {
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "system_fingerprint": null
            }
            """
        
        let decoder = JSONDecoder()
        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let chatResult = try decoder.decode(ChatResult.self, from: jsonString.data(using: .utf8)!)
        XCTAssertEqual(chatResult.id, "")
    }
    
    func testThrowsErrorIfOptionsNotSufficient() throws {
        let jsonString = """
            {
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": []
            }
            """
        
        let decoder = JSONDecoder()
        decoder.userInfo = [.parsingOptions: ParsingOptions.fillRequiredFieldIfValueNotFound]
        do {
            _ = try decoder.decode(ChatResult.self, from: jsonString.data(using: .utf8)!)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key as! ChatResult.CodingKeys, ChatResult.CodingKeys.id)
            default:
                XCTFail("Unexpected error")
            }
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testParseNullSystemFingerprintWithDefaultParsingOptions() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "system_fingerprint": null
            }
            """
        
        let jsonDict = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!) as! [String: Any]
        
        XCTAssertEqual(jsonDict["model"] as! String, "gpt-4", "Invalid json mock")
        XCTAssertTrue(jsonDict["system_fingerprint"] is NSNull, "The field is expected to be missing or null")
        let jsonData = jsonString.data(using: .utf8)!
        let chatResult = try JSONDecoder().decode(ChatResult.self, from: jsonData)
        XCTAssertEqual(chatResult.model, "gpt-4")
        XCTAssertEqual(chatResult.systemFingerprint, nil)
    }
}

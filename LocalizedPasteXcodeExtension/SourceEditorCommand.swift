//
//  SourceEditorCommand.swift
//  LocalizedPasteXcodeExtension
//
//  Created by 劉柏賢 on 2018/5/3.
//  Copyright © 2018年 劉柏賢. All rights reserved.
//

import Foundation
import XcodeKit
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        defer {
            // Signal to Xcode that the command has completed.
            completionHandler(nil)
        }
        
        let input: String? = getInputString()
        let result: String? = getResult(for: input, with: invocation)
        let cursorIndex: Int? = getInsertPosition(for: result, with: invocation)
        
        insert(string: result, with: invocation, at: cursorIndex)
    }
}


// MARK: - Private method
extension SourceEditorCommand {
    
    private func getInputString() -> String? {
        let paste = NSPasteboard.general
        guard let translation: String = paste.string(forType: NSPasteboard.PasteboardType.string) else {
            return nil
        }
        
        print(translation)
        
        return translation
    }
    
    private func getResult(for input: String?, with invocation: XCSourceEditorCommandInvocation) -> String? {
        
        guard let bundleID: String = Bundle.main.bundleIdentifier else {
            return nil
        }
        
        let sourceID: String = invocation.commandIdentifier.replacingOccurrences(of: "\(bundleID).", with: "")
        
        return Utilities.getLocalized(input: input, source: SourceCommand(rawValue: sourceID))
    }
    
    private func getInsertPosition(for result: String?, with invocation: XCSourceEditorCommandInvocation) -> Int? {
        guard let selections: [XCSourceTextRange] = invocation.buffer.selections as? [XCSourceTextRange],
            let cursorIndex: Int = selections.last?.start.line,
            (0..<invocation.buffer.lines.count) ~= cursorIndex else {
                
                return nil
        }
        
        return cursorIndex
    }
    
    private func insert(string result: String?, with invocation: XCSourceEditorCommandInvocation, at cursorIndex: Int?) {
        
        guard let result: String = result else {
            return
        }
        
        guard let cursorIndex: Int = cursorIndex else {
            return
        }
        
        let lines = invocation.buffer.lines
        lines.insert([result], at: [cursorIndex])
        
    }
}



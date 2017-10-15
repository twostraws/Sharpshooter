//
//  SourceEditorCommand.swift
//  Extension
//
//  Created by Paul Hudson on 15/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        defer { completionHandler(nil) }

        if invocation.commandIdentifier.hasSuffix("Add") {
            addComments(with: invocation)
        } else if invocation.commandIdentifier.hasSuffix("Remove") {
            removeComments(with: invocation)
        }
    }

    /**
     Adds comments to the current file.
    */
    func addComments(with invocation: XCSourceEditorCommandInvocation) {
        // we need to indent our print() statement one level deeper than the function
        let extraIndent: String

        if invocation.buffer.usesTabsForIndentation {
            // indent with an extra tab
            extraIndent = "\t"
        } else {
            // indent with as many spaces as needed
            extraIndent = String(repeatElement(" ", count: invocation.buffer.indentationWidth))
        }

        // REGEX: Any spaces or tabs, then some text (e.g. "static private"), then "func ", then the function name, then params, then a line break
        guard let regex = try? NSRegularExpression(pattern: "([ \\t]*)(.*func )([^(]+)(.*?\n)", options: .caseInsensitive) else { return }

        // REPLACEMENT: Print the original function line, then an extra indent, then our print() line for this function
        invocation.buffer.completeBuffer = regex.stringByReplacingMatches(in: invocation.buffer.completeBuffer, options: [], range: NSRange(location: 0, length: invocation.buffer.completeBuffer.utf16.count), withTemplate: "$1$2$3$4$1\(extraIndent)print(\"# Sharpshooter: Entering $3()\")\n")
    }

    /**
     Removes comments from the current file.
     */
    func removeComments(with invocation: XCSourceEditorCommandInvocation) {
        // REGEX: Any text followed by our unique marker, then any other text
        guard let regex = try? NSRegularExpression(pattern: "(.*# Sharpshooter: Entering.*\n)", options: .caseInsensitive) else { return }

        // REPLACEMENT: Empty string
        invocation.buffer.completeBuffer = regex.stringByReplacingMatches(in: invocation.buffer.completeBuffer, options: [], range: NSRange(location: 0, length: invocation.buffer.completeBuffer.utf16.count), withTemplate: "")
    }
}

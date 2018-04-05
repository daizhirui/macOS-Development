//===--- MarkdownTests.swift ----------------------------------------------------===//
//
//Copyright (c) 2015-2016 Daniel Leping (dileping)
//
//This file is part of Markdown.
//
//Swift Express is free software: you can redistribute it and/or modify
//it under the terms of the GNU Lesser General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//Swift Express is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU Lesser General Public License for more details.
//
//You should have received a copy of the GNU Lesser General Public License
//along with Swift Express.  If not, see <http://www.gnu.org/licenses/>.
//
//===----------------------------------------------------------------------===//

import XCTest
import Foundation

@testable import Markdown

#if !os(Linux) || dispatch
import Dispatch
#endif

class MarkdownTests: XCTestCase {
    
    func testHeader() {
        do {
            let md = try Markdown(string:"% test\n% daniel\n% 02.03.2016\n")
            
            let title = md.title
            XCTAssertNotNil(title)
            XCTAssertEqual(title!, "test")
            
            let author = md.author
            XCTAssertNotNil(author)
            XCTAssertEqual(author!, "daniel")
            
            let date = md.date
            XCTAssertNotNil(date)
            XCTAssertEqual(date!, "02.03.2016")
        } catch {
            XCTFail("Exception caught")
        }
    }
    
    func testBody() {
        do {
            let md = try Markdown(string:"# test header")
            let document = try md.document()
            XCTAssertEqual(document, "<h1>test header</h1>")
        } catch {
            XCTFail("Exception caught")
        }
    }
    
    func testTableOfContents() {
        do {
            let md = try Markdown(string:"# test header", options: .TableOfContents)
            let document = try md.document()
            XCTAssertEqual(document, "<a name=\"test.header\"></a>\n<h1>test header</h1>")
            let toc = try md.tableOfContents()
            XCTAssertEqual(toc, "<ul>\n <li><a href=\"#test.header\">test header</a></li>\n</ul>\n")
        } catch {
            XCTFail("Exception caught")
        }
    }
    
    func testStyle() {
        do {
            let md = try Markdown(string:"<style>background-color: yellow;</style>\n# test header")
            let document = try md.document()
            XCTAssertEqual(document, "\n\n<h1>test header</h1>")
            let css = try md.css()
            XCTAssertEqual(css, "<style>background-color: yellow;</style>\n")
        } catch {
            XCTFail("Exception caught")
        }
    }
    
    #if !os(Linux) || dispatch
    // no dispatch
    func testStress() {
        let id = UUID().uuidString
        let queue = DispatchQueue(label: id, attributes: .concurrent)
        
        for i in 0...10000 {
            let expectation = self.expectation(description: "OK " + String(i))
            queue.async {
                do {
                    let markdown = try Markdown(string: "# test line " + String(i), options: .None)
                    let html = try markdown.document()
                    
                    XCTAssertEqual(html, "<h1>test line " + String(i) + "</h1>")
                    expectation.fulfill()
                } catch {
                    XCTFail("Exception caught")
                }
            }
        }
        
        self.waitForExpectations(timeout: 60, handler: nil)
    }
    
    #endif
    
}

#if os(Linux)
extension MarkdownTests {
	static var allTests : [(String, (MarkdownTests) -> () throws -> Void)] {
        var tests:[(String, (MarkdownTests) -> () throws -> Void)] = [
			("testHeader", testHeader),
			("testBody", testBody),
			("testTableOfContents", testTableOfContents),
			("testStyle", testStyle),
		]
        
        #if dispatch
            tests.append(("testStress", testStress))
        #endif
        
        return tests
	}
}
#endif

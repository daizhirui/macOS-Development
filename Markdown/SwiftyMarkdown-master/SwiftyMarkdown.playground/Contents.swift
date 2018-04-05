//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 400.0, height: 600))

PlaygroundPage.current.liveView = containerView
let label = UITextView(frame: containerView.frame)
containerView.addSubview(label)

var foundCharacters : String = ""
var matchedCharacters : String = "\\Some string ''\\"
if let hasRange = matchedCharacters.range(of: "\\") {
	
	let newRange  = hasRange.lowerBound..<hasRange.upperBound
	foundCharacters = foundCharacters + matchedCharacters[newRange]
	
	matchedCharacters.removeSubrange(newRange)
}
//
//public protocol FontProperties {
//	var fontName : String { get set }
//	var color : UIColor { get set }
//}
//
//
//public struct BasicStyles : FontProperties {
//	public var fontName = UIFont.preferredFontForTextStyle(UIFontTextStyleBody).fontName
//	public var color = UIColor.blackColor()
//}
//
//enum LineType : Int {
//	case H1, H2, H3, H4, H5, H6, Body, Italic, Bold, Code
//}
//
//
//public class SwiftyMarkdown {
//	
//	public var h1 = BasicStyles()
//	public var h2 = BasicStyles()
//	public var h3 = BasicStyles()
//	public var h4 = BasicStyles()
//	public var h5 = BasicStyles()
//	public var h6 = BasicStyles()
//	
//	public var body = BasicStyles()
//	public var link = BasicStyles()
//	public var italic = BasicStyles()
//	public var code = BasicStyles()
//	public var bold = BasicStyles()
//	
//	let string : String
//	let instructionSet = NSCharacterSet(charactersInString: "\\*_`")
//	
//	public init(string : String ) {
//		self.string = string
//	}
//	
//	public init?(url : NSURL ) {
//		
//		do {
//			self.string = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding) as String
//			
//		} catch {
//			self.string = ""
//			fatalError("Couldn't read string")
//			return nil
//		}
//	}
//	
//	public func attributedString() -> NSAttributedString {
//		let attributedString = NSMutableAttributedString(string: "")
//		
//		let lines = self.string.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
//		
//		var lineCount = 0
//		
//		let headings = ["# ", "## ", "### ", "#### ", "##### ", "###### "]
//		
//		
//		var skipLine = false
//		for line in lines {
//			lineCount++
//			if skipLine {
//				skipLine = false
//				continue
//			}
//			var headingFound = false
//			for heading in headings {
//				
//				if let range =  line.rangeOfString(heading) where range.startIndex == line.startIndex {
//					
//					let startHeadingString = line.stringByReplacingCharactersInRange(range, withString: "")
//					let endHeadingHash = " " + heading.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//					
//					let finalHeadingString = startHeadingString.stringByReplacingOccurrencesOfString(endHeadingHash, withString: "")
//					
//					// Make Hx where x == current index
//					let string = attributedStringFromString(finalHeadingString, withType: LineType(rawValue: headings.indexOf(heading)!)!)
//					attributedString.appendAttributedString(string)
//					headingFound = true
//				}
//			}
//			if headingFound {
//				continue
//			}
//			
//			
//			if lineCount  < lines.count {
//				let nextLine = lines[lineCount]
//				
//				if let range = nextLine.rangeOfString("=") where range.startIndex == nextLine.startIndex {
//					// Make H1
//					let string = attributedStringFromString(line, withType: .H1)
//					attributedString.appendAttributedString(string)
//					skipLine = true
//					continue
//				}
//				
//				if let range = nextLine.rangeOfString("-") where range.startIndex == nextLine.startIndex {
//					
//					
//					// Make H1
//					let string = attributedStringFromString(line, withType: .H2)
//					attributedString.appendAttributedString(string)
//					skipLine = true
//					continue
//				}
//			}
//			
//			if line.characters.count > 0 {
//				
//				let scanner = NSScanner(string: line)
//				
//				
//				scanner.charactersToBeSkipped = nil
//
//				while !scanner.atEnd {
//					
//					var followingString : NSString?
//					var string : NSString?
//					// Get all the characters up to the ones we are interested in
//					if scanner.scanUpToCharactersFromSet(instructionSet, intoString: &string) {
//						if let hasString = string as? String {
//							let bodyString = attributedStringFromString(hasString, withType: .Body)
//							attributedString.appendAttributedString(bodyString)
//
//							var matchedCharacters = self.tagFromScanner(scanner)
//							
//							
//							let location = scanner.scanLocation
//							// If the next string after the characters is a space, then add it to the final string and continue
//							if !scanner.scanUpToString(" ", intoString: nil) {
//								
//								let charAtts = attributedStringFromString(matchedCharacters, withType: .Body)
//								
//								attributedString.appendAttributedString(charAtts)
//							} else {
//								scanner.scanLocation = location
//								scanner.scanUpToCharactersFromSet(instructionSet, intoString: &followingString)
//								if let hasString = followingString as? String {
//									let attString : NSAttributedString
//									
//									if matchedCharacters.containsString("\\") {
//										attString = attributedStringFromString(matchedCharacters + hasString, withType: .Body)
//									} else if matchedCharacters == "**" || matchedCharacters == "__" {
//										attString = attributedStringFromString(hasString, withType: .Bold)
//									} else {
//										attString = attributedStringFromString(hasString, withType: .Italic)
//									}
//									attributedString.appendAttributedString(attString)
//								}
//								matchedCharacters = self.tagFromScanner(scanner)
//								
//								if matchedCharacters.containsString("\\") {
//									let attString = attributedStringFromString(matchedCharacters, withType: .Body)
//									
//									attributedString.appendAttributedString(attString)
//								}
//								
//							}
//						}
//					} else {
//						var matchedCharacters = self.tagFromScanner(scanner)
//
//						scanner.scanUpToCharactersFromSet(instructionSet, intoString: &followingString)
//						if let hasString = followingString as? String {
//							let attString : NSAttributedString
//							
//							if matchedCharacters.containsString("\\") {
//								attString = attributedStringFromString(matchedCharacters + hasString, withType: .Body)
//							} else if matchedCharacters == "**" || matchedCharacters == "__" {
//								attString = attributedStringFromString(hasString, withType: .Bold)
//							} else {
//								attString = attributedStringFromString(hasString, withType: .Italic)
//							}
//							attributedString.appendAttributedString(attString)
//						}
//						matchedCharacters = self.tagFromScanner(scanner)
//						
//						if matchedCharacters.containsString("\\") {
//							let attString = attributedStringFromString(matchedCharacters, withType: .Body)
//							
//							attributedString.appendAttributedString(attString)
//						}
//						
//					}
//				}
//			}
//			attributedString.appendAttributedString(NSAttributedString(string: "\n"))
//		}
//		
//		return attributedString
//	}
//	
//	func tagFromScanner( scanner : NSScanner ) -> String {
//		var matchedCharacters : String = ""
//		var tempCharacters : NSString?
//		
//		// Scan the ones we are interested in
//		while scanner.scanCharactersFromSet(instructionSet, intoString: &tempCharacters) {
//			if let chars = tempCharacters as? String {
//				matchedCharacters = matchedCharacters + chars
//			}
//		}
//		return matchedCharacters
//	}
//	
//	
//	// Make H1
//	
//	func attributedStringFromString(string : String, withType type : LineType ) -> NSAttributedString {
//		var attributes : [String : AnyObject]
//		let textStyle : String
//		let fontName : String
//		
//		var appendNewLine = true
//		
//		switch type {
//		case .H1:
//			fontName = h1.fontName
//			
//			if #available(iOS 9, *) {
//				textStyle = UIFontTextStyleTitle1
//			}
//			attributes = [NSForegroundColorAttributeName : h1.color]
//		case .H2:
//			fontName = h2.fontName
//			textStyle = UIFontTextStyleTitle2
//			attributes = [NSForegroundColorAttributeName : h2.color]
//		case .H3:
//			fontName = h3.fontName
//			textStyle = UIFontTextStyleTitle3
//			attributes = [NSForegroundColorAttributeName : h3.color]
//		case .H4:
//			fontName = h4.fontName
//			textStyle = UIFontTextStyleHeadline
//			attributes = [NSForegroundColorAttributeName : h4.color]
//		case .H5:
//			fontName = h5.fontName
//			textStyle = UIFontTextStyleSubheadline
//			attributes = [NSForegroundColorAttributeName : h5.color]
//		case .H6:
//			fontName = h6.fontName
//			textStyle = UIFontTextStyleFootnote
//			attributes = [NSForegroundColorAttributeName : h6.color]
//		case .Italic:
//			fontName = italic.fontName
//			attributes = [NSForegroundColorAttributeName : italic.color]
//			textStyle = UIFontTextStyleBody
//			appendNewLine = false
//		case .Bold:
//			fontName = bold.fontName
//			attributes = [NSForegroundColorAttributeName : bold.color]
//			appendNewLine = false
//			textStyle = UIFontTextStyleBody
//		default:
//			appendNewLine = false
//			fontName = body.fontName
//			textStyle = UIFontTextStyleBody
//			attributes = [NSForegroundColorAttributeName:body.color]
//			break
//		}
//		
//		let font = UIFont.preferredFontForTextStyle(textStyle)
//		let styleDescriptor = font.fontDescriptor()
//		let styleSize = styleDescriptor.fontAttributes()[UIFontDescriptorSizeAttribute] as? CGFloat ?? CGFloat(14)
//		
//		var finalFont : UIFont
//		if let font = UIFont(name: fontName, size: styleSize) {
//			finalFont = font
//		} else {
//			finalFont = UIFont.preferredFontForTextStyle(textStyle)
//		}
//		
//		let finalFontDescriptor = finalFont.fontDescriptor()
//		if type == .Italic {
//			let italicDescriptor = finalFontDescriptor.fontDescriptorWithSymbolicTraits(.TraitItalic)
//			finalFont = UIFont(descriptor: italicDescriptor, size: styleSize)
//		}
//		if type == .Bold {
//			let boldDescriptor = finalFontDescriptor.fontDescriptorWithSymbolicTraits(.TraitBold)
//			finalFont = UIFont(descriptor: boldDescriptor, size: styleSize)
//		}
//		
//		
//		attributes[NSFontAttributeName] = finalFont
//		
//		if appendNewLine {
//			return NSAttributedString(string: string + "\n", attributes: attributes)
//		} else {
//			return NSAttributedString(string: string, attributes: attributes)
//		}
//	}
//}
//
//if let url = NSBundle.mainBundle().URLForResource("test", withExtension: "md"), md = SwiftyMarkdown(url: url) {
//	
//	label.attributedText = md.attributedString()
//}
//

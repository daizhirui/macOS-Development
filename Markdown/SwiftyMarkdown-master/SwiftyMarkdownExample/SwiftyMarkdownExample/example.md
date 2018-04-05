# Swifty Markdown

SwiftyMarkdown is a Swift-based *Markdown* parser that converts *Markdown* files or strings into **NSAttributedStrings**. It uses sensible defaults and supports dynamic type, even if you use custom fonts.

## Features

Customise fonts and colours easily in a Swift-like way: 

`md.code.fontName = "CourierNewPSMT"`

`md.h2.fontName = "AvenirNextCondensed-Medium"`
`md.h2.color = UIColor.redColor()`

*An italic line*

It ignores random * and correctly handles escaped \*asterisks\* and \_underlines\_ and has error handling for mismatched tags (\*\*bold\* == **bold*). It also supports inline Markdown [Links](http://voyagetravelapps.com/)

Supports Alternative Headings
===




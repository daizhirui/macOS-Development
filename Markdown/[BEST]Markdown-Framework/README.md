[<p align="center"><img alt="Markdown" src="https://cdn0.iconfinder.com/data/icons/octicons/1024/markdown-256.png"></p>](#markdown)

# Markdown

![🐧 linux: ready](https://img.shields.io/badge/%F0%9F%90%A7%20linux-ready-red.svg)
[![Build Status](https://travis-ci.org/crossroadlabs/Markdown.svg?branch=master)](https://travis-ci.org/crossroadlabs/Markdown)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Platform OS X | Linux](https://img.shields.io/badge/platform-OS%20X%20%7C%20Linux-orange.svg)
![Swift version](https://img.shields.io/badge/Swift-2.1 | 2.2-blue.svg)
[![GitHub license](https://img.shields.io/badge/license-LGPL v3-green.svg)](https://raw.githubusercontent.com/crossroadlabs/Markdown/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/crossroadlabs/Markdown.svg)](https://github.com/crossroadlabs/Markdown/releases)

## Full [markdown](https://en.wikipedia.org/wiki/Markdown) support for Swift - wrapper over [Discount](https://github.com/Orc/discount) (this actually is what GitHub uses deep down)

## Goals

[<img align="left" src="https://raw.githubusercontent.com/crossroadlabs/Express/master/logo-full.png" hspace="20" height=128>](https://github.com/crossroadlabs/Express) Markdown library was mainly introduced to fulfill the needs of [Swift Express](https://github.com/crossroadlabs/Express) - web application server side framework for Swift.

Still we hope it will be useful for everybody else.

[Happy marking down ;)](#examples)

## Getting started

### Installation

#### Prerequisites

First of all you need to install [Discount](https://github.com/Orc/discount).

##### OS X:

```sh
#this one install a static library, so don't worry about redistribution
brew install discount
```

##### Linux:

```sh
sudo apt-get install libmarkdown2-dev
```

#### [Package Manager](https://swift.org/package-manager/)

Add the following dependency to your [Package.swift](https://github.com/apple/swift-package-manager/blob/master/Documentation/Package.swift.md):

```swift
.Package(url: "https://github.com/crossroadlabs/Markdown.git", majorVersion: 0)
```

Run ```swift build``` and build your app. Package manager is supported on OS X, but it's still recommended to be used on Linux only.

#### [Carthage](https://github.com/Carthage/Carthage)
Add the following to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
github "crossroadlabs/Markdown"
```

Run `carthage update` and follow the steps as described in Carthage's [README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

### Examples

#### Hello Markdown

```swift
let md = try Markdown(string:"# Hello Markdown")
let document = try md.document()
print(document)
```

The output will be the following:

```
<h1>Hello Markdown</h1>
```

#### Metadata

```swift
let md = try Markdown(string:"% test\n% daniel\n% 02.03.2016\n")
            
let title = md.title!
let author = md.author!
let date = md.date

print("Title: ", title)
print("Author: ", author)
print("Date: ", date)
```

The output will be the following:

```
Title: test
Author: daniel
Date: 02.03.2016
```

#### Table of contents

```swift
let md = try Markdown(string:"# test header", options: .TableOfContents)
let toc = try md.tableOfContents()
print(toc)
```

The output will be the following:

```
<ul>
 <li><a href=\"#test.header\">test header</a></li>
</ul>
```

#### Style

```swift
let md = try Markdown(string:"<style>background-color: yellow;</style>\n# test header")
let css = try md.css()
print(css)
```

The output will be the following:

```
<style>background-color: yellow;</style>
```

### Have a nice marking down ;)

## Contributing

To get started, <a href="https://www.clahub.com/agreements/crossroadlabs/Markdown">sign the Contributor License Agreement</a>.

## [![Crossroad Labs](http://i.imgur.com/iRlxgOL.png?1) by Crossroad Labs](http://www.crossroadlabs.xyz/)

//===--- Package.swift ----------------------------------------------------===//
//
//Copyright (c) 2016 Daniel Leping (dileping)
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

import PackageDescription

let package = Package(
    name: "Markdown",
    dependencies: [
        .Package(url: "https://github.com/crossroadlabs/CDiscount.git", majorVersion: 2, minor: 2)
    ]
)

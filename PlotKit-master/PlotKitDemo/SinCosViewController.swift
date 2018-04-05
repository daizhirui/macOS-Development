// Copyright © 2015 Venture Media Labs. All rights reserved.
//
// This file is part of PlotKit. The full PlotKit copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Cocoa
import PlotKit

class SinCosViewController: NSViewController {
    let π = Double.pi
    let sampleCount = 1024
    let font = NSFont(name: "Optima", size: 16)!

    @IBOutlet weak var plotView: PlotView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createAxes()
        createSinePlot()
        createCosinePlot()
    }

    func createAxes() {
        let ticks = [
            TickMark(π/2, label: "π/2"),
            TickMark(π, label: "π"),
            TickMark(3*π/2, label: "3π/2"),
            TickMark(2*π, label: "2π"),
        ]
        var xaxis = Axis(orientation: .horizontal, ticks: .list(ticks))
        xaxis.position = .value(0)
        xaxis.labelAttributes = [NSAttributedStringKey.font: font]
        plotView.addAxis(xaxis)

        var yaxis = Axis(orientation: .vertical, ticks: .distance(0.5))
        yaxis.labelAttributes = [NSAttributedStringKey.font: font]
        yaxis.position = .value(0)
        plotView.addAxis(yaxis)
    }

    func createSinePlot() {
        let t = (0..<sampleCount).map({ 2*π * Double($0) / Double(sampleCount - 1) })
        let y = t.map({ sin($0) })

        let pointSet = PointSet(points: (0..<sampleCount).map{ Point(x: t[$0], y: y[$0]) })
        plotView.addPointSet(pointSet, title: "sin")
    }

    func createCosinePlot() {
        let t = (0..<sampleCount).map({ 2*π * Double($0) / Double(sampleCount - 1) })
        let y = t.map({ cos($0) })

        let pointSet = PointSet(points: (0..<sampleCount).map{ Point(x: t[$0], y: y[$0]) })
        pointSet.lineColor = NSColor.blue
        plotView.addPointSet(pointSet, title: "cos")
    }
}

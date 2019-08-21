//
//  BUnitAnimation.swift
//  GoD
//
//  Created by kai chen on 2019/6/1.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
extension BUnit {
    func lighting1() {
        let lighting = Game.instance.pictureThunder1.getNode([0,1,2,3,4,5,6,7].one(), 1, 1, 2)
        lighting.size = CGSize(width: _charSize * 1, height: _charSize * 2)
//        lighting.anchorPoint = CGPoint(x: 0.5, y: 0)
        lighting.yAxis = _charSize * 0.55
        lighting.zPosition = _charNode.zPosition + 20
        addChild(lighting)
        setTimeout(delay: 0.5, completion: {
            lighting.removeFromParent()
        })
    }
    func lighting2() {
        let lighting = Game.instance.pictureThunder1.getNode([8,9].one(), 1, 1, 2)
        lighting.size = CGSize(width: _charSize * 1, height: _charSize * 2)
        //        lighting.anchorPoint = CGPoint(x: 0.5, y: 0)
        lighting.yAxis = _charSize * 0.25
        lighting.zPosition = _charNode.zPosition + 20
        addChild(lighting)
        setTimeout(delay: 0.5, completion: {
            lighting.removeFromParent()
        })
    }
    func flame1(index:CGFloat = 2, line: CGFloat = 0) {
        let line:CGFloat = line == 0 ? 1 : 3
        let an = Game.instance.pictureFlame1.getNode(index * 2, line, 2, 2)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        an.zPosition = _charNode.zPosition + 20
        an.alpha = 0
        let fi = SKAction.fadeIn(withDuration: TimeInterval(0.25))
        let fo = SKAction.fadeOut(withDuration: TimeInterval(0.25))
        addChild(an)
        an.run(SKAction.sequence([fi, fo])) {
            an.removeFromParent()
        }
    }
    func flame2(index:CGFloat = 2, line: CGFloat = 1) {
        let line:CGFloat = line == 0 ? 1 : 3
        let an = Game.instance.pictureFlame2.getNode(index * 2, line, 2, 2)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        an.yAxis = _charSize * 0.5
        an.zPosition = _charNode.zPosition + 20
        an.alpha = 0
        let fi = SKAction.fadeIn(withDuration: TimeInterval(0.25))
        let fo = SKAction.fadeOut(withDuration: TimeInterval(0.25))
        addChild(an)
        an.run(SKAction.sequence([fi, fo])) {
            an.removeFromParent()
        }
    }
    func flame3() {
        let an = Game.instance.pictureFlame2.getNode(4, 3, 2, 2)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        an.yAxis = _charSize * 0.55
        an.zPosition = _charNode.zPosition + 20
        addChild(an)
        setTimeout(delay: 0.5, completion: {
            let fo = SKAction.fadeOut(withDuration: TimeInterval(0.25))
            an.run(fo) {
                an.removeFromParent()
            }
        })
    }
    func attacked1() {
        let an = Game.instance.pictureAttacked1.getNode([1,2,3,4].one(), 0)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        //        lighting.anchorPoint = CGPoint(x: 0.5, y: 0)
//        an.yAxis = _charSize * 0.25
        an.zPosition = _charNode.zPosition + 20
        addChild(an)
        setTimeout(delay: 0.25, completion: {
            an.removeFromParent()
        })
    }
    func attacked2() {
        let an = Game.instance.pictureMixed.getNode([0,1].one(), 0)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        an.zPosition = _charNode.zPosition + 20
        addChild(an)
        setTimeout(delay: 0.25, completion: {
            an.removeFromParent()
        })
    }
    func water1(index:CGFloat = 1) {
        let an = Game.instance.pictureWater1.getNode(index, 0)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        an.zPosition = _charNode.zPosition + 20
        an.alpha = 0
        let fi = SKAction.fadeIn(withDuration: TimeInterval(0.25))
        let fo = SKAction.fadeOut(withDuration: TimeInterval(0.25))
        addChild(an)
        an.run(SKAction.sequence([fi, fo])) {
            an.removeFromParent()
        }
    }
    //渐隐
    func mixed1(index:CGFloat = 4, completion:@escaping () -> Void = {}) {
        let an = Game.instance.pictureMixed.getNode(index, 0)
        an.size = CGSize(width: _charSize * 1.5, height: _charSize * 1.5)
        an.zPosition = _charNode.zPosition + 20
        an.alpha = 0
        let fi = SKAction.fadeIn(withDuration: TimeInterval(0.25))
        let fo = SKAction.fadeOut(withDuration: TimeInterval(0.25))
        addChild(an)
        an.run(SKAction.sequence([fi, fo])) {
            an.removeFromParent()
            completion()
        }
    }
    //轮转
    func mixed2(index:CGFloat = 2, completion:@escaping () -> Void = {}) {
        let an = Game.instance.pictureMixed.getNode(index, 0)
        an.size = CGSize(width: _charSize * 1.5, height: _charSize * 1.5)
        an.zPosition = _charNode.zPosition + 20
        let r = SKAction.rotate(byAngle: 1, duration: TimeInterval(1))
        let fo = SKAction.fadeOut(withDuration: TimeInterval(0.25))
        addChild(an)
        an.run(SKAction.sequence([r, fo])) {
            an.removeFromParent()
            completion()
        }
    }
    func water2() {
        let t1 = Game.instance.pictureWater2.getCell([0,2,4,6,8].one(), [3,1].one(), 2, 2)
        let t2 = Game.instance.pictureWater2.getCell([0,2,4,6,8].one(), [3,1].one(), 2, 2)
        let w = SKAction.wait(forDuration: TimeInterval(0.25))
        let a1 = SKAction.setTexture(t1)
        let a2 = SKAction.setTexture(t2)
        let a = SKAction.sequence([a1, w, a2, w])
        let an = SKSpriteNode()
        an.size = CGSize(width: _charSize * 1.5, height: _charSize * 1.5)
        an.yAxis = _charSize * 0.5
        an.zPosition = _charNode.zPosition + 20
        addChild(an)
        an.run(a) {
            an.removeFromParent()
        }
    }
    func water3() {
        let an = Game.instance.pictureWater3.getNode([0,2,4,6,8].one(), 1, 2, 2)
        an.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        //        lighting.anchorPoint = CGPoint(x: 0.5, y: 0)
        an.yAxis = _charSize * 0.25
        an.zPosition = _charNode.zPosition + 20
        addChild(an)
        setTimeout(delay: 0.5, completion: {
            an.removeFromParent()
        })
    }
}

//
//  FullAnimation.swift
//  GoD
//
//  Created by kai chen on 2019/10/22.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
extension BUnit {
    func getDuration() -> CGFloat {
        return 1 / 12
    }
    func getLayer() -> SKSpriteNode {
//        return Game.instance.scene._layer
        return _battle._animationLayer
    }
    func getMeasure() -> CGFloat {
        return 192
    }
    func animate(ao:AnimationOption, completion:@escaping () -> Void = {}) {
        var layer:SKSpriteNode!
        if ao.single {
            layer = ao.targetLayer
        } else {
            layer = ao.selfLayer ? self._animationLayer : getLayer()
            if !ao.selfLayer {
                if playerPart {
                    layer.position.y = cellSize * 5
                } else {
                    layer.position.y = cellSize * -2.5
                }
            } else {
                layer.yAxis = _charSize * ao.yAxis
                layer.size = CGSize(width: _charSize * ao.layerSize, height: _charSize * ao.layerSize)
            }
        }
        
        var x:CGFloat = ao.startX * 4, y:CGFloat = ao.startY * 4 + 3, xSize:CGFloat = ao.pictureWidth / 48, ySize:CGFloat = ao.pictureheight / 48, frameSize = ao.frameSize
        let cut = SKAction.wait(forDuration: TimeInterval(ao.duration / 1000))
        let t = SKTexture(imageNamed: ao.imgUrl)
        var seq = Array<SKAction>()
        for _ in 0...frameSize - 1 {
            let texture = t.getCell(x, y, 4, 4)
            seq.append(SKAction.setTexture(texture))
            seq.append(cut)
            x += 4
            if x >= (xSize - 1) {
                x = 0
                y += 4
                if y >= ySize - 1 {
                    break
                }
            }
        }
        if ao.executeTimes > 1 {
            for _ in 0...ao.executeTimes - 2 {
                x = ao.startX * 4
                y = ao.startY * 4 + 3
                for _ in 0...frameSize - 1 {
                    let texture = t.getCell(x, y, 4, 4)
                    seq.append(SKAction.setTexture(texture))
                    seq.append(cut)
                    x += 4
                    if x >= (xSize - 1) {
                        x = 0
                        y += 4
                        if y >= ySize - 1 {
                            break
                        }
                    }
                }
            }
        }
        if ao.fadeOut {
            seq.append(SKAction.fadeOut(withDuration: TimeInterval(0.5)))
        } else if ao.lasting > 0 {
            seq.append(SKAction.wait(forDuration: TimeInterval(ao.lasting)))
        }
        let action = ao.repeatForever ? SKAction.repeatForever(SKAction.sequence(seq)) : SKAction.sequence(seq)
        layer.run(action) {
            layer.texture = nil
            layer.alpha = 1
            completion()
        }
//        layer.run(SKAction.fadeOut(withDuration: TimeInterval(1)))
        
    }
    func hit1(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 4
        ao.imgUrl = "Hit1.png"
        self.animate(ao: ao, completion: completion)
    }
    func hit2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 3
        ao.imgUrl = "Hit2.png"
        self.animate(ao: ao, completion: completion)
    }
    func hitFire(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.imgUrl = "HitFire.png"
        self.animate(ao: ao, completion: completion)
    }
    func hitThunder(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.imgUrl = "HitThunder.png"
        self.animate(ao: ao, completion: completion)
    }
    func hitIce(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.imgUrl = "HitIce.png"
        self.animate(ao: ao, completion: completion)
    }
    func hitSpecial2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 7
        ao.imgUrl = "HitSpecial2.png"
        self.animate(ao: ao, completion: completion)
    }
    //not used
    func explosion1(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 15
        ao.imgUrl = "Explosion1.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func explosion2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.selfLayer = false
        ao.imgUrl = "Explosion2.png"
        ao.frameSize = 23
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    
    func breath(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 15
        ao.imgUrl = "Breath.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func blow(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 6
        ao.imgUrl = "Blow.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func wind4(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.imgUrl = "Wind4.png"
        ao.frameSize = 5
        ao.executeTimes = 2
        ao.yAxis = 0.25
        self.animate(ao: ao, completion: completion)
    }
    func recovery2f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 6
        ao.imgUrl = "Recovery2.png"
        self.animate(ao: ao, completion: completion)
    }
    func recovery3(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 22
        ao.imgUrl = "Recovery3.png"
        self.animate(ao: ao, completion: completion)
    }
    func recovery1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 15
        ao.imgUrl = "Recovery1.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func water1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 11
        ao.imgUrl = "Water1.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func water3f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 3
        ao.executeTimes = 3
        ao.imgUrl = "Water3.png"
        self.animate(ao: ao, completion: completion)
    }
    func water3s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 3
        ao.startX = 4
        ao.executeTimes = 2
        ao.imgUrl = "Water3.png"
        self.animate(ao: ao, completion: completion)
    }
    func thunder1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 1
        ao.duration = 120
//        ao.startX = 4
//        ao.executeTimes = 2
        ao.imgUrl = "Thunder1.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func thunder1s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 1
        ao.startX = 2
        ao.startY = 2
        ao.duration = 120
//        ao.executeTimes = 2
        ao.imgUrl = "Thunder1.png"
        self.animate(ao: ao, completion: completion)
    }
    func thunder2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 6
        ao.duration = 100
        ao.executeTimes = 2
        ao.imgUrl = "Thunder1.png"
        self.animate(ao: ao, completion: completion)
    }
    func thunder4s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 1
        ao.duration = 120
        ao.startX = 4
        ao.startY = 1
//        ao.executeTimes = 2
        ao.imgUrl = "Thunder4.png"
        self.animate(ao: ao, completion: completion)
    }
    func thunder3(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 4
        ao.startX = 1
        ao.executeTimes = 3
        ao.imgUrl = "Thunder3.png"
        self.animate(ao: ao, completion: completion)
    }
    func magic2t(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 9
        ao.startX = 1
        ao.startY = 2
        ao.imgUrl = "Magic2.png"
        self.animate(ao: ao, completion: completion)
    }
    func magic1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 6
        ao.executeTimes = 2
        ao.duration = 100
        ao.imgUrl = "Magic1.png"
        self.animate(ao: ao, completion: completion)
    }
    func stateDown2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 11
        ao.imgUrl = "StateDown2.png"
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    func stateDown3f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 16
        ao.imgUrl = "StateDown3.png"
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    func stateDown3s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 11
        ao.startX = 1
        ao.startY = 3
        ao.imgUrl = "StateDown3.png"
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    func stateUp2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 23
        ao.imgUrl = "StateUp2.png"
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    func stateDarkf(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 13
        ao.imgUrl = "StateDark.png"
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    func stateDeathf(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.duration = 100
        ao.imgUrl = "StateDeath.png"
        ao.fadeOut = true
        self.animate(ao: ao, completion: completion)
    }
    func statePoison(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 15
        ao.imgUrl = "StatePoison.png"
        self.animate(ao: ao, completion: completion)
    }
    func stateSleepf(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 9
        ao.duration = 100
        ao.imgUrl = "StateSleep.png"
        self.animate(ao: ao, completion: completion)
    }
    func special3(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 20
        ao.duration = 60
        ao.imgUrl = "Special3.png"
        self.animate(ao: ao, completion: completion)
    }
    func gun1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 6
//        ao.duration = 180
        ao.imgUrl = "Gun1.png"
        self.animate(ao: ao, completion: completion)
    }
    func pollen(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 15
        ao.imgUrl = "Pollen.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness4fifth(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 6
        ao.startY = 4
        ao.startX = 1
        ao.imgUrl = "Darkness4.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness4t(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 4
        ao.startY = 1
        ao.startX = 0
        ao.executeTimes = 2
        ao.imgUrl = "Darkness4.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness4f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.startY = 2
        ao.startX = 3
        ao.duration = 100
        ao.imgUrl = "Darkness4.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness5(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 24
        ao.startX = 1
        ao.duration = 60
        ao.imgUrl = "Darkness5.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.duration = 100
        ao.fadeOut = true
        ao.imgUrl = "Darkness1.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness1s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.duration = 100
        ao.startY = 1
        ao.startX = 3
        ao.imgUrl = "Darkness1.png"
        self.animate(ao: ao, completion: completion)
    }
    func darkness3(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 10
        ao.duration = 100
        ao.fadeOut = true
        ao.imgUrl = "Darkness3.png"
        self.animate(ao: ao, completion: completion)
    }
    func cure1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 17
        ao.imgUrl = "Cure1.png"
        self.animate(ao: ao, completion: completion)
    }
    func cure1s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 11
        ao.startX = 2
        ao.startY = 3
        ao.imgUrl = "Cure1.png"
        self.animate(ao: ao, completion: completion)
    }
    func cure2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 20
        ao.fadeOut = true
        ao.imgUrl = "Cure2.png"
        self.animate(ao: ao, completion: completion)
    }
    func cure3t(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.startY = 3
        ao.startX = 3
        ao.imgUrl = "Cure3.png"
        self.animate(ao: ao, completion: completion)
    }
    func cure3f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 11
        ao.startX = 2
        ao.startY = 1
        ao.duration = 100
        ao.imgUrl = "Cure3.png"
        self.animate(ao: ao, completion: completion)
    }
    func cure4(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.imgUrl = "Cure4.png"
        self.animate(ao: ao, completion: completion)
    }
    func fire2f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 5
        ao.imgUrl = "Fire2.png"
        self.animate(ao: ao, completion: completion)
    }
    func fire3f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 13
        ao.startX = 1
        ao.imgUrl = "Fire3.png"
        self.animate(ao: ao, completion: completion)
    }
    func ice1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 5
        ao.imgUrl = "Fire2.png"
        self.animate(ao: ao, completion: completion)
    }
    func ice2f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.duration = 100
        ao.imgUrl = "Ice2.png"
        self.animate(ao: ao, completion: completion)
    }
    func preSpecial3f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 17
        ao.duration = 100
        ao.selfLayer = false
        ao.imgUrl = "PreSpecial1.png"
        self.animate(ao: ao, completion: completion)
    }
    func preSpecial3s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 10
        ao.duration = 100
        ao.startX = 2
        ao.startY = 3
        ao.fadeOut = true
        ao.imgUrl = "PreSpecial3.png"
        self.animate(ao: ao, completion: completion)
    }
    func absorbf(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 8
        ao.imgUrl = "Absorb.png"
        self.animate(ao: ao, completion: completion)
    }
    func absorbs(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.startY = 1
        ao.startX = 3
        ao.imgUrl = "Absorb.png"
        self.animate(ao: ao, completion: completion)
    }
    func absorbt(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 5
        ao.startY = 4
        ao.imgUrl = "Absorb.png"
        self.animate(ao: ao, completion: completion)
    }
    func claw(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 7
//        ao.duration = 60
        ao.yAxis = 0.25
        ao.layerSize = 1.5
        ao.imgUrl = "Claw.png"
        self.animate(ao: ao, completion: completion)
    }
    func clawSpecial1(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 25
        ao.duration = 60
        ao.imgUrl = "ClawSpecial1.png"
        self.animate(ao: ao, completion: completion)
    }
    func clawSpecial2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.duration = 60
        ao.imgUrl = "ClawSpecial2.png"
        self.animate(ao: ao, completion: completion)
    }
    func light3(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 20
        ao.imgUrl = "Light3.png"
        self.animate(ao: ao, completion: completion)
    }
    func light4(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 30
        ao.fadeOut = true
        ao.selfLayer = false
        ao.imgUrl = "Light4.png"
        self.animate(ao: ao, completion: completion)
    }
    func revival1f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 7
        ao.duration = 125
        ao.fadeOut = true
        ao.imgUrl = "Revival1.png"
        self.animate(ao: ao, completion: completion)
    }
    func revival2f(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 11
        ao.duration = 100
        ao.yAxis = 0.25
        ao.imgUrl = "Revival2.png"
        self.animate(ao: ao, completion: completion)
    }
    func revival2s(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 4
        ao.duration = 125
        ao.yAxis = 0.25
        ao.lasting = 0.75
        ao.startX = 1
        ao.startY = 2
        ao.imgUrl = "Revival2.png"
        self.animate(ao: ao, completion: completion)
    }
    func earth5(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 20
//        ao.duration = 100
        ao.startX = 1
        ao.fadeOut = true
        ao.selfLayer = false
        ao.imgUrl = "Earth5.png"
        self.animate(ao: ao, completion: completion)
    }
    func sonic(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 7
        ao.executeTimes = 1
        ao.duration = 100
        ao.imgUrl = "Sonic.png"
        self.animate(ao: ao, completion: completion)
    }
    
    func holy5(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 17
        ao.startX = 1
        ao.selfLayer = false
        ao.imgUrl = "Holy5.png"
        self.animate(ao: ao, completion: completion)
    }
    func slashSpecial3t(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.startX = 1
        ao.startY = 3
        ao.imgUrl = "SlashSpecial3.png"
        self.animate(ao: ao, completion: completion)
    }
    func howl(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 10
        ao.imgUrl = "Howl.png"
        self.animate(ao: ao, completion: completion)
    }
    func laser2(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 14
        ao.duration = 100
        ao.selfLayer = false
        ao.imgUrl = "Laser2.png"
        self.animate(ao: ao, completion: completion)
    }
    func stickSpelcial3(completion:@escaping () -> Void = {}) {
        let ao = AnimationOption()
        ao.frameSize = 12
        ao.imgUrl = "StickSpecial3.png"
        self.animate(ao: ao, completion: completion)
    }
    
}

class AnimationOption {
    init() {
        
    }
    var imgUrl:String = ""
    var frameSize:Int = 0
    var pictureWidth:CGFloat = 960
    var pictureheight:CGFloat = 1200
    var startX:CGFloat = 0
    var startY:CGFloat = 0
    var selfLayer:Bool = true
    var executeTimes:Int = 1
    var fadeOut = false
    var duration:CGFloat = 83
    var toAppendActions = Array<SKAction>()
    var single = false
    var targetLayer:SKSpriteNode!
    var repeatForever = false
    var yAxis:CGFloat = 0
    var layerSize:CGFloat = 2
    var lasting:CGFloat = 0
}

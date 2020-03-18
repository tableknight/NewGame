//
//  BunitAction.swift
//  GoD
//
//  Created by kai chen on 2019/7/5.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
extension BUnit {
    func actionAttack(completion:@escaping () -> Void) {
        if _attackActing {
//            completion()
            return
        }
        _attackActing = true
        if weaponIs(Outfit.Bow) {
            actionShoot(completion: {
                self._attackActing = false
                completion()
            })
            return
        }
        let range = _charSize * 0.5
        var v = CGVector(dx: 0, dy: range)
        var v2 = CGVector(dx: 0, dy: -range)
        if !playerPart {
            v = CGVector(dx: 0, dy: -range)
            v2 = CGVector(dx: 0, dy: range)
        }
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.1))
        let go = SKAction.sequence([wait, move1, SKAction.wait(forDuration: TimeInterval(0.25)), move2])
        _select.run(go)
        _charNode.run(go, completion: {
            self._attackActing = false
            completion()
        })
    }
    func actionWait(_ time:CGFloat = 1, completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(time))
        _charNode.run(wait, completion: completion)
    }
    func actionBuff(completion:@escaping () -> Void) {
        auroUp(x: 2)
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroUp(x: 2)
        })
        setTimeout(delay: 0.4, completion: {
            this.auroUp(x: 2)
        })
        setTimeout(delay: 0.6, completion: {
            this.auroUp(x: 2)
        })
        setTimeout(delay: 0.8, completion: {
            this.auroUp(x: 2) {
                completion()
            }
        })
    }
    func actionDebuff(completion:@escaping () -> Void) {
        auroDown()
        Sound.play(node: self, fileName: "down")
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.4, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.6, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.8, completion: {
            this.auroDown() {
                completion()
            }
        })
    }
    
    func actionAttacked(defend:Bool = false, completion:@escaping () -> Void) {
        if _attackedActing {
            //            debug("正在表演")
            //            completion()
            //            return
            return
        }
        
        _attackedActing = true
        if (isDefend || defend) && _battle._selectedAction is Physical {
            actionDefead {
                self._attackedActing = false
                completion()
            }
            return
        }
        _attackedActing = true
        let d = _charSize * 0.12
        var v = CGVector(dx: 0, dy: -d)
        var v2 = CGVector(dx: 0, dy: d)
        if !playerPart {
            v = CGVector(dx: 0, dy: d)
            v2 = CGVector(dx: 0, dy: -d)
        }
        //        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.8))
        let go = SKAction.sequence([move1, wait, move2])
        _charNode.run(go)
        _select.run(go)
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(0))
        let fadeIn = SKAction.fadeIn(withDuration: TimeInterval(0))
        let fadeWait = SKAction.wait(forDuration: TimeInterval(0.15))
        let fadeGo = SKAction.sequence([fadeOut, fadeWait, fadeIn, fadeWait, fadeOut, fadeWait, fadeIn, fadeWait, fadeOut, fadeWait, fadeIn])
        _charNode.run(fadeGo) {
            self._attackedActing = false
            completion()
            let c = self._battle._curRole
            if self.hasStatus(type: Status.ICE_GUARD) && c.isClose() && c._battle._selectedAction is Physical {
                if Core().d5() {
                    c.showText(text: "Spd -10")
                }
            }
        }
    }
    func actionDefead(completion:@escaping () -> Void) {
        let d = _charSize * 0.05
        var v = CGVector(dx: 0, dy: -d)
        var v2 = CGVector(dx: 0, dy: d)
        if !playerPart {
            v = CGVector(dx: 0, dy: d)
            v2 = CGVector(dx: 0, dy: -d)
        }
        //        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.05))
        let go = SKAction.sequence([move1, wait, move2])
        _charNode.run(go, completion: completion)
    }
    func actionSpark(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(0.25))
        let fadeout = SKAction.fadeOut(withDuration: TimeInterval(0.15))
        let fadein = SKAction.fadeIn(withDuration: TimeInterval(0.15))
        let go = SKAction.sequence([wait,fadeout,fadein,fadeout,fadein,fadeout,fadein])
        _charNode.run(go) {
            completion()
        }
    }
    func actionCast(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let fadeout = SKAction.fadeOut(withDuration: TimeInterval(0.15))
        let fadein = SKAction.fadeIn(withDuration: TimeInterval(0.15))
        let go = SKAction.sequence([wait,fadeout,fadein,fadeout,fadein,fadeout,fadein, SKAction.wait(forDuration: TimeInterval(0.15))])
        setTimeout(delay: 0.5, completion: {
            Sound.play(node: self, fileName: "cast")
        })
        _charNode.run(go) {
            completion()
        }
//        if _unit is Boss || _unit is IFace || _unit._race != EvilType.MAN {
//            
//        } else {
//            let wt1 = SKAction.wait(forDuration: TimeInterval(0.5))
//            let wt = SKAction.wait(forDuration: TimeInterval(0.1))
//            let n = SKAction.setTexture(_charTexture.getCell(0, 3))
//            let w = SKAction.setTexture(_charTexture.getCell(0, 1))
//            let s = SKAction.setTexture(_charTexture.getCell(0, 0))
//            let e = SKAction.setTexture(_charTexture.getCell(0, 2))
//            var go = SKAction.sequence([wt, w, wt, s, wt, e, wt, n, wt, w, wt, s, wt, e, wt, n, wt1])
//            if !playerPart {
//                go = SKAction.sequence([wt, e, wt, n, wt, w, wt, s, wt, e, wt, n, wt, w, wt, s, wt1])
//            }
//            _charNode.run(go) {
//                completion()
//            }
//        }
    }
    
    func actionAvoid(completion:@escaping () -> Void) {
        if _avoidActing {
            return
        }
        Sound.play(node: self, fileName: "avoid")
        _avoidActing = true
        let d = cellSize * 0.3
        var v = CGVector(dx: 0, dy: -d)
        var v2 = CGVector(dx: 0, dy: d)
        if !playerPart {
            v = CGVector(dx: 0, dy: d)
            v2 = CGVector(dx: 0, dy: -d)
        }
        //        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.8))
        let go = SKAction.sequence([move1, wait, move2])
        _charNode.run(go, completion: {
            self._avoidActing = false
            completion()
        })
        _select.run(go)
    }
    func actionDead(completion:@escaping () -> Void) {
        removeFromBattle()
        if _attackedActing {
            setTimeout(delay: 1, completion: {
                self.actionDead(completion: completion)
            })
        } else {
            setTimeout(delay: 0.5, completion: {
                Sound.play(node: self, fileName: "dead")
            })
            let wait = SKAction.fadeAlpha(to: 0, duration: TimeInterval(0.75))
            _charNode.run(wait, completion: completion)
        }
    }
    func actionSummon(completion:@escaping () -> Void) {
        Sound.play(node: self, fileName: "Raise3")
        _charNode.alpha = 0
        let wait = SKAction.fadeAlpha(to: 1, duration: TimeInterval(0.75))
        _charNode.run(wait, completion: completion)
    }
    func actionRecall(completion:@escaping () -> Void) {
        Sound.play(node: self, fileName: "Raise3")
        let wait = SKAction.fadeAlpha(to: 0, duration: TimeInterval(0.75))
        _charNode.run(wait, completion: completion)
    }
    func actionFrozen(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        _charNode.run(wait, completion: completion)
    }
    func actionCursed(completion:@escaping () -> Void) {
        actionDebuff {
            completion()
        }
    }
    func actionUnfreeze(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        _charNode.run(wait, completion: completion)
    }
    func auroUp(x:CGFloat = 1, completion:@escaping () -> Void = {}) {
        let node = SKSpriteNode(texture: _selectTexture.getCell(x, 1))
        node.zPosition = 80
        node.position.y = -cellSize * 0.25
        addChild(node)
        let move = SKAction.moveBy(x: 0, y: cellSize * 0.75, duration: TimeInterval(0.5))
        node.run(move) {
            node.removeFromParent()
            completion()
        }
    }
    func actionHealed(completion:@escaping () -> Void) {
        auroUp()
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroUp()
        })
        setTimeout(delay: 0.4, completion: {
            this.auroUp()
        })
        setTimeout(delay: 0.6, completion: {
            this.auroUp()
        })
        setTimeout(delay: 0.8, completion: {
            this.auroUp() {
                completion()
            }
        })
    }
    private func auroDown(x:CGFloat = 0, completion:@escaping () -> Void = {}) {
        let node = SKSpriteNode(texture: _selectTexture.getCell(x, 1))
        node.zPosition = 80
        node.position.y = cellSize * 0.5
        addChild(node)
        let move = SKAction.moveBy(x: 0, y: -cellSize * 0.5, duration: TimeInterval(0.5))
        node.run(move) {
            node.removeFromParent()
            completion()
        }
    }
    func actionSealed(completion:@escaping () -> Void) {
        auroDown()
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.4, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.6, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.8, completion: {
            this.auroDown() {
                completion()
            }
        })
    }
    func actionShoot(completion:@escaping () -> Void) {
        let d = cellSize * 0.3
        var v = CGVector(dx: 0, dy: -d)
        var v2 = CGVector(dx: 0, dy: d)
        if !playerPart {
            v = CGVector(dx: 0, dy: d)
            v2 = CGVector(dx: 0, dy: -d)
        }
        //        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        let go = SKAction.sequence([move1, wait, move2])
        _charNode.run(go, completion: completion)
        _select.run(go)
    }
    func play(_ fileName:String) {
        Sound.play(node: self, fileName: fileName)
    }
}

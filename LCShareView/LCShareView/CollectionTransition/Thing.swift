//
//  Thing.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class Thing: NSObject {
    var title: String?
    var image: UIImage?
    var overview: String?
    
    static func exampleThings() -> [Thing] {
        return  [Thing(title: "Thing 1", image: UIImage(named: "thing01"), overview: "Drumstick cow beef fatback turkey boudin. Meatball leberkas boudin hamburger pork belly fatback."),
                 Thing(title: "Thing 2", image: UIImage(named: "thing02"), overview: "Shank pastrami sirloin, sausage prosciutto spare ribs kielbasa tri-tip doner."),
                 Thing(title: "Thing 3", image: UIImage(named: "thing03"), overview: "Frankfurter cow filet mignon short loin ham hock salami meatloaf biltong andouille bresaola prosciutto."),
                 Thing(title: "Thing 4", image: UIImage(named: "thing04"), overview: "Pastrami sausage turkey shank shankle corned beef."),
                 Thing(title: "Thing 5", image: UIImage(named: "thing05"), overview: "Tri-tip short loin pork belly, pastrami biltong ball tip ham hock. Shoulder ribeye turducken shankle.")]
    }
    
    init(title: String?, image: UIImage?, overview: String?) {
        super.init()
        self.title = title
        self.image = image
        self.overview = overview
    }
}

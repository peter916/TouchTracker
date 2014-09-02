//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by peter on 14-9-2.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchDrawView : UIView
{
    NSMutableDictionary* linesInProcess;
    NSMutableArray* completeLines;
}
-(void)clearAll;
-(void)endTouches:(NSSet*)touches;
@end

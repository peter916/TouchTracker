//
//  Line.h
//  TouchTracker
//
//  Created by peter on 14-9-2.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Line : NSObject
{
    CGPoint begin;
    CGPoint end;
}

@property(nonatomic) CGPoint begin;
@property(nonatomic) CGPoint end;

@end

//
//  RegEntity.h
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-11.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RegEntity : NSManagedObject

@property (nonatomic, retain) NSString * authguid;
@property (nonatomic, retain) NSString * deviceuid;

@end

//
//  UserCell.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 04/01/2014.
//  Copyright (c) 2014 Thibault Guégan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCell : UITableViewCell

+ (UserCell*) userCell;

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@end

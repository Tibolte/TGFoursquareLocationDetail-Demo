//
//  DetailLocationCell.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 17/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "DetailLocationCell.h"

@implementation DetailLocationCell

+ (DetailLocationCell*) detailLocationCell
{
    DetailLocationCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailLocationCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Rating
        _viewRate.layer.cornerRadius = 20.0f;
        
        
        //Btn save
        _btnSave.layer.borderColor = [UIColor colorWithRed:0/255.0 green:161/225.0 blue:0/255.0 alpha:1.0].CGColor;
        _btnSave.layer.borderWidth = 1.0f;
        _btnSave.layer.cornerRadius = 15.0f;
        
        //Btn checkin
        _btnCheckin.layer.cornerRadius = 15.0f;
    }
    return self;
}

- (void)awakeFromNib
{
    //Rating
    _viewRate.layer.cornerRadius = 20.0f;
    
    
    //Btn save
    _btnSave.layer.borderColor = [UIColor colorWithRed:0/255.0 green:161/225.0 blue:0/255.0 alpha:1.0].CGColor;
    _btnSave.layer.borderWidth = 1.0f;
    _btnSave.layer.cornerRadius = 15.0f;
    
    //Btn checkin
    _btnCheckin.layer.cornerRadius = 15.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

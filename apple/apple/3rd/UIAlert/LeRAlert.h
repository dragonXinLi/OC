//
//  LeRAlert.h
//  apple
//
//  Created by sangfor on 17/4/11.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    AlertPromptTypeNone,
    AlertPromptTypeSuccess,
    AlertPromptTypeError,
    AlertPromptTypeLoading,
}AlertPromptType;

typedef enum
{
    AlertTypePrompt,
    AlertTypeTextView,
    AlertTypeSystem,
}AlertType;

@interface LeRAlert : UIAlertView
{
    AlertType alertType;
    AlertPromptType promptType;
}

@property (nonatomic , strong) UIView *alertView;

- (id)initWithTitle:(NSString *)title andAlertPromptType:(AlertPromptType)type delegate:(id)delegate;

@end

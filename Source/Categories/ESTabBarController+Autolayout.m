//
//  ESTabBarController+Autolayout.m
//  Pods
//
//  Created by Ezequiel Scaruli on 5/5/15.
//
//

#import "ESTabBarController+Autolayout.h"


@interface ESTabBarController ()

@property (nonatomic, weak) UIView *buttonsContainer;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) NSInteger controllersAmount;
@property (nonatomic, strong) UIView *selectionIndicator;
@property (nonatomic, strong) NSLayoutConstraint *selectionIndicatorLeadingConstraint;


@end


@implementation ESTabBarController (Autolayout)


#pragma mark - Public methods


- (void)setupButtonsConstraints {
    for (NSInteger i = 0; i < self.controllersAmount; i++) {
        [self.buttons[i] setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.view addConstraints:[self leftLayoutConstraintsForButtonAtIndex:i]];
        [self.view addConstraints:[self verticalLayoutConstraintsForButtonAtIndex:i]];
        [self.view addConstraint:[self widthLayoutConstraintForButtonAtIndex:i]];
    }
}


- (void)setupSelectionIndicatorConstraints {
    self.selectionIndicatorLeadingConstraint = [self leadingLayoutConstraintForIndicator];
    
    [self.buttonsContainer addConstraint:self.selectionIndicatorLeadingConstraint];
    [self.buttonsContainer addConstraints:[self widthLayoutConstraintsForIndicator]];
    [self.buttonsContainer addConstraints:[self heightLayoutConstraintsForIndicator]];
    [self.buttonsContainer addConstraints:[self bottomLayoutConstraintsForIndicator]];
}


#pragma mark - Private methods


- (NSArray *)leftLayoutConstraintsForButtonAtIndex:(NSInteger)index {
    UIButton *button = self.buttons[index];
    NSArray *leftConstraints;
    
    if (index == 0) {
        // First button. Stick it to its left margin.
        leftConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[button]"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:@{@"button": button}];
    } else {
        NSDictionary *views = @{@"previousButton": self.buttons[index - 1],
                                @"button": button};
        
        // Stick the button to the previous one.
        leftConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[previousButton]-(0)-[button]"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:views];
    }
    
    return leftConstraints;
}


- (NSArray *)verticalLayoutConstraintsForButtonAtIndex:(NSInteger)index {
    UIButton *button = self.buttons[index];
    
    // The button is sticked to its top and bottom margins.
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[button]-(0)-|"
                                                   options:0
                                                   metrics:nil
                                                     views:@{@"button": button}];
}


- (NSLayoutConstraint *)widthLayoutConstraintForButtonAtIndex:(NSInteger)index {
    UIButton *button = self.buttons[index];
    
    return [NSLayoutConstraint constraintWithItem:button
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self.buttonsContainer
                                        attribute:NSLayoutAttributeWidth
                                       multiplier:1.0 / self.buttons.count
                                         constant:0.0];
}


- (NSLayoutConstraint *)leadingLayoutConstraintForIndicator {
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[selectionIndicator]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:@{@"selectionIndicator": self.selectionIndicator}];
    
    return [constraints firstObject];
}


- (NSArray *)widthLayoutConstraintsForIndicator {
    NSDictionary *views = @{@"button": self.buttons[0],
                            @"selectionIndicator": self.selectionIndicator};
    
    return [NSLayoutConstraint constraintsWithVisualFormat:@"[selectionIndicator(==button)]"
                                                   options:0
                                                   metrics:nil
                                                     views:views];
}


- (NSArray *)heightLayoutConstraintsForIndicator {
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectionIndicator(==3)]"
                                                   options:0
                                                   metrics:nil
                                                     views:@{@"selectionIndicator": self.selectionIndicator}];
}


- (NSArray *)bottomLayoutConstraintsForIndicator {
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectionIndicator]-(0)-|"
                                                   options:0
                                                   metrics:nil
                                                     views:@{@"selectionIndicator": self.selectionIndicator}];
}


@end

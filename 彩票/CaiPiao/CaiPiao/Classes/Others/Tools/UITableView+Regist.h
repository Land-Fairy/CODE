//
//  UITableView+Regist.h
//  ChatBubble
//
//

#import <UIKit/UIKit.h>

@interface UITableView (Regist)
/**
 *  这个方法是大神我写的,想用得保证标识符和类名一致
 */
- (void)zy_registNibCell:(Class)aClass;
- (void)zy_registClassCell:(Class)aClass;
@end






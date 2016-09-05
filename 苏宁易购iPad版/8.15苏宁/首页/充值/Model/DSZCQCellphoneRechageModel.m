//
//  DSZCQCellphoneRechageModel.m
//  8.1苏宁ipad
//
//  Created by app20 on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZCQCellphoneRechageModel.h"

@implementation DSZCQCellphoneRechageModel

@synthesize IDNumber,cellphoneNumber,shouldPrice,truePrice,time,state;

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.IDNumber forKey:@"IDNumber"];
    [encoder encodeObject:self.cellphoneNumber forKey:@"cellphoneNumber"];
    [encoder encodeObject:self.shouldPrice forKey:@"shouldPrice"];
    [encoder encodeObject:self.truePrice forKey:@"truePrice"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.state forKey:@"state"];
    
//    [encoderencodeObject:[NSNumber numberWithInt: self.age] forKey:@"age"];
//    
//    [encoderencodeObject:[NSNumber numberWithBool: self.sex] forKey:@"sex"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    if (self = [super init]) {
        
        self.IDNumber = [decoder decodeObjectForKey:@"IDNumber"];
        self.cellphoneNumber = [decoder decodeObjectForKey:@"cellphoneNumber"];
        self.shouldPrice = [decoder decodeObjectForKey:@"shouldPrice"];
        self.truePrice = [decoder decodeObjectForKey:@"truePrice"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.state = [decoder decodeObjectForKey:@"state"];
        
//        self.age =((NSNumber*)[decoderdecodeObjectForKey:@"age"]).intValue;
//        
//        self.sex =((NSNumber*) [decoderdecodeObjectForKey:@"sex"]).boolValue;
        
    }
    
    return self;   
    
}

@end

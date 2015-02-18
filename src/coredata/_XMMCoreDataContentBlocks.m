// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to XMMCoreDataContentBlocks.m instead.

#import "_XMMCoreDataContentBlocks.h"

const struct XMMCoreDataContentBlocksAttributes XMMCoreDataContentBlocksAttributes = {
	.contentBlockType = @"contentBlockType",
	.order = @"order",
	.publicStatus = @"publicStatus",
	.title = @"title",
};

const struct XMMCoreDataContentBlocksRelationships XMMCoreDataContentBlocksRelationships = {
	.content = @"content",
	.contentBlockType0 = @"contentBlockType0",
	.contentBlockType1 = @"contentBlockType1",
	.contentBlockType2 = @"contentBlockType2",
	.contentBlockType3 = @"contentBlockType3",
	.contentBlockType4 = @"contentBlockType4",
	.contentBlockType5 = @"contentBlockType5",
	.contentBlockType6 = @"contentBlockType6",
	.contentBlockType7 = @"contentBlockType7",
	.contentBlockType8 = @"contentBlockType8",
	.contentBlockType9 = @"contentBlockType9",
};

@implementation XMMCoreDataContentBlocksID
@end

@implementation _XMMCoreDataContentBlocks

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"XMMCoreDataContentBlocks" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"XMMCoreDataContentBlocks";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"XMMCoreDataContentBlocks" inManagedObjectContext:moc_];
}

- (XMMCoreDataContentBlocksID*)objectID {
	return (XMMCoreDataContentBlocksID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"orderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"order"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic contentBlockType;

@dynamic order;

- (int16_t)orderValue {
	NSNumber *result = [self order];
	return [result shortValue];
}

- (void)setOrderValue:(int16_t)value_ {
	[self setOrder:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveOrderValue {
	NSNumber *result = [self primitiveOrder];
	return [result shortValue];
}

- (void)setPrimitiveOrderValue:(int16_t)value_ {
	[self setPrimitiveOrder:[NSNumber numberWithShort:value_]];
}

@dynamic publicStatus;

@dynamic title;

@dynamic content;

@dynamic contentBlockType0;

@dynamic contentBlockType1;

@dynamic contentBlockType2;

@dynamic contentBlockType3;

@dynamic contentBlockType4;

@dynamic contentBlockType5;

@dynamic contentBlockType6;

@dynamic contentBlockType7;

@dynamic contentBlockType8;

@dynamic contentBlockType9;

@end


// PFQuery.m
// Copyright 2011 Parse, Inc. All rights reserved.

#import <Foundation/Foundation.h>
#import "PFGeoPoint.h"
#import "PFObject.h"
#import "PFUser.h"

/*!
  A class that defines a query that is used to query for PFObjects.
 */
@interface PFQuery : NSObject {
    NSString *className;
    NSMutableDictionary *where;
    NSMutableArray *include;
    NSNumber *limit;
    NSNumber *skip;
    NSString *order;
    PFCachePolicy cachePolicy;
}

/*!
  The class name to query for
 */
@property (nonatomic, retain) NSString *className;

/*!
  A limit on the number of objects to return.
 */
@property (nonatomic, retain) NSNumber *limit;

/*!
  The number of objects to skip before returning any.
 */
@property (nonatomic, retain) NSNumber *skip;

/*!
  The cache policy to use for requests.
 */
@property (readwrite, assign) PFCachePolicy cachePolicy;

/*!
  A string representing an ordering for the objects returned.
 @deprecated Use orderByAscending: and orderByDescending: instead.
 */
@property (nonatomic, retain) NSString *order;

/*!
  Initializes the query with a class name.
 @param newClassName The class name.
 */
- (id)initWithClassName:(NSString *)newClassName;

/*!
  Sort the results in ascending order with the given key.
 @param key The key to order by.
 */
- (void)orderByAscending:(NSString *)key;

/*!
  Sort the results in descending order with the given key.
 @param key The key to order by.
 */
- (void)orderByDescending:(NSString *)key;

/*!
  Add a where condition to the query.
 @param key The key to search on
 @param object The value to search on.
 @deprecated Use whereKey:equalTo: instead.
 */
- (void)whereObject:(id)object forKey:(NSString *)key __attribute__ ((deprecated));

/*!
  Add a constraint to the query that requires a particular key's object to be equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key equalTo:(id)object;

/*!
  Add a constraint to the query that requires a particular key's object to be less than the provided object.
 @param key The key to be constrained.
 @param object The object that provides an upper bound.
 */
- (void)whereKey:(NSString *)key lessThan:(id)object;

/*!
  Add a constraint to the query that requires a particular key's object to be less than or equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key lessThanOrEqualTo:(id)object;

/*!
  Add a constraint to the query that requires a particular key's object to be greater than the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key greaterThan:(id)object;

/*!
  Add a constraint to the query that requires a particular key's object to be greater than or equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key greaterThanOrEqualTo:(id)object;

/*!
  Add a constraint to the query that requires a particular key's object to be not equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must not be equalled.
 */
- (void)whereKey:(NSString *)key notEqualTo:(id)object;

/*!
  Add a constraint to the query that requires a particular key's object to be contained in the provided array.
 @param key The key to be constrained.
 @param array The possible values for the key's object.
 */
- (void)whereKey:(NSString *)key containedIn:(NSArray *)array;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via PFGeoPoint) be near
 a reference point.  Distance is calculated based on angular distance on a sphere.  Results will be sorted by distance
 from reference point.
 @param key The key to be constrained.
 @param geopoint The reference point.  A PFGeoPoint.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(PFGeoPoint *)geopoint;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via PFGeoPoint) be near
 a reference point and within the maximum distance specified (in miles).  Distance is calculated based on
 a spherical coordinate system.  Results will be sorted by distance (nearest to farthest) from the reference point.
 @param key The key to be constrained.
 @param geopoint The reference point.  A PFGeoPoint.
 @param maxDistance Maximum distance in miles.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(PFGeoPoint *)geopoint withinMiles:(double)maxDistance;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via PFGeoPoint) be near
 a reference point and within the maximum distance specified (in kilometers).  Distance is calculated based on
 a spherical coordinate system.  Results will be sorted by distance (nearest to farthest) from the reference point.
 @param key The key to be constrained.
 @param geopoint The reference point.  A PFGeoPoint.
 @param maxDistance Maximum distance in kilometers.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(PFGeoPoint *)geopoint withinKilometers:(double)maxDistance;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via PFGeoPoint) be near
 a reference point and within the maximum distance specified (in radians).  Distance is calculated based on
 angular distance on a sphere.  Results will be sorted by distance (nearest to farthest) from the reference point.
 @param key The key to be constrained.
 @param geopoint The reference point.  A PFGeoPoint.
 @param maxDistance Maximum distance in radians.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(PFGeoPoint *)geopoint withinRadians:(double)maxDistance;

/*!
 Make the query include PFObjects that have a reference stored at the provided key.
 This has an effect similar to a join.
 @param key The key to load child PFObjects for.
 */
- (void)includeKey:(NSString *)key;

/*!
  Finds objects based on the constructed query.
 @result Returns an array of PFObjects that were found.
 */
- (NSArray *)findObjects;

/*!
  Finds objects based on the constructed query and sets an error if there was one.
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns an array of PFObjects that were found.
 */
- (NSArray *)findObjects:(NSError **)error;

/*!
  Finds objects asynchronously and calls the given callback with the results.
 @param target The object to call the selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSArray *)result error:(NSError *)error. result will be nil if error is set and vice versa.
 */
- (void)findObjectsInBackgroundWithTarget:(id)target selector:(SEL)selector;

/*!
  Counts objects based on the constructed query.
 @result Returns the number of PFObjects that match the query, or -1 if there is an error.
 */
- (NSInteger)countObjects;

/*!
  Counts objects based on the constructed query and sets an error if there was one.
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns the number of PFObjects that match the query, or -1 if there is an error.
 */
- (NSInteger)countObjects:(NSError **)error;

/*!
  Counts objects asynchronously and calls the given callback with the count.
 @param target The object to call the selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSNumber *)result error:(NSError *)error. */
- (void)countObjectsInBackgroundWithTarget:(id)target selector:(SEL)selector;

/*!
  Returns a PFObject with the given id.
 @param objectId The id of the object that is being requested.
 @result The PFObject if found. Returns nil if the object isn't found, or if there was an error.
 */
- (PFObject *)getObjectWithId:(NSString *)objectId;

/*!
  Returns a PFObject with the given id and sets an error if necessary.
 @param error Pointer to an NSError that will be set if necessary.
 @result The PFObject if found. Returns nil if the object isn't found, or if there was an error.
 */
- (PFObject *)getObjectWithId:(NSString *)objectId error:(NSError **)error;

/*!
  Gets a PFObject asynchronously.
 @param objectId The id of the object being requested.
 @param target The target for the callback selector.
 @param selector The selector for the callback. It should have the following signature: (void)callbackWithResult:(PFObject *)result error:(NSError *)error. result will be nil if error is set and vice versa.
 */
- (void)getObjectInBackgroundWithId:(NSString *)objectId target:(id)target selector:(SEL)selector;

/*!
  Returns a PFObject with a given class and id.
 @param objectClass The class name for the object that is being requested.
 @param objectId The id of the object that is being requested.
 @result The PFObject if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (PFObject *)getObjectOfClass:(NSString *)objectClass objectId:(NSString *)objectId;

/*!
  Returns a PFObject with a given class and id and sets an error if necessary.
 @param error Pointer to an NSError that will be set if necessary.
 @result The PFObject if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (PFObject *)getObjectOfClass:(NSString *)objectClass objectId:(NSString *)objectId error:(NSError **)error;

/*!
  Returns a PFQuery for a given class.
 @param className The class to query on.
 @return A PFQuery object.
 */
+ (PFQuery *)queryWithClassName:(NSString *)className;

/*!
  Returns a PFUser with a given id.
 @param objectId The id of the object that is being requested.
 @result The PFUser if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (PFUser *)getUserObjectWithId:(NSString *)objectId;

/*!
  Returns a PFUser with a given class and id and sets an error if necessary.
 @param error Pointer to an NSError that will be set if necessary.
 @result The PFUser if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (PFUser *)getUserObjectWithId:(NSString *)objectId error:(NSError **)error;

/*!
  Returns a PFQuery for a PFUser.
 @return A PFQuery object.
 */
+ (PFQuery *)queryForUser;

/*!
  Finds objects asynchronously and calls the given block with the results.
 @param block The block to execute. The block should have the following argument signature:(NSArray *objects, NSError *error) 
 */
- (void)findObjectsInBackgroundWithBlock:(PFArrayResultBlock)block;

/*!
  Counts objects asynchronously and calls the given block with the counts.
 @param block The block to execute. The block should have the following argument signature:
      (int count, NSError *error) 
 */
- (void)countObjectsInBackgroundWithBlock:(PFIntegerResultBlock)block;

/*!
  Gets a PFObject asynchronously and calls the given block with the result. 
 @param block The block to execute. The block should have the following argument signature: (NSArray *object, NSError *error)
 */
- (void)getObjectInBackgroundWithId:(NSString *)objectId block:(PFObjectResultBlock)block;

@end

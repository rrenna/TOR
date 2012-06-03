//
//  SGTipController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-11-30.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGTipController.h"
#import "Parse/Parse.h"

@interface SGTipController()
-(IBAction)voteUp:(id)sender;
-(IBAction)voteDown:(id)sender;
@end

@implementation SGTipController
@synthesize parseType,entityName,tips,tableView,parentViewController;

-(id)init
{
    self = [super init];
    if(self)
    {
        self.tips = [NSArray array];
    }
    return self;
}
-(void)dealloc
{
    [parseType release];
    [entityName release];
    [tips release];
    [super dealloc];
}
-(void)getTips
{
    PFQuery* tipQuery = [PFQuery queryWithClassName:self.parseType];
    [tipQuery whereKey:@"Entity" equalTo:self.entityName];
    [tipQuery orderByDescending:@"Vote"];
    
    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) 
     {
         self.tips = objects;
         [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
     }];
}
-(void)submit
{
    //Submit Tip
    void(^displaySubmitTipDialog)() = ^()
    {  
        SGSubmitTipViewController* submitTipController = [SGSubmitTipViewController new];
        submitTipController.delegate = self;
        [parentViewController presentModalViewController:submitTipController animated:YES];
        [submitTipController release];
    };

    PFUser *currentUser = [PFUser currentUser];
    if(!currentUser)
    {
        NSArray* permissions = [NSArray array];
        [PFUser logInWithFacebook:permissions block:^(PFUser *user, NSError *error) 
         {
             BOOL proceed = YES;
             if (!user) 
             {
                 NSLog(@"Uh oh. The user cancelled the Facebook login.");
                 proceed = NO;
             } 
             else if (user.isNew) 
             {
                 NSLog(@"User with facebook id %@ signed up and logged in!", user.facebookId);
             } 
             else 
             {
                 NSLog(@"User with facebook id %@ logged in!", user.facebookId);
             }
             
             [user save];
      
             if(proceed)  displaySubmitTipDialog();
             
         }];
    }
    else
    {
        displaySubmitTipDialog();
    }
}
#pragma mark - Private methods
-(IBAction)voteUp:(id)sender
{
    int index = [sender tag] - 1;
    PFObject* tip = [self.tips objectAtIndex:index];
    [tip incrementKey:@"Vote" byAmount:[NSNumber numberWithInt:1]];
    [tip save];
}
-(IBAction)voteDown:(id)sender
{
    int index = [sender tag] - 1;
    PFObject* tip = [self.tips objectAtIndex:index];
    
    int currentVote = 0;
    NSNumber* voteNumber = [tip objectForKey:@"Vote"];
    if(voteNumber) { currentVote = [voteNumber intValue]; } 
    
    //Only decrease Vote if above zero
    if(currentVote > 0)
    {
        [tip incrementKey:@"Vote" byAmount:[NSNumber numberWithInt:-1]];
        [tip save];
    }
}
#pragma mark - UITableView Delegate & Datasource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MAX( 2, 1 + [tips count]);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#define HEIGHT_FOR_DIVIDER 40
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //First section has no header
    if(section == 0) return 0;
    
    return HEIGHT_FOR_DIVIDER;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    //First section has no header
    if(section == 0) return nil;
    
    UIImageView* dividerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_FOR_DIVIDER)] autorelease];
    dividerView.image = [UIImage imageNamed:@"divider.png"];
    dividerView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel* dividerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(13, 0, 215, HEIGHT_FOR_DIVIDER)] autorelease];
    dividerLabel.backgroundColor = [UIColor clearColor];
    dividerLabel.textColor = [UIColor darkGrayColor];
    dividerLabel.shadowColor = [UIColor whiteColor];
    dividerLabel.shadowOffset = CGSizeMake(0,1);
    [dividerView addSubview:dividerLabel];
    
    UILabel* voteLabel  = [[[UILabel alloc] initWithFrame:CGRectMake(240, 0, 85, HEIGHT_FOR_DIVIDER)] autorelease];
    voteLabel.backgroundColor = [UIColor clearColor];
    voteLabel.textColor = [UIColor darkGrayColor];
    voteLabel.shadowColor = [UIColor whiteColor];
    voteLabel.shadowOffset = CGSizeMake(0,1);
    voteLabel.font = [UIFont systemFontOfSize:12];
    [dividerView addSubview:voteLabel];
    
    if([tips count] == 0) 
    { 
        dividerLabel.text = @"No tips submitted"; 
    }
    else
    {
        PFObject* tip = [self.tips objectAtIndex:section - 1];
        NSString* title = [tip objectForKey:@"Title"];
        dividerLabel.text = title;
        
        NSNumber* vote = [tip objectForKey:@"Vote"];
        NSString* voteDisplayCount = vote ? [vote stringValue] : @"0";
        voteLabel.text = [NSString stringWithFormat:@"Rating : %@", voteDisplayCount ];
    }

    return dividerView;
}
#define CELL_HEIGHT 45
#define CELL_TITLE_FONT @"Helvetica"
#define CELL_TITLE_SIZE 14
#define CELL_BODY_FONT @"Helvetica"
#define CELL_BODY_SIZE 14
#define CELL_BODY_LINE_BREAK_MODE UILineBreakModeWordWrap
#define HEIGHT_OF_TITLE 30
#define HEIGHT_OF_BUTTON 46
#define CELL_CONTENT_SEPERATOR_PADDING 20
static int heightOfBody(NSString* body)
{
    UIFont *myFont = [UIFont fontWithName:CELL_BODY_FONT size:CELL_BODY_SIZE];
    CGSize bodySize = [body sizeWithFont:myFont 
                                             constrainedToSize:CGSizeMake(300, 9999) 
                                                 lineBreakMode:CELL_BODY_LINE_BREAK_MODE];
    
    return bodySize.height;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Submit button
    if(indexPath.section == 0)
    {
        return CELL_HEIGHT + 4;
    }
    else
    {
        if([tips count] == 0) { return HEIGHT_OF_TITLE; }
        
        PFObject* tip = [self.tips objectAtIndex:indexPath.section - 1];
        return HEIGHT_OF_BUTTON + CELL_CONTENT_SEPERATOR_PADDING + heightOfBody([tip objectForKey:@"Body"]);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Submit button
    if(indexPath.section == 0)
    {
        UIButton* submitButton = [[[UIButton alloc] initWithFrame:CGRectMake(88, 5, 144, HEIGHT_OF_BUTTON)] autorelease];
        [submitButton setBackgroundImage:[UIImage imageNamed:@"ConfirmButton"] forState:UIControlStateNormal];
        [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:submitButton];
    }
    //No Tips cell
    else if([tips count] == 0)
    {
        cell.textLabel.text = @"There are no tips yet. Be the first to add one!";
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    else
    {
        PFObject* tip = [self.tips objectAtIndex:indexPath.section - 1];
        cell.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
        
        NSString* body = [tip objectForKey:@"Body"];
        UILabel* bodyLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, heightOfBody(body))] autorelease];
        bodyLabel.backgroundColor = [UIColor clearColor];
        bodyLabel.textColor = [UIColor lightGrayColor];
        bodyLabel.shadowColor = [UIColor darkGrayColor];
        bodyLabel.shadowOffset = CGSizeMake(0, 1);
        bodyLabel.font = [UIFont fontWithName:CELL_BODY_FONT size:CELL_BODY_SIZE];
        bodyLabel.lineBreakMode = CELL_BODY_LINE_BREAK_MODE;
        bodyLabel.numberOfLines = 0;
        bodyLabel.text = body;
        
        [cell.contentView addSubview:bodyLabel];
        
        UIButton* likeButton = [[[UIButton alloc] initWithFrame:CGRectMake(16,CELL_CONTENT_SEPERATOR_PADDING + bodyLabel.frame.size.height, 144, HEIGHT_OF_BUTTON)] autorelease];
        [likeButton setBackgroundImage:[UIImage imageNamed:@"ConfirmButton"] forState:UIControlStateNormal];
        [likeButton setTitle:@"Like" forState:UIControlStateNormal];
        [likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [likeButton addTarget:self action:@selector(voteUp:) forControlEvents:UIControlEventTouchUpInside];
        likeButton.tag = indexPath.section;
        
        [cell.contentView addSubview:likeButton];
        
        UIButton* dislikeButton = [[[UIButton alloc] initWithFrame:CGRectMake(10 + 144,CELL_CONTENT_SEPERATOR_PADDING + bodyLabel.frame.size.height, 144, HEIGHT_OF_BUTTON)] autorelease];
        [dislikeButton setBackgroundImage:[UIImage imageNamed:@"ConfirmButton"] forState:UIControlStateNormal];
        [dislikeButton setTitle:@"Dislike" forState:UIControlStateNormal];
        [dislikeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [dislikeButton addTarget:self action:@selector(voteDown:) forControlEvents:UIControlEventTouchUpInside];
        dislikeButton.tag = indexPath.section;
        
        [cell.contentView addSubview:dislikeButton];
    }

    return cell;
}
#pragma mark -SGSubmitTipViewDelegate methods
-(void)submitTipControllerDidCancel:(SGSubmitTipViewController*)submitTipController
{
    [submitTipController dismissModalViewControllerAnimated:YES];
}
#define FILTERED_WORDS_COUNT 451
static NSString* filteredWords[FILTERED_WORDS_COUNT] = {@"ahole",@"anus",@"ash0le",@"ash0les",@"asholes",@"Ass Monkey",@"Assface",@"assh0le",@"assh0lez",@"asshole",@"assholes",@"assholz",@"asswipe",@"azzhole",@"bassterds",@"bastard",@"bastards",@"bastardz",@"basterds",@"basterdz",@"Biatch",@"bitch",@"bitches",@"Blow Job",@"boffing",@"butthole",@"buttwipe",@"c0ck",@"c0cks",@"c0k",@"Carpet Muncher",@"cawk",@"cawks",@"Clit",@"cnts",@"cntz",@"cock",@"cockhead",@"cock-head",@"cocks",@"CockSucker",@"cock-sucker",@"crap",@"cum",@"cunt",@"cunts",@"cuntz",@"dick",@"dild0",@"dild0s",@"dildo",@"dildos",@"dilld0",@"dilld0s",@"dominatricks",@"dominatrics",@"dominatrix",@"dyke",@"enema",@"f u c k",@"f u c k e r",@"fag",@"fag1t",@"faget",@"fagg1t",@"faggit",@"faggot",@"fagit",@"fags",@"fagz",@"faig",@"faigs",@"fart",@"flipping the bird",@"fuck",@"fucker",@"fuckin",@"fucking",@"fucks",@"Fudge Packer",@"fuk",@"Fukah",@"Fuken",@"fuker",@"Fukin",@"Fukk",@"Fukkah",@"Fukken",@"Fukker",@"Fukkin",@"g00k",@"gay",@"gayboy",@"gaygirl",@"gays",@"gayz",@"God-damned",@"h00r",@"h0ar",@"h0re",@"hells",@"hoar",@"hoor",@"hoore",@"jackoff",@"jap",@"japs",@"jerk-off",@"jisim",@"jiss",@"jizm",@"jizz",@"knob",@"knobs",@"knobz",@"kunt",@"kunts",@"kuntz",@"Lesbian",@"Lezzian",@"Lipshits",@"Lipshitz",@"masochist",@"masokist",@"massterbait",@"masstrbait",@"masstrbate",@"masterbaiter",@"masterbate",@"masterbates",@"Motha Fucker",@"Motha Fuker",@"Motha Fukkah",@"Motha Fukker",@"Mother Fucker",@"Mother Fukah",@"Mother Fuker",@"Mother Fukkah",@"Mother Fukker",@"mother-fucker",@"Mutha Fucker",@"Mutha Fukah",@"Mutha Fuker",@"Mutha Fukkah",@"Mutha Fukker",@"n1gr",@"nastt",@"nigger;",@"nigur;",@"niiger;",@"niigr;",@"orafis",@"orgasim;",@"orgasm",@"orgasum",@"oriface",@"orifice",@"orifiss",@"packi",@"packie",@"packy",@"paki",@"pakie",@"paky",@"pecker",@"peeenus",@"peeenusss",@"peenus",@"peinus",@"pen1s",@"penas",@"penis",@"penis-breath",@"penus",@"penuus",@"Phuc",@"Phuck",@"Phuk",@"Phuker",@"Phukker",@"polac",@"polack",@"polak",@"Poonani",@"pr1c",@"pr1ck",@"pr1k",@"pusse",@"pussee",@"pussy",@"puuke",@"puuker",@"queer",@"queers",@"queerz",@"qweers",@"qweerz",@"qweir",@"recktum",@"rectum",@"retard",@"sadist",@"scank",@"schlong",@"screwing",@"semen",@"sex",@"sexy",@"Sh!t",@"sh1t",@"sh1ter",@"sh1ts",@"sh1tter",@"sh1tz",@"shit",@"shits",@"shitter",@"Shitty",@"Shity",@"shitz",@"Shyt",@"Shyte",@"Shytty",@"Shyty",@"skanck",@"skank",@"skankee",@"skankey",@"skanks",@"Skanky",@"slut",@"sluts",@"Slutty",@"slutz",@"son-of-a-bitch",@"tit",@"turd",@"va1jina",@"vag1na",@"vagiina",@"vagina",@"vaj1na",@"vajina",@"vullva",@"vulva",@"w0p",@"wh00r",@"wh0re",@"whore",@"xrated",@"xxx",@"b!+ch",@"bitch",@"blowjob",@"clit",@"arschloch",@"asshole",@"b!tch",@"b17ch",@"b1tch",@"bastard",@"bi+ch",@"boiolas",@"buceta",@"c0ck",@"cawk",@"chink",@"cipa",@"clits",@"cock",@"cum",@"cunt",@"dildo",@"dirsa",@"ejakulate",@"fatass",@"fcuk",@"fuk",@"fux0r",@"hoer",@"hore",@"jism",@"kawk",@"l3itch",@"l3i+ch",@"lesbian",@"masturbate",@"masterbat",@"masterbat3",@"motherfucker",@"s.o.b.",@"mofo",@"nazi",@"nigga",@"nigger",@"nutsack",@"phuck",@"pimpis",@"pusse",@"pussy",@"scrotum",@"sh!t",@"shemale",@"slut",@"smut",@"teets",@"tits",@"boobs",@"b00bs",@"teez",@"testical",@"testicle",@"titt",@"w00se",@"jackoff",@"wank",@"whoar",@"whore",@"dyke",@"fuck",@"shit",@"@$$",@"amcik",@"andskota",@"arse*",@"assrammer",@"ayir",@"bi7ch",@"bitch*",@"bollock*",@"breasts",@"butt-pirate",@"cabron",@"cazzo",@"chraa",@"chuj",@"Cock*",@"cunt*",@"d4mn",@"daygo",@"dego",@"dick*",@"dike*",@"dupa",@"dziwka",@"ejackulate",@"Ekrem*",@"Ekto",@"enculer",@"faen",@"fag*",@"fanculo",@"fanny",@"feces",@"feg",@"Felcher",@"ficken",@"fitt*",@"Flikker",@"foreskin",@"Fotze",@"Fu(*",@"fuk*",@"futkretzn",@"gay",@"gook",@"guiena",@"h0r",@"h4x0r",@"hell",@"helvete",@"hoer*",@"honkey",@"Huevon",@"hui",@"injun",@"jizz",@"kanker*",@"kike",@"klootzak",@"kraut",@"knulle",@"kuk",@"kuksuger",@"Kurac",@"kurwa",@"kusi*",@"kyrpa*",@"lesbo",@"mamhoon",@"masturbat",@"merd",@"mibun",@"monkleigh",@"mouliewop",@"muie",@"mulkku",@"muschi",@"nazis",@"nepesaurio",@"nigger*",@"orospu",@"paska*",@"perse",@"picka",@"pierdol*",@"pillu*",@"pimmel",@"piss*",@"pizda",@"poontsee",@"poop",@"porn",@"p0rn",@"pr0n",@"preteen",@"pula",@"pule",@"puta",@"puto",@"qahbeh",@"queef*",@"rautenberg",@"schaffer",@"scheiss*",@"schlampe",@"schmuck",@"screw",@"sh!t*",@"sharmuta",@"sharmute",@"shipal",@"shiz",@"skribz",@"skurwysyn",@"sphencter",@"spic",@"spierdalaj",@"splooge",@"suka",@"b00b*",@"testicle",@"titt",@"twat",@"vittu",@"wank*",@"wetback",@"wichser",@"wop",@"yed",@"zabourah"};

-(void)submitTipControllerDidSubmit:(SGSubmitTipViewController*)submitTipController
{
    NSString* tipTitle = submitTipController.titleTextField.text;
    NSString* tipBody = submitTipController.textView.text;
    
    //Validation
    BOOL valid = YES;
    NSString* invalidReason;
    
    if(!tipTitle || [tipTitle length] < 5)
    {
        invalidReason = @"Title is too short.";
        valid = NO;
    }
    else if(!tipBody || [tipBody length] < 10)
    {
        invalidReason = @"Tip is too short.";
        valid = NO;
    }
    else
    {
        BOOL containsFilteredWords = NO;
        for(int i=0;i < FILTERED_WORDS_COUNT;i++)
        {
            if([tipBody rangeOfString:filteredWords[i] options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                containsFilteredWords = YES;
                break;
            }
        }
        
        if(containsFilteredWords)
        {
            invalidReason = @"Contain inappropriate words.";
            valid = NO;
        }
    }
    
    if(valid)
    {
        PFObject *tip = [PFObject objectWithClassName:parseType];
        [tip setObject:entityName forKey:@"Entity"];
        [tip setObject:tipTitle forKey:@"Title"];
        [tip setObject:tipBody forKey:@"Body"];
        [tip setObject:[NSNumber numberWithInt:0] forKey:@"Vote"];
        
        [tip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) 
        {
            NSLog(@"%@",error);
                //TODO: Display popup (with gradient)
        }];
        
        [submitTipController dismissModalViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView* invalidAlert = [[UIAlertView alloc] initWithTitle:@"" message:invalidReason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalidAlert show];
        [invalidAlert release];
    }
}
@end


//
//  SGNameGeneratorViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGNameGeneratorViewController.h"

@interface SGNameGeneratorViewController ()
-(void)populateFormats;
-(NSString*)generateNameForMale;
-(NSString*)generateNameForFemale;
-(NSString*)generateNameForWithFormats:(NSArray*)formats;
@end

@implementation SGNameGeneratorViewController
@synthesize previousNames;

#pragma mark - View lifecycle
-(id)init
{
    self = [self initWithNibName:@"SGNameGeneratorViewController" bundle:nil];
    if(self)
    {
        self.title = @"Name Generator";
        self.previousNames = [NSMutableArray array];
        maleNames = YES;
        [self populateFormats];
    }
    return self;
}
-(void)dealloc
{    
    [maleNameFormats release];
    [femaleNameFormats release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    [shareButton release];
}

#pragma mark - IBActions
-(IBAction)generate:(id)sender
{
    NSString* name = (maleNames) ? [self generateNameForMale] :  [self generateNameForFemale];
    [previousNames insertObject:name atIndex:0]; //Record name in history
    nameLabel.text = name;
    [tableView reloadData]; //Reload table, currently displayed name will now appear in history
    
}
-(IBAction)switchGender:(id)sender
{
    maleNames = !maleNames;
}
#define ACTION_SHARE @"Share"
#define ACTION_REPORT_ERROR @"Report Error"
//Opens an action sheet, presenting various sharing options 
-(IBAction)share:(id)sender
{
    UIActionSheet* shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:ACTION_SHARE, nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [shareActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

-(IBAction)emailNames:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
        mailComposeController.mailComposeDelegate = self;
        
        NSString* subject = @"My Generated Names from T.O.R. Codex";
        NSMutableString* body = [NSMutableString stringWithString:@"<html><body><i>I've generated some names that will fit right into The Old Republic.</i></br><br/><table>"];
        
        for(NSString* name in previousNames)
        {
            [body appendFormat:@"<tr><td>%@</td></tr>",name];
        }
        
        [body appendString:@"</table></div><br/><div><i>Get the ultimate Old Republic database, in the palm of your hand. <b>T.O.R. Codex</b> is avaliable on iOS now!</i><br/><br/><a href='http://itunes.apple.com/app/t.o.r.-guide/id463743698?mt=8'><img src='https://developer.apple.com/appstore/images/as_available_appstore_icon_20091006.png'/></a></div></body></html>"];
        
        [mailComposeController setSubject:subject];
        [mailComposeController setMessageBody:body isHTML:YES];
        [self presentModalViewController:mailComposeController animated:YES];

    }
    else
    {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You don't seem to have an email address setup on this device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
        [alert show];
    }
}
#pragma mark - Private Methods
-(void)populateFormats
{    
    //*v* = vowel
    //*s* = special character ' or <space> or - or <nothing>
    //*z* = can be a 'z' or an 's'
    maleNameFormats = [[NSArray arrayWithObjects:@"C*s**v*ph*v*er F*v*rb*v*rt",@"M*v*lc*v*lm D*v*lg*v**z*",@"N*v**v*l*v* Fl*v*t*v*",@"L*v**v* N*v*j*v*q*v**v*",@"W*s**v*g H*v*rt",@"Z*v*k Cr*v*w",@"St*v*ph*v*n *v*r*v**v*n",@"K*v*l*v*n S*v*rt*v*sk*v*",@"P*v*kk*v* L*v**v*k*v*",@"*v**v*r*v*n L*v*p*v*st",@"D*v*vr*v*n F*v*lst*v*m",@"L*v*mb*v*d*v* G*v*th*v*r*v*",@"St*v*ph*v*n Mckn*v*ght",@"R*v**v*l M*v*rr*v*w",@"L*v*wdg*v*tt Ty*v*th",@"*v*b*v*r*v*n Th*v*r*v*nd*v*n",@"G*v*r*v*k *v*r*v*l*v*n",@"*v*r*v*m*v*s C*v**v*ns*v*l",@"H*v*ff Wr*v*tt*v*",@"*v*th*v*n S*v*m*v*ck",@"Br*v*n Pr*v*n*v*",@"K*v*r S*v*r*v*t*v*",@"S*v**v*r T*v* Rh*v**v*",@"P*v**v*rs*v*n Sc*v*t*v*",@"L*v*v*v*d*v**v*n *v*lm*v*st*v*n",@"S*v*th J*v*r*v*l",@"V*v*sl*v*r Str*v*ng",@"D*v*v*v*d T*v*rs*v*",@"*v*m*v*r*v*nt M*v*r*v*ns*v*",@"J*v*n*v*s P*v*ndr*v*h*v*n",@"*v*nr*v*c G*v*nn",@"G*v*rd*v*n K*s**v*yl*v*",@"D*v**v*s *v*dr*v**v*n",@"D*v**v*tr*v*ch S*v*l*v*n",@"J*v*ns*v**v*k Gr*v*mb",@"L*v*c*v**v*s Gr*v*nt*v*",@"L*v**v* Th*v*n*v*",@"*v*th*v*n Th*v*n*v*w*v*lf",@"R*v*w*v*n  G*v*dr*v**v*l",@"J*v*rc H*v*ns*v*l",@"M*v*r*v**v*n C*v*r*v*l",@"K*v*sch*v* Syp*v*kn*v*",@"X*s*j*v*n S*v*b*v*sk",@"J*v*pl*v* *v*sh",@"W*v*v*v*rn N*v*m*v*r*v*",@"R*v*ssh*v*k *v*t*v*m",@"Fl*v*r*v**v*n Gr*v*l",@"J*v*s*v* R*v*th",@"Q*v**v*n Ch*v*cr*v*",@"*v*r*v*t M*v*rkyl*v*",@"V*v*sl*v*r R*v*d*v**v**v*n",@"B*v*r*v*k R*v*st",@"K*v*m *v*b*v*rl*v*",@"V*v*l*v*k K*v**v*n*v**v*n",@"K*v**v*r C*v*nv*v*r*v**v*n",@"*v*gn*v*v F*v*tz*v*k*v*tz*v*",@"S*v*rl P*v*g",@"*v*l*v*x H*v*lk*v*sh",@"R*v*sh*v* S*v*lz*v*n",@"Q*v**v*n*v* Sw*v*ft",@"Sn*v*rh C*v*r*v*ly",@"*v*nth*v*ny C*v**v*lg*v*n",@"B*v*ll*v*k *v*ng*v*v*v*l",@"C*v*rl N*v*z*v*",@"*v*s*s*k*v*l G*v*l*v*c",@"Sl*v*v*v**v*n K*v*l*v*'myr",@"B*v*n*v*l R*v**v*d*v*r",@"F*v*b*v**v*n  H*v*rd*v*n",@"Th*v**v*m*v*n T*v**v*b",@"R*v*b M*v*rn*v*th",@"D*v*lz*v*  P*v*ndr*v*h*v*n",@"H*v*l K*v*r",@"S*v*l*v*s R*v*ct*v*",@"*v*lm*v*r B*v*n*v*",@"*v*k*v*l*v* C*v*rr",@"V*v*ct*v*r D?*s**v*r*v*z*v**v*",@"*v**v*t M*v*r*v*n*v*k*v*r",@"S*v**v*t B*v*nt*v*ghr",@"K*v*ll T*v*lz*v*k",@"S*v*g*v*r Dr*v*m*v*",@"*v*l*v*r*v*nd R*v*v*v*nl*v*ck*v*",@"Myth*v*s *v*nj*v*k",@"N*v*c*v*d*v*m*v*s V*v*r*v*sx",@"J*v**v*k *v*nt*v*ll*v*s",@"*v**v*lr*v**v*n*v* J*v*s*v*l*v*d*v**v*",@"M*v*rn*v*g *v*r*v**v*l*v*s",@"Br*v*ll G*v*ld*v*nb*v*r",@"V*v*r*v*n B*v*j*v*ld",@"F*v**v*s K*v*l*v*m*v**v*",@"K*v*m*v**v*s F*v*lkr*v*w*v*",@"D*v*k M*v*m*v*m",@"C*v*tt*v*r T*z**v*r",@"D*v*rn Cynth*v*s*v*",@"K*v*v*v* Tr*v**v*ld",@"B*v*n*v* *v*b*v*nv*v*r",@"*v*m*v*y D*v*m*v*n*v*",@"R*v*c-X*v*n*v* S*v*r*v*s",@"N*v*rw*v*n S*v*yl*v*n",@"*v*tt*v*g*v*r S*v*ms",@"C*v*l*v* J*v*lb*v**z**v*", nil] retain];
    femaleNameFormats = [[NSArray arrayWithObjects: @"Sun*v* Doof*v*",@"Cheriss D*v*em*v*n",@"Shernis*v* *v*sh*v*k*v*hw*v*",@"Sh*v*ll*v* Bix*v*-L*v*c*v*",@"Vosc*v* B*v*onte",@"Tyl*v* Geilvt*v*",@"J*v*in*v* M*v*rinik*v*r",@"Br*v*n*v*d*v* Sel*v*nn*v*",@"*z*or*v*s M*v*kin*v*n",@"L*v*ssey*v* H*v*rk*v*r",@"Vort*v* Bel*v*",@"M*v*r*v* Els*v*n",@"Bri C*v*m*v*s*v*u",@"Pin*v*ci*v* Em*v*l*v*",@"Sulen V*v*nce",@"*v*erith Ferobo",@"J*v*ir*v* V*s**v*nt*v*i",@"Lir*s**v*t*v* Dr*v*k*v*r",@"K*v*ll*v* S*v*rn",@"Yvette Botos",@"Emily Forb*v*rt",@"Connie Br*v*ndt",@"Row*v*n*v*  Shmo",@"Kid*v* Rether*v*",@"Orcin*v* En*z*",@"G*v*eriel K*v*pporr*v*",@"Teler*v* *v*nt*v*res",@"*v*lysi*v* V*v*sch",@"Sh*v*dr*v* Ordo",@"Kryst*v*h W*v*rner",@"Syn*v* Tero*v*l*v**v*s",@"*v**z**v*lyn Ni*z**z*re",@"Keelu K*v*yle",@"*v*ugust M*v*lric",@"L*v*r*v* Kerosine",@"Bobi  Th*v*ne",@"Sw*v*-Lu Fit*z*im",@"J*v*in*v* Sivron",@"Kiyfi Fry",@"*v*ugust H*s**v*mor",@"*v*klee *v*ne*z*",@"Esli Defelice",@"L*v**v*ri C*v*llipso",@"Hoosh*v* Bokete",@"Jory*v* Drii",@"V*v*l M*v*tt",@"Quelli*v* F*v*lc*v*n*v*r",@"*v**v*m*v* Rem*v*x",@"T'R*v*ni  L*v*st*v*r",@"G*v*l*v*te*v* Sev*v*n*v*r",@"Josephine Rom*v*nsk*v*",@"Vex*v* Cunh*v*",@"Ree *v*rden",@"Nov*v*l T*v*i",@"Selonn*v* L'hnn*v*r",@"Eour*v* Svung",@"Sh*v*neek*v* Cl*v*ermoore",@"Onn*v* D*v* Res",@"*v*ny*v* Steveus",@"J*v*uh*z*mynn Get*z*",@"*z*enie M*v*reel",@"*z*yri*v*s Ev*v*s",@"Milk*v* Rostoni",@"Oyun*v* *v*dr*v*m*s*ssi*v*",@"Oon*v* M*v*ch*v*do",@"Bot H*v*new",@"D*v*rrin*v* Nov*v*r",@"M*v*ureen H*v*yes",@"L*v*h*v*ni T*v*iner",@"Miw*v* Pell",@"*v*yv*v* Tull",@"J*v*smine Vuusen",@"Kitt*v*ni *v*fric",@"Frey*v* Mind*v*r",@"Leil*v*ni K*v*ss*v*l",@"*v*yumi Deeni*v*",@"D*v*nni Gr*v*yh*v*lm",@"Miw*v* Th*v*lk*v*rti",@"Kitt*v*ni *v**s*vun",@"Lun*v* K*v*llos",@"L*v*uren Dr*v*y*v*n",@"*v**v*ri K*v*ll*v*s",@"V*v*rin*v* G*v*nn",@"Linor*v* Ev*v*rbright",@"M*v*ris L*v*rim*v*re",@"D*v*ll*v* Bl*v*th",@"Quelli*v* B*v*rdok",@"*v*shlyn M*v*ntr*v*se",@"Edr*v*si Sl*v*rg*v*",@"R*v*ilin C*v*ndroon",@"Ki*v*ndr*v* Sev*v*n*v*r",@"Ethe*v* Th*v*xton",@"Eevy Morel*v*nd",@"S*v**v*ni *v*n*s*dromi*v*s",@"K*v*yd*v* Er*v*s",@"Cor*v*n*v* Ment*z*er",@"S*v*l*v* *v*ndromi*v*s",@"K*v*reb*v*n Lee",@"Bemere H*v*nnic*v*",@"Kit Lope*z*"  , nil] retain];
}
-(NSString*)generateNameForMale
{
    return [self generateNameForWithFormats:maleNameFormats];
}
-(NSString*)generateNameForFemale
{
    return [self generateNameForWithFormats:femaleNameFormats];
}
-(NSString*)generateNameForWithFormats:(NSArray*)formats
{
    int index = rand() % [formats count];
    NSMutableString* name = [[formats objectAtIndex:index] mutableCopy];
    
    static int numberOfVowels = 5;
    static int numberOfSpecials = 5;
    static NSString* vowels[] = {@"a",@"e",@"i",@"o",@"u"};
    static NSString* specials[] = {@" ",@"-",@"'",@"",@""};//The <blank> character appears twice as it should come up more often
    static NSString* zOrS[] = {@"z",@"s"};
    
    //Find all vowel replacements, and replace with random vowel
    NSRange rangeOfVowelReplacement;
    do 
    {
        rangeOfVowelReplacement = [name rangeOfString:@"*v*"];
        if(rangeOfVowelReplacement.length != 0)
        {
            int indexOfVowel = rand() % numberOfVowels;
            [name replaceCharactersInRange:rangeOfVowelReplacement withString:vowels[indexOfVowel]];
        }
        
    } while (rangeOfVowelReplacement.length != 0);
    
    //Find all special character replacements, and replace with special character
    NSRange rangeOfSpecialReplacement;
    do 
    {
        rangeOfSpecialReplacement = [name rangeOfString:@"*s*"];
        if(rangeOfSpecialReplacement.length != 0)
        {
            int indexOfSpecial = rand() % numberOfSpecials;
            [name replaceCharactersInRange:rangeOfSpecialReplacement withString:specials[indexOfSpecial]];
        }
        
    } while (rangeOfSpecialReplacement.length != 0);
    
    //Find all places which can be replaced by a 'z' or an 's', and replace with either
    NSRange rangeOfZorSReplacement;
    do 
    {
        rangeOfZorSReplacement = [name rangeOfString:@"*z*"];
        if(rangeOfZorSReplacement.length != 0)
        {
            int indexOfZorS = rand() % 2;
            [name replaceCharactersInRange:rangeOfZorSReplacement withString:zOrS[indexOfZorS]];
        }
        
    } while (rangeOfZorSReplacement.length != 0);
         
    return [name autorelease];
}
#pragma mark - UITableView Datasource & Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [previousNames count];
}
#define HEIGHT_FOR_ROW 30
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FOR_ROW;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //Email Name
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString* name = [previousNames objectAtIndex:indexPath.row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    cell.textLabel.shadowOffset = CGSizeMake(0,1);
    cell.textLabel.shadowColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.text = name;

    return cell;
}
#pragma mark - UIActionSheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    //Share
    if([buttonTitle isEqualToString:ACTION_SHARE])
    {
        [self emailNames:nil];
    }
    //Report Error
    else if([buttonTitle isEqualToString:ACTION_REPORT_ERROR])
    {
        //TODO: report error with name generation
        //[self reportError:nil];
    }
}
#pragma mark - MFMailCompose delegate methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}
@end

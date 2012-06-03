//
//  SGAggregateDataController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 None. All rights reserved.
//

#import "SGAggregateDataController.h"
#import "SWTOR_Guide_Content_AggregatorAppDelegate.h"

@implementation SGAggregateDataController

//Factions
#define ALLEGIANCE_REPUBLIC @"Republic"
#define ALLEGIANCE_EMPIRE @"Sith Empire"
#define ALLEGIANCE_HUTT_CONTROLLED @"Controlled by the Hutts"
#define ALLEGIANCE_INDEPENDENT @"Independent"
#define ALLEGIANCE_NONE @"No Government"
//Planets 
#define HOTH @"Hoth"
#define BELSAVIS @"Belsavis"
#define DENOVA @"Denova"
#define UNKNOWN_PLANET @"Unknown"

//Race Names
#define ZABRAK @"Zabrak"
#define HUMAN @"Human"
#define MIRALUKA @"Miraluka"
#define MIRIALAN @"Mirialan"
#define TWILEK @"Twi'lek"
#define SITH_PUREBLOOD @"Sith Pureblood"
#define RATTATAKI @"Rattataki"
#define CHISS @"Chiss"
#define CYBORG @"Cyborg"

//NPC-only
#define DROID @"Droid"
#define CATHAR @"Cathar"
#define WEEQUAY @"Weequay"
#define GAND @"Gand"
#define WOOKIE @"Wookie"
#define MANDALORIAN @"Mandalorian"
#define MON_CALAMARI @"Mon Calamari"
#define TRANDOSHAN @"Trandoshan"
#define SARKHAI @"Sarkhai"
#define CHAGRIAN @"Chagrian"
#define JAWA @"Jawa"
#define HOUK @"Houk"
#define DEVORIAN @"Devorian"
#define HUMAN_RAKGHOUL @"Human (transforms into Rakghoul)"
#define DASHADE @"Dashade"
#define TOGRUTA @"Togruta"
#define KALEESH @"Kaleesh"
#define TALZ @"Talz"
#define KIFFAR @"Kiffar"

//Class Names
#define SMUGGLER @"Smuggler"
#define GUNSLINGER @"Gunslinger"
#define SCOUNDREL @"Scoundrel"
#define TROOPER @"Trooper"
#define COMMANDO @"Commando"
#define VANGUARD @"Vanguard"
#define IMPERIAL_AGENT @"Imperial Agent"
#define OPERATIVE @"Operative"
#define SNIPER @"Sniper"
#define BOUNTY_HUNTER @"Bounty Hunter"
#define MERCENARY @"Mercenary"
#define POWERTECH @"Powertech"
#define JEDI_KNIGHT @"Jedi Knight"
#define JEDI_GUARDIAN @"Jedi Guardian"
#define JEDI_SENTINEL @"Jedi Sentinel"
#define JEDI_CONSULAR @"Jedi Consular"
#define JEDI_SAGE @"Jedi Sage"
#define JEDI_SHADOW @"Jedi Shadow"
#define SITH_WARRIOR @"Sith Warrior"
#define SITH_ASSASSIN @"Assassin"
#define SITH_SORCERER @"Sorcerer"
#define SITH_INQUISITOR @"Sith Inquisitor"
#define SITH_JUGGERNAUT @"Juggernaut"
#define SITH_MARAUDER @"Marauder"

//Skill Trees
#define COMBAT_MEDIC @"Combat Medic"
#define BALANCE @"Balance"
#define TELEKINETICS @"Telekinetics"
#define SEER @"Seer"
#define INFILTRATION @"Infiltration"
#define KINETIC_COMBAT @"Kinetic Combat"
#define FOCUS @"Focus"
#define VIGILANCE @"Vigilance"
#define DEFENSE @"Defense"
#define WATCHMAN @"Watchman"
#define COMBAT @"Combat"
#define DIRTY_FIGHTING @"Dirty Fighting"
#define SABOTEUR @"Saboteur"
#define SHARPSHOOTER @"Sharpshooter"
#define SAWBONES @"Sawbones"
#define SCRAPPER @"Scrapper"
#define ASSAULT_SPECIALIST @"Assault Specialist"
#define GUNNERY @"Gunnery"
#define TACTICS @"Tactics"
#define SHIELD_SPECIALIST @"Shield Specialist"
#define PYROTECH @"Pyrotech"
#define ARSENAL @"Arsenal"
#define BODYGUARD @"Bodyguard"
#define SHIELD_TECH @"Shield Tech"
#define ADVANCED_PROTOTYPE @"Advanced Prototype"
#define LETHALITY @"Lethality"
#define CONCEALMENT @"Concealment"
#define MARKSMANSHIP @"Marksmanship"
#define ENGINEERING @"Engineering"
#define RAGE @"Rage"
#define VENGEANCE @"Vengeance"
#define IMMORTAL @"Immortal"
#define ANNIHILATION @"Annihilation"
#define CARNAGE @"Carnage"
#define MADNESS @"Madness"
#define DECEPTION @"Deception"
#define DARKNESS @"Darkness"
#define LIGHTNING @"Lightning"
#define CORRUPTION @"Corruption"
#define MEDICINE @"Medicine"

//Crafting Skill Types
#define CRAFTING_TYPE @"Crafting"
#define GATHERING_TYPE @"Gathering"
#define MISSION_TYPE @"Mission"

//Ships
#define BT7_THUNDERCLAP @"BT-7 THUNDERCLAP"
#define XS_FREIGHTER @"XS FREIGHTER"
#define DEFENDER @"DEFENDER"
#define FURY @"FURY"
#define D5_MANTIS @"D5-MANTIS"
#define X70B_PHANTOM @"X-70B PHANTOM"

-(void)addClasses
{
    id(^addClass)(NSString*,NSString*) = ^(NSString* name,NSString* allegiance) 
    {
        id characterClass = [NSEntityDescription insertNewObjectForEntityForName:@"SGCharacterClass" inManagedObjectContext:moc];
        [characterClass setValue:name forKey:@"Name"];
        [characterClass setValue:allegiance forKey:@"Allegiance"];
        [characterClass setValue:[NSString stringWithFormat:@"classPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        [classes setObject :characterClass forKey:name];
        return characterClass;
    };
    
    //Trooper
    id trooper = addClass(TROOPER,ALLEGIANCE_REPUBLIC);
    [trooper setValue:@"Not all heroes carry Lightsabers. Some just have the will to fight.\n\nFor decades, the armed forces of the Galactic Republic defended their civilization against the seemingly unstoppable Sith Empire. Despite countless setbacks, the men and women of the Republic military never backed down until the Senate ordered them to do so. These brave souls remain ready and willing to lay their lives on the line today." forKey:@"Description"];
    [trooper setValue:@"Honor, Duty, Defense of the Republic." forKey:@"Headline"];
    
    id vanguard = addClass(VANGUARD,ALLEGIANCE_REPUBLIC);
    [vanguard setValue:@"Unstoppable and utterly fearless, Vanguards are the first and best line of defense in the Republic Military." forKey:@"Headline"];
    [vanguard setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [vanguard setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id commando = addClass(COMMANDO,ALLEGIANCE_REPUBLIC);
    [commando setValue:@"Trained in advanced assault tactics and weaponry, Commandos charge into battle with massive assault cannons, overwhelming their enemies with brute firepower." forKey:@"Headline"];
    [commando setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [commando setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [trooper addAdvancedClassesObject:vanguard];
    [trooper addAdvancedClassesObject:commando];
    
    //Smuggler
    id smuggler = addClass(SMUGGLER,ALLEGIANCE_REPUBLIC);
    [smuggler setValue:@"Sometimes luck is more important than skill, but it never hurts to have both.\n\nLawlessness has become common in the wake of the devastating war between the Republic and Empire. Shifting political allegiances and marauding pirates have made independent space travel a dangerous enterprise. Cut off from traditional supply routes, entire star systems waver on the verge of collapse. An adventurous spirit who’s not afraid to break a few rules can make a handsome profit hauling cargo to these hotspots, but it requires fast reflexes, fast wits and a fast draw with a blaster. Even then, the life of a Smuggler is always a gamble." forKey:@"Description"];
    [smuggler setValue:@"Smugglers survive by being slick, sneaky and street-smart." forKey:@"Headline"];
    
    id gunslinger = addClass(GUNSLINGER,ALLEGIANCE_REPUBLIC);
    [gunslinger setValue:@"Master of the trick shot and willing to take advantage of every opportunity, the Gunslinger learns how to fire two blasters at once, specializing in long-range combat." forKey:@"Headline"];
    [gunslinger setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [gunslinger setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id scoundrel = addClass(SCOUNDREL,ALLEGIANCE_REPUBLIC);
    [scoundrel setValue:@"In addition to his trusty blaster, the Scoundrel packs a stealth belt, a scattergun and a med pack--everything he needs to get in, knock the enemy for a loop and get out alive." forKey:@"Headline"];
    [scoundrel setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [scoundrel setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [smuggler addAdvancedClassesObject:gunslinger];
    [smuggler addAdvancedClassesObject:scoundrel];
    
    //Jedi Knight
    id jediKnight = addClass(JEDI_KNIGHT,ALLEGIANCE_REPUBLIC);
    [jediKnight setValue:@"A symbol of hope in dark times, the Jedi Knight stands for the legacy of the Jedi Order—more than twenty-thousand years of protecting the Republic and keeping the peace across the galaxy. Though Jedi Knights have served as generals, guerilla fighters, and warriors for generations, their legendary combat prowess faces its greatest test during this age." forKey:@"Description"];
    [jediKnight setValue:@"Through training, the Knight turns combat into an art." forKey:@"Headline"];
    
    id guardian = addClass(JEDI_GUARDIAN,ALLEGIANCE_REPUBLIC);
    [guardian setValue:@"A wall between the good people of the Republic and their enemies, the Guardian stands firm in the face of overwhelming odds and dares opponents to attack." forKey:@"Headline"];
    [guardian setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [guardian setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id sentinel = addClass(JEDI_SENTINEL,ALLEGIANCE_REPUBLIC);
    [sentinel setValue:@"Control and focus are the hallmarks of the Sentinel. Through years of training the Sentinel learns the art of using two Lightsabers simultaneously to create an intricate web of damage that is almost impossible to evade." forKey:@"Headline"];
    [sentinel setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [sentinel setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [jediKnight addAdvancedClassesObject:guardian];
    [jediKnight addAdvancedClassesObject:sentinel];
    
    //Jedi Consular
    id jediConsular = addClass(JEDI_CONSULAR,ALLEGIANCE_REPUBLIC);
    [jediConsular setValue:@"For more than 20,000 years, the Jedi Order has worked to promote peace and balance in the Galactic Republic, but each new day brings with it a new threat, promising to rip the Jedi and the entire galaxy apart. If the Republic is to survive, it needs leaders and visionaries; it needs the Jedi Consular." forKey:@"Description"];
    [jediConsular setValue:@"Consulars channel the power of the Force for both strength and wisdom." forKey:@"Headline"];
    
    id sage = addClass(JEDI_SAGE,ALLEGIANCE_REPUBLIC);
    [sage setValue:@"Sages are famed for their wisdom much as for their powerful healing and defensive skills. In troubled times, a Sage brings together the insight of the past with raw power to change the flow of galactic events." forKey:@"Headline"];
    [sage setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [sage setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id shadow = addClass(JEDI_SHADOW,ALLEGIANCE_REPUBLIC);
    [shadow setValue:@"Wielding double-bladed Lightsabers, Shadows embrace the synergy between melee and Force combat, enabling them to strike down enemies of the Order with deadly efficiency." forKey:@"Headline"];
    [shadow setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [shadow setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [jediConsular addAdvancedClassesObject:sage];
    [jediConsular addAdvancedClassesObject:shadow];
    
    //Bounty Hunter
    id bountyHunter = addClass(BOUNTY_HUNTER,ALLEGIANCE_EMPIRE);
    [bountyHunter setValue:@"Countless enemies stand in the way of the Sith Empire’s drive for domination. The Empire spares no expense eliminating these threats, offering massive bounties to employ the galaxy’s most lethal hunters. Earning a death mark from the Empire means a life spent in fear, constantly looking over one’s shoulder. It’s never a question if a Bounty Hunter will find you… only when." forKey:@"Description"];
    [bountyHunter setValue:@"Bounty Hunters are rugged, independent, and always get the job done." forKey:@"Headline"];
    
    id powertech = addClass(POWERTECH,ALLEGIANCE_EMPIRE);
    [powertech setValue:@"The best in shielding, defensive tactics and high-powered flamethrowers combine to make the Powertech an impenetrable one-man blockade, getting up close and personal to take down enemies of all sizes." forKey:@"Headline"];
    [powertech setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [powertech setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id mercenary = addClass(MERCENARY,ALLEGIANCE_EMPIRE);
    [mercenary setValue:@"A pair of blasters, deadly heat-seeking missiles, and heavy armor make the Mercenary a mobile weapons platform. There's no problem extra firepower can't solve, and no one with sense gets between a Mercenary and their target." forKey:@"Headline"];
    [mercenary setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [mercenary setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [bountyHunter addAdvancedClassesObject:powertech];
    [bountyHunter addAdvancedClassesObject:mercenary];

    //Sith Warrior
    id sithWarrior = addClass(SITH_WARRIOR,ALLEGIANCE_EMPIRE);
    [sithWarrior setValue:@"An unstoppable force of darkness, the Sith Warrior is entrusted with the task of destroying the Empire’s enemies and enforcing Sith domination across the galaxy. The Warrior channels the destructive emotions of fear, anger, and hatred to purge weakness from body and mind and become a being of pure, brutal efficiency." forKey:@"Description"];
    [sithWarrior setValue:@"Warriors channel anger and hatred to become brutal combatants." forKey:@"Headline"];
    
    id juggernaut = addClass(SITH_JUGGERNAUT,ALLEGIANCE_EMPIRE);
    [juggernaut setValue:@"A stalwart defender of the Sith Empire, the Juggernaut embodies the teachings of Marka Ragnos, charging into enemies with heavy armor and pure rage." forKey:@"Headline"];
    [juggernaut setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [juggernaut setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id marauder = addClass(SITH_MARAUDER,ALLEGIANCE_EMPIRE);
    [marauder setValue:@"Entrusted with the task of destroying the Empire’s enemies, the dual-wielding Marauder embodies the teachings of Naga Sadow. Never hesitating, never faltering, there is no swifter bringer of pain in the galaxy." forKey:@"Headline"];
    [marauder setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [marauder setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [sithWarrior addAdvancedClassesObject:juggernaut];
    [sithWarrior addAdvancedClassesObject:marauder];
    
    //Sith Inquisitor
    id sithInquisitor = addClass(SITH_INQUISITOR,ALLEGIANCE_EMPIRE);
    [sithInquisitor setValue:@"The history of the Sith Empire is fraught with scheming politics and dark secrets—the lifeblood of the Sith Inquisitor. Treachery hides around every corner in the Empire’s dark corridors, and survival depends on an individual’s natural cunning and the will to manipulate and defeat their enemies and allies alike. The Inquisitor experiments with forbidden powers to not only survive in this cutthroat environment, but to excel and seize authority." forKey:@"Description"];
    [sithInquisitor setValue:@"Inquisitors harness the Force to rip life from their foes." forKey:@"Headline"];
    
    id assassin = addClass(SITH_ASSASSIN,ALLEGIANCE_EMPIRE);
    [assassin setValue:@"Assassins leap from the shadows, channeling Force lightning through their double-bladed Lightsabers to disable and drain their enemies. They are masters of subterfuge, feared by even the most terrible opponents." forKey:@"Headline"];
    [assassin setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [assassin setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id sorcerer = addClass(SITH_SORCERER,ALLEGIANCE_EMPIRE);
    [sorcerer setValue:@"The Sith Sorcerer draws energy from the forbidden depths of the Force, mastering techniques that sap and drain enemies as they invigorate allies--or simply wreak utter devastation." forKey:@"Headline"];
    [sorcerer setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [sorcerer setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [sithInquisitor addAdvancedClassesObject:assassin];
    [sithInquisitor addAdvancedClassesObject:sorcerer];
    
    //Imperial Agent
    id imperialAgent = addClass(IMPERIAL_AGENT,ALLEGIANCE_EMPIRE);
    [imperialAgent setValue:@"The Empire dominates scores of star systems across the galaxy, but not through the power of the dark side alone. Behind the scenes, the cunning Agents of Imperial Intelligence track down and eliminate the Empire’s enemies—from intractable Republic senators to traitorous Imperial Moffs to bloodthirsty rebels with Republic ties. Imperial Agents must master the arts of infiltration, seduction, and assassination to advance the Empire’s causes; they face the opposition of a terrified galaxy and the capriciousness of their own Sith overlords." forKey:@"Description"];
        [imperialAgent setValue:@"Agents are masters of stealth, seduction, and assassination." forKey:@"Headline"];

    
    id sniper = addClass(SNIPER,ALLEGIANCE_EMPIRE);
    [sniper setValue:@"Identified as the most elite sharpshooters in the galaxy, Snipers use their extensive training to eliminate sensitive targets and turn the tide of the battle in the Empire's favor." forKey:@"Headline"];
    [sniper setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [sniper setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    id operative = addClass(OPERATIVE,ALLEGIANCE_EMPIRE);
    [operative setValue:@"Whether ambushing enemies from stealth or using advanced medical technology to keep colleagues in the fight, the operative will do whatever it takes to advance the agenda of the Empire.." forKey:@"Headline"];
    [operative setValue:[NSNumber numberWithBool:YES] forKey:@"isAdvancedClass"];
    [operative setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
    
    [imperialAgent addAdvancedClassesObject:sniper];
    [imperialAgent addAdvancedClassesObject:operative];
}
-(void)addRacesAndClasses
{
    id(^addRace)(NSString*) = ^(NSString* name) 
    {
        id race = [NSEntityDescription insertNewObjectForEntityForName:@"SGRace" inManagedObjectContext:moc];
        [race setValue:name forKey:@"Name"];
        [race setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
        [races setObject:race forKey:name];
        
        //[race setValue:[NSString stringWithFormat:@"racePreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        return race;
    };
    void(^addRaceToClass)(id,NSString*) = ^(id race,NSString* className) 
    {
        [race setValue:[NSNumber numberWithBool:NO] forKey:@"NPCOnly"];
        id characterClass = [classes objectForKey:className];
        [race addClassesObject:characterClass];
    };
    
    //Player Races
    //Zabrak
    id zabrak = addRace(ZABRAK);
    addRaceToClass(zabrak,JEDI_CONSULAR);
    addRaceToClass(zabrak,JEDI_KNIGHT);
    addRaceToClass(zabrak,TROOPER);
    addRaceToClass(zabrak,SITH_INQUISITOR);
    addRaceToClass(zabrak,SITH_WARRIOR);
    addRaceToClass(zabrak,BOUNTY_HUNTER);
    addRaceToClass(zabrak,IMPERIAL_AGENT);
    addRaceToClass(zabrak,SMUGGLER);
    //Human
    id human = addRace(HUMAN);
    addRaceToClass(human,JEDI_CONSULAR);
    addRaceToClass(human,JEDI_KNIGHT);
    addRaceToClass(human,SMUGGLER);
    addRaceToClass(human,TROOPER);
    addRaceToClass(human,SITH_WARRIOR);
    addRaceToClass(human,SITH_INQUISITOR);
    addRaceToClass(human,BOUNTY_HUNTER);
    addRaceToClass(human,IMPERIAL_AGENT);
    //Miraluka
    id miraluka = addRace(MIRALUKA);
    addRaceToClass(miraluka,JEDI_CONSULAR);
    addRaceToClass(miraluka,JEDI_KNIGHT);
    //Mirialan
    id mirialan = addRace(MIRIALAN);
    addRaceToClass(mirialan,JEDI_CONSULAR);
    addRaceToClass(mirialan,SMUGGLER);
    addRaceToClass(mirialan,TROOPER);
    addRaceToClass(mirialan,JEDI_KNIGHT);
    //Twi'lek
    id twilek = addRace(TWILEK);
    addRaceToClass(twilek,JEDI_CONSULAR);
    addRaceToClass(twilek,SMUGGLER);
    addRaceToClass(twilek,SITH_INQUISITOR);
    addRaceToClass(twilek,JEDI_KNIGHT);
    //Sith Pureblood
    id sithPureblood = addRace(SITH_PUREBLOOD);
    addRaceToClass(sithPureblood,SITH_WARRIOR);
    addRaceToClass(sithPureblood,SITH_INQUISITOR);
    //Rattataki
    id rattataki = addRace(RATTATAKI);
    addRaceToClass(rattataki,SITH_INQUISITOR);
    addRaceToClass(rattataki,BOUNTY_HUNTER);
    addRaceToClass(rattataki,IMPERIAL_AGENT);
    //Chiss
    id chiss = addRace(CHISS);
    addRaceToClass(chiss,IMPERIAL_AGENT);
    addRaceToClass(chiss,BOUNTY_HUNTER);
    //Cyborg
    id cyborg = addRace(CYBORG);
    addRaceToClass(cyborg,TROOPER);
    addRaceToClass(cyborg,BOUNTY_HUNTER);
    addRaceToClass(cyborg,SITH_WARRIOR);
    addRaceToClass(cyborg,IMPERIAL_AGENT);
    addRaceToClass(cyborg,SMUGGLER);
    
    //NPC-ONLY Races
    id droid = addRace(DROID);
    id cathar = addRace(CATHAR);
    id weequay = addRace(WEEQUAY);
    id gand = addRace(GAND);
    id wookie = addRace(WOOKIE);
    id mandalorian = addRace(MANDALORIAN);
    id monCalamari = addRace(MON_CALAMARI);
    id trandoshan = addRace(TRANDOSHAN);
    id sarkhai = addRace(SARKHAI);
    id chagrian = addRace(CHAGRIAN);
    id jawa = addRace(JAWA);
    id houk = addRace(HOUK);
    id devorian = addRace(DEVORIAN);
    id humanRakghoul = addRace(HUMAN_RAKGHOUL);
    id togruta = addRace(TOGRUTA);
    id kaleesh = addRace(KALEESH);
    id kalz = addRace(TALZ);
    id dashade = addRace(DASHADE);
    id kiffar = addRace(KIFFAR);
}
-(void)addPlanets
{
    id(^addPlanet)(NSString*) = ^(NSString* name) 
    {
        id planet = [NSEntityDescription insertNewObjectForEntityForName:@"SGPlanet" inManagedObjectContext:moc];
        [planet setValue:name forKey:@"Name"];
        [planet setValue:[NSString stringWithFormat:@"planetPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        [locations setObject:planet forKey:name];
        return planet;
    };
    void(^addStartingClass)(id,NSString*) = ^(id planet,NSString* name) 
    {
        id characterClass = [classes objectForKey:name];
        if(characterClass)
        {
            [planet addStartingClassesObject:characterClass];
        }
    };
         
    //Unknown Planet - used when the planet an entry is on is annonymous/unknown
    id unknownPlanet = addPlanet(UNKNOWN_PLANET);
    [unknownPlanet setValue:@"Unknown" forKey:@"Terrain"];
    [unknownPlanet setValue:@"Unknown" forKey:@"Description"];
    [unknownPlanet setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
        
    //Denova - Used in Explosive Conflict Operation
    id denova = addPlanet(DENOVA);
     [denova setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [denova setValue:@"Unknown" forKey:@"Region"];
    [denova setValue:@"Coastline of elevated grasslands and forests." forKey:@"Terrain"];
    [denova setValue:@"Denova was a planet in the Ojoster sector that consisted mostly of woods and high peaked mountains. Ancient ruins were noted to be present on the surface though details on them were largely undocumented. It was discovered during the Cold War by the Galactic Republic who first scouted the world. This led to the discovery of extensive deposits of the ore known as Baradium. In order to control this resource, the Republic hired a mercenary army due to manpower shortages in the Republic Military.\n\nThus, a Trandoshan group known as the Warstalkers were hired that was being led by the veteran Kephess to prevent the world from falling into the hands of the Sith Empire. However, the mercenaries went renegade and formed an alliance with renegade forces within the Imperial Army." forKey:@"Description"];
    [denova setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];

    //Alderaan
    id alderaan = addPlanet(@"Alderaan");
    [alderaan setValue:@"Forests, Hills and Snow-Capped Mountains" forKey:@"Terrain"];
    [alderaan setValue:ALLEGIANCE_INDEPENDENT forKey:@"Allegiance"];
    [alderaan setValue:@"Core Worlds" forKey:@"Region"];
    [alderaan setValue:@"Several of Alderaan’s noble houses are battling for the throne in a brutal civil war" forKey:@"Status"];
    [alderaan setValue:@"Since the Republic’s inception, Alderaan’s nobility has been at the political forefront, taking a stand in the Senate for peace, freedom and unity. While Coruscant has always been considered the heart of the Republic, to some extent, Alderaan has been its soul. In the aftermath of the Treaty of Coruscant, however, Alderaan withdrew from the Republic and soon became embroiled in one of the bloodiest civil wars in the galaxy’s history. The future of this once-proud planet is heavily in doubt." forKey:@"Description"];
    //Belsavis
    id belsavis = addPlanet(BELSAVIS);
    [belsavis setValue:@"Ice Covered with Small Pockets of Volcanic Temperate Zones" forKey:@"Terrain"];
    [belsavis setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [belsavis setValue:@"Outer Rim" forKey:@"Region"];
    [belsavis setValue:@"Following the Chaos of an Imperial Prison Break Initiative, the Republic is Striving to Restore Order" forKey:@"Status"];
    [belsavis setValue:@"Republic knowledge of Belsavis predates the Great Hyperspace War, but for centuries, the planet warranted little attention. With the exception of some unusual volcanic activity, the planet was deemed, in all ways, unremarkable. Belsavis was added to the star charts then summarily dismissed as nothing more than another curiosity of the Outer Rim." forKey:@"Description"];
    //Balmorra
    id balmorra = addPlanet(@"Balmorra");
    [balmorra setValue:@"War-torn Plains" forKey:@"Terrain"];
    [balmorra setValue:ALLEGIANCE_INDEPENDENT forKey:@"Allegiance"];
    [balmorra setValue:@"Colonies Region" forKey:@"Region"];
    [balmorra setValue:@"Occupied by the Empire" forKey:@"Status"];
    [balmorra setValue:@"Few places in the galaxy have seen the peace promised by the Treaty of Coruscant so thoroughly cast aside as the world of Balmorra. Fiercely independent, this long time ally of the Republic has led the galaxy in advanced droid and weapons manufacturing. Now Balmorra’s workers live and suffer under a full Imperial occupation force." forKey:@"Description"];
    //Corellia
    id corellia = addPlanet(@"Corellia");
    [corellia setValue:@"Environmentally-Conscious Cityscape" forKey:@"Terrain"];
    [corellia setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [corellia setValue:@"Core Worlds" forKey:@"Region"];
    [corellia setValue:@"Rumors of Imperial Influence Over Corellian Leaders" forKey:@"Status"];
    [corellia setValue:@"A founding member of the Galactic Republic, Corellia is one of the most vibrant business centers in the galaxy, and of the highest strategic importance. Besides being the hub for galactic corporate enterprise and maintaining a vocal presence in the Senate, Corellia is also the birthplace of many Republic economic, political, and military leaders. While Coruscant is a symbol of Republic power and tradition, Corellia is a testament to the Republic’s resourcefulness and respect for personal and economic freedom." forKey:@"Description"];
    //Coruscant
    id coruscant = addPlanet(@"Coruscant");
    [coruscant setValue:@"Cityscape" forKey:@"Terrain"];
    [coruscant setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [coruscant setValue:@"Core Worlds" forKey:@"Region"];
    [coruscant setValue:@"Capital of the Republic" forKey:@"Status"];
    [coruscant setValue:@"At the center of the galaxy, the gleaming towers of Coruscant symbolize the power and prosperity of Republic civilization—the result of thousands of years of progress and democracy. Coruscant has been capital of the Republic since its founding more than twenty thousand years ago. Home to the Supreme Chancellor and the Galactic Senate, Coruscant is the most politically prominent planet in the galaxy.\n\nProtected by the legendary Jedi Order, Coruscant has always been the galaxy’s safest haven for law abiding citizens. All who would come in peace and partnership are welcome, and hundreds of alien species and star systems have come to be represented on Coruscant over time." forKey:@"Description"];
    //Dromund Kaas
    id dromundKaas = addPlanet(@"Dromund Kaas");
    [dromundKaas setValue:@"Swamps, Jungle, and the Metropolis of Kaas City" forKey:@"Terrain"];
    [dromundKaas setValue:ALLEGIANCE_EMPIRE forKey:@"Allegiance"];
    [dromundKaas setValue:@"Sith Space" forKey:@"Region"];
    [dromundKaas setValue:@"Imperial Capital" forKey:@"Status"];
    [dromundKaas setValue:@"On the remote jungle world of Dromund Kaas, the Sith have spent a thousand years building their mighty war machine to prepare for an assault on the Galaxy.\n\nColonized in ancient times by the Sith Empire, the hyperspace coordinates of Dromund Kaas were lost to time, allowing the isolated planet to fade into distant memory. Following a crushing defeat in the Great Hyperspace War, the handful of surviving Sith desperately sought to escape annihilation at the hands of their Jedi foes. The desperate Sith, leaving their collective destiny to chance, chose to forgo all known hyperspace routes and attempt a series of dangerously random hyperspace jumps and blind scouting missions. For 20 years the Sith armada drifted aimlessly in the forgotten regions of space before finally rediscovering the Dromund system." forKey:@"Description"];
    //Hoth
    id hoth = addPlanet(HOTH);
    [hoth setValue:@"Frozen, Desolate wasteland" forKey:@"Terrain"];
    [hoth setValue:ALLEGIANCE_NONE forKey:@"Allegiance"];
    [hoth setValue:@"Outer Rim" forKey:@"Region"];
    [hoth setValue:@"Contested" forKey:@"Status"];
    [hoth setValue:@"One of the most remote and lifeless planets in the known galaxy, Hoth was of no real interest to the Republic until it became the site of a devastating military defeat. At the height of the Great War, Republic and Imperial fleets clashed in the Hoth system in a decisive battle which saw the destruction of some of the most advanced and powerful starships in the galaxy.\n\nIn the aftermath of the battle, the icy planet of Hoth became a massive starship graveyard, littered with the wreckage of hundreds of warships from both sides, including several prototype ships the Republic had deployed in the hope of turning the tide of the war. As the war raged on, though, neither the Republic nor the Empire had the time and resources to mount a recovery operation." forKey:@"Description"];
    //Hutta
    id hutta = addPlanet(@"Hutta");
    [hutta setValue:@"Swamps and Industrial wasteland" forKey:@"Terrain"];
    [hutta setValue:ALLEGIANCE_HUTT_CONTROLLED forKey:@"Allegiance"];
    [hutta setValue:@"Hutt Space" forKey:@"Region"];
    [hutta setValue:@"Over-industrialized, Polluted" forKey:@"Status"];
    [hutta setValue:@"In Huttese, the name translates into \"Glorious Jewel\", and the planet more commonly called Nal Hutta is considered a paradise to the gluttonous tastes of the Hutts. To anyone else, though, the planet is a living nightmare—a disgusting and dangerous place to visit, and an unthinkable place to live. Current Underworld slang has shortened the name to a simple ‘Hutta’—a place where more civilized people threaten to send their children if they misbehave." forKey:@"Description"];
    //Ilum
    id ilum = addPlanet(@"Ilum");
    [ilum setValue:@"Mountainous Ice World with Subterranean Crystals" forKey:@"Terrain"];
    [ilum setValue:ALLEGIANCE_NONE forKey:@"Allegiance"];
    [ilum setValue:@"Unknown Regions" forKey:@"Region"];
    [ilum setValue:@"Ilum’s natural crystal formations are capable of harnessing power that the Empire has become interested in" forKey:@"Status"];
    [ilum setValue:@"For centuries, a treasure trove of resources lay untapped in the most unexpected of places--a small, frigid world at the edge of the galaxy—Ilum.\n\nThe first to discover Ilum’s potential were the Jedi. The planet’s wealth of subterranean Adegan crystals proved to be perfectly attuned for use in Lightsabers, and Jedi began undertaking pilgrimages to Ilum to forge their legendary weapons. Dangerous and far from civilization, many Jedi lost their lives to Ilum’s bizarre beasts and brutal climate." forKey:@"Description"];
    
    //Korriban
    id korriban = addPlanet(@"Korriban");
    [korriban setValue:@"Red, rocky desert" forKey:@"Terrain"];
    [korriban setValue:ALLEGIANCE_EMPIRE forKey:@"Allegiance"];
    [korriban setValue:@"Imperial-controlled Outer Rim" forKey:@"Region"];
    [korriban setValue:@"Tightly controlled by the Sith" forKey:@"Status"];
    [korriban setValue:@"The earliest Sith lived on the red, dusty planet of Korriban, determined to grow strong despite the inhospitable climate. Their success culminated in a bold civilization, made stronger when dark Force-users arrived and interbred after being driven out of the early Jedi Order. This ancient Sith civilization eventually became a superpower and challenged the Republic during the Great Hyperspace war. Their defeat drove a handful of survivors into deep space where they regrouped and rebuilt, determined to return.\n\nOver time, the new Sith Empire lost its way back to Korriban, until a visit a few centuries ago by two Jedi returning from the Mandalorian wars. Turned to the dark side, the two Jedi, Revan and Malak, attempted to reclaim the Sith’s legacy in the known galaxy, but turned on each other and self-destructed." forKey:@"Description"];
    //Nar Shaddaa
    id narShaddaa = addPlanet(@"Nar Shaddaa");
    [narShaddaa setValue:@"Vast cityscape, ranging from neon towers to squalid dens" forKey:@"Terrain"];
    [narShaddaa setValue:ALLEGIANCE_HUTT_CONTROLLED forKey:@"Allegiance"];
    [narShaddaa setValue:@"Hutt Space" forKey:@"Region"];
    [narShaddaa setValue:@"Nar Shaddaa has profited greatly from the war, rampant crime, and chaos" forKey:@"Status"];
    [narShaddaa setValue:@"One of the most vibrant and dangerous places in the galaxy, Nar Shaddaa is a sprawling cityscape where nothing comes without a price. Dominated by a black market that caters to every indulgence, the moon has become the ultimate symbol of corruption. The upper levels present an endless parade of glittering neon towers and floating pleasure palaces; no greater concentration of wealth exists across the galaxy. Behind these flashy facades, crime bosses and secret political emissaries make backroom deals that decide the fates of worlds, and as much as both the Galactic Republic and the Sith Empire might like to change it, the Hutt Cartel calls the shots." forKey:@"Description"];
    //Ord Mantell
    id ordMantell = addPlanet(@"Ord Mantell");
    [ordMantell setValue:@"Saltwater seas and Islands" forKey:@"Terrain"];
    [ordMantell setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [ordMantell setValue:@"Mid Rim" forKey:@"Region"];
    [ordMantell setValue:@"Embroiled in civil war" forKey:@"Status"];
    [ordMantell setValue:@"The mountainous plains and volcanic islands of Ord Mantell are littered with the ravages of a ruthless civil war. Republic forces are fighting elusive separatists who are conducting guerilla style strikes against both military and civilian targets. Adding questions to an already questionable situation, the planet’s government, though loyal to the Republic, is merely a puppet regime for underworld concerns.\n\nCorellian colonists settled Ord Mantell nine thousand years ago, and the planet became a staging point for Republic military operations in the Outer Rim. Ord Mantell’s strategic value waned over the centuries, however, and after a corrupt admiral sold off the local fleet, the military all but abandoned the planet. Ord Mantell soon became a haven for smugglers, pirates, and bounty hunters, and the local government fell under the sway of the crime syndicates—a dynamic that remains in place to this day." forKey:@"Description"];
    
    //Quesh
    id quesh = addPlanet(@"Quesh");
    [quesh setValue:@"Primarily Toxic Swampland and Marshes" forKey:@"Terrain"];
    [quesh setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [quesh setValue:@"Hutt Space" forKey:@"Region"];
    [quesh setValue:@"The Empire has moved in to hijack Republic mining operations" forKey:@"Status"];
    [quesh setValue:@"Environmental poisons have made Quesh one of the most dangerous and valuable planets in the galaxy, and the grounds for a savage battle between the Galactic Republic and the Sith Empire. Though the chemicals on Quesh are lethal to most life forms, they can also be used to create some of the most potent adrenals in the galaxy… and untold wealth for whoever controls the ingredients.\n\nInitially discovered by the Republic during the Great War, Quesh was abandoned after scientists detected the poisonous content of its atmosphere. It wasn’t until years later that a young chemist rummaging through old data recognized the potential for the chemical compounds on Quesh—they are incredibly close to venenit shadaaga (Hutt Venom), a primary ingredient in high-grade adrenals for healing, reflexes, and concentration." forKey:@"Description"];
    //Taris
    id taris = addPlanet(@"Taris");
    [taris setValue:@"Swamplands, Modern Ruins, Frequent Rainfall" forKey:@"Terrain"];
    [taris setValue:ALLEGIANCE_INDEPENDENT forKey:@"Allegiance"];
    [taris setValue:@"Outer Rim" forKey:@"Region"];
    [taris setValue:@"Republic Re-Colonization Efforts Have Begun" forKey:@"Status"];
    [taris setValue:@"Taris is a post-apocalyptic swamp, abandoned but not forgotten by the greater galaxy for three centuries. Until recently, only overgrown ruins bore testimony to the thriving civilization that once dominated the surface – a civilization annihilated by the Sith Lord Darth Malak while seeking to eliminate the Jedi Knight Bastila Shan.\n\nAs a symbol of hope and redemption in the face of Sith atrocities, the Republic has begun an unlikely effort to re-colonize Taris, establishing a spaceport, military base and the beginning of settlements amid the ruins. The remnants of the once great city-world have proven to be far more treacherous than anyone expected, though, and many believe the effort to reclaim Taris is doomed to end in disaster. One thing is certain – cleaning up what the Sith destroyed isn’t nearly as perilous as facing what they didn’t." forKey:@"Description"];
    //Tatooine
    id tatooine = addPlanet(@"Tatooine");
    [tatooine setValue:@"Seas of Sand and Rock" forKey:@"Terrain"];
    [tatooine setValue:ALLEGIANCE_INDEPENDENT forKey:@"Allegiance"];
    [tatooine setValue:@"Outer Rim" forKey:@"Region"];
    [tatooine setValue:@"Haven for Pirates and Smugglers" forKey:@"Status"];
    [tatooine setValue:@"Far in the Outer Rim, the sands of Tatooine bake beneath the glare of two bright suns. Small pockets of barely civilized communities dot the desolate landscape, surrounded by the endless expanse of barren dunes and rocky canyons that have silently slain so many of those who ventured out into the desert. Among the small shantytowns and settlements that persist, travelers may find shelter from the brutal climate, but trust is as rare as water on this lawless world. Visitors and locals alike must constantly watch their backs in Tatooine’s townships." forKey:@"Description"];
    //Tython
    id tython = addPlanet(@"Tython");
    [tython setValue:@"Mountains and forests" forKey:@"Terrain"];
    [tython setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    [tython setValue:@"Deep Core" forKey:@"Region"];
    [tython setValue:@"Largely Unexplored" forKey:@"Status"];
    [tython setValue:@"Mystical scholars gathered on the harsh and mysterious world of Tython millennia ago to begin the first studies of the Force, but controversy among the scholars’ ranks created a cataclysm which nearly destroyed the planet. A small group of survivors fled to another star system, put their dark past behind them, and founded the Jedi Order.\n\nThousands of years passed, and the true legacy of Tython was forgotten.\n\nRediscovering the planet early in the Great War, the modern Jedi began exploring the mysteries of Tython’s history, and learning much about the earliest Force users." forKey:@"Description"];
    //Voss
    id voss = addPlanet(@"Voss");
    [voss setValue:@"Forest, Mountains, Plateaus" forKey:@"Terrain"];
    [voss setValue:ALLEGIANCE_INDEPENDENT forKey:@"Allegiance"];
    [voss setValue:@"Outer Rim" forKey:@"Region"];
    [voss setValue:@"Failed Imperial conquest, now both sides vie for alliance" forKey:@"Status"];
    [voss setValue:@"Voss is a planet of more questions than answers. Discovered by accident shortly after the Treaty of Coruscant, its rocky plateaus, unspoiled peaks and verdant forests were at first thought to be inhabited only by Gormak, a tech-savvy but pre-space flight species of extremely hostile natives. When the second, much less populous species on Voss made itself known, however, the galaxy was thrown into turmoil and the war almost restarted." forKey:@"Description"];

    //Add Starting Classes
    addStartingClass(ordMantell,TROOPER);
    addStartingClass(ordMantell,SMUGGLER);
    
    addStartingClass(tython,JEDI_KNIGHT);
    addStartingClass(tython,JEDI_CONSULAR);
    
    addStartingClass(korriban,SITH_WARRIOR);
    addStartingClass(korriban,SITH_INQUISITOR);
    
    addStartingClass(hutta,IMPERIAL_AGENT);
    addStartingClass(hutta,BOUNTY_HUNTER);
}
-(void)addLocations
{
    id(^addLocation)(NSString*) = ^(NSString* name) 
    {
        id location = [NSEntityDescription insertNewObjectForEntityForName:@"SGLocation" inManagedObjectContext:moc];
        [location setValue:name forKey:@"Name"];
        [location setValue:[NSString stringWithFormat:@"locationPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        [location setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
        
        [locations setObject:location forKey:name];
        return location;
    };
    
    //The Voidstar
    id theVoidstar = addLocation(@"The Voidstar");
    [theVoidstar setValue:@"Forests, Hills and Snow-Capped Mountains" forKey:@"Terrain"];
}
-(void)addShips
{
    id(^addShip)(NSString*,NSString*,NSString*,NSString*) = ^(NSString* name,NSString* className,NSString* manufacturer,NSString* model) 
    {
        id ship = [NSEntityDescription insertNewObjectForEntityForName:@"SGShip" inManagedObjectContext:moc];
        id characterClass = [classes objectForKey:className];
        
        [ship setValue:name forKey:@"Name"];
        [ship setValue:manufacturer forKey:@"manufacturer"];
        [ship setValue:model forKey:@"model"];
        
        [ship setValue:[NSString stringWithFormat:@"starshipPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        [ship addCharacterClassesObject:characterClass];
        [ships setObject:ship forKey:name];
        
        return ship;
    };
    void(^addCharacterClassToShip)(id,NSString*) = ^(id ship,NSString* className) 
    {
        id characterClass = [classes objectForKey:className];
        [ship addCharacterClassesObject:characterClass];
    };
    
    //Republic Ships
    //BT-7 THUNDERCLAP
    id bt7Thuderclap = addShip(BT7_THUNDERCLAP,TROOPER,@"Rendili Hyperworks",@"Assault Ship");
    [bt7Thuderclap setValue:@"The Rendili Hyperworks BT-7 Thunderclap is the Republic’s largest and most elite rapid assault ship which is the player ship for the Trooper.\n\nStreamlined for fast deployment in combat situations,upgrades requested by Republic Special Forces ensure reliable performance and durability: state-of-the-art armor plating and heavy laser cannons provide exceptional combat capability, modular shield systems protect the Thunderclap from enemy fire, and the ship’s design deflects blaster fire away from crucial components in the event of shield failure. Despite its efficient military design, the Thunderclap is outfitted with all manner of interior improvements. The main deck contains a high-tech command center and briefing room, a secure armory, and a fully-outfitted medical bay. Personal bunk space is above average, and recreational facilities are available for increased quality of life for the squad during extended missions." forKey:@"Description"];
    [bt7Thuderclap setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    //XS FREIGHTER
    id xsFreighter = addShip(XS_FREIGHTER,SMUGGLER,@"Corellian Engineering Corporation",@"Freighter");
    [xsFreighter setValue:@"The Corellian XS Stock Light Freighter is the starship available to players of the Smuggler class. The XS Light Freighter is an advancement of past freighter designs, built both for speed and to ensure the security of its occupants and cargo; this vessel's weapons array includes the standard laser and torpedo batteries as well as turrets mounted upon both its upper and lower hemispheres. These turrets can either be controlled manually or from the cockpit.\n\nThe XS Light Freighter is designed to accommodate long-distance space travel, and its interior includes dedicated living areas for crew and passengers alike." forKey:@"Description"];
    [xsFreighter setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    //DEFENDER
    id defender = addShip(DEFENDER,JEDI_KNIGHT,@"Rendili Vehicle Corporation",@"Light Corvette");
    addCharacterClassToShip(defender,JEDI_CONSULAR);
    [defender setValue:@"The Corellian Defender-class Light Corvette is a starship available to players of both the Jedi Knight and Jedi Consular classes. Commissioned and built specifically for the Jedi Order during the Great War, the Defender boasts numerous upgrades and modifications that allow it to serve the specialized needs of a Jedi.\n\nDeveloped at the height of the Great War, the Defender was custom-built for the Jedi Order. The Jedi Council commissioned the starship after determining that Republic military vessels were not well-suited to the Jedi’s more specialized missions. The Defender’s exterior design is based on the consumer model corvette, but it has been outfitted with countless customized upgrades. The starship includes two levels. The formal upper level features diplomatic meeting rooms and an elegant conference room at the ship’s center." forKey:@"Description"];
    [defender setValue:ALLEGIANCE_REPUBLIC forKey:@"Allegiance"];
    
    //Sith Empire Ships
    //FURY
    id fury = addShip(FURY,SITH_WARRIOR,@"Imperial Navy",@"Fury");
    addCharacterClassToShip(fury,SITH_INQUISITOR);
    [fury setValue:@"The Fury-class Imperial Interceptor is a starship available to players of both the Sith Warrior and Sith Inquisitor classes. The Fury is a favorite vessel among Sith Lords, as it includes highly sophisticated technology and weapons systems; even given the fact that the focus of the ship's design is functionality, this vessel remains very versatile and luxurious.\n\nFeaturing an advanced hyperdrive and state-of-the-art sub-light engines, the Fury is the most versatile starship in the Imperial fleet. Though initially designed for high-priority military missions, the Fury has become a favorite among Sith Lords and the latest models have been engineered accordingly." forKey:@"Description"];
    [fury setValue:ALLEGIANCE_EMPIRE forKey:@"Allegiance"];
    //D5-MANTIS
    id d5Mantis = addShip(D5_MANTIS,BOUNTY_HUNTER,@"Kuat Drive Yards",@"Mantis Patrol Craft");
    [d5Mantis setValue:@"The D5-Mantis Patrol Craft is the ship available to Bounty Hunters. The D5-Mantis Patrol Craft was a rare, top-of-the-line starship during the Cold War. It was meant to meet the demands of larger capital ships. " forKey:@"Description"];
    [d5Mantis setValue:ALLEGIANCE_EMPIRE forKey:@"Allegiance"];
    //X-70B PHANTOM
    id x70bPhantom = addShip(X70B_PHANTOM,IMPERIAL_AGENT,@"Imperial Intelligence",@"Prototype");
    [x70bPhantom setValue:@"The X-70B Phantom-Class Prototype is a starship available to players of the Imperial Agent class. These advanced prototype vessels are the result of revisions to traditional Imperial starship design theory, incorporating concepts and technologies gathered over the years of the Great War.\n\nThe X-70B far surpasses the capabilities of current starship mass production techniques, ensuring the vessel will only be entrusted to those carrying out missions vital to the Empire." forKey:@"Description"];
    [x70bPhantom setValue:ALLEGIANCE_EMPIRE forKey:@"Allegiance"];
}
-(void)addCompanions
{
    id(^addCompanion)(NSString*,NSString*,NSString*,id,int) = ^(NSString* name,NSString* race,NSString* type,id characterClass, int order) 
    {
        id companion = [NSEntityDescription insertNewObjectForEntityForName:@"SGCharacter" inManagedObjectContext:moc];
        [companion setValue:name forKey:@"Name"];
        [companion setValue:type forKey:@"type"];
        [companion setValue:[NSNumber numberWithInt:order] forKey:@"order"];
        
        id r = [races objectForKey:race];
        [companion setValue:r forKey:@"race"];
        
        [companion setValue:characterClass forKey:@"characterClassesCompanion"];
        [companion setValue:[NSString stringWithFormat:@"characterPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        
        return companion;
    };
    id(^addShipDroid)(NSString*,NSString*,NSString*,id) = ^(NSString* name,NSString* race,NSString* type,NSSet* ships) 
    {
        id companion = [NSEntityDescription insertNewObjectForEntityForName:@"SGCharacter" inManagedObjectContext:moc];
        [companion setValue:name forKey:@"Name"];
        [companion setValue:type forKey:@"type"];
        [companion setValue:ships forKey:@"companionForShips"];
        
        id r = [races objectForKey:race];
        [companion setValue:r forKey:@"race"];
        
        [companion setValue:[NSString stringWithFormat:@"characterPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        return companion;
    };
    void(^setDescription)(id,NSString*) = ^(id companion,NSString* description) 
    {
        [companion setValue:description forKey:@"Description"];
    };
    
#define LIGHT @"Light"
#define DARK @"Dark"
#define NEUTRAL @"Neutral"
    
#define NOT_ROMANCEABLE @"Not Possible"
#define FEMALE_ROMANCEABLE @"Possible to Females"
#define MALE_ROMANCEABLE @"Possible to Males"
#define ROMANCEABLE @"Possible to both Genders"
    
    void(^setCompanionExtraDetails)(id,NSString*,NSString*,NSString*,NSString*) = ^(id companion,NSString* likes,NSString* dislikes,NSString* personality,NSString* romanceable) 
    {
        [companion setValue:likes forKey:@"likes"];
        [companion setValue:dislikes forKey:@"dislikes"];
        [companion setValue:personality forKey:@"personality"];
        [companion setValue:romanceable forKey:@"romanceable"];
    };

    //Starship Droids
    id defenderShip = [ships objectForKey:DEFENDER];
    id thunderclapShip = [ships objectForKey:BT7_THUNDERCLAP];
    id xsFreighterShip = [ships objectForKey:XS_FREIGHTER];
    
    id d5MantisShip = [ships objectForKey:D5_MANTIS];
    id furyShip = [ships objectForKey:FURY];
    id x70BPhantomShip = [ships objectForKey:X70B_PHANTOM];
    
    id c2n2 = addShipDroid(@"C2-N2",DROID,@"Crafting and Missions specialist",[NSSet setWithObjects:defenderShip,thunderclapShip,xsFreighterShip,nil]);
    id twovr8 = addShipDroid(@"2V-R8",DROID,@"Crafting and Missions specialist",[NSSet setWithObjects:d5MantisShip,furyShip,x70BPhantomShip,nil]);
    
    setDescription(c2n2,@"C2-N2 is a companion droid assigned to all Republic ships. While unskilled in combat it can be used to craft and perform missions.");
    setCompanionExtraDetails(c2n2,@"None",@"None",LIGHT,NOT_ROMANCEABLE);
    
    setDescription(twovr8,@"2V-R8 is a companion droid assigned to all Empire ships. While unskilled in combat it can be used to craft and perform missions.");
    setCompanionExtraDetails(twovr8,@"None",@"None",DARK,NOT_ROMANCEABLE);
    
    //Trooper Companions
    id trooper = [classes objectForKey:@"Trooper"];
    
    id aricJorgan = addCompanion(@"Aric Jorgan",CATHAR,@"Ranged DPS",trooper,0);
    id elaraDorne = addCompanion(@"Elara Dorne",HUMAN,@"Ranged Healer",trooper,1);
    id m14x = addCompanion(@"M1-4X",DROID,@"Ranged DPS",trooper,2);
    id tannoVik = addCompanion(@"Tanno Vik",WEEQUAY,@"Melee Tank",trooper,3);
    id yuun = addCompanion(@"Yuun",GAND,@"Melee DPS",trooper,4);
    
    setDescription(aricJorgan,@"A born leader, Aric Jorgan is one of the Republic's most capable field officers. He enlisted in the military at an early age and quickly distinguished himself as a talented marksman. His impeccable service record earned him a spot in the Republic's top sniper squad, where he successfully carried out over a dozen missions against high-ranking Imperial targets.\n\nSince his transfer to Fort Garnik, Jorgan has earned a reputation as a hard and demanding taskmaster. However, few realize his surly demeanor belies a genuine concern for the well-being of his troops. While those under his command may not particularly like the brooding Cathar, they almost always respect him.");
    
    setCompanionExtraDetails(aricJorgan,@"Efficiency, Duty, The Republic Military, Honesty",@"Failure, Excuses, Callous Sacrifices",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(elaraDorne,@"A highly talented field medic, Elara Dorne was born Imperial and served in the Empire's military for two years before defecting to the Republic. She has since served with distinction as a search-and-rescue squad leader, earning several commendations for aiding wounded men under direct enemy fire. Her operational record is flawless.\n\nWhat no record can show is that Dorne's background, combined with her strict adherence to regulations and rigid, uncompromising personality, has made her fairly unpopular with her fellow soldiers. In truth, she's widely regarded as a cold, asocial killjoy, an unfortunate side effect of her dedication to embodying the laws and ideals of the Republic.");
    
    setCompanionExtraDetails(elaraDorne,@"Rules, Propriety, Selflessness",@"Unnecessary Violence, Corruption",LIGHT,MALE_ROMANCEABLE);
    
    setDescription(m14x,@"M1-4X is a highly advanced war droid designed and built specifically to serve in Havoc Squad. As such, his engineers programmed him to be a perfect soldier: completely loyal, fervently patriotic, and willing and eager to go to any length or face any risk in order to destroy the Republic's enemies.\n\nM1-4X's armor plating, weapons systems and processing power are significantly advanced over typical military droid standards, due in large part to his unusual power core. Constructed by an unknown group or organization, the core was recovered during a classified operation and has output capabilities far beyond conventional models.");
    setCompanionExtraDetails(m14x,@"Destroying The Republic’s Enemies, Pro-Republic Messages, Courage",@"Anything against The Republic’s Goals",LIGHT,NOT_ROMANCEABLE);
    
    setDescription(tannoVik,@"One of the most talented demolitions experts to ever serve in the Republic military, Tanno Vik is charming, highly skilled, and completely amoral. Born to the lawless streets of Nar Shaddaa, Vik is accustomed to putting his own interests first; enlistment was merely a convenient means of escape after betraying one criminal partner too many.But once he got his hands on the most advanced weapons and explosives in the galaxy, he was hooked.\n\nDuring training, Vik impressed his instructors with his unprecedented speed at locating structural weaknesses in everything from buildings to vehicles, ensuring that he always planted his explosives where they would do the most damage. He was even considered for entry into Special Forces division, but his belligerent attitude and disregard for authority held him back. Criminal accusations were registered against him throughout his short service career, until he was finally convicted for masterminding a protection racket while defending a Republic outpost on Talay. After his discharge, Vik resorted to mercenary work, and still plies his abilities in the galaxy’s deadliest conflict areas to this day.");
    setCompanionExtraDetails(tannoVik,@"Ruthlessness, Mercenary Behavior, Mocking Authority and Everyone Else, Blowing Things Up",@"Kindness, Self-Sacrifice",DARK,NOT_ROMANCEABLE);
    
    setDescription(yuun,@"Even in an organization as diverse as the Republic Army, Yuun stands out. A member of the Gand species and hailing from the Gand homeworld, Yuun is a Findsman, a type of shamanistic tracker held in very high regard among his people. He applies his unusual training to technical tasks of every kind, resulting in a success record unmatched by any other technician in the military.\n\nAs effective as Yuun's methods are, they rarely meet with understanding or approval from his fellow soldiers. But despite his eccentricities, Yuun's fighting skill and calm approach to any challenge generally earn at least the grudging respect of the men and women he serves with.");
    setCompanionExtraDetails(yuun,@"Mysteries, Respect for Unusual People/Beliefs, Patience, Self-Restraint",@"Unnecessary Violency, Chaos, Rudeness, Recklessness, Bragging",LIGHT,NOT_ROMANCEABLE);
                
                   
    [aricJorgan setValue:[locations objectForKey:@"Ord Mantell"] forKey:@"location"];
    [elaraDorne setValue:[locations objectForKey:@"Taris"] forKey:@"location"];
    [m14x setValue:[locations objectForKey:@"Nar Shaddaa"] forKey:@"location"];
    [tannoVik setValue:[locations objectForKey:@"Balmorra"] forKey:@"location"];
    [yuun setValue:[locations objectForKey:HOTH] forKey:@"location"];
    
    //Smuggler Companions
    id smuggler = [classes objectForKey:@"Smuggler"];
    
    id corsoRiggs = addCompanion(@"Corso Riggs",KIFFAR,@"Ranged Tank",smuggler,0);
    id bowdaar = addCompanion(@"Bowdaar",WOOKIE,@"Melee Tank",smuggler,1);
    id risha = addCompanion(@"Risha",HUMAN,@"Ranged DPS",smuggler,2);
    id akaaviSpaar = addCompanion(@"Akaavi Spaar",ZABRAK,@"Melee DPS",smuggler,3);
    id gussTuno = addCompanion(@"Guss Tuno",MON_CALAMARI,@"Healer",smuggler,4);
    
    [corsoRiggs setValue:[locations objectForKey:@"Ord Mantell"] forKey:@"location"];
    [bowdaar setValue:[locations objectForKey:@"Nar Shaddaa"] forKey:@"location"];
    [risha setValue:[locations objectForKey:@"Alderaan"] forKey:@"location"];
    [akaaviSpaar setValue:[locations objectForKey:@"Balmorra"] forKey:@"location"];
    [gussTuno setValue:[locations objectForKey:HOTH] forKey:@"location"];
    
    setDescription(corsoRiggs,@"Corso Riggs is a cheerful, disarmingly optimistic mercenary soldier. Raised as a rancher's son on the rough frontier of Ord Mantell, Corso developed a mixture of naive innocence and primitive toughness, wrapped with old-fashioned chivalry.\n\nIn addition to his gung-ho enjoyment of a good, dirty fight and his encyclopedic knowledge of weapons, Corso remains a ray of sunshine in even the worst circumstances. He has no sense of his own mortality and is absolutely convinced he's going to live forever. Corso also has a soft spot for damsels in distress, even when it's clear they're up to no good.");
    setCompanionExtraDetails(corsoRiggs,@"Protecting the Weak, Being Nice to Ladies, Punishing Bad Guys",@"Hurting for Profit, Hurting Women no matter what they did, Working with Sith or Imperials",LIGHT,FEMALE_ROMANCEABLE);
                   
    setDescription(bowdaar,@"Bowdaar fights in gladiator arenas across the galaxy. In 108 years of competition, he has never been beaten. Some say that Bowdaar is an immortal being with supernatural powers, but those who have faced him in combat and lived to tell the tale know that he is only the best fighter out there.\n\nThough his fights have made and lost fortunes for countless gamblers, Bowdaar has not profited. He is and has been a slave for all of the time he has been in the arena.");
     setCompanionExtraDetails(bowdaar,@"A Good Fight Against Worthy Foes, Protecting the Weak, Personal Honor",@"Cruelty, Bullying, Slavery, Respecting Authority that’s in the Wrong",LIGHT,NOT_ROMANCEABLE);
    
    setDescription(risha,@"Petty criminal, starship mechanic, woman of mystery, royal queen: all of these terms apply to Risha, daughter of notorious crime lord Nok Drayen. Considering her upbringing as a violent gangster's child, it's a wonder Risha turned out remotely normal. Wise and experienced beyond her years, she has led an adventurous life containing some extremely dark chapters.\n\nDespite her biting sarcasm and general selfishness, one can never shake the feeling that Risha would be a better person if only she knew how. Years spent among the galaxy's dregs have fostered layers of personal self-defense mechanisms and a cynical shell around her. Only the most persistent friend has any hope of meeting the \"real\" Risha hiding beneath the surface.");
    setCompanionExtraDetails(risha,@"Self-interest, Profit, Secrets and New Tech",@"Unprofessional or Emotional Behavior, Killing Innocents, Working with the Stupid or Uneducated",NEUTRAL,MALE_ROMANCEABLE);
    
    setDescription(akaaviSpaar,@"Akaavi Spar was born into a respected Mandalorian clan and became one of its finest warriors. She killed her first foe–an abusive Abyssin mercenary–at the age of eight using an improvised flamethrower. This victory earned her the nickname \"firehand\" among her clan and marked the beginning of an impressive career as an Imperial bounty hunter. Akaavi captured and killed all manner of targets in her youth, from career criminals to Jedi. When her entire clan was framed for crimes against the Empire and executed, Akaavi alone survived the brutal purge–but her outlook on the galaxy changed forever. With no connection to her Mandalorian heritage, she became a wandering mercenary loyal to no one.");
    setCompanionExtraDetails(akaaviSpaar,@"Combat Challenges, Profit, Irritating Authority Figures",@"The Republic, Dishonorable Acts, Mercy",DARK,MALE_ROMANCEABLE);
    
    setDescription(gussTuno,@"A failed Jedi Padawan who abandoned his training, the enthusiastically greedy Guss Tuno prefers the underworld lifestyle's potential for material riches. In a perfect galaxy, Guss would spend his retirement lounging in a heated swimming pool surrounded by exotic beauties while consuming a steady diet of fresh fish and expensive cocktails.\n\nAlthough he often speaks before he thinks, Guss has talked his way out of certain death many times. He often uses his minimal knowledge of Jedi--and the lightsaber he stole from his old master--to fool gullible criminals into leaving him alone. When that fails, Guss reveals he's a much better shot than anyone would believe.");
    setCompanionExtraDetails(gussTuno,@"Mocking Force Users, Profit from Those Who Can Afford It, A Good Scam",@"Killing Innocents, Risking Your Neck for Nothing",NEUTRAL,NOT_ROMANCEABLE);
    
    //Jedi Consular Companions
    id jediConsular = [classes objectForKey:JEDI_CONSULAR];
    
    id qyzenFess = addCompanion(@"Qyzen-Fess",TRANDOSHAN,@"Melee Tank",jediConsular,0);
    id theranCedrex = addCompanion(@"Theran Cedrex",HUMAN,@"Ranged Healer/Techie",jediConsular,1);
    id zenith = addCompanion(@"Zenith",TWILEK,@"Ranged DPS",jediConsular,2);
    id ltIreso = addCompanion(@"Lt Ireso",HUMAN,@"Ranged Tank",jediConsular,3);
    id nadiaGrell = addCompanion(@"Nadia Grell",SARKHAI,@"Melee DPS",jediConsular,4);
    
    setDescription(qyzenFess,@"Qyzen Fess was a male Trandoshan hunter during the time of the Cold War.\n\nUnlike many of his kin, he did not become a mercenary, but instead chose the traditional path of a big game hunter, pitting his skills against the deadliest predators the galaxy had to offer. As such, he became a famed hunter and tracker, with his travels taking him from the swamps of Belkadan to the deserts of Tatooine in search of prey. He lost his right eye during one such hunt, and replaced it with a cybernetic prosthesis. Fess bartered his trophies in exchange for supplies and passage to new hunting grounds, and carried few personal possessions. Instead, he kept hold of only his weapons and a tally of his kills that he offered to the Scorekeeper. His hunting trips occasionally brought him into conflict with other sentient beings, including criminals, Mandalorians and even Jedi Masters, with such experiences making him slow to trust outsiders. However, whenever he did make a friend, Qyzen would defend such individuals with his life.");
    
    setCompanionExtraDetails(qyzenFess,@"Killing Powerful Enemies, Encouraging others to Defend themselves, Danger, Honor",@"Killing the Weak, Mercenary Work, Sparing Powerful Enemies",LIGHT,NOT_ROMANCEABLE);
    
    setDescription(theranCedrex,@"Although not a household name, Tharan Cedrax is well-known in several circles. In the casinos of Nar Shaddaa, he is cursed as a card-counting mathematical genius. To the eligible women of the galaxy, he is a famous charmer who sees rejection as an intriguing challenge. Among technologists, he earned accolades for solving a technical paradox that revolutionized computer slicing; despite his achievements, however, Tharan isn't taken seriously by the galaxy's scientific community, which looks down on him as a playboy rather than a serious researcher.\n\nIn recent years, Tharan has taken an interest in \"exo-technology,\" an almost unknown field involving esoteric alien sciences, and gone into business making custom gadgets for wealthy clients. Often accompanied by his lovely holographic companion, Holiday, Tharan has spent his credits freely, enjoying the very best Nar Shaddaa has to offer while staying just shy of its dangers. ");
    
    setCompanionExtraDetails(theranCedrex,@"Cleverness, Logical Thinking, Aiding Scientists and Beautiful Women, Getting Something for Nothing",@"Mystical Jedi Nonsense, Force Persuade, Destroying Science, Heroism that involves Danger",NEUTRAL,FEMALE_ROMANCEABLE);
    
    setDescription(zenith,@"\"Zenith\" is the codename of a Balmorran revolutionary fighter who has made a career out of hurting the Empire. Once a member of a powerful resistance cell broken up by Imperial infiltrators, Zenith has struck out on his own, gathering followers from Balmorra's oppressed population to launch sneak attacks, raids and bombings against the occupying Imperial forces. \n\nYears spent in hiding and seeing the plight of Balmorran citizens have left Zenith with a deep-seated paranoia and hatred of the Empire--especially Balmorra's Sith governor, Darth Lachris. Nothing enrages him more than those who collaborate with the oppressors; he has been known to refuse aid to Balmorrans who cooperate with Imperial soldiers. The sacrifices he has endured have also nurtured Zenith's ambitions--when Balmorra is finally free, someone will have to ensure her new government is strong enough to prevent another occupation.");
    
    setCompanionExtraDetails(zenith,@"Hurting Imperials, Standing up for the Weak, Stubborness, Resolve",@"Mercy to the Empire, Betrayal, Second Chances for those who do Wrong",NEUTRAL,NOT_ROMANCEABLE);
    
    setDescription(ltIreso,@"The son of refugees made homeless during the Great War, Lieutenant Felix Iresso has been a career soldier for many years. His file shows participation in several notable battles, including the so-called Eight-Hour Invasion of Dubrillion where Republic forces repelled an Imperial invasion force with minimal reinforcements. Since then, Lieutenant Iresso has earned excellent technical scores and commendations for exemplary service.\n\nHowever, his file also contains some discrepancies. Lieutenant Iresso has one of the highest transfer rates in the Republic military, serving under almost a dozen commanders across the galaxy in two years. The lieutenant has also been overlooked for promotion several times. The only explanation from his superiors is a reference to an incident on Althir where Lieutenant Iresso was captured by the Empire, but no details are given.");
    
    setCompanionExtraDetails(ltIreso,@"Republic Military, Leadership, Danger for the Greater Good, Honor and Mercy",@"Breaking The Law, Cruelty",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(nadiaGrell,@"A native of distant Sarkhai and daughter of Senator Tobas Grell, Nadia Grell is a newcomer not only to the Republic, but to the entire concept of space exploration. Surrounded by new species and strange cultures, Nadia is eager to experience everything she can. She has become interested in the intricacies of galactic diplomacy while traveling alongside her father, and often acts as hisassistant during talks.\n\nAs she revealed on Attis Station, Nadia is also strong in the Force; unusually strong, in fact. As Force sensitives are relatively unknown on Sarkhai, Nadia's untrained powers left her shunned and feared by her own people. Senator Grell's decision to take her with him when he left Sarkhai was motivated by the hope of finding others like her in the Republic, and perhaps discovering some way for her to control her incredible talents.");
    
    setCompanionExtraDetails(nadiaGrell,@"Learning, Helping the Weak, Charity, Mercy, Testing Her Powers",@"Cruelty, Dark Jedi, Insulting Authority",LIGHT,MALE_ROMANCEABLE);
    
    [qyzenFess setValue:[locations objectForKey:@"Tython"] forKey:@"location"];
    [theranCedrex setValue:[locations objectForKey:@"Nar Shaddaa"] forKey:@"location"];
    [zenith setValue:[locations objectForKey:@"Balmorra"] forKey:@"location"];
    [ltIreso setValue:[locations objectForKey:HOTH] forKey:@"location"];
    [nadiaGrell setValue:[locations objectForKey:BELSAVIS] forKey:@"location"];
    
    //Jedi Knight Companions
    id jediKnight = [classes objectForKey:JEDI_KNIGHT];
    
    id t701 = addCompanion(@"T7-01",DROID,@"Ranged Tank",jediKnight,0);
    id kira = addCompanion(@"Kira Carsen",HUMAN,@"Melee DPS",jediKnight,1);
    id doc = addCompanion(@"Doc",HUMAN,@"Ranged Healer",jediKnight,2);
    id sargentRusk = addCompanion(@"Sargent Rusk",CHAGRIAN,@"Ranged Tank",jediKnight,3);
    id lordScourge = addCompanion(@"Lord Scourge",SITH_PUREBLOOD,@"Melee DPS",jediKnight,4);
    
    setDescription(t701,@"The quirky and stubborn Astromech Droid designated T7-O1 hasn’t been memory-wiped since his activation more than two centuries ago. This rare condition gives T7 a massive knowledge base, with detailed records of every mission he’s ever undertaken and the many friends and enemies made along the way. Because his memories remain intact, T7 has developed a candid personality, a strong independent streak and a unique perspective on the galaxy. Unlike other droids, T7 doesn’t perceive his organic owners as masters, but instead refers to them more like partners. Over the centuries, he has faithfully teamed up with senators, spies, smugglers and even Jedi.\n\nT7 sees himself as protector of his more fragile organic allies, willingly placing himself in harm’s way and always ready to play the hero when innocent lives are in danger. Although he was originally designed for repair and piloting duties, T7 has accumulated many special modifications, expanding his potential uses on and off the battlefield. This little droid is much more than a mechanical servant… he’s a friend and ally to the end.");
    
    setCompanionExtraDetails(t701,@"Jedi, Morally Correct Actions, Defeating The Empire",@"Bullying, Killing Innocents, Disrespecting Authority",LIGHT,NOT_ROMANCEABLE);
    
    setDescription(kira,@"Prone to cynicism and a stubborn independent streak, Kira Carsen is an improbable recruit to the Jedi Order. This is partially excused by the fact that she began her Padawan training as a young adult; Kira had spent most of her life up to that point as a homeless drifter, scraping out a miserable existence on some of the galaxy's most unpleasant worlds.\n\nThanks to her hard-luck upbringing, Kira has considerably more life experience than most Jedi--and a world-weary sophisticate's attitude to match. In the eyes of her peers, Kira is someone who refuses to take anything seriously or fully commit to the Jedi path.\n\nThose who look more closely, however, might detect the glimmer of an optimist peeking through Kira's sarcastic facade. Despite her insistence on questioning its teachings, she has a deep appreciation for the comfort and relative safety she obtained by joining the Jedi Order.");
    
    setCompanionExtraDetails(kira,@"Being Funny, Getting Involved, Mocking and Defeating The Empire",@"Bullying, Acting like a Mercenary, Cooperating with Sith",LIGHT,MALE_ROMANCEABLE);
    
    setDescription(doc,@"The brilliant med-tech known simply as \"Doc\" is driven to bring quality health care to underserved star systems. This has led Doc to keep some unusual company: pathosis-riddled crime lord Fashaka Four-Toes, the Red Band Rebels of Cadinth and even the Imperial military during a brief stint impersonating a member of the Imperial Medical Corps on the conquered planet Sullust.\n\nDoc has a talent for using bad people to save good lives--a fact he emphasizes to anyone within earshot. Some characterize Doc as a blowhard and scoundrel, but these individuals have never required his impressive surgical skills. Doc has visited every major galactic battleground over the past five years and saved more lives than even he can count.");
    
    setCompanionExtraDetails(doc,@"Looking like a Hero, Romance and Flirtation, Helping those in need",@"Looking Bad, Hurting the Innocent, Refusing to Help",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(sargentRusk,@"Raised by a colony of pacifist Chagrians, Rusk rebelled against his family's beliefs and enlisted with the Republic military as soon as he could. At first, he proved to be a brilliant soldier and was identified as a rising star in the Republic's ranks. Somewhere along the way, however, his bravery crossed the line into recklessness.\n\nAlthough he still accomplished his missions, casualty rates among his squad rose astronomically. Rusk quickly became a pariah among other soldiers, including his superiors. His aggressive pursuit of victory over the Empire at any cost has earned him many medals from politicians, but no promotions from his commanders.");
    
    setCompanionExtraDetails(sargentRusk,@"Killing Imperials, Protecting The Republic, Motivating Others to Fight",@"Avoiding Fights, Weakness, Disrespecting Authority",DARK,NOT_ROMANCEABLE);
    
    setDescription(lordScourge,@"As the Sith Emperor's personal executioner, the grimly fatalistic Lord Scourge has personally killed more than a hundred Jedi--and ten times as many Sith. Even the most powerful members of the Dark Council avoid offending the man bearing the title \"the Emperor's Wrath.\"\n\nLord Scourge has dutifully served the Empire for over three hundred years, his life unnaturally prolonged by perverse technology and his master's dark side powers. Centuries spent watching his fellow Sith Lords rise and fall has given Lord Scourge a unique perspective on people. He can analyze someone's flaws after only brief observation, and freely shares his perceptions (whether they're wanted or not).");
    
    setCompanionExtraDetails(lordScourge,@"Using Power against the Weak, Power, Anger, Revenge and Spite",@"Greed, Acts of Mercy, Jedi and Republic Authorities",DARK,NOT_ROMANCEABLE);
    
    [t701 setValue:[locations objectForKey:@"Tython"] forKey:@"location"];
    [kira setValue:[locations objectForKey:@"Coruscant"] forKey:@"location"];
    [doc setValue:[locations objectForKey:@"Balmorra"] forKey:@"location"];
    [sargentRusk setValue:[locations objectForKey:HOTH] forKey:@"location"];
    [lordScourge setValue:[locations objectForKey:HOTH] forKey:@"location"]; 
    //Special Note : Hoth (Empires Palace – Class quest right after Hoth)
    
    //Bounty Hunter Companions
    id bountyHunter = [classes objectForKey:@"Bounty Hunter"];
    
    id mako = addCompanion(@"Mako",HUMAN,@"Ranged Healer",bountyHunter,0);
    id gault = addCompanion(@"Gault",DEVORIAN,@"Ranged DPS",bountyHunter,1);
    id torianCadera = addCompanion(@"Torian Cadera",HUMAN,@"Melee Tank",bountyHunter,2);
    id blizz = addCompanion(@"Blizz",JAWA,@"Ranged Tank",bountyHunter,3);
    id skadge = addCompanion(@"Skadge",HOUK,@"Melee Tank",bountyHunter,4);
    
    setDescription(mako,@"Nobody on Nar Shaddaa knows quite where Mako came from but everyone agrees she was born to be a slicer. By the time she was seven it was clear she had an unnatural affinity for all things computer-related and she quickly taught herself all known programming languages.At eight, Mako crashed the accounts of a Red Light Sector orphanage that was attempting to sell her to the highest bidder. With credits in hand and marketable skills she soon found herself running with some of the more notorious slicer gangs on Nar Shaddaa.\n\nSeven years later Mako was found wounded in an alley by an aging bounty hunter named Braden. He needed a tech specialist for his crew and she needed to get off the moon until the Hutt Cartel job her 'friends' had so spectacularly blown faded a bit from memory. With Braden and his crew, Mako discovered a love of underground bounty hunter culture, a code of honor that gave her life structure and most importantly, her first real family.");
    
    setCompanionExtraDetails(mako,@"Professionalism, bounty hunters, making money, freedom, kindness",@"Bullying, cruelty, snobs",LIGHT,MALE_ROMANCEABLE);
    
    setDescription(gault,@"Formerly the notorious smuggler and confidence man Tyresius Lokai, Gault Rennow now enjoys a relatively paranoia-free lifestyle as an unknown gun-for-hire. Still, old habits are hard to shake, and Gault's cautiousness and duplicity are a constant reminder that the only thing to really change is his name. How long until the crafty Devaronian finds himself climbing up the galaxy's most wanted list again is anyone's guess.");
    
    setCompanionExtraDetails(gault,@"Greed, indulgence, thinking your way through a problem",@"Fair fights, pain, charity, rules",DARK,NOT_ROMANCEABLE);
    
    setDescription(torianCadera,@"It is the Mandalorian ideal that a warrior be judged by his or her own actions, not by those of his or her ancestors--but reality rarely lives up to ideals.\n\nTorian Cadera has spent his entire short life trying to overcome the stigma of being a traitor's son--a shame he has seldom been allowed to forget in the company of his peers. But Torian long ago learned to armor himself against contempt, and others' doubts regarding his loyalty have only driven him to strive harder to prove his worth.\n\nBecause of this, Torian adheres to the codes and traditions of the Mandalorians with more devotion than many twice his age. Upholding honor and enduring adversity are the cornerstones of his existence.");
    
    setCompanionExtraDetails(torianCadera,@"Challenges, honor, Mandalorians, respect",@"Selling out, cowardice",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(blizz,@"Infinitely curious and adventuresome, Blizz always felt confined on his native Tatooine--the endless rolling dunes and limited selection of scrap leaving him perpetually bored. So when the traveling salvager Slam Streever visited Blizz's clan to offer Jawas work as \"ferrets\"--individuals he could send into dangerous and dilapidated areas to scout for salvage treasure--Blizz leapt at the opportunity.\n\nBlizz spent several years with Slam's crew before the old scrapper made the mistake of selling his services to Hoth's White Maw pirates. Years of toil under the menacing watch of the White Maw would soon deprive the salvagers of reasons to smile--but first, Slam gave his small friend the nickname \"Blizz\" after the little Jawa kicked up a snowstorm of excitement during his first encounter with the \"white sands.\" It's a name Blizz cherishes; one that reminds him of happier times.");
    
    setCompanionExtraDetails(blizz,@"Adventure, gadgets, attention, praise, friendship",@"Scary things, extreme violence, people who are mean to him",LIGHT,NOT_ROMANCEABLE);
    
    setDescription(skadge,@"A career gangster and psychopath, Skadge had been enjoying a prestigious position at the top of Coruscant's most wanted list when a joint police, military and SIS task force managed to finally capture him. Deemed impossible to control or reform, the murderous Houk was secretly ushered to the only facility capable of housing him: Belsavis.\n\nAlthough considered a prime candidate for the prison's domination experiments, Skadge was removed from the program during his initial evaluation--a period over which he destroyed a gang of armed Kaleesh, every remaining member of his test group, half the observing researchers and three security details... with his bare hands.\n\nNow, with the Imperial invasion of Belsavis, Skadge has been set loose after nearly three years of solitary confinement. He's ready to settle some grudges.");
    
    setCompanionExtraDetails(skadge,@"Violence, causing suffering, destruction, bullying",@"Compromise, taking orders, weakness",DARK,NOT_ROMANCEABLE);

    [mako setValue:[locations objectForKey:@"Hutta"] forKey:@"location"];
    [gault setValue:[locations objectForKey:@"Tatooine"] forKey:@"location"];
    [torianCadera setValue:[locations objectForKey:@"Taris"] forKey:@"location"];
    [blizz setValue:[locations objectForKey:HOTH] forKey:@"location"];
    [skadge setValue:[locations objectForKey:BELSAVIS] forKey:@"location"]; 
    
    //Imperial Agent Companions
    id imperialAgent = [classes objectForKey:@"Imperial Agent"];
    
    id kaliyoDjannis = addCompanion(@"Kaliyo D'jannis",RATTATAKI,@"Ranged Tank",imperialAgent,0);
    id vectorHyllus = addCompanion(@"Vector Hyllus",HUMAN,@"Melee DPS",imperialAgent,1);
    id doctorLokin = addCompanion(@"Doctor Lokin",HUMAN_RAKGHOUL,@"Melee Tank",imperialAgent,2);//Special Note : turns into Rakghoul as his tanking form
    id ensignRainaTemple = addCompanion(@"Ensign Raina Temple",HUMAN,@"Ranged Healer",imperialAgent,3);
    id scorpio = addCompanion(@"Scorpio",DROID,@"Ranged DPS",imperialAgent,4);
    
    setDescription(kaliyoDjannis,@"The CorSec criminal report for Kaliyo Djannis contains a pixelated holoimage showing a top Exchange gangster with his arm draped affectionately around a tiny Rattataki woman. In one hand, the woman is triumphantly hoisting an assault rifle; with the other, she's lifting a wine bottle to her associate's lips.The image is labeled 'Kaliyo Djannis and Vanus Cruor--First Meeting.'\n\nThanks to contradictory accounts, Kaliyo's personal history is murky at best. For at least a decade, she's worked as a freelance enforcer and assassin for a half-dozen criminal syndicates, served time in prison, and kept close ties to a violent anarchist cell. Whether she's genuinely political or just in it for the thrills, nobody seems to know.\n\nOnly when firepower fails Kaliyo does she fall back on her charm--and the underworld does seem to find her dangerously charming. Jilted associates describe her as manipulative, while other colleagues remain infatuated long after her departure. Regardless, anyone working with or against Kaliyo should be extremely cautious--no one walks away from the Rattataki unscathed.");
    
    setCompanionExtraDetails(kaliyoDjannis,@"Disrespecting authority, casual violence, anarchy for the fun of it",@"Self sacrifice for the greater good, sincerity, obedience, patriotic spirit and being taken advantage of",DARK,MALE_ROMANCEABLE);
    
    setDescription(vectorHyllus,@"Second-generation Imperial; mother native to Jurio, married Captain Adronik Hyllus after Jurio was granted Imperial governance. Expressed desire to join Diplomatic Service at early age and displayed appropriate traits. Ranked high academically during training, and soon after graduation was granted (by request) post aboard exploration and first contact vessel (see service record).\n\nReassigned to Alderaan due to diplomatic manpower needs (see House Thul). Served ably until encounter with Killik species and subsequent \"Joiner\" transformation. Current status is unclear.");
    
    setCompanionExtraDetails(vectorHyllus,@"Diplomacy, helping people, exploring alien cultures",@"Greed, cruelty, prejudice, anti-alien sentiment",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(doctorLokin,@"Doctor Lokin was a male Human hybrid alive during the Cold War. Somehow, Doctor Lokin had the ability to transform into a Rakghoul, infectious creatures created by Sith Lord Karness Muur who were most famously found in the Undercity of Taris.\n\nAge and surname suggest Lokin was born on Dromund Kaas during the pre-war years. Files acquired during Operation: Freefall reference a \"Doctor E. Lokin\" working as a Science and Medical Advisor to Kaas City military police during this period, but no visual is provided.\n\nFirst confirmed sighting was during the boarding of Imperial dreadnaught Warhammer-Lokin was one of the two individuals aboard who evaded capture. Interestingly, he was not listed in the crew roster. First identification as Fixer Fifteen came during Operation: Red Cell. Additional sightings and references to the Fixer Fifteen designation uncovered intermittently since.\n\nTake a close look at the operations where we caught Lokin, and you'll notice a pattern-every time he turns up, something big is happening and we cant' figure the role he's playing. He's professional, he knows his science and he's sneaky. We know he rubs some of his colleagues the wrong way, but even his fellow agents haven't given us anything useful under questioning.");
    
    setCompanionExtraDetails(doctorLokin,@"Clever solutions, long-term thinking, technology, pragmatism",@"Ideology, honesty, selfish actions without clear long-term gain",NEUTRAL,NOT_ROMANCEABLE);
    
    setDescription(ensignRainaTemple,@" Standard searches reveal no Imperial citizenship record for a \"Raina Temple,\" but the usual caveats apply--our data on the Imperial populace remains sadly incomplete. Temple's skills and attitude suggest Imperial Army training, but her presence inside the Chiss Expansionary Defense Force is extremely unusual; neither the CEDF nor the Imperial military is known for its transfer programs.\n\nPersonable and bright Imperial military cadets don't end up embedded with aliens at the far edge of the galaxy without good reason. Temple could be a plant, but it's just as likely she's been intentionally forced out of the picture. Best-guess personality profile suggests she's a typically patriotic example of the rank-and-file Imperial military--a true believer in Imperial superiority and duty. No matter how easygoing or empathetic she may be at times, the needs of her nation have to come first.");
    
    setCompanionExtraDetails(ensignRainaTemple,@"The Empire, the Sith, duty, honor",@"Cruelty, casual violence, selfishness",LIGHT,MALE_ROMANCEABLE);
    
    setDescription(scorpio,@"Claims to have been designed for heuristic self-improvement by unknown parties. Current chassis is of recent design, suggesting multiple precursor bodies or independent database.\n\nOver a century ago, SCORPIO became involved with Star Cabal organization and accepted guardianship of Belsavis Megasecurity Ward 23. In return for rare technology, SCORPIO willingly acted as the Star Cabal's security system until application of control codes by Cipher Nine. Currently unable to directly harm Cipher Nine without provocation or depart Cipher Nine's presence on a long-term basis.\n\nApplication of Wreyn-Tsatke Cyber-Psychology Scale results in a 9-NIX rating for SCORPIO (level 9 intelligence, nonhuman, independent, unknown) with 22% accuracy. These preliminary results match anecdotal experience--SCORPIO places no inherent value on biological or cybernetic life and is interested primarily in self-iteration through rapid experience. If given appropriate challenges and upgrade opportunities, SCORPIO may prove cooperative for limited periods. She appears to value others who share her traits--intelligence, amoral self-interest and curiosity.");
    
    setCompanionExtraDetails(scorpio,@"Learning and gaining new tech, selfishness, killing threats",@"Self-sacrifice, duty, wastefulness",DARK,NOT_ROMANCEABLE);
    
    [kaliyoDjannis setValue:[locations objectForKey:@"Hutta"] forKey:@"location"];
    [vectorHyllus setValue:[locations objectForKey:@"Alderaan"] forKey:@"location"];
    [doctorLokin setValue:[locations objectForKey:@"Taris"] forKey:@"location"];
    [ensignRainaTemple setValue:[locations objectForKey:@"Hoth"] forKey:@"location"];
    [scorpio setValue:[locations objectForKey:BELSAVIS] forKey:@"location"]; 
    
    //Sith Inquisitor Companions
    id sithInquisitor = [classes objectForKey:SITH_INQUISITOR];
    
    id khemVal = addCompanion(@"Khem Val",DASHADE,@"Melee Tank",sithInquisitor,0);
    id andronikosRevel = addCompanion(@"Andronikos Revel",HUMAN,@"Ranged DPS",sithInquisitor,1);
    id asharaZavros = addCompanion(@"Ashara Zavros",TOGRUTA,@"Melee DPS",sithInquisitor,2);
    id talosDrellik = addCompanion(@"Talos Drellik",HUMAN,@"Ranged Healer",sithInquisitor,3);
    id xalek = addCompanion(@"Xalek",KALEESH,@"Melee Tank",sithInquisitor,4);
    
    setDescription(khemVal,@"Centuries ago, Khem Val was the proud servant of Tulak Hord, one of the greatest Dark Lords of the Sith to ever live. His people, the Dashade, thrived. A powerful species of Force-resistant killers, they drew strength from feeding on Jedi and Sith alike. Khem Val was called Shadow Killer and Devourer. As his master conquered, he feasted, and the unusual bond between the Sith Lord and the Shadow Killer grew stronger.\n\nBut that was centuries ago. The Dashade have all but disappeared from the galaxy, and the details of Khem Val’s legend have faded to formless, creeping fear. Deep in the tomb of Naga Sadow on Korriban, Khem Val sleeps, suspended in a stasis field guarded by crackling electric energy. No one knows how he got there, or how to wake him. Even the greatest Sith Lords do not dare try. For when he wakes, he is sure to be hungry...");
    
    setCompanionExtraDetails(khemVal,@"Killing Force users, displays of strength, making foolish people unhappy",@"Weakness in any form, not killing Force users",DARK,NOT_ROMANCEABLE);

    setDescription(andronikosRevel,@"For five notorious years, the pirate Andronikos Revel terrorized Republic and Imperial space alike as the captain of the Sky Princess. Known for his sharp temper and sharper flying skills, Revel was one of the few pirate captains to serve as his own pilot.\n\nHis piracy career was cut short by a strange mutiny, however, and he was abandoned to the Imperials who had been hunting him since he'd raided a ship carrying valuable artifacts. After a year in Imperial prison, Andronikos Revel was let loose. He has been meticulously hunting and killing the mutineers who betrayed him ever since.");
    
    setCompanionExtraDetails(andronikosRevel,@"Action, keeping promises, complications",@"Authority, betrayal, backing down from a fight",NEUTRAL,FEMALE_ROMANCEABLE);
    
    
    setDescription(asharaZavros,@"A twenty-year-old Togruta Padawan, Ashara Zavros descends from a long line of Force-users. From an early age, she has aspired to study the Force and become one of the best Jedi the order has to offer.\n\nAshara came to Taris to train under Jedi Masters Ryen and Ocera, whose philosophy is that Padawans best learn the travails of using the Force through firsthand experience of the galaxy. In Ashara's case, the Masters brought her to Taris for two reasons: First, to teach her compassion amidst the destruction that had occurred there and warn against the dangers of pride and the dark side. Second, to complete her trials by helping to drive a dark ghost from the ruins of a Jedi enclave.");
    
    setCompanionExtraDetails(asharaZavros,@"Rational choices, secrets of the Force, fighting bullies",@"Random cruelty, fighting Jedi",LIGHT,MALE_ROMANCEABLE);
    
    setDescription(talosDrellik,@"Lieutenant Talos Drellik has never excelled as a soldier, and his true passion has always been history and archeology. To Talos, the Imperial Reclamation Service does an invaluable job, preserving Imperial and Sith history against the onslaught of time.\n\nUnlike many Reclamation Service officers who are career soldiers with only a passing interest in history, Lieutenant Drellik has thrown himself into his work, studying with experts in the field such as the illustrious Professor Auselio Gann and galactic historian Deravon Wells.");
    
    setCompanionExtraDetails(talosDrellik,@"Artifacts, discovery, history, pro-Empire sentiment, clever word play",@"Cruelty, rudeness, secrets from allies",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(xalek,@"A Kaleesh warrior who was captured by the Empire in battle and brought to Korriban to train as a Sith, Xalek prefers to let his actions speak in place of words. Before even reaching Korriban, Xalek had killed several of his fellow slaves who were also intended for training--a bold statement by any measure.\n\nXalek melds his training as a Kaleesh warrior with a firm belief in the Sith Code. He kills without remorse, and is an expert student of lightsaber technique and martial combat.");
    
    setCompanionExtraDetails(xalek,@"Following the Sith Code, fighting overwhelming odds, brevity",@"Mercy, weakness, talking",DARK,NOT_ROMANCEABLE);
    
    [khemVal setValue:[locations objectForKey:@"Korriban"] forKey:@"location"];
    [andronikosRevel setValue:[locations objectForKey:@"Tatooine"] forKey:@"location"];
    [asharaZavros setValue:[locations objectForKey:@"Taris"] forKey:@"location"];
    [talosDrellik setValue:[locations objectForKey:HOTH] forKey:@"location"];
    [xalek setValue:[locations objectForKey:@"Voss"] forKey:@"location"]; //Special Note : After Voss
    
    //Sith Warrior
    id sithWarrior = [classes objectForKey:SITH_WARRIOR];
    
    id vette = addCompanion(@"Vette",TWILEK,@"Ranged DPS",sithWarrior,0);
    id malaviQuinn = addCompanion(@"Malavi Quinn",HUMAN,@"Ranged Healer/DPS",sithWarrior,1);
    id jaesaWillsaam = addCompanion(@"Jaesa Willsaam",HUMAN,@"Melee DPS",sithWarrior,2);
    id lieutenantPierce  = addCompanion(@"Lieutenant Pierce",HUMAN,@"Ranged Tank",sithWarrior,3);
    id broonmark = addCompanion(@"Broonmark",TALZ,@"Melee Tank",sithWarrior,4);
    
    setDescription(vette,@"Few people have seen as much of the galaxy as Vette and few have had as little control of their destiny. Born a slave on the occupied world of Ryloth, Vette was separated from her family at an early age and sold to a series of minor crime lords. When legendary pirate lord Nok Drayen utterly destroyed her latest owner's holdings, Vette and the other slaves were given their choice of freedom or joining up with Nok. Vette became a pirate, travelling the known worlds and learning to get in and out of places she wasn't allowed.\n\nYears later Nok Drayen mysteriously and suddenly released all of his people from service. Vette was left on Nar Shaddaa where she joined up with other young, idealistic Twi'leks and used her criminal abilities to rob and ruin those who exploited Ryloth's cultural artifacts and people. An unquenchable spark, Vette is older than her years but far from mature, delighting in silly pranks and always ready to laugh at people who think too much of themselves.");
    
    setCompanionExtraDetails(vette,@"Anti-authority behavior, protecting the weak, treasure and getting paid",@"Bullying, killing innocents, kissing up",NEUTRAL,MALE_ROMANCEABLE);
    
    setDescription(malaviQuinn,@"An officer in the Imperial military, Malavai Quinn is loyal to the Empire and everything it stands for: order, the glory of the Sith and the conquest of the Republic. Following his mysterious disgrace at the Battle of Druckenwell, he was stationed on Balmorra where he occasionally carried out small missions for Darth Baras (to whom he owes much of his career's early success).\n\nDuty-bound and honorable, Quinn is not afraid to express earned admiration for his superiors, but he is neither a bootlicker nor a mindless servant. He values competence alongside loyalty and will do whatever is necessary to thwart the enemies of the Empire as a whole and Darth Baras personally.");
    
    setCompanionExtraDetails(malaviQuinn,@"Patriotism to the Empire, rewarding hard work, honor",@"Selfishness, betrayal, irrational behavior",LIGHT,FEMALE_ROMANCEABLE);
    
    setDescription(jaesaWillsaam,@"Once in a millennium, a man or woman is born who expands the frontiers of what Force-users can achieve. Proud young Jedi Padawan Jaesa Wilsaam discovered the unprecedented ability to discern any being's true nature and uncover a person's most secret intentions. Born to a family of servants on Alderaan, she was brought to the Jedi Order and trained by Master Nomen Karr.\n\nBut Nomen Karr could only protect and shield his Padawan from the world for so long. Through the machinations of Darth Baras, Jaesa was drawn away from the protection of the order and confronted by Baras's own apprentice--and with the emotional instability of her Master.\n\nHaving finally witnessed the Jedi Order's weakness and the dark side's true power, Jaesa embraces the Sith path with reckless abandon. She now knows that the only truth-inducing force in the galaxy is fear.");
    
    setCompanionExtraDetails(jaesaWillsaam,@"(LIGHT)Helping the weak, secrets of the Force, honor,(DARK)Random cruelty, secrets of the Force, murder and chaos",@"(LIGHT)Random cruelty, hurting innocents, rudeness,(DARK)Honor, mercy, helping people",@"There is a Light and Dark variation",@"Possible to Dark Males");
    
    setDescription(lieutenantPierce,@"While few who are not Force-sensitive in the Empire have any choice but to join the military, Lieutenant Pierce joined eagerly--not out of a sense of duty but out of a lust for action. In fact, although his soldiering and his bravery are beyond question, Pierce has faced resistance and scrutiny throughout his military career due to his occasionally reckless attitude and his disdain for authority.\n\nFortunately, Pierce's years in military black operations groups kept him away from the stuffier elements of the military hierarchy. Very often, Pierce is assigned to the most dangerous and far-flung worlds, where the Empire's primary goal is destruction--which suits the lieutenant just fine.");
    
    setCompanionExtraDetails(lieutenantPierce,@"Personal gain, hurting the Republic, danger and laughing at authority",@"Rules, kssing up, peace",DARK,NOT_ROMANCEABLE);
    
    setDescription(broonmark,@"Broonmark is a unique creature among the Talz. While his peers spent their youths learning survival skills and playing on the frozen tundra of Alzoc Three, Broonmark developed a fascination with death. As a child, Broonmark watched his father killed by one of Alzoc Three's predators, and instead of sadness, Broonmark felt only shame at his father's weakness. Violence became an obsession and point of pride for Broonmark; he started hunting in secret and lived for the rush of a kill.\n\nWhen the Republic began recruiting Talz for their elite commando units, Broonmark eagerly volunteered for the chance to turn his claws against more challenging prey. But with each kill Broonmark's desire for carnage and bloodshed intensified. His clan soon challenged his brutal leadership, and Broonmark watched in anger as the gentle Talz he fought to empower mutinied against him.");
    
    setCompanionExtraDetails(broonmark,@"Violence as a solution, testing yourself, protecting those close to you",@"Betrayal of allies, inaction, talking things out",DARK,NOT_ROMANCEABLE);
    
    [vette setValue:[locations objectForKey:@"Korriban"] forKey:@"location"];
    [malaviQuinn setValue:[locations objectForKey:@"Balmorra"] forKey:@"location"];
    [jaesaWillsaam setValue:[locations objectForKey:@"Hutta"] forKey:@"location"];
    [lieutenantPierce setValue:[locations objectForKey:@"Taris"] forKey:@"location"];
    [broonmark setValue:[locations objectForKey:HOTH] forKey:@"location"];
}
-(void)addFlashpoints
{
    id(^addFlashpoint)(NSString*,NSString*,NSString*) = ^(NSString* name,NSString* alligianceAvaliability,NSString* gameLevel) 
    {
        id flashpoint = [NSEntityDescription insertNewObjectForEntityForName:@"SGFlashpoint" inManagedObjectContext:moc];
        [flashpoint setValue:name forKey:@"Name"];
        [flashpoint setValue:alligianceAvaliability forKey:@"Allegiance"];
        [flashpoint setValue:gameLevel forKey:@"GameLevel"];
        
        [flashpoint setValue:[NSString stringWithFormat:@"flashpointPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        return flashpoint;
    };
    
    id blackTalon = addFlashpoint(@"The Black Talon",ALLEGIANCE_EMPIRE,@"Early Game (lvl 8+)");
    [blackTalon setValue:@"Imperial Grand Moff Kilren wanted a defector held aboard the Republic Thranta-class warship Brentaal Star so he tasked Captain Revinal Orzik to intercept it, when the captain disobeys the order he dispatches a group of heroes to discipline the Captain.\n\nThe Player(s) and companion(s) board the transport and fight against Sith Marines to be able to reach the bridge in order to find out what was going on." forKey:@"Description"];
    
    id theEsseles = addFlashpoint(@"The Esseles",ALLEGIANCE_REPUBLIC,@"Early Game (lvl 8+)");
    [theEsseles setValue:@"When a Republic transport secretly carrying a high-profile passenger is attacked by Imperials, your team must defend the ship and eventually must decide the passenger’s fate." forKey:@"Description"];
    
    id athiss = addFlashpoint(@"Athiss",@"All Factions",@"Mid Game (lvl 17-21)");
    [athiss setValue:@"You have been asked to assemble a team to investigate a distress signal coming from the planet Athiss. Once home to an ancient and mad Sith Lord, there are concerns that a Republic survey team sent there may have disturbed something best left to lie.\n\nFor most galactic travelers, the planet Athiss barely warrants a second glance on the scanner. It appears to be nothing more than a small world off the Descri Wris hyperlane, with little of interest besides a scattering of unexplored ruins.\n\nBut the Jedi Archives tell a grim story. The Jedi Master Chamma visited Athiss early in his career and clashed with a dark side entity there. The duel, and the oppressive feeling of evil on Athiss's surface, drove Chamma close to the dark side of the Force. Shaken by the experience, he went into a self-imposed exile; it was almost a century before he came to terms with what he had seen and felt on Athiss, and was able to return to the order." forKey:@"Description"];
    
    id boardingParty = addFlashpoint(@"Boarding Party",ALLEGIANCE_EMPIRE,@"Mid Game (lvl 32+)");
    [boardingParty setValue:@"When a high-level Republic prisoner escapes from an Imperial prison, your team must track down the target and prevent an audacious attack to destroy the Sith Empire." forKey:@"Description"];
    
    id colicoidWarGame = addFlashpoint(@"Colicoid War Game",@"All Factions",@"Mid Game (lvl 41+)");
    [colicoidWarGame setValue:@"The Colicoids are an insectoid species that specialize in the development and sale of weapons and technology. Throughout the war, the Colicoids have sold their wares to both sides, but now they wish to align themselves with one faction. To see which side is more deserving of their business, the Colicoids have constructed an advanced war game on a remote asteroid located somewhere in the Outer Rim.\n\nTo gain the favor of the Colicoids and deny the enemy of valuable weaponry, both the Republic and the Empire have agreed to take part in the war game. Now both factions must send their most elite warriors to the asteroid, where they will battle against both the many traps that have been laid, and the Colicoids themselves." forKey:@"Description"];
    
    id directive7 = addFlashpoint(@"Directive 7",@"All Factions",@"Late Game");
    [directive7 setValue:@"Mutinous droids on a remote moon develop a technology that could lead to massive destruction for both the Republic and the Empire. Your team must shut down the rebellion before it’s too late." forKey:@"Description"];
    
    id mandalorianRaiders =  addFlashpoint(@"Mandalorian Raiders",@"All Factions",@"Mid Game (lvl 21+)");
    [mandalorianRaiders setValue:@"A rogue faction of Mandalorians under the banner of Clan Varad has stolen the Republic warship Allusis, and they are using it to wreak havoc on vulnerable worlds in the Outer Rim. Darth Malgus charged you with gathering a boarding party to seize control of the ship and put an end to the clan's attacks on Imperial colonies." forKey:@"Description"];

    
    id taralV = addFlashpoint(@"Taral V",ALLEGIANCE_REPUBLIC,@"Mid Game (lvl 32+)");
    [taralV setValue:@"Imperials are holding a Jedi prisoner who is critical to the Republic war effort. Your team must travel deep into enemy territory to recover the key to liberating this Republic hero." forKey:@"Description"];
    
     id hammerStation = addFlashpoint(@"Hammer Station",@"All Factions",@"Early Game (lvl 14-22)");
      [hammerStation setValue:@"The ‘Hammer,’ a powerful prototype battle station developed by the Republic, was thought to have been destroyed in the war, but it has mysteriously reappeared in the possession of the expansionist Advozsec. Determined to assert their new power, the Advozsec have been using the weapon to conquer neutral worlds in the Outer Rim. Now, before the Hammer can strike again, both the Galactic Republic and Sith Empire have set plans in motion to bring the station down." forKey:@"Description"];
    
    id maelstromPrison = addFlashpoint(@"Maelstrom Prison",ALLEGIANCE_REPUBLIC,@"Mid Game (lvl 33-37)");
    [maelstromPrison setValue:@"A Jedi Master named Oteg recruited you for a top secret mission: Enter the Empire’s impregnable Maelstrom Prison and free a captive Jedi with vital information on the enemy’s plans.\n\nLocated along the Relgim Run, the vast Maelstrom Nebula has hampered navigators and explorers for centuries; the nebula’s unpredictable electromagnetic radiation means the safe routes through the Maelstrom change every few minutes. When the Empire came into possession of an ancient Gree computer capable of calculating safe passage through the Maelstrom, however, Imperial strategists decided the nebula would be the perfect location to house high-risk prisoners.\n\nThe Maelstrom Prison is a massive space station that uses both modern and ancient methods of containment. Intelligence recovered by the Republic SIS suggests some chambers were built according to specifications provided by the Emperor himself. The exact number of prisoners held is unknown, but tentative projections put the number at less than thirty; this, in turn, suggests that freeing any of the inmates would be a significant blow to the Empire." forKey:@"Description"];
    
    id theFountry = addFlashpoint(@"The Foundry",ALLEGIANCE_EMPIRE,@"Mid Game (lvl 36+)");
     [theFountry setValue:@"The Empire has learned that a mysterious Jedi Master has rediscovered an ancient alien space station called the Foundry. You joined the force sent to capture the Foundry and eliminate the Jedi.\n\nBuilt into a massive asteroid in a long-forgotten star system, the Foundry is an engineering marvel. According to data obtained by Imperial Intelligence, the Foundry has at least twelve manufacturing levels capable of producing thousands of droids. Vast tunnels honeycombing the asteroid suggest automated mining droids were used to pick the interior clean of any useful ores. The Imperial Reclamation Service believes the Foundry now uses a network of tractor beams to capture and break apart nearby asteroids, providing raw materials for its endless mass production.\n\nThe Foundry appears to be at least twenty to thirty thousand years old, built by a long-forgotten alien species. Its specifications resemble those of three other space stations discovered by the Empire, each possessing vast power--one, the \"Star Forge,\" constructed fleets of warships, while another was capable of xenoforming entire planets. The extent of the Foundry's production capabilities are as yet unknown, but if history is any guide, the station could change the galaxy." forKey:@"Description"];
    
    id redReaper = addFlashpoint(@"The Red Reaper",@"All Factions",@"Late Game (lvl 45+)");
    [redReaper setValue:@"In the century before the Sith Empire’s return to the known galaxy, the powerful Sith Lord Ikoral was among the Emperor’s most honored servants. Ikoral, himself a Sith Pureblood, believed in the genetic superiority of pureblooded Sith and became obsessed with discovering other Purebloods that fled from Korriban centuries ago. Over time Ikoral convinced the Dark Council to allow him to search for these lost Sith, and he set off with an expeditionary fleet.\n\nSeventy years have passed. Darth Ikoral has returned from his expedition with an army of mad Sith, and has begun a campaign to purify the galaxy of those he deems as unworthy. Having already laid waste to an Imperial fortress at the edge of the galaxy, Ikoral now sets his sights on the Republic-controlled world of Chandrila. While the Republic scrambles to defend their world, the Empire plots its revenge against Ikoral for his betrayal. Both factions now assemble elite groups of their strongest warriors to board his flagship and defeat Ikoral once and for all." forKey:@"Description"];
    
    id theBattleOfIlum = addFlashpoint(@"The Battle of Ilum",@"All Factions",@"Late Game (lvl 50)");
    [theBattleOfIlum setValue:@"An old friend of the Empire turned traitor now seeks to destroy it using their own weapons against them. The Empire strike-group will secure a stealth ship to steal themselves onto the betrayer’s station. Escorted by the Imperial guard, the team must fight their way through his forces and ultimately win the day for the Empire." forKey:@"Description"];
    
    id theFalseEmperor = addFlashpoint(@"The False Emperor",ALLEGIANCE_EMPIRE,@"Late Game (lvl 50)");
    [theFalseEmperor setValue:@"Darth Malgus has declared himself the leader of a new inclusive Empire that will unite the galaxy by purging the old, weak Empire and eradicating the Republic.\n\nYou successfully thwarted Malgus's invasion of Ilum and secured a stealth command ship from the invading fleet. Board the stealth command ship, and prepare to take the fight to Darth Malgus aboard his space station." forKey:@"Description"];
    
    id Cademimu = addFlashpoint(@"Cademimu",@"All Factions",@"Mid Game (lvl 26-32)");
    [Cademimu setValue:@"Cademimu is a dungeon for levels 26-32. It takes place on a planet that has seceded from the Republic. For Empire side players, your goal is to take out the missile batteries so the Empire may move in and take over the planet." forKey:@"Description"];
    
    id kaonUnderSiege = addFlashpoint(@"Kaon Under Siege",@"All Factions",@"Late Game (lvl 50)");
    [kaonUnderSiege setValue:@"The Tion Hegemony is in utter chaos. A mysterious outbreak of the Rakghoul plague has spread across several worlds, killing countless civilians while mutating others into Rakghouls themselves. On the planet of Kaon a small group of survivors fight against the endless waves of Rakghoul monstrosities. Now both the Galactic Republic and the Sith Empire have set plans in motion to rescue the survivors of Kaon, locate the source of the virus, and forge an alliance with the Tion Hegemony." forKey:@"Description"];
    
    id theLostIsland = addFlashpoint(@"The Lost Island",@"All Factions",@"Late Game (lvl 50)");
     [theLostIsland setValue:@"The survivors of Kaon have been rescued, and the truth of the Rakghoul outbreak has been learned; a scientist, branded a traitor by the Tion Hegemony years earlier, released the virus in an attempt to eliminate the Tion nobility. With his plan thwarted and his identity revealed, the scientist has gone into hiding while continuing to plot his takeover of the Tion Hegemony.\n\nThough he believes himself to be safe, agents for both the Republic and the Empire have traced him to a small island on Ord Mantell. Now both factions assemble strike teams to dispatch to Ord Mantell to battle their way through twisted monstrosities before confronting the scientist in his island laboratory. While the Republic wants to see the Rakghoul virus destroyed, the Empire sees an opportunity to take the virus for itself and turn it into a powerful weapon…" forKey:@"Description"];
}
-(void)addWarzones
{
    id(^addWarzone)(NSString*,BOOL) = ^(NSString* name,BOOL isFactionSeperated) 
    {
        id warzone = [NSEntityDescription insertNewObjectForEntityForName:@"SGWarzone" inManagedObjectContext:moc];
        [warzone setValue:name forKey:@"Name"];
        [warzone setValue:[NSNumber numberWithBool:isFactionSeperated] forKey:@"isFactionSeperated"];
    
        [warzone setValue:[NSString stringWithFormat:@"warzonePreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        return warzone;
    };
    
    id huttball = addWarzone(@"Huttball",NO);
    [huttball setValue:@"Huttball is a PvP warzone located on neutral planet of Nar Shaddaa. Due to the planet's neutral nature, competing teams from the Republic or the Empire can battle teams from the same faction.\n\nHuttball itself is a spectator sport sponsored by Hutt cartels. The basic goal is to grab the ball at the center of the field by right-clicking on the ball itself, then take it across the opposing team's endline. Players can move the ball by running, jumping, and throwing passes. Incomplete passes reset the ball to the central platform. Defensive play seems to primarily be violent attacks against anyone not on your team. Killing the character who currently has the ball transfers the ball to you. The game is timed, and in case of tied scores, the team with final possession wins. After each game, a leaderboard is displaying showing various stats for the players." forKey:@"Description"];
    [huttball setValue:[locations objectForKey:@"Nar Shaddaa"] forKey:@"location"];
    [huttball setValue:@"Indoor arena filled with traps layed out over three levels." forKey:@"terrain"];
    
    id alderaan = addWarzone(@"Alderaan Warzone",YES);
    [alderaan setValue:@"The Alderaan Warzone consists of two teams of 8 players per team. Upon loading into the Warzone and beginning the match, players will start in Drop Ships located above the Warzone. Players will transport to the ground on speeder bikes and fight in an objective-based PvP match with the goal of controlling the planetary defenses. These cannons can be used to attack the other team's drop ship. The winning team is the first team to destroy the opposing team's drop ship.\n\nThe defenses consist of one large, central cannon and a few smaller laser cannons around it. Beneath the center turret is a command center that provides a shortcut to the east and west turrets, as well as various power-ups. The cannons can change hands at any time during the battle. Blue or red indicators will show which faction is in control of which turrets. Gaining possession over each turret is noted by a blue progress bar when a character is next to the turret, 'slicing' the controls. This progress is interrupted by attacks. There is a red/green indicator in the Warzone to show how much damage has been done to a Drop Ship.\n\nWhen a player dies there is no respawn timer; instead, the character returns to their drop ship and must fly a speederbike back to the combat area. This allows players to get a sense of the tactical situation as they approach. Each faction gets additional speederbikes outside the drop ship for each turret in their control." forKey:@"Description"];
    [alderaan setValue:[locations objectForKey:@"Alderaan"] forKey:@"location"];
    [alderaan setValue:@"Rough snow-covered valley, dotted with military installations." forKey:@"terrain"];
    
    id voidStar = addWarzone(@"Voidstar",YES);
    [voidStar setValue:@"The Voidstar is a derelict Imperial Battle Cruiser that disappeared during the Great War. The ship is believed to contain the schematics to a powerful weapon. Now that it's been rediscovered floating in the depths of space, both the Empire and the Republic are racing to take control of the vessel and access the secrets stored in its memory banks.\n\n The Voidstar is an assault-style Warzone in which one side attempts to fight its way to access the ship’s data core, while the other side defends the ship and attempts to prevent the other side from reaching the data core. The battle takes places across multiple sections of the ship, through blast doors and across elevated bridge spans where taking a fall is almost always lethal. The attackers battle their way through each section, drawing ever closer to the ship’s data core, while the defenders seek to halt the attackers’ progress at various control points.\n\nThe match is broken up into multiple rounds. After the completion of each round, the teams switch sides between being the attackers and the defenders. The winner is determined by whichever side reaches the data core the fastest. In the case that the defenders win both rounds, the winner is determined by whichever side came closest to achieving the objective." forKey:@"Description"];
    [voidStar setValue:[locations objectForKey:@"The Voidstar"] forKey:@"location"];
    [voidStar setValue:@"Tight ship interior with maze-like hallways, littered with debris." forKey:@"terrain"];
    
    id novareCoast = addWarzone(@"Novare Coast",YES);
    [novareCoast setValue:@"On the war-torn planet of Denova, opposing forces vie for control of Novare Coast, a strategically vital beachhead that leads to the open oceans of Denova. Whoever controls this coastline will have a decisive advantage in taking control of the planet. To secure the beach, sides battle for control of three mortar turrets which can be used to pound the enemy with artillery fire.\n\nThe Novare Coast, a long stretch of coastline on the planet of Denova, is of strategic importance to both the Republic and the Empire. Both sides know that whoever controls the beach has the upper hand in taking control of the planet, and now the two armies battle for control of a powerful mortar battery which overlooks the coastline and can fend off enemy advances.\n\nIn the Warzone Novare Coast, two teams battle for control of Denova, a planet rich in resources that is prized by both the Republic and the Empire. To achieve victory, players will fight for control over a series of mortar emplacements that are scattered across the map. As one team takes control of a mortar, it will begin to fire on the enemy base, weakening its shields before striking at the base itself. The team that destroys the enemy’s base first is the victor.\n\nWhile Novare Coast lets Republic and Imperial players face off against each other, this Warzone allows players from the same faction to face each other in a live-fire simulation of the battle." forKey:@"Description"];
    [novareCoast setValue:[locations objectForKey:DENOVA] forKey:@"location"];
    [novareCoast setValue:@"Coastline of elevated grasslands and forests." forKey:@"terrain"];
    

}
-(void)addOperations
{
    id(^addOperation)(NSString*) = ^(NSString* name) 
    {
        id operation = [NSEntityDescription insertNewObjectForEntityForName:@"SGOperation" inManagedObjectContext:moc];
        [operation setValue:name forKey:@"Name"];
        
        NSString* previewImageFilename = [NSString stringWithFormat:@"operationPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]];
        previewImageFilename = [previewImageFilename stringByReplacingOccurrencesOfString:@"'" withString:@""];
        
        [operation setValue:previewImageFilename forKey:@"PreviewBackgroundFilename"];
        return operation;
    };
    
    id eternityVault = addOperation(@"The Eternity Vault");
    [eternityVault setValue:@"Buried deep in the icy mountains of Belsavis, a prison housing an ancient power that threatens both the Republic and the Empire has been uncovered. Both factions have their own reasons for sending players into the Eternity Vault, and each side has a unique and compelling story surrounding the mission. Once inside, you and your group will have to work together to solve puzzles and confront some of the most powerful enemies in the galaxy. Your heroics will not go unrewarded; Operations often contain powerful weapons, armor, and other items.\n\nYou’ll undoubtedly want to experience every part of the Operation, but don’t feel like you have to explore every nook and cranny on your first playthrough. Since Operations are repeatable, you and your friends can go back and replay any of them at any time. Each Operation will also have variable difficulty settings, meaning that even after you’ve mastered it, you can choose to increase the difficulty level for a greater challenge." forKey:@"Description"];
    [eternityVault setValue:[locations objectForKey:BELSAVIS] forKey:@"location"];
    //[eternityVault setValue:@"" forKey:@"terrain"];
    
    id karaggasPalace = addOperation(@"Karagga's Palace");
    [karaggasPalace setValue:@"The same power vacuum that enticed the Tion Hegemony into action has caused the Hutt Cartel to break their traditional neutrality. As a faction with a lot of bank and influence behind them, they are a very real contender for control of the Galaxy. But they're not working alone." forKey:@"Description"];
    [karaggasPalace setValue:[locations objectForKey:UNKNOWN_PLANET] forKey:@"location"];
    
    id explosiveConflict = addOperation(@"Explosive Conflict");
    [explosiveConflict setValue:@"On the planet of Denova, a brutal conflict between an invading Imperial army and Republic-backed mercenaries has come to an abrupt end. Both armies have turned on their governments, swearing allegiance to a legendary warlord who has declared himself ruler of the planet! Now both the Empire and the Republic call on their strongest champions to head to Denova and take the planet from the warlord and his army." forKey:@"Description"];
    [explosiveConflict setValue:[locations objectForKey:DENOVA] forKey:@"location"];
}
-(void)addSkillTrees
{
    id(^addSkillTree)(NSString*,NSString*,NSString*) = ^(NSString* name,NSString* description,NSString* class) 
    {
        id skillTree = [NSEntityDescription insertNewObjectForEntityForName:@"SGSkillTree" inManagedObjectContext:moc];
        [skillTree setValue:name forKey:@"Name"];
        [skillTree setValue:description forKey:@"Description"];
        [skillTree setValue:[NSNumber numberWithBool:YES] forKey:@"Searchable"];
        
        id characterClass = [classes objectForKey:class];
        [characterClass addSkillTreesObject: skillTree];
        
        [skillTrees setObject:skillTree forKey:name];
        [skillTree setValue:@"skillTreeRowPreview" forKey:@"PreviewBackgroundFilename"];
        return skillTree;
    };
    
    //JEDI CONSULAR
    addSkillTree(BALANCE,@"Balance enhances the Sage’s Force attacks and augments the Shadow's Force and Lightsaber abilities.",JEDI_CONSULAR);
    
    addSkillTree(TELEKINETICS,@"Telekinetics affords the power to distort reality and move waves of energy, tearing apart enemies.",JEDI_SAGE);
    addSkillTree(SEER,@"Seer allows the Sage to master the art of using the Force to heal and protect allies.",JEDI_SAGE);
    addSkillTree(INFILTRATION,@"Infiltration allows them to use positional attacks and surprise to defeat foes.",JEDI_SHADOW);
    addSkillTree(KINETIC_COMBAT,@"Kinetic Combat uses the double-bladed Lightsaber defensively to protect the Shadow and his allies.",JEDI_SHADOW);
    //JEDI KNIGHT    
    addSkillTree(FOCUS,@"Focus specializes in advanced Force techniques and the Shii-Cho lightsaber form.",JEDI_KNIGHT);
    
    addSkillTree(VIGILANCE,@"Vigilance provides greater skill in single-blade offense and the ability to take enemies down quickly.",JEDI_GUARDIAN);
    addSkillTree(DEFENSE,@"Defense allows the them to more effectively withstand enemy attacks and protect allies.",JEDI_GUARDIAN);
    addSkillTree(WATCHMAN,@"Watchman masters the Juyo Lightsaber form, making him more dangerous as a fight goes on.",JEDI_SENTINEL);
    addSkillTree(COMBAT,@"Combat allows the Sentinel to master the Ataru Lightsaber form to rapidly dispatch enemies.",JEDI_SENTINEL);
    //SMUGGLER
    addSkillTree(DIRTY_FIGHTING,@"Dirty Fighting teaches tactics that leave no trick off-the-table and often leave an enemy crippled or bleeding.",SMUGGLER);
    
    addSkillTree(SABOTEUR,@"The Saboteur skill tree teaches the Gunslinger to use explosives and advanced tech to sustain a longer assault.",GUNSLINGER);
    addSkillTree(SHARPSHOOTER,@"The Sharpshooter skill tree teaches the Gunslinger to focus on precise, high damage attacks from the safety of cover.",GUNSLINGER);
    addSkillTree(SAWBONES,@"The Sawbones skill tree teaches the Scoundrel to patch his allies up using whatever medical supplies he can scrape together.",SCOUNDREL);
    addSkillTree(SCRAPPER,@"The Scrapper skill tree teaches the Scoundrel to focus on using stealth and the scatter gun to sneak in, take out the enemy, and get out.",SCOUNDREL);
    //COMMANDO
    addSkillTree(ASSAULT_SPECIALIST,@"The Assault Specialist skill tree trains the Commando and the Vanguard explosives and grenades to complement either rifles or heavy cannons.",TROOPER);
    
    addSkillTree(GUNNERY,@"The Gunnery skill tree teaches the Commando to focus on maximizing the assault cannon's destructive power.",COMMANDO);
    addSkillTree(COMBAT_MEDIC,@"The Combat Medic skill tree trains the Commando to provide expert first aid to wounded comrades in the heat of battle.",COMMANDO);
    addSkillTree(TACTICS,@"The Tactics skill tree trains the Vanguard how to more effectively deal with close range combatants.",VANGUARD);
    addSkillTree(SHIELD_SPECIALIST,@"The Shield Specialist skill tree powers up the Vanguard’s shield generator to absorb firepower and protect their allies.",VANGUARD);
    //BOUNTY HUNTER
    addSkillTree(PYROTECH,@"The Pyrotech skill tree provides the Mercenary and Powertech upgrades for their weapons to deal more damage to their enemies.",BOUNTY_HUNTER);
    
    addSkillTree(ARSENAL,@"The Arsenal skill tree uses advanced rocketry and specializes in taking down their targets quickly.",MERCENARY);
    addSkillTree(BODYGUARD,@"The Bodyguard skill tree provides the Mercenary skills and technology to heal and restore his allies.",MERCENARY);
    addSkillTree(SHIELD_TECH,@"The Shield Tech skill tree further boosts the Powertech's defensive technology, allowing him to soak up attacks.",POWERTECH);
    addSkillTree(ADVANCED_PROTOTYPE,@"The Advanced Prototype skill tree provides training in the latest technology making the Powertech a versatile fighter against any enemy.",POWERTECH);
    //IMPERIAL AGENT
    addSkillTree(LETHALITY,@"The Lethality skill tree leverages the Operative and Sniper's toxic power of poisons to debilitate enemies over the course of a long fight.",IMPERIAL_AGENT);
    
    addSkillTree(CONCEALMENT,@"The Concealment skill tree upgrades the Operative's stealth and close-range attacks, allowing the Agent to strike without detection.",OPERATIVE);
    addSkillTree(MEDICINE,@"The Medicine skill tree advances the Operative's healing technologies, keeping his allies both alive and effective.",OPERATIVE);
    addSkillTree(MARKSMANSHIP,@"The Marksmanship skill tree teaches the Sniper to strike down targets from long distances and from the safety of cover.",SNIPER);
    addSkillTree(ENGINEERING,@"The Engineering skill tree empowers the Sniper's droids and probes to weaken enemies and give the Empire an advantage.",SNIPER);
    //SITH WARRIOR
    addSkillTree(RAGE,@"The Rage skill tree allows the Sith Marauder and Sith Juggernaut greater control of the Force and further mastery of the Shii-Cho form.",SITH_WARRIOR);
    
    addSkillTree(VENGEANCE,@"The Vengeance skill tree teaches the Sith Juggernaut to stop at nothing to crush enemies, obliterating them with heavy hits.",SITH_JUGGERNAUT);
    addSkillTree(IMMORTAL,@"The Immortal skill tree teaches the Sith Juggernaut to use the power of the Force to increase the Warrior's survivability in battle.",SITH_JUGGERNAUT);
    addSkillTree(ANNIHILATION,@"The Annihilation skill tree allows the Sith Marauder to master the aggressive Juyo form, destroying enemies from within.",SITH_MARAUDER);
    addSkillTree(CARNAGE,@"The Carnage skill tree allows the Sith Marauder to focus on acrobatic Lightsaber techniques that strike quickly and lethally.",SITH_MARAUDER);
    //SITH INQUISITOR
    addSkillTree(MADNESS,@"The  Madness skill tree enables the Sith Assassin and Sith Sorcerer to increase their mastery of the Force to drain and corrupt enemies.",SITH_INQUISITOR);
    
    addSkillTree(DECEPTION,@"The Deception skill tree enhances the Assassin's stealth ability, helping him sneak up and dispatch his foes.",SITH_ASSASSIN);
    addSkillTree(DARKNESS,@"The Darkness skill tree enables the Sith Assassin to focus on defensive techniques to help protect him and his allies.",SITH_ASSASSIN);
    addSkillTree(LIGHTNING,@"The Lightning skill tree allows the Sith Sorcerer to channel the Force to overload the Inquisitor's enemies with blasts of lightning.",SITH_SORCERER);
    addSkillTree(CORRUPTION,@"The Corruption skill tree allows the Sith Sorcerer to use dark power to maintain allies' health in battle, and protect them from enemy attacks.",SITH_SORCERER);
}
#define INSTANT @"Instant"
#define PASSIVE @"Passive"
-(void)addCharacterSkills
{
    id(^addCharacterSkillOLD)(NSString*,NSString*,NSString*,NSString*) = ^(NSString* name,NSString* type,NSString* tree,NSString* headline) 
    {
        id characterSkill = [NSEntityDescription insertNewObjectForEntityForName:@"SGCharacterSkill" inManagedObjectContext:moc];
        [characterSkill setValue:name forKey:@"Name"];
        [characterSkill setValue:headline forKey:@"Description"];
        [characterSkill setValue:type forKey:@"Type"];
        [characterSkill setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
        [characterSkill setValue:[NSNumber numberWithInt:1] forKey:@"tier"];
        
        id skillTree = [skillTrees objectForKey:tree];
        [skillTree addSkillsObject:characterSkill];
        
        //[craftingSkill setValue:[NSString stringWithFormat:@"craftingSkillPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
        return characterSkill;
    };
    
    id(^addCharacterSkill)(NSString*,NSString*,NSString*,NSString*,int) = ^(NSString* name,NSString* type,NSString* tree,NSString* headline,int tier) 
    {
        id characterSkill = [NSEntityDescription insertNewObjectForEntityForName:@"SGCharacterSkill" inManagedObjectContext:moc];
        [characterSkill setValue:name forKey:@"Name"];
        [characterSkill setValue:headline forKey:@"Description"];
        [characterSkill setValue:type forKey:@"Type"];
        [characterSkill setValue:[NSNumber numberWithBool:NO] forKey:@"Searchable"];
        [characterSkill setValue:[NSNumber numberWithInt:tier] forKey:@"tier"];
        
        id skillTree = [skillTrees objectForKey:tree];
        [skillTree addSkillsObject:characterSkill];

        return characterSkill;
    };
    
    //Advanced Prototype
    //Tier 1
    addCharacterSkill(@"Prototype Burn Enhancers",PASSIVE,ADVANCED_PROTOTYPE,@"Increases the crit chance of all burn effects by 3%.",1);
    //addCharacterSkill(@"Precision Instruments",PASSIVE,ADVANCED_PROTOTYPE,@"Reduces the energy cost of Corrosive Dart, Debilitate and Sever Tendon by 2.",1);
    addCharacterSkill(@"Prototype Electro Surge",PASSIVE,ADVANCED_PROTOTYPE,@"Reduces the cooldown of Electro Dart by 5 seconds.",1);
    addCharacterSkill(@"Puncture",PASSIVE,ADVANCED_PROTOTYPE,@"Rail shot ignores 20% of the target's armor.",1);
    //Tier 2
    addCharacterSkill(@"Prototype Cylinders",PASSIVE,ADVANCED_PROTOTYPE,@" Combustable Gas Cylinder: Tech crit chance up 3%. High Velocity Gas Cylinder : Increases all internal and elemental damage dealt by 3%. Ion Gas Cylinder : Increases the damage dealt by 8%.",2);
    addCharacterSkill(@"Hot Iron",PASSIVE,ADVANCED_PROTOTYPE,@"Increases the damage dealt by Flame Burst and Retractable Blade.",2);
    addCharacterSkill(@"Power Armor",PASSIVE,ADVANCED_PROTOTYPE,@"Reduces all damage taken by 1%.",2);
    addCharacterSkill(@"Advanced Tools",PASSIVE,ADVANCED_PROTOTYPE,@"Reduces the cooldown of Flame Thrower by 1.5 seconds and Grapple by 5 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Hitman",PASSIVE,ADVANCED_PROTOTYPE,@"Reduces the cooldown of Quell by 1 seconds.",3);
    addCharacterSkill(@"Pneumatic Boots",PASSIVE,ADVANCED_PROTOTYPE,@"Increases movement speed by 7.5% while High Energy Gas Cylinder is active.",3);
        addCharacterSkill(@"Retractable Blade",PASSIVE,ADVANCED_PROTOTYPE,@"Plunges a retractable blade into the target that deals 2048 - 2915 kinetic damage and causes the target to bleed for 2993 internal damage over 15 seconds.",3);
        addCharacterSkill(@"Prototype Cylinder Ventilation",PASSIVE,ADVANCED_PROTOTYPE,@"While High Energy Gas Cylinder is active, you have a 50% chance to vent 8 heat every 6 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Flame Barrage",PASSIVE,ADVANCED_PROTOTYPE,@"Flame Burst has a 15% chance and Immolation has a 50% chance to make your next Rocket Punch free. This effect lasts 15 seconds.",4);
    addCharacterSkill(@"Serrated Blades",PASSIVE,ADVANCED_PROTOTYPE,@"Increases the damage dealt by Retracted Blade's bleed effect by 5%.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    //NOTE - OBSOLETE?
    /*
    //id meltdown = addCharacterSkillOLD(@"Meltdown",PASSIVE,ADVANCED_PROTOTYPE,@"Your Immolate and Retractable Blade have a 20% chance to make your next Flamethrower channel twice as fast and tick twice as frequently.");
     */
    {
        /*
        id immolate = addCharacterSkill(@"Immolate",INSTANT,ADVANCED_PROTOTYPE,@"A spray of fuel hits a burning target igniting into a fireball that does 882-886 damage to the target and 115 damage to up to 3 additional nearby enemies. Target must be burning.",7);
         */
    }
    
    //Annihilation
    //Tier 1
    addCharacterSkill(@"Battle Cry",PASSIVE,ANNIHILATION,@"Force Charge has a 50% chance to make your next Force Scream cost no rage.",1);
    addCharacterSkill(@"Quick Recovery",PASSIVE,ANNIHILATION,@"Reduces the rage cost of Smash and Sweeping Slash by 1 and reduces the cooldown of Smash by 1.5 seconds.",1);
    addCharacterSkill(@"Enraged Slash",PASSIVE,ANNIHILATION,@"Vicious Slash, Massacre, and Annihilate have a 33.3% chance to refund 1 rage when used.",1);
    //Tier 2
    addCharacterSkill(@"Juyo Mastery",PASSIVE,ANNIHILATION,@"Your bleed effects are 1% more likely to critically hit per stack of Juyo Form",2);
    addCharacterSkill(@"Seeping Wound",PASSIVE,ANNIHILATION,@"Rupture has a 50% chance to also reduce the target's moving speed by 30% for the duration.",2);
    addCharacterSkill(@"Hungering",PASSIVE,ANNIHILATION,@"Critical hits with bleed effects heal you for 1% of your maximum health.",2);
    //Tier 3
    addCharacterSkill(@"Bleedout",PASSIVE,ANNIHILATION,@"Increases the critical strike damage of your bleed effects by 15%.",3);
    addCharacterSkill(@"Deadly Saber",INSTANT,ANNIHILATION,@"Charges your lightsabers with deadly energy for 15 seconds, causing your next 3 successful melee attacks to make the target bleed for 402 internal damage over 6 seconds. Stacks up to 3 times. This effect cannot occur more than once every 1.5 seconds.",3);
    addCharacterSkill(@"Blurred Speed",PASSIVE,ANNIHILATION,@"Lowers the cooldown of Force Charge by 1.5 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Short Fuse",PASSIVE,ANNIHILATION,@"Increases the amount of Fury built by 1 when activating abilities that spend rage, and reduces the cooldown of Frenzy by 15 seconds.",4);
    addCharacterSkill(@"Phantom",PASSIVE,ANNIHILATION,@"Reduces all damage taken by 50% while Force Camouflage is active.",4);
    addCharacterSkill(@"Annihilation",PASSIVE,ANNIHILATION,@"Increases the direct damage dealt by Rupture and Annihilate by 10%.",4);
    addCharacterSkill(@"Close Quarters",PASSIVE,ANNIHILATION,@"Reduces the minimum range of Force Charge by 5 meters.",4);
    //Tier 5
    addCharacterSkill(@"Ferocity",PASSIVE,ANNIHILATION,@"Further increases your movement speed by 15% while Predation is active.",5);
    addCharacterSkill(@"Inescapable Torment",PASSIVE,ANNIHILATION,@"Choked targets take 10% more damage from your next 5 bleed effects. Lasts 15 seconds.",5);
    addCharacterSkill(@"Subjugation",PASSIVE,ANNIHILATION,@"Reduces the cooldown of Obfuscate by 7.5 seconds and Disruption by 1 second.",5);
    
    //id inescapableTorment = addCharacterSkill(@"Inescapable Torment",PASSIVE,ANNIHILATION,@"Choked targets take 30% more damage from your next 5 bleed effects. Lasts 15 seconds.",5);
    //Tier 6
    //Tier 7
        //id annihilate = addCharacterSkill(@"Annihilate",INSTANT,ANNIHILATION,@"Strikes the target with both LIghtsabers for 547-633 weapon damage. Each use of this ability grants Annihilator for 15 seconds, lowering the cooldownof your next Annihilate by 1.5 seconds. Stack up to three times. Requires two lightsabers.",4);
    
    //Arsenal
    //Tier 1
    addCharacterSkill(@"Mandalorian Iron Warheads",PASSIVE,ARSENAL,@"Increases the damage dealt by all missile and Power Shot by 3% and the healing dealt by Kolto Missile by 10%.",1);
    addCharacterSkill(@"Integrated Systems",PASSIVE,ARSENAL,@"Increases the healing recieved by 1% and all healing done by 1%.",1);
    addCharacterSkill(@"Ironsights",PASSIVE,ARSENAL,@"Increases aim by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Stabilizers",PASSIVE,ARSENAL,@"Reduces the pushback suffered while activating Power Shot, Concussion Missile, Tracer Missile and Unload by 25%.",2);
    addCharacterSkill(@"Muzzle Fluting",PASSIVE,ARSENAL,@"Reduces the heat cost of Power Shot and Tracer Missile by 9.",2);
    addCharacterSkill(@"Upgraded Arsenal",PASSIVE,ARSENAL,@"Combustable Gas Cylinder: Tech crit chance up 3%. High Velocity Gas Cylinder : Reduces the heat cost of by Rail Shot 8. Kolto Gas Cylinder : Increases the tech crit chance by 3%.",2);
    addCharacterSkill(@"Custom Enviro Suit",PASSIVE,ARSENAL,@"Increases endurance 1% and all healing recieved by 3%.",2);
    //Tier 3
    addCharacterSkill(@"Power Barrier",PASSIVE,ARSENAL,@"Power Shot and Tracer Missile have a 50% chance to generate a Power Barrier that reduces damage taken by 2% for 15 seconds. Stacks up to 5 times.",3);
    addCharacterSkill(@"Afterburners",PASSIVE,ARSENAL,@"Rocket Punch has a 50% chance to knock the target back several meters. In addition, Jet Boost's knockback effect is stronger and pushes enemies 2 meters further away.",3);
    addCharacterSkill(@"Trace Missle",INSTANT,ARSENAL,@"Launches a missile at the target that deals (current weapon) kinetic damage and applies a heat signature, reducing the armor rating by 4% for 15 seconds. Stacks up to 5 times. Heat signatures leave the target vulnerable to Rail Shot.",3);
    addCharacterSkill(@"Target Tracking",PASSIVE,ARSENAL,@"Increases the critical bonus damage of Unload and Heatseeking Missiles by 15%.",3);
    //Tier 4
    addCharacterSkill(@"Light Em Up",PASSIVE,ARSENAL,@"Tracer Missile now applies an additional heat signature.",4);
    addCharacterSkill(@"Jet Escape",PASSIVE,ARSENAL,@"Reduces the cooldown of Jet Boost by 5 seconds and Determination by 15 seconds.",4);
    addCharacterSkill(@"Terminal Velocity",PASSIVE,ARSENAL,@"While High Velocity Gas Cylinder is active, critical hits with missiles and Unload have a 50% chance to vent 8 heat. This effect cannot occur more than once every 3 seconds.",4);
    //Tier 5
    addCharacterSkill(@"Pinning Fire",PASSIVE,ARSENAL,@"Unload has a 50% chance per hit to slow the target's movement by 50% for 2 seconds.",5);
    addCharacterSkill(@"Riddle",PASSIVE,ARSENAL,@"Increases the damage dealt by Unload by 33%.",5);
    addCharacterSkill(@"Tracer Lock",PASSIVE,ARSENAL,@"Tracer Missile grants Target Lock, increasing the damage dealt by the next Rail Shot by 6%. Stacks up to 5 times.",5);
    addCharacterSkill(@"Kolto Vents",PASSIVE,ARSENAL,@"Vent Heat regenerates 7% of your ",5);
    //Tier 6
    //Tier 7
    //id heatseekerMissiles = addCharacterSkill(@"Heatseeker Missiles",INSTANT,ARSENAL,@"Fires several missiles that home in on the target and do 1131-1141 damage. This damage is increased by 3% per heat signature on the target.",7);
    
    //Assault Specialist
    //Tier 1
    addCharacterSkill(@"Target Lock",PASSIVE,ASSAULT_SPECIALIST,@"Increases ranged and tech accuracy by 1%.",1);
    addCharacterSkill(@"Heavy Stock",PASSIVE,ASSAULT_SPECIALIST,@"Increases the damage dealt by Stockstrike by 4",1);
    addCharacterSkill(@"Soldier's Endurance",PASSIVE,ASSAULT_SPECIALIST,@"Increases endurance by 1%.",1);
    //Tier 2
    addCharacterSkill(@"Superheated Plasma",PASSIVE,ASSAULT_SPECIALIST,@"Increases the damage dealt by Plasma Cell by 10% and increases its chance to be triggered by 2%.",2);
    addCharacterSkill(@"Sweltering Heat",PASSIVE,ASSAULT_SPECIALIST,@"Plasma Cell has a 50% chance when it applies its effects to reduce the movement speed of the target by 50% for 2 seconds.",2);
    addCharacterSkill(@"Parallactic Combat Stims",PASSIVE,ASSAULT_SPECIALIST,@"You have a 50% chance to recharge 1 energy cell when stunned, immobilized, knocked down or otherwise incapacitated.",2);
    //Tier 3
    addCharacterSkill(@"Degauss",PASSIVE,ASSAULT_SPECIALIST,@"Reactive Shield has a 50% chance to remove all movement-impairing effects when activated.",3);
    addCharacterSkill(@"High Friction Bolts",PASSIVE,ASSAULT_SPECIALIST,@"High Impact Bolt ignores 15% of the target's armor. In addition, if High Impact Bolt hits a burning target, it has a 50% chance to generate 1 energy cell and refresh the duration of your Plasma Cell's burn effect if present.",3);
    addCharacterSkill(@"Incendiary Round",PASSIVE,ASSAULT_SPECIALIST,@"Launches an incendiary projectile, setting the target ablaze for elemental damage and an additional elemental damage over 18 seconds.",3);
    addCharacterSkill(@"Nightvision Scope",PASSIVE,ASSAULT_SPECIALIST,@"Increases stealth detection by 1, melee and ranged defense by 1% and reduces the cooldown of Stealth Scan by 2.5 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Rapid Recharge",PASSIVE,ASSAULT_SPECIALIST,@"Reduces the cooldown of Recharge Cells by 15 seconds.",4);
    addCharacterSkill(@"Ionic Accelerator",PASSIVE,ASSAULT_SPECIALIST,@"Charged Bolts has a 10% chance and Full Auto has a 20% chance to finish the cooldown on High Impact Bolt and make the next High Impact Bolt free.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    //addCharacterSkill(@"Assault Plastique",INSTANT,ASSAULT_SPECIALIST,@"Hurle a moldable plastic explosive that will detonate after several seconds. Weak enemies enter a state of panic when the grenade is active. The explosion deals 498-518 kinetic damage when it goes off. Standard and weak targets are knocked back from the blast. Shares a 15 second cooldown with Stick Grenade.",7);
    
    //Balance
    //Tier 1
    addCharacterSkill(@"Empowered Throw",PASSIVE,BALANCE,@"Increases the damage dealt by Telekinetic Throw by 12%.",1);
    addCharacterSkill(@"Jedi Resistance",PASSIVE,BALANCE,@"Reduces all damage by 2%.",1);
    addCharacterSkill(@"Will of the Jedi",PASSIVE,BALANCE,@"Increases total Willpower by 6%",1);
    //Tier 2
    addCharacterSkill(@"Pinning Resolve",PASSIVE,BALANCE,@"Reduces the cooldown of Force Stun by 10 seconds. In addition, your Force Lift affects up to 2 additional standard or weak enemies within 8 meters of the target.",2);
    addCharacterSkill(@"Upheaval",PASSIVE,BALANCE,@"When you activate Project, you have a 45% chance to project and additional chunk of debris at the target, dealing 50% of normal damage.",2);
    addCharacterSkill(@"Focused Insight",PASSIVE,BALANCE,@"Causes your periodic damaging abilities that crit to restore 1% of your total health.",2);
    addCharacterSkill(@"Critical Kinesis",PASSIVE,BALANCE,@"Increases critical chance of Telekinetic Throw and Disturbance by 10%.",2);
    //Tier 3
    addCharacterSkill(@"The Force in Balance",INSTANT,BALANCE,@"Deals (unknown) internal damage to up to 3 targets within 8 meters of the targeted area and heals you for (unknown) per affected target.",3);
    addCharacterSkill(@"Psychic Barrier",PASSIVE,BALANCE,@"Reduces the pushback suffered while activating Mind Crush and Telekinetic Throw by 25%. In addition, each time your Telekinetic Throw deals damage, you have a 33.33% chance to recover 1% of your total Force.",3);
    addCharacterSkill(@"Telekinetic Balance",PASSIVE,BALANCE,@"Telekinetic Throw no longer has a cooldown.",3);
    //Tier 4
    addCharacterSkill(@"Containment",PASSIVE,BALANCE,@"Lowers the activation time of Force Lift by 50%. In addition, when your Force Lift breaks early from damage, the target is stunned for 1 second.",4);
    addCharacterSkill(@"Mind Ward",PASSIVE,BALANCE,@"Reduces the damage taken by all periodic effects by 7.5%.",4);
    addCharacterSkill(@"Presence of Mind",PASSIVE,BALANCE,@"When your Telekinetic Throw deals damage, you have a 30% chance to cause your next Force-damaging attack with an activation time to activate instantly and deal 20% more damage.",4);
    //Tier 5
    //Tier 6
    //Tier 7
        
    //Bodyguard
    //Tier 1
    addCharacterSkill(@"Improved Vents",PASSIVE,BODYGUARD,@"Vent Heat now immediately vents an additional 8 heat.",1);
    addCharacterSkill(@"Med Tech",PASSIVE,BODYGUARD,@"Reduces the activation time of Lesser Healing Scan by 0.25 seconds and reduces the cooldown of Healing Scan by 1.5 seconds.",1);
    addCharacterSkill(@"Hired Muscle",PASSIVE,BODYGUARD,@"Increases crit chance by 2%.",1);
    //Tier 2
    addCharacterSkill(@"Empowered Scans",PASSIVE,BODYGUARD,@"Increases the healing done by Healing Scan and Lesser Healing scan by 3%.",2);
    addCharacterSkill(@"Surgical Precision System",PASSIVE,BODYGUARD,@"Reduces the pushback suffered while activating healing abilities by 35% and reduces the threat generated by healing abilities by 5%.",2);
    addCharacterSkill(@"Prototype Gas Cylinder",PASSIVE,BODYGUARD,@"Loads a Kolto Gas Cylinder into your blaster, increasing healing done by 3%. While active, targetting an ally with Rapid Shot will heal the target for 100% of your tech bonus healing.",2);
    addCharacterSkill(@"Critical Reaction",PASSIVE,BODYGUARD,@"Critical results with damage and healing abilities have a 50% chance to grant Critical Reaction, increasing alacrity by 5% for 6 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Heat Damping",PASSIVE,BODYGUARD,@"Reduces the heat cost of Jet Boost, Concussion Missile and Electro Dart by 8.",3);
    addCharacterSkill(@"Kolto Residue",PASSIVE,BODYGUARD,@"Kolto Missile has a 50% chance to leave Kolto Residue on affected targets, increasing all healing received by 5% for 15 seconds.",3);
    addCharacterSkill(@"Kolto Missile",INSTANT,BODYGUARD,@"Heals up to 3 allies within 8 meters of the targeted area for 95 - 206.",3);
    addCharacterSkill(@"Power Shield",PASSIVE,BODYGUARD,@"Energy Shield now further decreases ability activation pushback by 30% and makes you immune to interrupts.",3);
    //Tier 4
    addCharacterSkill(@"Powered Insulators",PASSIVE,BODYGUARD,@"Reduces all damage taken by 2% while Combat Support Cylinder is active.",4);
    addCharacterSkill(@"Critical Efficiency",PASSIVE,BODYGUARD,@"Healing Scan has a 33.34% chance to reduce the heat cost of your next Rapid Scan by 16.",4);
    addCharacterSkill(@"Protective Field",PASSIVE,BODYGUARD,@"Increases all healing received by 10% while Energy Shield is active.",4);
    //Tier 5
    addCharacterSkill(@"Reactive Armor",PASSIVE,BODYGUARD,@"Proactive Medicine now also provides 10% armor while active.",5);
    addCharacterSkill(@"Proactive Medicine",PASSIVE,BODYGUARD,@"Healing Scan has a 50% chance to apply Proactive Medicine to the target, healing for an additional 0 over 9 seconds.",5);
    addCharacterSkill(@"Kolto Shell",INSTANT,BODYGUARD,@"Deploys a kolto shell around the target that has 10 charges and lasts 5 minutes. When damaged, the kolto shell loses 1 charge and heals the target for 61 - 72. This effect cannot occur more than once every 3 seconds. Only one Kolto Shell can be deployed at a time.",5);
    addCharacterSkill(@"Cure Mind",PASSIVE,BODYGUARD,@"Reduces the heat cost of Cure by 8. In addition, Cure now removes negative mental effects.",5);
    //Tier 6
    {
    //id koltoShell = addCharacterSkill(@"Kolto Shell",INSTANT,BODYGUARD,@"A shell of kolto energy surrounds the target. When the target takes damage they are healed for 151. 10 charges lasts 5 minutes. Heal can only happen every 3 seconds..",6);
    //id reactiveArmor = addCharacterSkill(@"Reactive Armor",PASSIVE,BODYGUARD,@"Proactive medicine now provides 10% armor while active.",6);
    }
    
    //Carnage
    //Tier 1
    addCharacterSkill(@"Cloak of Carnage",PASSIVE,CARNAGE,@"Cloak of Pain has a 50% chance to generate 1 rage when it reciprocates damage to an attacker. This effect cannot occur more than once every 3 seconds.",1);
    addCharacterSkill(@"Dual Wield Mastery",PASSIVE,CARNAGE,@"Increases damage dealt with offhand saber attacks by 12%.",1);
    addCharacterSkill(@"Defensive Forms",PASSIVE,CARNAGE,@"Shii-Cho Form: Further increases damage reduction by 1%. Juyu Form: Reduces internal and elemental damage taken by 2%. Ataru Form: Increases your movement speed by 5%.",1);
    //Tier 2
    addCharacterSkill(@"Narrowed Hatred",PASSIVE,CARNAGE,@"Increases melee and force accuracy by 1%.",2);
    addCharacterSkill(@"Defensive Roll",PASSIVE,CARNAGE,@"Reduces damage taken from area effect by 15%.",2);
    addCharacterSkill(@"Enraged Charge",PASSIVE,CARNAGE,@"Force Charge has a 50% chance to generate rage.",2);
    addCharacterSkill(@"Brutality",PASSIVE,CARNAGE,@"Increases the critical strike chance of Vicious Slash by 7.5%.",2);
    //Tier 3
    addCharacterSkill(@"Saber Strength",PASSIVE,CARNAGE,@"Increases the damage dealt by Vicious Slash and Obliterate by 3%.",3);
    addCharacterSkill(@"Ataru Form",PASSIVE,CARNAGE,@"Enters an acrobatic lightsaber form, increasing accuracy by 3%. In addition, your successful melee attacks have a 20% chance to trigger a second strike that deals 229 energy damage. This effect cannot occur more than once every 1.5 seconds.",3);
    addCharacterSkill(@"Ataru Mastery",PASSIVE,CARNAGE,@"Increases the damage dealt by your triggered Ataru Form attacks by 15%.",3);
    //Tier 4
    addCharacterSkill(@"Blood Frenzy",PASSIVE,CARNAGE,@"Hits from Ataru Form grants Blood Frenzy for 6 seconds. When Blood Frenzy ends, you generate 1 rage. This can only occur once every 6 seconds.",4);
    addCharacterSkill(@"Towering Rage",PASSIVE,CARNAGE,@"Increases the critical strike chance of Force Scream by 50% while Blood Frenzy is active.",4);
    addCharacterSkill(@"Enraged Assault",PASSIVE,CARNAGE,@"Reduces the cooldown of Battering Assault by 1.5 seconds.",4);
    addCharacterSkill(@"Displacement",PASSIVE,CARNAGE,@"Deadly Throw has a 50% chance to immobilize the target for 3 seconds. Additionally increases the range of Obfuscate by 3 meters.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    {
    //id ataruForm = addCharacterSkillOLD(@"Ataru Form",INSTANT,CARNAGE,@"Enter an acrobatic Lightsaber form, increasing accuracy by 3%. In addition, your successful melee attacks have a 20% chance to trigger a second force strike that deals 148 energy damage. This effect cannot occur more than once every 1.5 seconds.");
    //id Gore = addCharacterSkillOLD(@"Gore",PASSIVE,CARNAGE,@"Impale now attacks with both Lightsabers when dual wielding.");
    }
    
    //Combat
    //Tier 1
    addCharacterSkill(@"Jedi Crusader",PASSIVE,COMBAT,@"Rebuke has a 50% chance to generate 1 focus when it reciprocates damage to an attacker. This effect cannot occur more than once every 3 seconds.",1);
    addCharacterSkill(@"Dual Wield Mastery",PASSIVE,COMBAT,@"Increases the damage dealt with offhand saber attacks by 12%.",1);
    addCharacterSkill(@"Defensive Forms",PASSIVE,COMBAT,@"Shii-Cho Form: Further increases damage reduction by 1%. Juyu Form: Reduces internal and elemental damage taken by 2%. Ataru Form: Increases your movement speed by 5%.",1);
    //Tier 2
    addCharacterSkill(@"Steadfast",PASSIVE,COMBAT,@"Increases melee and force accuracy by 1%.",2);
    addCharacterSkill(@"Defensive Roll",PASSIVE,COMBAT,@"Reduces damage taken from area effects by 15%.",2);
    addCharacterSkill(@"Focused Leap",PASSIVE,COMBAT,@"Force Leap has a 50% chance to generate 1 additional focus.",2);
    addCharacterSkill(@"Temperance",PASSIVE,COMBAT,@"Cauterize has a 33.3% chance to refund 1 focus when used.",2);
    //Tier 3
    addCharacterSkill(@"Ataru Form",INSTANT,COMBAT,@"Enters an acrobatic lightsaber form, increasing accuracy by 3%. In addition, your successful melee attacks have a 20% chance to trigger a second strike that deals 229 energy damage. This effect cannot occur more than once every 1.5 seconds.",3);
    addCharacterSkill(@"Opportune Attack",PASSIVE,COMBAT,@"Your Ataru Form hits have a 50% chance to make your next focus spender deal 10% more damage.",3);
    addCharacterSkill(@"Ataru Mastery",PASSIVE,COMBAT,@"Increases the damage dealt by your triggered Ataru Form attacks by 15%.",3);
    //Tier 4
    addCharacterSkill(@"Immaculate Force",PASSIVE,COMBAT,@"Increases the critical strike chance of Blade Storm by 50% while Combat Focus or Combat Trance is active.",4);
    addCharacterSkill(@"Combat Trance",PASSIVE,COMBAT,@"Hits from Ataru Form grants Combat Trance for 6 seconds. When Combat Trance ends, you generate 1 focus. This can only occur once every 6 seconds.",4);
    addCharacterSkill(@"Righteous Zeal",PASSIVE,COMBAT,@"Reduces the cooldown of Zealous Strike by 1.5 seconds.",4);
    addCharacterSkill(@"Displacement",PASSIVE,COMBAT,@"Crippling Throw has a 50% chance to immobilize the target for 3 seconds. Additionally increases the range of Pacify by 3 meters.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    {
        /*id bladeRush = addCharacterSkillOLD(@"Blade Rush",INSTANT,COMBAT,@"Strikes the target with both weapons for 647-729 weapon damage and automatically triggers an Ataru Form strike. For 6 seconds after using Blade Rush, your Ataru Form has an extra 30% chance to be triggered. Requires two Lightsabers.");
    id opportuneAttack = addCharacterSkillOLD(@"Opportune Attack",PASSIVE,COMBAT,@"Your Ataru Form hits have a 100% chance to make your next focus spender deal 10% more damage.");
    */
    }
    
    //Immortal
    //Tier 1
    addCharacterSkill(@"Battle Cry",PASSIVE,IMMORTAL,@"Force Charge and Obliterate have a 50/100% chance to make the next Force Scream activated cost no rage.",1);
    addCharacterSkill(@"Quake",PASSIVE,IMMORTAL,@"Smash has a 50% chance to lower the accuracy of affected targets by 5% for 18 seconds.",1);
    addCharacterSkill(@"Enraged Sunder",PASSIVE,IMMORTAL,@"Sundering Assault has a 50% chance to build 1 additional rage.",1);
    //Tier 2
    addCharacterSkill(@"Intimidation",PASSIVE,IMMORTAL,@"Reduces the rage of Chilling Scream and Backhand by 1.",2);
    addCharacterSkill(@"Lash Out",PASSIVE,IMMORTAL,@"Reduces the rage cost of Retaliation by 1 while Soresu Form is active.",2);
    addCharacterSkill(@"Guard Stance",PASSIVE,IMMORTAL,@"Increases your melee and ranged defense by 2% while in Soresu Form.",2);
    //Tier 3
    addCharacterSkill(@"Heavy Handed",PASSIVE,IMMORTAL,@"Increases the damage dealt by Backhand, Smash and Sweeping Slash by 5%.",3);
    addCharacterSkill(@"Blade Barricade",PASSIVE,IMMORTAL,@"Retaliation now increases melee and ranged defenses by 2/4/6% for 6 seconds.",3);
    addCharacterSkill(@"Invincible",INSTANT,IMMORTAL,@"Reduces all damage taken by 40% for 10 seconds.",3);
    addCharacterSkill(@"Unleashed",PASSIVE,IMMORTAL,@"Reduces the Cooldown of Unleash by 15/30 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Thrown Gauntlet",PASSIVE,IMMORTAL,@"Reduces the cooldown of Threatening Scream and Force Push by 7.5 seconds.",4);
    addCharacterSkill(@"Revenge",PASSIVE,IMMORTAL,@"While in Soresu Form, parrying, deflecting, shielding or resisting an attack has a 25% chance to grant Revenge, reducing the rage cost of your next Force Scream or Smash by 1. Lasts 10 seconds and stacks up to 3 times.",4);
    addCharacterSkill(@"Shield Specialization",PASSIVE,IMMORTAL,@"Increases shield chance by 2%.",4);
    //Tier 5
    addCharacterSkill(@"Sonic Barrier",PASSIVE,IMMORTAL,@"Force Scream has a 50% chance to grant Sonic Barrier, which absorbs a moderate amount of damage. Lasts 10 seconds.",5);
    addCharacterSkill(@"Crash",PASSIVE,IMMORTAL,@"Force Charge now stuns the target for 2 seconds.",5);
    addCharacterSkill(@"Backhand",INSTANT,IMMORTAL,@"Bashes the target for 1024 - 1135 kinetic damage, stunning it for 4 seconds. This ability generates a high amount of threat.",5);
    addCharacterSkill(@"Force Grip",PASSIVE,IMMORTAL,@"Force Choke no longer needs to be channeled, applying its full effect over 3 seconds.",5);
    //Tier 6
    //Tier 7
    //id invincible = addCharacterSkillOLD(@"Invincible",INSTANT,IMMORTAL,@"Reduces the damage the Warrior suffers from all sources by 60% for 9 seconds.");
    //id revenge = addCharacterSkillOLD(@"Revenge",PASSIVE,IMMORTAL,@"While in Soresu Form, parrying, deflecting, shielding, or resisting an attack has a 50% chance to grant Revenge, reducing the rage cost of your next Force Scream or Smash by 1. Lasts 10 seconds and stacks up to 3 times.");
    
    //Combat Medic
    //Tier 1
    addCharacterSkill(@"Cell Capacitor",PASSIVE,COMBAT_MEDIC,@"Increases the number of Powercells restored by Recharge Cells by 1.",1);
    addCharacterSkill(@"Quick Thinking",PASSIVE,COMBAT_MEDIC,@"Reduces the activation time of Medical Probe by 0.25 seconds and reduces the cooldown of Advanced Medical Probe by 1.5 seconds.",1);
    addCharacterSkill(@"Field Training",PASSIVE,COMBAT_MEDIC,@"Increases crit chance by 2%.",1);
    //Tier 2
    addCharacterSkill(@"Field Medicine",PASSIVE,COMBAT_MEDIC,@"Increases the healing done by Medical Probe and Advanced Medical Probe by 3%. In addition, Medical Probe builds 3 charges of Combat Support Cell.",2);
    addCharacterSkill(@"Steady Hands",PASSIVE,COMBAT_MEDIC,@"Reduces the pushback suffered while activating healing abilities by 35% and reduces the threat generated by healing abilities by 5%.",2);
    addCharacterSkill(@"Supercharge Cells",PASSIVE,COMBAT_MEDIC,@"Converts 30 charges of Combat Support Cell to Supercharge your blaster, increasing all damage and healing dealt by 10% for 10 seconds. Charged Bolts: Cost reduced by 2. Full Auto: Cost reduced by 1. Advanced Medical Probe: Cooldown reduced by 100%. Kolto Bomb: Places a shield on all targets, reducing damage taken by 10% for 15 seconds.",2);
    addCharacterSkill(@"First Responder",PASSIVE,COMBAT_MEDIC,@"Critical results with damage and healing abilities have a 50% chance to grant First Responder, increasing alacrity by 5% for 6 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Efficient Conversions",PASSIVE,COMBAT_MEDIC,@"Reduces the cost of Concussion Charge, Concussive Round and Cryo Grenade by 1.",3);
    addCharacterSkill(@"Kolto Residue",PASSIVE,COMBAT_MEDIC,@"Kolto Bomb has a 50% chance to leave Kolto Residue on affected targets, increasing all healing received by 5% for 15 seconds.",3);
    addCharacterSkill(@"Kolto Bomb",INSTANT,COMBAT_MEDIC,@"Lobs a kolto bomb at the target area, exploding on impact. Heals up to 3 allies within 8 meters of the targeted area for 95 - 206.",3);
    addCharacterSkill(@"Combat Shield",PASSIVE,COMBAT_MEDIC,@"Reactive Shield now further decreases ability activation pushback by 30% and makes you immune to interrupts.",3);
    //Tier 4
    addCharacterSkill(@"Treated Wound Dressings",PASSIVE,COMBAT_MEDIC,@"Reduces all damage taken by 2% while Combat Support Cell is active.",4);
    addCharacterSkill(@"Field Triage",PASSIVE,COMBAT_MEDIC,@"Advanced Medical Probe has a 33.34% chance to reduce the cost of your next Medical Probe by 2.",4);
    addCharacterSkill(@"Med Zone",PASSIVE,COMBAT_MEDIC,@"Increases all healing received by 10% while Reactive Shield is active.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    
    //Concealment
    //Tier 1
    addCharacterSkill(@"Concealed Attacks",PASSIVE,CONCEALMENT,@"Increases the crit chance of Backstab and Hidden Strike by 8%.",1);
    addCharacterSkill(@"Imperial Brew",PASSIVE,CONCEALMENT,@"Increases the damage dealt by Corrosive Dart by 10%.",1);
    addCharacterSkill(@"Survival Training",PASSIVE,CONCEALMENT,@"Increases all healing done by 1% and all healing recieved by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Infiltrator",PASSIVE,CONCEALMENT,@"Increases movement speed by 5% and effective stealth level by 1.",2);
    addCharacterSkill(@"Surgical Strikes",PASSIVE,CONCEALMENT,@"Increases the damage dealt by Shiv, Overload Shot and Laceration by 3%.",2);
    addCharacterSkill(@"Inclement Conditioning",PASSIVE,CONCEALMENT,@"Increases total Endurance by 2%.",2);
    addCharacterSkill(@"Scouting",PASSIVE,CONCEALMENT,@"Increases stealth detection level by 1 and defense by 1%.",2);
    //Tier 3
      addCharacterSkill(@"Waylay",PASSIVE,CONCEALMENT,@"Reduces the energy cost of Shiv by 5 and Backstab by 10.",3);
    addCharacterSkill(@"Laceration",PASSIVE,CONCEALMENT,@"Executes your Tactical Advantage, lacerating the target for 1330 - 1552 kinetic damage. Requires and consumes Tactical Advantage.",3);
                      addCharacterSkill(@"Collateral Strike",PASSIVE,CONCEALMENT,@"Laceration has a 25% chance to trigger a Collateral Strike, dealing 394 additional kinetic damage. This effect cannot occur more than once every 10 seconds. Standard and weak targets are additionally stunned by Collateral Strike.",3);
    addCharacterSkill(@"Revitalizers",PASSIVE,CONCEALMENT,@"Stim Boost now additionally grants Revitalizers, restoring 2% of total health every 3 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Energy Screen",PASSIVE,CONCEALMENT,@"Dodging or resisting an attack restores 1 energy. In addition, Cloaking Screen no longer reduces healing dealt and received.",4);
    addCharacterSkill(@"Pin Down",PASSIVE,CONCEALMENT,@"Sever Tendon has a 50% chance to immobilize the target for 2 seconds.",4);
    addCharacterSkill(@"Tactical Opportunity",PASSIVE,CONCEALMENT,@"Collateral Strike has a 50% chance to immediately re-grant Tactical Advantage when hitting a poisoned target.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    //id waylay = addCharacterSkillOLD(@"Waylay",PASSIVE,CONCEALMENT,@"Backstab no longer has an energy cost.");
    //id slice = addCharacterSkillOLD(@"Slice",PASSIVE,CONCEALMENT,@"Sever Tendon has a 100% chance to root targets for 2 seconds.");
   
    //Corruption
    //Tier 1
    addCharacterSkill(@"Dark Mending",PASSIVE,CORRUPTION,@"Reduces the activation time of Dark Infusion by 0.25 seconds.",1);
    addCharacterSkill(@"Seeping Darkness",PASSIVE,CORRUPTION,@"Increases Force critical chance by 1%.",1);
    addCharacterSkill(@"Haunting Presence",PASSIVE,CORRUPTION,@"Increases total Presence by 3% and all healing done by 1%.",1);
    //Tier 2
    addCharacterSkill(@"Lucidity",PASSIVE,CORRUPTION,@"Reduces the pushback suffered when activating healing abilities by 25% and lowers the threat generated by healing abilities by 5%.",2);
    addCharacterSkill(@"Empty Body",PASSIVE,CORRUPTION,@"Increases all healing recieved by 4%.",2);
    addCharacterSkill(@"Force Suffusion",PASSIVE,CORRUPTION,@"Increases the damage and healing of area effect abilities by 5%.",2);
    //Tier 3
    addCharacterSkill(@"Resurgence",INSTANT,CORRUPTION,@"Immediately heals a target, plus additional healing over 9 seconds.",3);
    addCharacterSkill(@"Force Bending",PASSIVE,CORRUPTION,@"Your Resurgence has a 50% chance to increases the effect of your next healing ability: Dark Heal: Force cost reduced by 50%. Dark Infusion: Activation time reduced by 1 second. Innervate: Critical chance increased by 25%. Revivification: Force cost reduced by 30%.",3);
    addCharacterSkill(@"Dark Resilience",PASSIVE,CORRUPTION,@"Reduces the health spent by Consumption by 1%.",3);
    addCharacterSkill(@"Efficacious Currents",PASSIVE,CORRUPTION,@"Reduces the Force cost of Static Barrier by 15 and reduces the cooldown of Static Barrier by 1.5 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Sith Purity",PASSIVE,CORRUPTION,@"Lowers the Force cost of Purge by 15. In addition, Purge now removes negative physical effects and heals the target for 111 - 167.",4);
    addCharacterSkill(@"Reconstruct",PASSIVE,CORRUPTION,@"Increases the duration of Resurgence by 3 seconds. In addition, Resurgence has a 50% chance to increase the target's armor rating by 10% for the duration of Resurgence.",4);
    addCharacterSkill(@"Fadeout",PASSIVE,CORRUPTION,@"Static Barrier increases the target's movement speed by 10% for 3 seconds.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    //id revivification = addCharacterSkillOLD(@"Revivificaton",INSTANT,CORRUPTION,@"Heals all allies within 8 meters of the targeted area for 341. Targets remainig in the area heal for an additional 483 over 10 seconds.");
    //id forceBending = addCharacterSkillOLD(@"Force Bending",PASSIVE,CORRUPTION,@"Your resurgence has a 100% chance to grant Force Bending, which reduces the cast time of your next Dark Heal, Dark Infusion, or Revivification by 30%.");
    
    //Darkness
    //Tier 1
    addCharacterSkill(@"Charge Mastery",PASSIVE,DARKNESS,@"Improves the effect of your Lightsaber charges while they're active.\n\nLightning Charge: Increases crit chance by 1% and the duration of Lightning Charge's Discharge by 1 seconds.\n\nDark Charge: Increases the internal and elemental resistance by 3%.\n\nSurging Charge: Your attacks ignore 3% of your target's armor.",1);
    addCharacterSkill(@"Lightning Reflexes",PASSIVE,DARKNESS,@"Whenever you succesfully shield, parry or deflect an attack, you recover 1% of your total Force. This effect cannot occur more than once a second. In addition your melee and ranged defense is increased by 2%.",1);
    addCharacterSkill(@"Thrashing Blades",PASSIVE,DARKNESS,@"Increases the damage dealt by Thrash, Lacerate, and Voltaic Slash by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Shroud of Darkness",PASSIVE,DARKNESS,@"Increases total endurance by 1%.",2);
    addCharacterSkill(@"Lightning Recovery",PASSIVE,DARKNESS,@"Reduces the cooldown of Force Speed by 5 seconds and Force Shroud by 7.5 seconds.",2);
    addCharacterSkill(@"Swelling Shadows",PASSIVE,DARKNESS,@"Increases the chance your Dark Charge applies its effects by 7.5%.",2);
    addCharacterSkill(@"Electric Execution",PASSIVE,DARKNESS,@"Increases the damage dealt by your lightsaber charges by 3%.",2);
    //Tier 3
    addCharacterSkill(@"Disjunction",PASSIVE,DARKNESS,@"Activating Force Speed now removes all movement-impairing effects, and your Force Shroud now lasts 2 seconds longer.",3);
    addCharacterSkill(@"Energize",PASSIVE,DARKNESS,@"While Dark Charge is active, Thrash and Lacerate have a 50% chance to finish the cooldown on Shock and make your next Shock a critical hit. Energized Shocks that consume a charge of Recklessness deal an additional 50% critical damage.",3);
    addCharacterSkill(@"Dark Ward",PASSIVE,DARKNESS,@"Surrounds you in a dark ward with 8 charges that increases your shield chance by 15% for 20 seconds. Each time you successfully shield, Dark Ward loses 1 charge. Does not break Stealth.",3);
    addCharacterSkill(@"Premonition",PASSIVE,DARKNESS,@"Increases your stealth detection level by 1 and defense by 1%.",3);
    //Tier 4
    addCharacterSkill(@"Hollow",PASSIVE,DARKNESS,@"Increases your shield absorption by 2%. In addition, when you activate Overcharge Saber while Dark Charge is active, you instantly heal for 5% of your total health.",4);
    addCharacterSkill(@"Blood of Sith",PASSIVE,DARKNESS,@"Increases the rate at which your Force regenerates by 10%.",4);
    //Tier 5
    //Tier 6
    //Tier 7
   
    //id wither = addCharacterSkillOLD(@"Wither",INSTANT,DARKNESS,@"Causes up to 5 targets to wither under the weight of the Force, dealing 297 kinetic damage and decreasing the damage all targets deal by 5%. This ability generates a high amount of threat. Lasts 15 seconds.");
    
    //Deception
    //Tier 1
    addCharacterSkill(@"Insulation",PASSIVE,DECEPTION,@"Increases your armor rating by 15% while Surging Charge or Lightning Charge is active.",1);
    addCharacterSkill(@"Duplicity",PASSIVE,DECEPTION,@"Direct damage attacks have a 10% chance to grant Exploit Weakness, causing your next Maul to ignore 50% of the target's armor cost and cost 50% less force. Cannot occur more than once every 10 seconds.",1);
    addCharacterSkill(@"Dark Embrace",PASSIVE,DECEPTION,@"While in Stealth mode and for 6 seconds after leaving Stealth mode, Force Regeneration is is increased by 25%.",1);
    //Tier 2
    addCharacterSkill(@"Obfuscation",PASSIVE,DECEPTION,@"Increases your effective stealth level by 1 and movement speed by 5% while stealthed.",2);
    addCharacterSkill(@"Recirculation",PASSIVE,DECEPTION,@"Reduces the cooldown of Discharge by 1.5 seconds.",2);
    addCharacterSkill(@"Avoidance",PASSIVE,DECEPTION,@"Lowers the cooldown of Jolt by 1 second and Unbreakable Will by 15 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Induction",PASSIVE,DECEPTION,@"Increases the critical strike damage dealt by Maul by [15 / 30]%. In addition, Thrash and Voltaic Slash have a [50 / 100]% chance to grant Induction, reducing the Force cost of your next Shock by 25%. Stacks up to 2 times.",3);
    addCharacterSkill(@"Surging Charge",INSTANT,DECEPTION,@"Charges your lightsaber with raw surging Force, giving your attacks a 25% chance to deal (current weapon) internal damage. This effect cannot occur more than once every 1.5 seconds. Requires a double-bladed lightsaber. Does not break Stealth.",3);
    addCharacterSkill(@"Darkswell",PASSIVE,DECEPTION,@"Blackout can now be used out of stealth mode, granting 6 seconds of Dark Embrace and restoring 10 Force. In addition, Force Cloak no longer reduces healing done and received.",3);
    addCharacterSkill(@"Deceptive Power",PASSIVE,DECEPTION,@"Increases your total Force by 10.",3);
    //Tier 4
    addCharacterSkill(@"Entropic Field",PASSIVE,DECEPTION,@"Reduces damage taken from area effects by 15%.",4);
    addCharacterSkill(@"Saber Conduit",PASSIVE,DECEPTION,@"Your Surging Charge has a 33.34% chance to restore 10 Force when it deals damage to an enemy. This effect cannot occur more than once every 10 seconds.",4);
    addCharacterSkill(@"Fade",PASSIVE,DECEPTION,@"Lowers the cooldown of Blackout by 7.5 seconds and Force Cloak by 30 seconds.",4);
    addCharacterSkill(@"Static Cling",PASSIVE,DECEPTION,@"Increases the duration of Force Slow and reduces the cooldown of Force Slow by 3 seconds.",4);
    //Tier 5
    //id staticCharges = addCharacterSkillOLD(@"Static Charges",PASSIVE,DECEPTION,@"When your Surging Charge deals damage, you have a 100% chance to build a Static Charge, increasing the damage dealt by your next Surging Discharge by 6%. Stacks up to 5 times.");
    //Tier 6
    //Tier 7
    
    //Defense
    //Tier 1
    addCharacterSkill(@"Momentum",PASSIVE,DEFENSE,@"Force Leap and Zealous Leap have a [33 / 66 / 99]% chance to make the next Blade Storm activate without a focus cost.",1);
    addCharacterSkill(@"Dust Storm",PASSIVE,DEFENSE,@"Force Sweep has a [50 / 100]% chance to lower the accuracy of affected targets by 5% for 18 seconds.",1);
    addCharacterSkill(@"Victory Rush",PASSIVE,DEFENSE,@"Sundering Strike has a [50 / 100]% chance to build 1 additional focus.",1);
    //Tier 2
    addCharacterSkill(@"Solidified Force",PASSIVE,DEFENSE,@"Reduces the focus cost of Hilt Strike and Freezing Force by [1 / 2].",2);
    addCharacterSkill(@"Lunge",PASSIVE,DEFENSE,@"Reduces the focus cost of Riposte by [1 / 2] while Soresu Form is active.",2);
    addCharacterSkill(@"Guard Stance",PASSIVE,DEFENSE,@"Increases your melee and ranged defenses by [2 / 4 / 6]% while in Soresu Form.",2);
    //Tier 3
    addCharacterSkill(@"Pacification",PASSIVE,DEFENSE,@"Increases the damage dealt by Hilt Strike, Force Sweep and Cyclone Slash by 5%.",3);
    addCharacterSkill(@"Profound Resolution",PASSIVE,DEFENSE,@"Reduces the cooldown of Resolute by 15 seconds.",3);
    addCharacterSkill(@"Warding Call",INSTANT,DEFENSE,@"Reduces all damage taken by 40% for 10 seconds.",3);
    addCharacterSkill(@"Blade Barricade",PASSIVE,DEFENSE,@"Riposte now increases melee and ranged defenses by 2% for 6 seconds.B",3);
    //Tier 4
    addCharacterSkill(@"Command",PASSIVE,DEFENSE,@"Reduces the cooldown of Challenging Call and Force Push by 7.5 seconds.",4);
    addCharacterSkill(@"Courage",PASSIVE,DEFENSE,@"While in Soresu Form, parrying, deflecting, shielding or resisting an attack has a 25% chance to grant courage, reducing the focus cost of your next Blade Storm or Force Sweep by 1. Lasts 10 seconds and stacks up to 3 times.",4);
    addCharacterSkill(@"Shield Specialization",PASSIVE,DEFENSE,@"Increases shield chance by 2%.",4);
    //Tier 5
    addCharacterSkill(@"Command",PASSIVE,DEFENSE,@"Reduces the cooldown of Force Push by 7.5 seconds.",5);
    addCharacterSkill(@"Hit Strike",INSTANT,DEFENSE,@"Bashes the target for (current weapon) kinetic damage, stunning it for 4. This ability generates a high amount of threat.",5);
    addCharacterSkill(@"Shield Specialization",PASSIVE,DEFENSE,@"Increases Shield chance by 2%.",5);
    //id forceclap = addCharacterSkillOLD(@"Forceclap",PASSIVE,DEFENSE,@"Force Leap now stuns targets for 2 seconds.");
    //Tier 6
    //Tier 7

    //id endure = addCharacterSkillOLD(@"Endure",INSTANT,DEFENSE,@"Temporarily increases your maximum health by 30% for 15 seconds. When the effect ends, the health is lost.");
    
    
    //Dirty Fighting
    //Tier 1
    addCharacterSkill(@"Black Market Mods",PASSIVE,DIRTY_FIGHTING,@"Increases alacrity by 2%.",1);
     addCharacterSkill(@"No Holds Barred",PASSIVE,DIRTY_FIGHTING,@"Increases range and tech critical chance by 2%.",1);
    addCharacterSkill(@"Holdout Defense",PASSIVE,DIRTY_FIGHTING,@"Increases the damage dealt by Blaster Whip by 5%.",1);
    //Tier 2
    addCharacterSkill(@"Dirty Escape",PASSIVE,DIRTY_FIGHTING,@"Reduces the cooldown of Dirty Kick by 7.5 seconds, and increases the movement speed by 15% for 4 seconds after activating Dirty Kick.",2);
    addCharacterSkill(@"Flash Powder",PASSIVE,DIRTY_FIGHTING,@"Reduces all targers' accuracy by 10% for 8 seconds after Flash Grenade ends.",2);
    addCharacterSkill(@"Mortal Wound",PASSIVE,DIRTY_FIGHTING,@"Vital Shot has a 12.5% chance to tick twice when it inflicts damage.",2);
    addCharacterSkill(@"Open Wound",PASSIVE,DIRTY_FIGHTING,@"Increases the duration of Vital Shot by 3 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Shrap Bomb",INSTANT,DIRTY_FIGHTING,@"Hurls a shrap bomb that explodes with razor-sharp shrapnel on impact, causing up to 3 targets within 5 meters to bleed for ? internal damage over 21 seconds.",3);
    addCharacterSkill(@"Street Tough",PASSIVE,DIRTY_FIGHTING,@"Pugnacity immediately restores 5 energy when activated. Additionally reduces the cooldown of Pugnacity by 7.5 seconds.",3);
    addCharacterSkill(@"Cheap Shots",PASSIVE,DIRTY_FIGHTING,@"Increases the damage dealt by Quick Shot, Blaster Volley and Wounding Shots by 3%.",3);
    //Tier 4
    addCharacterSkill(@"Fighting Spirit",PASSIVE,DIRTY_FIGHTING,@"Reduces the cooldown of Cool Head by 15 seconds. In addition, critical hits with bleed effects restore 1 energy.",3);
    addCharacterSkill(@"Feelin' Woozy",PASSIVE,DIRTY_FIGHTING,@"Shrap Bomb has a 50% chance to reduce the movement speed of all targets by 30% for 6 seconds.",3);
    addCharacterSkill(@"Quick Getaway",PASSIVE,DIRTY_FIGHTING,@"Reduces the cooldown of Dodge by 7.5 seconds and Escape by 15 seconds.",3);
    addCharacterSkill(@"Black Market Equipment",PASSIVE,DIRTY_FIGHTING,@"Increases the critical hit chance of all periodic effects by 4%.",3);
    //Tier 5
    //Tier 6
    //id coldBlooded = addCharacterSkillOLD(@"Cold Blooded",PASSIVE,DIRTY_FIGHTING,@"Bleed effects do 25% more damage against targets with less than 30% health.");
    //Tier 7
    
    //id heightenedEvasion = addCharacterSkillOLD(@"Heightened Evasion",PASSIVE,DIRTY_FIGHTING,@"Reduces cooldown of Dodge by 30 seconds. Dodge has a 30% chance to grant a speed boost to the player while active.");
   
    //Engineering
    //Tier 1
    addCharacterSkill(@"Engineer's Tool Belt",PASSIVE,ENGINEERING,@"Reduces the cooldown of Flash Bang by 7.5 seconds and Fragmentation Grenade by 1.5 seconds.",1);
    addCharacterSkill(@"Energy Tanks",PASSIVE,ENGINEERING,@"Increases maximum energy by 5.",1);
    addCharacterSkill(@"Gearhead",PASSIVE,ENGINEERING,@"Increases total Cunning by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Explosive Engineering",PASSIVE,ENGINEERING,@"Increases the damage dealt by Explosive Probe and all area effects by 5%",2);
    addCharacterSkill(@"Vital Regulators",PASSIVE,ENGINEERING,@"Adrenaline Probe now heals you for 3% of your total health over 3 seconds.",2);
    addCharacterSkill(@"Calculated Pursuit",PASSIVE,ENGINEERING,@"You have a 50% chance to gain Calculated Pursuit upon exiting cover, allowing your next Snipe to be used in any situation.",2);
    addCharacterSkill(@"Vitality Serum",PASSIVE,ENGINEERING,@"Increases total Endurance by 2%.",2);
    //Tier 3
    id clusterBombs = addCharacterSkill(@"Cluster Bombs",PASSIVE,ENGINEERING,@"After Explosive Probe is detonated, it drops an additional 3 cluster bombs on the target. When the target takes ranged damage, one cluster bomb explodes.",3);
    addCharacterSkill(@"Efficient Engineering",PASSIVE,ENGINEERING,@"Reduces the energy cost of Explosive Probe, Interrogation Probe and Plasma Probe by 2.",3);
    addCharacterSkill(@"Interrogation Probe",INSTANT,ENGINEERING,@"Summons an interrogation probe that clings to the target and deals 2581 energy damage over 18 seconds.",3);
    addCharacterSkill(@"Inventive Interrogation Techniques",PASSIVE,ENGINEERING,@"Interrogation Probe reduces the target's movement speed by 15% for the duration.",3);
    //Tier 4
    addCharacterSkill(@"Imperial Methodology",PASSIVE,ENGINEERING,@"Increases the number of cluster bombs dropped by Explosive Probe by 1. In addition, when the cluster bombs detonate, you recover 5 energy.",4);
    addCharacterSkill(@"Stroke of Genius",PASSIVE,ENGINEERING,@"Activating Cover Pulse has a 50% chance of making the next Snipe activate instantly.",4);
    addCharacterSkill(@"Experimental Explosives",PASSIVE,ENGINEERING,@"Increases the critical damage dealt by all area effects by 15%.",4);
    //Tier 5
    //Tier 6
    //Tier 7

    //id sharpBurst = addCharacterSkillOLD(@"Sharp Burst",PASSIVE,ENGINEERING,@"When you hit a target affected by Interrogation Probe with Takedown, there is a 100% chance a shrapnel burst occurs dealing damage to enemies within 8 meters of the target.");
    
    //PYROTECH
    //Tier 1
    addCharacterSkill(@"Advanced Targeting",PASSIVE,PYROTECH,@"Increases ranged and tech accuracy by 1%.",1);
    addCharacterSkill(@"System Calibrations",PASSIVE,PYROTECH,@"Increases Alacrity by 2%.",1);
    addCharacterSkill(@"Integrated Cardio Package",PASSIVE,PYROTECH,@"Increases Endurance by 1%.",1);
    //Tier 2
    addCharacterSkill(@"Superheated Gas",PASSIVE,PYROTECH,@"Increases the damage dealt by Combustible Gas Cyclinder by 10% and it's chance to be triggered by 2%.",2);
    addCharacterSkill(@"Sweltering Heat",PASSIVE,PYROTECH,@"Combustible Gas Cyclinder has a 50% chance when it applies its effects to reduce the movement speed of the target for 2 seconds.",2);
    addCharacterSkill(@"Gyroscopic Alignment Jets",PASSIVE,PYROTECH,@"You have a 50% chance to vent 8 heat when stunned, immobilized, knocked down or otherwise incapacitated.",2);
    //Tier 3
    id incendiaryMissile = addCharacterSkill(@"Incendiary Missile",INSTANT,PYROTECH,@"Fires a missile at an enemy doing elemental damage and applying a burn that deals damage every 3 seconds for 18 seconds.",3);
    addCharacterSkill(@"Infrared Sensors",PASSIVE,PYROTECH,@"Increases the stealth detection by 1, melee and ranged defense by 1%, and reduces the cooldown of Stealth Scan by 2.5 seconds.",3);
    addCharacterSkill(@"Superheated Rail",PASSIVE,PYROTECH,@"Rail Shot ignores 15% of the target's armor. In addition, if Rail Shot hits a burning target, it has a 50% chance to vent 8 heat and refresh the duration of your Combustable Gas Cylinder's burn effect if present.",3);
     addCharacterSkill(@"Degauss",PASSIVE,PYROTECH,@"Energy Shield has a 50% chance to remove all movement-imparing effects when activated.",3);
    //Tier 4
    id prototypeParticleAccelerator = addCharacterSkill(@"Prototype Particle Accelerator",PASSIVE,PYROTECH,@"Your incendiary missile damage has a 30% chance to finish the cooldown on Rail Shot and to remove its heat cost. This effect can only happen every 10 seconds.",4);
    addCharacterSkill(@"Rapid Venting",PASSIVE,PYROTECH,@"Reduces the cooldown of Vent Heat by 15 seconds.",4);
    //Tier 5
    addCharacterSkill(@"Energy Rebounder",PASSIVE,PYROTECH,@"When you take damage, you have 50% chance to reduce the active cooldown of Energy Shield by 1.5 seconds. This effect cannot occur more than once every 1.5 seconds.",5);
    addCharacterSkill(@"Rain of Fire",PASSIVE,PYROTECH,@"Rapid Shots, Power Shot, Rail Shot, Unload and Sweeping Blasters deal 3% additional damage to burning targets.",5);
    addCharacterSkill(@"Firebug",PASSIVE,PYROTECH,@"Increases the critical bonus damage of Combustible Gas Cylinder, Rail Shot, Incendiary Missile and Thermal Detonator by 15%.",5);
    //Tier 6
    //Tier 7

    //Focus
    //Tier 1
    addCharacterSkill(@"Master Focus",PASSIVE,FOCUS,@"Reduces the cooldown of Master Strike by 1.5 seconds and Force Stasis by 5 seconds.",1);
    addCharacterSkill(@"Insight",PASSIVE,FOCUS,@"Increase the critical strike chance of your Force attacks by 2%.",1);
    addCharacterSkill(@"Stagger",PASSIVE,FOCUS,@"Increases the duration of Force Leap's immobilize effect by 0.5 seconds.",1);
    //Tier 2
    addCharacterSkill(@"Second Wind",PASSIVE,FOCUS,@"Resolve has a 50% chance to heal you for 10% of your maximum life.",2);
    addCharacterSkill(@"Zephyr",PASSIVE,FOCUS,@"Reduces the cooldown of all Force abilities while in Shii-Cho Form by 1.5 seconds.",2);
    addCharacterSkill(@"Visionary",PASSIVE,FOCUS,@"You now generate 1 focus when attacked when attacked in Shii-Cho Form. This effect cannot occur more than once every 6 seconds.",2);
    addCharacterSkill(@"Swift Slash",PASSIVE,FOCUS,@"Increases the critical strike chance of Slash by 7.5%.",2);
    //Tier 3
    addCharacterSkill(@"Saber Strength",PASSIVE,FOCUS,@"Increases the damage dealth by Slash and Zealous Leap by 3%.",3);
    addCharacterSkill(@"Zealous Leap",INSTANT,FOCUS,@"Leaps to target, stabbing it for weapon damage. Strikes with both weapons if dual wielding. Cannot be used against targets in cover.",3);
    addCharacterSkill(@"Pulse",PASSIVE,FOCUS,@"Reduces the pushback suffered while channeling Force Stasis by 50%.",3);    
    //Tier 4
    addCharacterSkill(@"Inner Focus",PASSIVE,FOCUS,@"Combat Focus immediately grants 1 additional focus.",4);
    addCharacterSkill(@"Felling Blows",PASSIVE,FOCUS,@"Force Leap and Zealous Leap have a 50% chance to make your next Sweep used within 15 seconds an automatic critical hit.",4);
    addCharacterSkill(@"Singularity",PASSIVE,FOCUS,@"Each tick of Force Stasis and Force Exhaustion grants you Singularity, increasing the damage your next Force Sweep deals by 12.5%. Stacks up to 4 times.",4);
    addCharacterSkill(@"Unwavering Focus",PASSIVE,FOCUS,@"Master Strike is now uninterruptible.",4);
    //Tier 5
    addCharacterSkill(@"Gravity",PASSIVE,FOCUS,@"Reduces the focus cost of Freezing Force and Force Exhaustion by 1.",5);
    addCharacterSkill(@"Agility Training",PASSIVE,FOCUS,@"Increases movement speed by 20% for 5 seconds after using Zealous Leap.",5);
    addCharacterSkill(@"Shii-Cho Mastery",PASSIVE,FOCUS,@"Shii-Cho Form increases armor penetration by 10%.",5);
    //Tier 6
    //Tier 7
    //id forceExhaustion = addCharacterSkillOLD(@"Force Exhaustion",INSTANT,FOCUS,@"Progressively slows the target from 60% ro 10% movement speed over 5 seconds and deals 180 kinetic damage each second. At the end of the duration the target is crushed, and takes an additional 553 kinetic damage.");
    
    //Gunnery
    //Tier 1
    addCharacterSkill(@"Havoc Rounds",PASSIVE,GUNNERY,@"Increases damage dealt by all rounds and Charged Bolts by 3% and increases the healing dealt by Kolto Bomb by 10%.",1);
    addCharacterSkill(@"Advanced Tech",PASSIVE,GUNNERY,@"Increases healing recieved by 1% and all healing done by 1%.",1);
    addCharacterSkill(@"Ironsights",PASSIVE,GUNNERY,@"Increases aim by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Steadied Aim",PASSIVE,GUNNERY,@"Reduces the pushback suffered while activating Charged Bolt, Concussive Round, Grav Round and Full Auto by 25%.",2);
    addCharacterSkill(@"Muzzle Fluting",PASSIVE,GUNNERY,@"Reduces the cost of Charged Bolts and Grav Round by 1.",2);
    addCharacterSkill(@"Special Munitions",PASSIVE,GUNNERY,@"Plasma Cell: Increases the tech crit chance by 3%. Armor Piercing Cell: Reduces the cost of High Impact Bolt by 1. Combat Support Cell: Increases the tech crit chance by 3%.",2);
    addCharacterSkill(@"Heavy Trooper",PASSIVE,GUNNERY,@"Increases endurance by 1% and all healing by 3%.",2);
    //Tier 3
    addCharacterSkill(@"Concussive Force",INSTANT,GUNNERY,@"Stockstrike has a 50% chance to knock the target back several meters. In additional, Concussion Charge's knockback effect is stronger and pushes enemies 2 meters further away.",3);
    addCharacterSkill(@"Grav Round",INSTANT,GUNNERY,@"Fires a round that creates a gravity vortex on the target that causes kinetic damage, crushing the target's armor and reducing the armor rating by 4% for 15 seconds. Stacks up to 5 times.",3);
    addCharacterSkill(@"Deadly Cannon",INSTANT,GUNNERY,@"Increases the critical bonus damage of Full Auto and Demolition Round by 15%.",3);
   addCharacterSkill(@"Charged Barrier",PASSIVE,GUNNERY,@"Charged Bolts and Grav Round have a 50% chance to build a Charged Barrier that reduces damage taken by 2% for 15 seconds. Stacks up to 5 times.",3);
    //Tier 4
    addCharacterSkill(@"Tenacious Defense",PASSIVE,GUNNERY,@"Reduces the cooldown of Concussion Charge by 5 seconds and Tenacity by 15 seconds.",4);
    addCharacterSkill(@"Gravity Surge",PASSIVE,GUNNERY,@"Grav Round now applies an additional gravity vortex.",4);
    addCharacterSkill(@"Cell Charger",PASSIVE,GUNNERY,@"While Armor-piercing Cell is active, critical hits with rounds and Full Auto have a 50% chance to generate 1 energy cell. This effect cannot occur more than once every 3 seconds.",4);
    //Tier 5
    //Tier 6
    //Tier 7

    //Infiltration
    //Tier 1
     addCharacterSkill(@"Shadowy Veil",PASSIVE,INFILTRATION,@"Increasing your armor rating by 15% while Shadow Technique or Force Technique is active.",1);
    addCharacterSkill(@"Infiltration Tactics",PASSIVE,INFILTRATION,@"Direct damage attacks have a 10% chance to grand Find Weakness, causing your next Shadow Strike to ignore 50% of the target's armor and cost 50% less force. Cannot occur more than once every 10 seconds.",1);
    addCharacterSkill(@"Shadow's Respite",PASSIVE,INFILTRATION,@"While in stealth mode and for 6 seconds after leaving stealth mode, force regeneration is increased by 25%.",1);
    //Tier 2
    addCharacterSkill(@"Misdirection",PASSIVE,INFILTRATION,@"Increases your effective stealth level by 1 and movement speed by 5% while stealth.",2);
    addCharacterSkill(@"Security Breach",PASSIVE,INFILTRATION,@"Reduces the cooldown of Force Breach by 1.5 seconds.",2);
    addCharacterSkill(@"Celerity",PASSIVE,INFILTRATION,@"Lowers the cooldown of Mind Snap by 1 second and Force of Will by 15 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Vigor",PASSIVE,INFILTRATION,@"Increases your total Force by 10.",3);
    addCharacterSkill(@"Circling Shadows",PASSIVE,INFILTRATION,@"Increases the critical strike damage dealt by Shadow Strike by 15%. In addition, Double Strike and Clairvoyant Strike have a 50% chance to grant Circling Shadows, reducing the Force cost of your next Project by 25%. Stacks up to 2 times.",3);
    addCharacterSkill(@"Masked Assault",PASSIVE,INFILTRATION,@"Blackout can now be used out of stealth mode, granting 6 seconds of Shadow's Respite. In addition, Force Cloak no longer reduces healing done and received.",3);
    addCharacterSkill(@"Shadow Technique",PASSIVE,INFILTRATION,@"Assumes a shadow technique, giving your attacks a 25% chance to deal 229 internal damage. This effect cannot occur more than once every 1.5 seconds. Requires a double-bladed lightsaber. Does not break Stealth.",3);
    //Tier 4
    addCharacterSkill(@"Kinetic Field",PASSIVE,INFILTRATION,@"Reduces damage taken from area effects by 15%.",4);
    addCharacterSkill(@"Profundity",PASSIVE,INFILTRATION,@"When your Shadow Technique deals damage, you have a 33.34% chance to recover 10 Force. This effect cannot occur more than once every 10 seconds.",4);
    addCharacterSkill(@"Fade",PASSIVE,INFILTRATION,@"Lowers the cooldown of Blackout by 7.5 seconds and Force Cloak by 30 seconds.",4);
    addCharacterSkill(@"Subduing Techniques",PASSIVE,INFILTRATION,@"Increases the duration of Force Slow and reduces the cooldown of Force Slow by 3 seconds.",4);
    //Tier 5
    //Tier 6
    //Tier 7

    //Kinetic Combat
    //Tier 1
    addCharacterSkill(@"Applied Force",PASSIVE,KINETIC_COMBAT,@"Increases the damage dealt by Double Strike, Whirling Blow and Clairvoyant Strike by 3%.",1);
    addCharacterSkill(@"Double-bladed Saber Defense",PASSIVE,KINETIC_COMBAT,@"Whenever you successfully parry or deflect an attack, you recover 1% of your total Force. This effect cannot occur more than once a second. In addition, your melee and ranged defenses are increased by 2%.",1);
    addCharacterSkill(@"Technique Mastery",PASSIVE,KINETIC_COMBAT,@"Force Technique: Increases the critical chance by 1% and the duration of Force Technique's Breach by 1 second. Combat Technique: Increases internal and elemental resistance by 3%. Shadow Technique: Increases your armor penetration by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Mental Fortitude",PASSIVE,KINETIC_COMBAT,@"Increases total Endurance by 1%.",2);
    
    addCharacterSkill(@"Elusiveness",PASSIVE,KINETIC_COMBAT,@"Reduces the cooldown of Force Speed by 7.5 seconds, and Resilience by 3 seconds.",2);
    addCharacterSkill(@"Rapid Recovery",PASSIVE,KINETIC_COMBAT,@"Increases the chance of your Combat Technique applies its effects by 2%.",2);
    addCharacterSkill(@"Expertise",PASSIVE,KINETIC_COMBAT,@"Increases the damage dealt by your techniques by 3%.",2);
    //Tier 3
    addCharacterSkill(@"Particle Acceleration",PASSIVE,KINETIC_COMBAT,@"Double Strike and Whirling Blow have a 50% chance to reset the cooldown on Project and make your next Project a critical hit.",3);
    addCharacterSkill(@"Shadowsight",PASSIVE,KINETIC_COMBAT,@"Increases your stealth detection level by 1%.",3);
    addCharacterSkill(@"Mind Over Matter",PASSIVE,KINETIC_COMBAT,@"Activating Force Speed now removes all movement-impairing effects, and your Resilience now lasts 2 seconds longer. In addition, using Cloud Mind while Combat Technique is active will no longer reduce threat, instead taunting all enemies within 15 meters and forcing them to attack you for 6 seconds.",3);
    addCharacterSkill(@"Kinetic Ward",INSTANT,KINETIC_COMBAT,@"Erects a kinetic ward with 8 charges that increases your shield chance by 15% for 20 seconds. Each time you successfully shield, Kinetic Ward loses 1 charge. Does not break Stealth.",3);
    //Tier 4
    addCharacterSkill(@"Impact Control",PASSIVE,KINETIC_COMBAT,@"Increases your shield absorption by 2%. In addition, when you activate Battle Readiness while Combat Technique is active, you instantly heal for 5% of your total health.",4);
    addCharacterSkill(@"One with the Force",PASSIVE,KINETIC_COMBAT,@"Increases the rate at which your Force regenerates by 10%.",4);
    //Tier 5
   
    //Tier 6
    //Tier 7
    //id spinningKick = addCharacterSkillOLD(@"Spinning Kick",INSTANT,KINETIC_COMBAT,@"Perform a spin kick that deals 560 kinetic damage and stuns the target for 3 seconds.");
    
    //Lethality
    //Tier 1
    addCharacterSkill(@"Deadly Directive",PASSIVE,LETHALITY,@"Increases Alacrity by 2%.",1);
    addCharacterSkill(@"Lethality",PASSIVE,LETHALITY,@"Increases critical chance by 2%.",1);
    addCharacterSkill(@"Razor Edge",PASSIVE,LETHALITY,@"Increases the damage dealt by Shiv by 6%.",1);
    //Tier 2
    addCharacterSkill(@"Slip Away",PASSIVE,LETHALITY,@"Reduces the cooldown of Debilitate by 7.5 seconds, and increases movement speed by 15% for 4 seconds after activating Debilitate.",2);
    addCharacterSkill(@"Flash Powder",PASSIVE,LETHALITY,@"Reduces the target's accuracy by 10% for 8 seconds after Flash Bang ends.",2);
    addCharacterSkill(@"Corrosive Microbes",PASSIVE,LETHALITY,@"Corrosive Dart  has a 12.5% chance to tick twice when inflicting damage.",2);
    addCharacterSkill(@"Lethal Injectors",PASSIVE,LETHALITY,@"Increases the duration of Corrosive Dart by 3 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Corrosive Grenade",PASSIVE,LETHALITY,@"Hurls a corrosive grenade that spews acid in a 5-meter radius on impact, dealing (unknown) internal damage over 21 seconds to up to 3 targets.",3);
    addCharacterSkill(@"Targeted Demolition",PASSIVE,LETHALITY,@"Increases the damage dealt by Fragmentation Grenade and Corrosive Grenade by 4%.",3);
    addCharacterSkill(@"Cut Down",PASSIVE,LETHALITY,@"Increases the damage dealt by Overload Shot, Carbine Burst and Cull by 3%.",3);
    //Tier 4
    addCharacterSkill(@"Lethal Purpose",PASSIVE,LETHALITY,@"Reduces the cooldown of Adrenaline Probe by 15 seconds. In addition, critical hits with poison effects restore 1 energy.",4);
    addCharacterSkill(@"Adhesive Corrosives",PASSIVE,LETHALITY,@"Corrosive Grenade has a 50% chance to reduce the movement speed of all targets by 30% for 6 seconds.",4);
    addCharacterSkill(@"Vanish",PASSIVE,LETHALITY,@"Reduces the cooldown of Evasion by 7.5 seconds and Escape by 15 seconds.",4);
    addCharacterSkill(@"Lethal Dose",PASSIVE,LETHALITY,@"Increases the critical hit chance of all periodic effects by 5%.",4);
    //Tier 5
    addCharacterSkill(@"Cull",INSTANT,LETHALITY,@"Executes your Tactical Advantage to fire a volley of corrosive shots, dealing (current weapon) weapon damage. For each of your poison effects present on the target, the target is culled for an additional (current weapon) internal damage. Requires and consumes Tactical Advantage.",5);
    addCharacterSkill(@"License to Kill",PASSIVE,LETHALITY,@"Reduces the energy cost of Cull by 3.",5);
    addCharacterSkill(@"Counterstrike",PASSIVE,LETHALITY,@"Countermeasures has a 50% chance to remove all movement impairing effects when activated.",5);
    //Tier 6
    //Tier 7
    //id improvise = addCharacterSkillOLD(@"Improvise",PASSIVE,LETHALITY,@"Critical poison damage has a 50% chance to make your next Snipe usable out of cover. The cost of your next Snipe is also reduced by 100%.");
    //id  corrosiveRounds = addCharacterSkillOLD(@"Corrosive Rounds",PASSIVE,LETHALITY,@"Weakening Blast has a 100% chance to refresh active poison effects on the target when the target is below 30% health.");
    
    //Lightning
    //Tier 1
    addCharacterSkill(@"Electric Induction",PASSIVE,LIGHTNING,@"Reduces the Force cost of Force attacks and healing abilities by 3%.",1);
    addCharacterSkill(@"Reserves",PASSIVE,LIGHTNING,@"Increases your total Force by 50.",1);
    addCharacterSkill(@"Convection",PASSIVE,LIGHTNING,@"Increases the damage dealt by Lightning Strike, Crushing Darkness, Chain Lightning, and Thundering Blast by 2%.",1);
    //Tier 2
    addCharacterSkill(@"Lightning Spire",PASSIVE,LIGHTNING,@"Increases the maximum range of Lightning Strike, Chain Lighting, and Thundering Blast by 5 meters.",2);
    addCharacterSkill(@"Exsanguinate",PASSIVE,LIGHTNING,@"Increases the duration of Affliction by 3 seconds.",2);
    addCharacterSkill(@"Subversion",PASSIVE,LIGHTNING,@"Reduces the pushback suffered while activating Lightning Strike, Chain Lightning and Thundering Blast by 35%. In addition, Lightning Strike has a 50% chance to increase your Force regeneration rate by 10% for 10 seconds. Stacks up to 3 times.",2);
    addCharacterSkill(@"Lightning Barrier",PASSIVE,LIGHTNING,@"Increases the amount absorbed by your Static Barrier by 10%.",2);
    //Tier 3
    addCharacterSkill(@"Lightning Barrage",PASSIVE,LIGHTNING,@"Affliction critical hits have a 50% chance to grant Lightning Barrage, causing your next Force Lightning to channel and tick twice as fast. This effect cannot occur more than once every 10 seconds.",3);
    addCharacterSkill(@"Electric Bindings",PASSIVE,LIGHTNING,@"Overload has a 50% chance to bind its targets in electricity, immobilizing them for 5 seconds. Damage dealt after 2 seconds ends the effect prematurely.",3);
    addCharacterSkill(@"Chain Lightning",INSTANT,LIGHTNING,@"Delivers an arc of lightning that deals 1298 - 1410 damage to up to 5 targets within 8 meters.",3);
    addCharacterSkill(@"Suppression",PASSIVE,LIGHTNING,@"Lowers the cooldown of Whirlwind by 7.5 seconds and increases the lockout duration of Jolt by 1 second.",3);
    //Tier 4
    addCharacterSkill(@"Lightning Storm",PASSIVE,LIGHTNING,@"Your Lightning Strike has a 30% chance and your Force Storm has a 10% chance when dealing damage to cause a Lightning Storm, immediately finishing the cooldown on Chain Lightning and reducing the activation time of your next Chain Lightning by 100%. This effect cannot occur more than once every 10 seconds.",4);
    addCharacterSkill(@"Lightning Effusion",PASSIVE,LIGHTNING,@"Force attacks that critically hit have a 50% chance to grant Lightning Effusion, reducing the Force cost of your next two Force abilities by 50%. Additionally reduces the cooldown of Force Speed by 5 seconds.",4);
    addCharacterSkill(@"Backlash",PASSIVE,LIGHTNING,@"Your Static Barrier has a 50% chance to erupt in a flash of light when it ends, blinding all nearby enemies for 3 seconds. Damage causes this effect to end prematurely.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    //id ethereality = addCharacterSkillOLD(@"Ethereality",PASSIVE,LIGHTNING,@"Force Speed has a 100% chance to remove all movement imparing effects when used and grant immunity to those effects for its duration.");
    
    //Madness
    //Tier 1
    addCharacterSkill(@"Calcify",PASSIVE,MADNESS,@"Increases the damage dealt by Force Lightning by 4%.",1);
    addCharacterSkill(@"Sith Defiance",PASSIVE,MADNESS,@"Reduces all damage taken by 1%.",1);
    addCharacterSkill(@"Will of the Sith",PASSIVE,MADNESS,@"Increases total Willpower by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Parasitism",PASSIVE,MADNESS,@"Causes critical hits from periodic damage abilities to restore 0.5% of your total health.",2);
    addCharacterSkill(@"Oppressing Force",PASSIVE,MADNESS,@"Lowers the cooldown of Electrocute by 5 seconds. In addition, your Whirlwind affects up to 1 additional standard or weak enemies within 8 meters of the target.",2);
    addCharacterSkill(@"Chain Shock",PASSIVE,MADNESS,@"When you activate Shock, you have a 15% chance to activate a second Shock, dealing 50% of normal damage.",2);
    addCharacterSkill(@"Disintegration",PASSIVE,MADNESS,@"Increases the critical chance of Force Lightning and Lightning Strike by 5%.",2);
    //Tier 3
    addCharacterSkill(@"Death Field",INSTANT,MADNESS,@"Creates a Death Field at the target location, dealing 965 internal damage and stealing 77 health from up to 3 targets within an 8 meter radius.",3);
    addCharacterSkill(@"Sith_Efficacy",PASSIVE,MADNESS,@"Reduces the pushback suffered while activating Crushing Darkness and Force Lightning by 25%. In addition, each time your Force Lightning deals damage, you have a 33.33% chance to recover 1% of your total Force.",3);
    addCharacterSkill(@"Madness",PASSIVE,MADNESS,@"Force Lightning no longer has a cooldown.",3);
    //Tier 4
    addCharacterSkill(@"Haunted Dream",PASSIVE,MADNESS,@"Lowers the activation time of Whirlwind by 50%. In addition, when your Whirlwind breaks early from damage, the target is stunned for 1 seconds.",4);
    addCharacterSkill(@"Corrupted Flesh",PASSIVE,MADNESS,@"Reduces the damage taken by all periodic effects by 7.5%.",4);
    addCharacterSkill(@"Wrath",PASSIVE,MADNESS,@"When your Force Lightning deals damage, you have a 30% chance to cause your next damaging Force attack with an activation time to activate instantly and deal 20% more damage.",4);
    //Tier 5
    //Tier 6
    //Tier 7

    //MARKSMANSHIP
    //Tier 1
    addCharacterSkill(@"Cover Screen",PASSIVE,MARKSMANSHIP,@"While exiting cover, you have a 50% chance to gain Cover Screen, increasing defense by 20% for 6 seconds.",1);
    addCharacterSkill(@"Steady Shots",PASSIVE,MARKSMANSHIP,@"Increases the damage dealt by Snipe, Series of Shots and Cull by 3%.",1);
    addCharacterSkill(@"Marksmenship",PASSIVE,MARKSMANSHIP,@"Increases ranged and tech accuracy by 1%.",1);
    //Tier 2
    addCharacterSkill(@"Heavy Shot",PASSIVE,MARKSMANSHIP,@"When Ambush strikes a target within 10 meters, the target is knocked back several meters.",2);
    addCharacterSkill(@"Ballistic Dampers",PASSIVE,MARKSMANSHIP,@"Entering cover grants 3 charges of Ballistic Dampers. Each charge absorbs 15% of the damage dealt by an incoming attack. This effect cannot occur more than once every 1.5 seconds. Ballistic Dampers can only be gained once every 6 seconds.",2);
    addCharacterSkill(@"Precision Ambush",PASSIVE,MARKSMANSHIP,@"Ambush ignores 10% of the target's armor.",2);
    addCharacterSkill(@"Imperial Demarcation",PASSIVE,MARKSMANSHIP,@"Reduces the cooldown of Leg Shot by 1.5 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Snap Shot",PASSIVE,MARKSMANSHIP,@"Entering cover has a 50% chance to make the next Snipe activate instantly.",3);
    addCharacterSkill(@"Diversion",INSTANT,MARKSMANSHIP,@"Throws a smoking canister at the target, reducing its accuracy by 45% for 9 seconds and exposing the target from cover for 6 seconds.",3);
    addCharacterSkill(@"Reactive Shot",PASSIVE,MARKSMANSHIP,@"Series of Shots and Snipe critical hits have a 50% chance to reduce the activation time of your next Ambush by 1 second.",3);
    //Tier 4
    addCharacterSkill(@"Between the Eyes",PASSIVE,MARKSMANSHIP,@"Increases the critical hit chance of Snipe, Series of Shots and Followthrough by 2%.",4);
    addCharacterSkill(@"Sector Ranger",PASSIVE,MARKSMANSHIP,@"Cover Pulse knocks targets back an additional 2 meters. Additionally reduces the activation time of Orbital Strike by 1 second.",4);
    addCharacterSkill(@"Sniper Volley",PASSIVE,MARKSMANSHIP,@"Ambush has a 33.34% chance to grant Sniper Volley, increasing alacrity by 3% for 6 seconds. While Sniper Volley is active, each subsequent Snipe has a 33.34% chance to build an additional stack of Sniper Volley. Stacks up to 3 times. The initial Sniper Volley effect cannot be gained more than once every 30 seconds.",4);
    addCharacterSkill(@"Sniper's Nest",PASSIVE,MARKSMANSHIP,@"Increases the energy regeneration rate by 1 per second while in cover.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    
    //Medicine
    //Tier 1
    addCharacterSkill(@"Incisive Action",PASSIVE,MEDICINE,@"Reduces the activation time of Kolto Injection by 0.25 seconds and gives Kolto Injection a 50% chance to grant Tactical Advantage.",1);
    addCharacterSkill(@"Precision Instruments",PASSIVE,MEDICINE,@"Reduces the energy cost of Corrosive Dart, Debilitate and Sever Tendon by 2.",1);
    addCharacterSkill(@"Imperial Education",PASSIVE,MEDICINE,@"Increases total Cunning by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Endorphin Rush",PASSIVE,MEDICINE,@"Adrenaline Probe now immediately restores 8 additional energy.",2);
    addCharacterSkill(@"Medical Consult",PASSIVE,MEDICINE,@"Increases all healing dealt by 1% at all times and an additional 2% while Tactical Advantage is active.",2);
    addCharacterSkill(@"Surgical Steadiness",PASSIVE,MEDICINE,@"Reduces the pushback suffered while activating healing abilities by 35%, and reduces the threat generated by heals by 5%.",2);
    addCharacterSkill(@"Chem-resistant Inlays",PASSIVE,MEDICINE,@"Reduces all damage taken by 2%.",2);
    //Tier 3
    addCharacterSkill(@"Prognosis Critical",PASSIVE,MEDICINE,@"Increases the critical chance of Diagnostic Scan by 12%.",3);
    addCharacterSkill(@"Kolto Probe",INSTANT,MEDICINE,@"Summons a droid that heals a friendly target for 280 over 18 seconds. Stacks up to 2 times.",3);
    addCharacterSkill(@"Sedatives",PASSIVE,MEDICINE,@"When Sleep Dart wears off, the target is struck by Sedatives, reducing all damage dealt by 25% for the next 10 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Patient Studies",PASSIVE,MEDICINE,@"Diagnostic Scan criticals restore 1 energy.",4);
    addCharacterSkill(@"Medical Engineering",PASSIVE,MEDICINE,@"Each tick of Kolto Probe has a 10% chance to grant Tactical Advantage. This effect cannot occur more than once every 9 seconds. Each rank beyond the first reduces this rate limit by 1.5 seconds.",4);
    addCharacterSkill(@"Evasive Imperative",PASSIVE,MEDICINE,@"Evasion increases movement speed by 10% while active.",4);
    //Tier 5
    addCharacterSkill(@"Tox Screen",PASSIVE,MEDICINE,@"Toxin Scan now removes negative mental effects and heals the target for 0.T",5);
    addCharacterSkill(@"Medical Therapy",PASSIVE,MEDICINE,@"Increases the healing dealt by periodic effects by 5% and Surgical Probe by 3%.",5);
    addCharacterSkill(@"Surgical Probe",INSTANT,MEDICINE,@"Executes your Tactical Advantage to summon a probe that instantly heals the target 106 - 273. Requires and consumes Tactical Advantage.",5);
    addCharacterSkill(@"Surgical Precision",PASSIVE,MEDICINE,@"Increases the healing dealt by Surgical Probe by 15%. In addition, Surgical Probe immediately re-grants Tactical Advantage when used on targets below 30% max health.",5);
    //Tier 6
    //Tier 7
    //id advancedToxinRemoval = addCharacterSkillOLD(@"Advanced Toxin Removal",PASSIVE,MEDIC,@"Toxin Scan now removes mental debuffs, and heals for a small amount.");
    //id reactiveHealing = addCharacterSkillOLD(@"Reactive Healing",PASSIVE,MEDIC,@"Critical direct heals refund 2% energy.");
    
    //Rage
    //Tier 1
    addCharacterSkill(@"Ravager",PASSIVE,RAGE,@"Reduces the cooldown of Ravage by 1.5 seconds and Force Choke by 5 seconds.",1);
    addCharacterSkill(@"Malice",PASSIVE,RAGE,@"Increases the critical strike chance of your Force attacks by 2%.",1);
    addCharacterSkill(@"Stagger",PASSIVE,RAGE,@"Increases the duration of Force Charge's Immobilize effect by 0.5 second.",1);
    //Tier 2
    addCharacterSkill(@"Payback",PASSIVE,RAGE,@"Unleash has a 50% chance to heal you for 10% of your maximum health.",2);
    addCharacterSkill(@"Force Alacrity",PASSIVE,RAGE,@"Reduces the cooldown of all Force abilities while in Shii-Cho Form by 1.5 seconds.",2);
    addCharacterSkill(@"Endless Rage",PASSIVE,RAGE,@"You now generate 1 rage when attacked in Shii-Cho Form. This effect cannot occur more than once every 6 seconds.",2);
    addCharacterSkill(@"Brutality",PASSIVE,RAGE,@"Increases the critical strike chance of Vicious Slash by 7.5%.",2);
    //Teri 3
    addCharacterSkill(@"Saber Strength",PASSIVE,RAGE,@"Increases the damage dealt by Vicious Slash and Obliterate by 3%.",3);
    addCharacterSkill(@"Obliterate",INSTANT,RAGE,@"Jumps to a target, impaling it for (current weapon) damage. Strikes with both weapons if dual wielding.",3);
    addCharacterSkill(@"Strangulate",PASSIVE,RAGE,@"Reduces the pushback suffered while channeling Force Choke by 50%.",3);
    //Tier 4
    addCharacterSkill(@"Relentless",PASSIVE,RAGE,@"Enrage immediately grants 1 additional rage.",4);
    addCharacterSkill(@"Dominate",PASSIVE,RAGE,@"Force Charge and Obliterate have a 50% chance to make your next Smash used within 15 seconds an automatic critical hit.",4);
    addCharacterSkill(@"Shockwave",PASSIVE,RAGE,@"Each tick of Force Choke and Force Crush grants you Shockwave, increasing the damage your next Smash deals by 12.5%. Stacks up to 4 times.",4);
    addCharacterSkill(@"Unbreakable Rage",PASSIVE,RAGE,@"Ravage is now uninterruptible.",4);
    //Tier 5
    addCharacterSkill(@"Gravity",PASSIVE,RAGE,@"Reduces the rage cost of all movement-slowing effects by 1.",5);
    addCharacterSkill(@"Interceptor",PASSIVE,RAGE,@"Increases movement speed by 20% for 5 seconds after using Obliterate.",5);
    addCharacterSkill(@"Shii-Cho Mastery",PASSIVE,RAGE,@"While in Shii-Cho Form, your attacks ignore 10% of your targets' armor.",5);
    //Tier 6
    addCharacterSkill(@"Dark Resonance",PASSIVE,RAGE,@"Increases the critical strike damage of all Force attacks by 10%.",6);
    addCharacterSkill(@"Sundering Throw",PASSIVE,RAGE,@"Lowers the cooldown of Saber Throw by 2.5 seconds and causes Saber Throw to apply 1 stack of sunder armor to the target.",6);
    //Tier 7
    
    //Saboteur
    //Tier 1
    addCharacterSkill(@"Saboteur's Utility Belt",PASSIVE,SABOTEUR,@"Reduces the cooldown of Flash Grenade by 7.5 seconds and Thermal Grenade by 1.5 seconds.",1);
    addCharacterSkill(@"Bravado",PASSIVE,SABOTEUR,@"Increases your maximum energy by 5.",1);
    addCharacterSkill(@"Streetwise",PASSIVE,SABOTEUR,@"Increases Cunning by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Independent Anarchy",PASSIVE,SABOTEUR,@"Increases the damage dealt by Sabotage Charge and all area effects by 5%.",2);
    addCharacterSkill(@"Cool Under Pressure",PASSIVE,SABOTEUR,@"Cool Head now heals you for 3% of your total health over 3 seconds.",2);
    addCharacterSkill(@"Hot Pursuit",PASSIVE,SABOTEUR,@"You have a 50% chance to gain Hot Pursuit upon exiting cover, allowing your next Charged Burst to be used in any situation.",2);
    addCharacterSkill(@"Underworld Hardships",PASSIVE,SABOTEUR,@"Increases total Endurance by 2%.",2);
    //Tier 3
    addCharacterSkill(@"Contingency Charges",PASSIVE,SABOTEUR,@"After Sabotage Charge detonates, it drops 1 contingency charge on the target. A Contingency Charge explodes when damaged by blaster fire, dealing 184 kinetic damage to the target. Contingency Charges cannot be detonated more than once every 1.5 seconds.",3);
    addCharacterSkill(@"Dealer's Discount",PASSIVE,SABOTEUR,@"Reduces the energy cost of Sabotage Charge, Shock Charge and Incendiary Grenade by 2.",3);
    addCharacterSkill(@"Shock Charge",INSTANT,SABOTEUR,@"Hurls an electric shock device that latches on to the target, dealing 2581 energy damage over 18 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Insurrection",PASSIVE,SABOTEUR,@"Increases the number of Contingency Charges dropped by Sabotage Charge by 1. In addition, when your Contingency Charges detonate, you recover 5 energy.",4);
    addCharacterSkill(@"Pandemonium",PASSIVE,SABOTEUR,@"Activating Pulse Detonator has a 50% chance of making the next Charged Burst activate instantly.",4);
    addCharacterSkill(@"Arsonist",PASSIVE,SABOTEUR,@"Increases the critical damage dealt by all area effects by 15%.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    
    //id overloadCharges = addCharacterSkillOLD(@"Overload Charges",INSTANT,SABOTEUR,@"Overloads all nearby Shock Charges, dealing 582 kinetic damage to all effected targets. Resets the cooldown of Cool Head, Defense Screen, Sabotage Charge, and Incendiary Grenade.");
    //id stunBomb = addCharacterSkillOLD(@"Stun Bomb",PASSIVE,SABOTEUR,@"Targets affected by Flash Grenade have a 100% chance to be stunned for 2 seconds on taking damage.");
    
    //Sawbones
    //Tier 1
    addCharacterSkill(@"Exploratory Surgery",PASSIVE,SAWBONES,@"Reduces the activation time of Underworld Medicine by 0.25 seconds and gives Underworld Medicine a 50% chance to grant Upper Hand.",1);
    addCharacterSkill(@"Anatomy Lessons",PASSIVE,SAWBONES,@"Reduces the energy cost of Vital Shot, Dirty Kick and Tendon Blast by 2.",1);
    addCharacterSkill(@"Bedside Manner",PASSIVE,SAWBONES,@"Increases total Cunning by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Keep Cool",PASSIVE,SAWBONES,@"Cool Head now immediately restores 8 additional energy.",2);
    addCharacterSkill(@"Healing Hands",PASSIVE,SAWBONES,@"Increases all healing dealt by 1% at all times and an additional 2% while Upper Hand is active.",2);
    addCharacterSkill(@"Smuggled Technology",PASSIVE,SAWBONES,@"Reduces the pushback suffered while activating healing abilities by 35%, and reduces the threat generated by heals by 5%.",2);
    addCharacterSkill(@"Scar Tissue",PASSIVE,SAWBONES,@"Reduces all damage taken by 2%.",2);
    //Tier 3
    addCharacterSkill(@"Prognosis Critical",PASSIVE,SAWBONES,@"Increases the critical chance of Diagnostic Scan by 12%.",3);
    addCharacterSkill(@"Slow-release Medpac",INSTANT,SAWBONES,@"Injects the target with slow-release medicine that heals for 280 over 18 seconds. Stacks up to 2 times.",3);
    addCharacterSkill(@"Sedatives",PASSIVE,SAWBONES,@"When Tranquilizer wears off, the target is struck by Sedatives, reducing all damage dealt by 25% for the next 10 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Patient Studies",PASSIVE,SAWBONES,@"Diagnostic Scan critical hits restore 1 energy.",4);
    addCharacterSkill(@"Medpac Mastery",INSTANT,SAWBONES,@"Each tick of Slow-release Medpac has a 10% chance to grant Upper Hand. This effect cannot occur more than once every 9 seconds. Each rank beyond the first reduces this rate limit by 1.5 seconds.",4);
    addCharacterSkill(@"Scramble",PASSIVE,SAWBONES,@"Dodge increases movement speed by 10% while active.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    
    //id fieldMedicine = addCharacterSkillOLD(@"Field Medicine",PASSIVE,SAWBONES,@"Reduces pushback from damage on healing abilities by 70%. Lowers threat of healing abilities by 10%.");
    //id amnesty = addCharacterSkillOLD(@"Amnesty",PASSIVE,SAWBONES,@"Dodge has a 100% chance to heal you and increase your armor by 10% for 10 seconds.");
    
    //Scrapper
    //Tier 1
    addCharacterSkill(@"Element of Surprise",PASSIVE,SCRAPPER,@"Increases the critical hit chance of Back Blast and Shoot First by 8%.",1);
    addCharacterSkill(@"Browbeater",PASSIVE,SCRAPPER,@"Increases the damage dealt by Vital Shot by 6% and Flechette Round by 3%.",1);
    addCharacterSkill(@"Survivor's Scars",PASSIVE,SCRAPPER,@"Increases all healing done by 1% and all healing received by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Sneaky",PASSIVE,SCRAPPER,@"Increases movement speed by 5% and effective stealth level by 1.",2);
    addCharacterSkill(@"Scrappy",PASSIVE,SCRAPPER,@"Increases the damage dealt by Blaster Whip, Quick Shot and Back Blast by 2%.",2);
    addCharacterSkill(@"Brawler's Grit",PASSIVE,SCRAPPER,@"Increases total Endurance by 2%.",2);
    addCharacterSkill(@"Shifty-eyed",PASSIVE,SCRAPPER,@"Increases stealth detection level by 1 and defense by 1%.",2);
    //Tier 3
    addCharacterSkill(@"Sawed Off",PASSIVE,SCRAPPER,@"Reduces the energy cost of Back Blast by 10 and Flechette Round by 2.",3);
    addCharacterSkill(@"Sucker Punch",INSTANT,SCRAPPER,@"Exploits Upper Hand to sucker punch the target for 1330 - 1552 kinetic damage. ",3);
    addCharacterSkill(@"Flying Fists",PASSIVE,SCRAPPER,@"Sucker Punch has a 25% chance to trigger Flying Fists, dealing 394 additional kinetic damage. This effect cannot occur more than once every 10 seconds. Standard and weak targets are additionally stunned by Flying Fists.",3);
    addCharacterSkill(@"Surprise Comback",PASSIVE,SCRAPPER,@"Pugnacity now additionally grants Surprise Comeback, restoring 2% of total health every 3 seconds.",2);
    //Tier 4
    addCharacterSkill(@"Fight or Flight",PASSIVE,SCRAPPER,@"Dodging or resisting an attack restores 1 energy. In addition, Disappearing Act no longer reduces healing dealt and received.",4);
    addCharacterSkill(@"Stopping Power",PASSIVE,SCRAPPER,@"Tendon Blast has a 50% chance to immobilize the target for 2 seconds.",4);
    addCharacterSkill(@"Round Two",PASSIVE,SCRAPPER,@"Flying Fists has a 50% chance to immediately regrant Upper Hand when hitting a bleeding target.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    
    //Seer
    //Tier 1
    addCharacterSkill(@"Immutable Force",PASSIVE,SEER,@"Reduces the activation time of Deliverance by 0.25 seconds",1);
     addCharacterSkill(@"Wisdom",PASSIVE,SEER,@"Increases total Presence by 3% and all healing done by 1%.",1);
    addCharacterSkill(@"Penetrating Light",PASSIVE,SEER,@"Increases the Force critical chance by 1%.",1);
    //Tier 2
    addCharacterSkill(@"Foresight",PASSIVE,SEER,@"Reduces the pushback suffered while activating healing abilities by 25% and lowers the threat generated by healing abilities by 5%.",2);
    addCharacterSkill(@"Pain Bearer",PASSIVE,SEER,@"Increases all healing received by 4%.",2);
    addCharacterSkill(@"Psychic Suffusion",PASSIVE,SEER,@"Increases the damage and healing of area effect abilities by 5%.",2);
    //Tier 3
    addCharacterSkill(@"Conveyance",PASSIVE,SEER,@"Rejuvenate has a 50% chance to increase the effect of your next healing ability: Benevolence: Force cost reduced by 50%. Deliverance: Activation time reduced by 1 second. Healing Trance: Critical chance increased by 25%. Salvation: Force cost reduced by 30%.",3);
    addCharacterSkill(@"Rejuvenate",INSTANT,SEER,@"Immediately heals a target for a 97 - 153, ",3);
    addCharacterSkill(@"Valiance",PASSIVE,SEER,@"Reduces the health spent by Noble Sacrifice by 1%.",3);
    addCharacterSkill(@"Preservation",PASSIVE,SEER,@"Reduces the Force cost of Force Armor by 15 and reduces the cooldown of Force Armor by 1.5 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Mend Wounds",PASSIVE,SEER,@"Lowers the Force cost of Restoration by 15. In addition, Restoration now removes negative physical effects and heals the target for 0.",4);
    addCharacterSkill(@"Force Shelter",PASSIVE,SEER,@"Increases the duration of Rejuvenate by 3 seconds. In addition, Rejuvenate has a 50% chance to apply the Force Shelter effect to its targets, increasing armor rating by 10% for the duration of Rejuvenate.",4);
    addCharacterSkill(@"Egress",PASSIVE,SEER,@"Force Armor increases the target's movement speed by 10% for 3 seconds.",4);
    //Tier 5
    addCharacterSkill(@"Healing Trance",INSTANT,SEER,@"Heals a target for 469 immediately and a further 469 per second for 3 seconds.",5);
    //Tier 6
    addCharacterSkill(@"Resplendence",PASSIVE,SEER,@"Healing Trance critical hits have a 50% chance to make the next Noble Sacrifice activate without degenerating Force and without spending any health.",6);
    //Tier 7
    
    //Sharpshooter
    //Tier 1
    addCharacterSkill(@"Cover Screen",PASSIVE,SHARPSHOOTER,@"When exiting cover, you have a 50% chance to gain Cover Screen, increasing ranged defense by 20% for 6 seconds.",1);
    addCharacterSkill(@"Steady Shots",PASSIVE,SHARPSHOOTER,@"Increases the damage dealt by Charged Burst, Speed Shot and Wounding Shots by 3%.",1);
    addCharacterSkill(@"Sharpshooter",PASSIVE,SHARPSHOOTER,@"Increases ranged and tech accuracy by 1%.",1);
    //Tier 2
    addCharacterSkill(@"Percussive Shot",PASSIVE,SHARPSHOOTER,@"When Aimed Shot strikes a target within 10 meters, the target is knocked back several meters.",2);
    addCharacterSkill(@"Ballistic Dampers",PASSIVE,SHARPSHOOTER,@"Entering cover grants 3 charges of Ballistic Dampers. Each charge absorbs 15% of the damage dealt by incoming attacks. This effect cannot occur more than once every 1.5 seconds. Ballistic Dampers can only be gained once every 6 seconds.",2);
    addCharacterSkill(@"Sharp Aim",PASSIVE,SHARPSHOOTER,@"Aimed Shot ignores 10% of the target's armor.",2);
    addCharacterSkill(@"Trip Shot",PASSIVE,SHARPSHOOTER,@"Reduces the cooldown of Leg Shot by 1.5 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Snap Shot",PASSIVE,SHARPSHOOTER,@"Entering cover has a 50% chance to make the next Charged Burst activate instantly.",3);
    addCharacterSkill(@"Sapping Charge",PASSIVE,SHARPSHOOTER,@"Shock Charge reduces the target's movement speed by 15% for the duration.",3);
    addCharacterSkill(@"Quick Aim",PASSIVE,SHARPSHOOTER,@"Charged Burst and Speed Shot's critical hits have a 50% chance to reduce the activation time of the next Aimed Shot by 1 second.",3);
    //Tier 4
    addCharacterSkill(@"Slick Shooter",PASSIVE,SHARPSHOOTER,@"Increases the critical hit chance of Charged Burst, Speed Shot and Trickshot by 2%.",4);
    addCharacterSkill(@"Spacer",PASSIVE,SHARPSHOOTER,@"Pulse Detonator knocks targets back an additional 2 meters. Additionally reduces the activation time of XS Freighter Flyby by 1 second.",4);
    addCharacterSkill(@"Burst Volley",PASSIVE,SHARPSHOOTER,@"Aimed Shot has a 33.34% chance to grant Burst Volley, increasing alacrity by 3% for 6 seconds. While Burst Volley is active, each subsequent Charged Burst has a 33.34% chance to build an additional stack of Burst Volley. Stacks up to 3 times. The initial Burst Volley effect cannot be gained more than once every 30 seconds.",4);
    addCharacterSkill(@"Foxhole",PASSIVE,SHARPSHOOTER,@"Increases the energy regeneration rate by 1 per second while in cover.",4);
    //Tier 5
    addCharacterSkill(@"Recoil Control",PASSIVE,SHARPSHOOTER,@"Fires a wild follow-up shot at the target that deals 420 - 642 weapon damage. Only usable within the 4.5 seconds immediately following a Charged Burst or Aimed Shot. Fires both blasters if dual wielding.",5);
    addCharacterSkill(@"Trickshot",INSTANT,SHARPSHOOTER,@"Fires a wild follow-up shot at the target that deals 420 - 642 weapon damage. Only usable within the 4.5 seconds immediately following a Charged Burst or Aimed Shot. Fires both blasters if dual wielding.",5);
    addCharacterSkill(@"Lay Low",PASSIVE,SHARPSHOOTER,@"Reduces the cooldown of Hunker Down and XS Freighter Flyby by 7.5 seconds.",5);
    //Tier 6
    //Tier 7
    
    //id exploitWeakness = addCharacterSkillOLD(@"Exploit Weakness",PASSIVE,SHARPSHOOTER,@"Quickdraw can be used on targets recently hit by a pistol ability critical hit.");
    //id surpriseAttack = addCharacterSkillOLD(@"Surprise Attack",PASSIVE,SHARPSHOOTER,@"Rolling into cover has a 100% chance to make your next Charged Burst an instant cast ability.");
    
    //Shield Specialist
    //Tier 1
    addCharacterSkill(@"Static Shield",PASSIVE,SHIELD_SPECIALIST,@"Increases the critical chance of Stockstrike and Explosive Surge by 15%. In addition, shielding an attack has a 25% chance to finish the cooldown on Stockstrike. This effect cannot occur more than once every 4.5 seconds.",1);
    addCharacterSkill(@"Intimidation",PASSIVE,SHIELD_SPECIALIST,@"Increases damage done by elemental attacks by 2%.",1);
    addCharacterSkill(@"Brutal Impact",PASSIVE,SHIELD_SPECIALIST,@"Increases the damage of High Impact Bolt by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Neural Overload",PASSIVE,SHIELD_SPECIALIST,@"Ion Cell damage now lowers the movement speed of the target by 50% for 2 seconds.",2);
    addCharacterSkill(@"Ion Overload",PASSIVE,SHIELD_SPECIALIST,@"Stockstrike now has a 50% chance to trigger your Ion Cell. In addition, when Ion Cell deals damage, it has a 50% chance to shock the target for 125 additional energy damage over 6 seconds.",2);
    addCharacterSkill(@"Steely Resolve",PASSIVE,SHIELD_SPECIALIST,@"Increases Aim by 3%.",2);
    addCharacterSkill(@"Rebraced Armor",PASSIVE,SHIELD_SPECIALIST,@"Increases armor rating by 8%.",2);
    //Tier 3
    addCharacterSkill(@"Shield Cycler",PASSIVE,SHIELD_SPECIALIST,@"Increases the shield chance by 1%. In addition, shielding an attack has a 25% chance to generate 1 energy cell. This effect cannot occur more than once every 6 seconds.",3);
    addCharacterSkill(@"Smoke Grenade",INSTANT,SHIELD_SPECIALIST,@"Throws a smoke grenade at your feet that releases a large cloud of smoke, causing nearby enemies to have their accuracy with ranged and melee attacks lowered by 20% for 18 seconds.",3);
    addCharacterSkill(@"Ceramic Plating",PASSIVE,SHIELD_SPECIALIST,@"Increases absorption by 3% and reduces the cooldown of Adrenaline Rush by 30 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Defense Measures",PASSIVE,SHIELD_SPECIALIST,@"Harpoon has a 50% chance to immobilize the target for 3 seconds. In addition, your Stealth Scan has a 50% chance to immobilize the targets it reveals for 3 seconds.",4);
    addCharacterSkill(@"Supercharged Ion Cell",PASSIVE,SHIELD_SPECIALIST,@"Increases the damage dealt by Ion Cell by 25% and increases its shock duration by 3 seconds.",4);
    addCharacterSkill(@"Ion Shield",PASSIVE,SHIELD_SPECIALIST,@"Further increases damage reduction by 1% while Ion Cell is active.",4);
    addCharacterSkill(@"Static Shield",PASSIVE,SHIELD_SPECIALIST,@"Increases the critical chance of Stockstrike and Explosive Surge by 15%. In addition, shielding an attack has a 25% chance to finish the cooldown on Stockstrike. This effect cannot occur more than once every 4.5 seconds.",4);
    //Tier 5
    //Tier 6
    //Tier 7
    
    //Shield Tech
    //Tier 1
    addCharacterSkill(@"Combust",PASSIVE,SHIELD_TECH,@"Your flamethrower combusts the target, lowering damage done by 2% for 15 seconds.",1);
    addCharacterSkill(@"Intimidation",PASSIVE,SHIELD_TECH,@"Increases damage done by all fire effects by 2%.",1);
    addCharacterSkill(@"Rail Loaders",PASSIVE,SHIELD_TECH,@"Increases the damage of Rail Shot by 3%.",1);
    //Tier 2
    addCharacterSkill(@"Neural Overload",PASSIVE,SHIELD_TECH,@"Ion Gas Cylinder damage now lowers the movement speed of the target by 50% for 2 seconds.",2);
    addCharacterSkill(@"Ion Overload",PASSIVE,SHIELD_TECH,@"Rocket Punch now has a 50% chance to trigger your Ion Gas Cylinder. In addition, when Ion Gas Cylinder deals damage, it has a 50% chance to shock the target for 125 additional energy damage over 6 seconds.",2);
    addCharacterSkill(@"Steely Resolve",PASSIVE,SHIELD_TECH,@"Increases Aim by 3%.",2);
    addCharacterSkill(@"Rebraced Armor",PASSIVE,SHIELD_TECH,@"Increases armor rating by 8%",2);
    //Tier 3
    addCharacterSkill(@"Shield Vents",PASSIVE,SHIELD_TECH,@"Increases shield chance by 1%. In addition, shielding an attack has a 25% chance to vent 8 heat. This effect cannot occur more than once every 6 seconds.",3);
    addCharacterSkill(@"Oil Slick",PASSIVE,SHIELD_TECH,@"Sprays the immediate area with oil. Nearby enemies become unbalanced and their accuracy of ranged and melee attacks is lowered by 20% for 18 seconds.",3);
    addCharacterSkill(@"Ablative Upgrades",PASSIVE,SHIELD_TECH,@"Increases absorption by 3% and reduces the cooldown of Kolto Overload by 30 seconds.",3);
    //Tier 4
    addCharacterSkill(@"No Escape",PASSIVE,SHIELD_TECH,@"Grapple has a 50% chance to immobilize the target for 3 seconds. In addition, your Stealth Scan has a 50% chance to immobilize the targets it reveals for 3 seconds.",4);
    addCharacterSkill(@"Supercharged Ion Gas",PASSIVE,SHIELD_TECH,@"Increases the damage dealt by Ion Gas Cylinder by 25% and increases its shock duration by 3 seconds.",4);
    addCharacterSkill(@"Ion Screen",PASSIVE,SHIELD_TECH,@"Further increases damage reduction while Ion Gas Cylinder is active by 1%.",4);
    addCharacterSkill(@"Flame Shield",PASSIVE,SHIELD_TECH,@"Increases the critical chance of Rocket Punch and Flame Sweep by 15%. In addition, shielding an attack has a 25% chance to finish the cooldown on Rocket Punch. This effect cannot occur more than once every 4.5 seconds.",4);
    //Tier 5
    addCharacterSkill(@"Jet Speed",PASSIVE,SHIELD_TECH,@"Jet Charge has a 50% chance to increase your movement speed by 30% for 4 seconds.",5);
    addCharacterSkill(@"Jet Charge",INSTANT,SHIELD_TECH,@"Jumps to a distant target, dealing (weapon damage) kinetic damage, interrupting the target's current action and immobilizing the target for 3 seconds. Cannot be used against targets in cover.",5);
    addCharacterSkill(@"Flame Surge",PASSIVE,SHIELD_TECH,@"Increases the critical strike bonus damage of Rocket Punch and Flame Sweep by 15%.",5);
    //Tier 6
    //Tier 7
    
    //Tactics
    //Tier 1
    addCharacterSkill(@"Demolition",PASSIVE,TACTICS,@"Increases the critical hit chance of elemental attacks by 3%.",1);
    addCharacterSkill(@"Containment Tactics",PASSIVE,TACTICS,@"Reduces the cooldown of Cryo Grenade by 5 seconds.",1);
    addCharacterSkill(@"Focused Impact",PASSIVE,TACTICS,@"High Impact Bolt penetrates 20% of the target's armor.",1);
    //Tier 2
    addCharacterSkill(@"Blaster Augs",PASSIVE,TACTICS,@"Increases the effect of your cells while they are active: Plasma Cell: Increases the tech critical hit chance by 3%. High Energy Cell: Further increases all internal and elemental damage dealt by 3%. Ion Cell: Increases the damage dealt by Ion Cell by 8%.",2);
    addCharacterSkill(@"Frontline Offense",PASSIVE,TACTICS,@"Increases the damage dealt by Ion Pulse and Gut by 3%.",2);
    addCharacterSkill(@"Power Armor",PASSIVE,TACTICS,@"Reduces all damage taken by 1%.",2);
    addCharacterSkill(@"Tactical Tools",PASSIVE,TACTICS,@"Reduces the cooldown of Pulse Cannon by 1.5 seconds and Harpoon by 5 seconds.",2);
    //Tier 3
    addCharacterSkill(@"Frontline Defense",PASSIVE,TACTICS,@"Reduces the cooldown of Riot Strike by 1 second.",3);
    addCharacterSkill(@"Battlefield Training",PASSIVE,TACTICS,@"Increases movement speed by 7.5% while High Energy Cell is active.",3);
    addCharacterSkill(@"Gut",INSTANT,TACTICS,@"Guts the target with a knuckle-plate vibroblade, dealing (current weapon) kinetic damage and causing the target to bleed for (current weapon) internal damage over 15 seconds.",3);
    addCharacterSkill(@"Cell Generator",PASSIVE,TACTICS,@"While High Energy Cell is active, you have a 50% chance to generate 1 energy cell every 6 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Battering Ram",PASSIVE,TACTICS,@"Ion Pulse has a 15% chance and Fire Pulse has a 50% chance to make your next Stockstrike free. This effect lasts 15 seconds.",4);
    addCharacterSkill(@"Serrated Blades",PASSIVE,TACTICS,@"Increases the damage dealt by Gut's bleed effect by 5%.",4);
    //Tier 5
    //Tier 6
    //Tier 7

    //Telekinetics
    //Tier 1
    addCharacterSkill(@"Inner Strength",PASSIVE,TELEKINETICS,@"Reduces the Force cost of Force attacks and healing abilities by 3%.",1);
    addCharacterSkill(@"Mental Longevity",PASSIVE,TELEKINETICS,@"Increases your total Force by 50.",1);
    addCharacterSkill(@"Clamoring Force",PASSIVE,TELEKINETICS,@"Increases the damage dealt by Disturbance, Mind Crush, Telekinetic Wave and Turbulence by 2%.",1);
    //Tier 2
    addCharacterSkill(@"Mind's Eye",PASSIVE,TELEKINETICS,@"Increases the maximum range of Disturbance, Telekinetic Wave and Turbulence by 5 meters.",2);
    addCharacterSkill(@"Disturb Mind",PASSIVE,TELEKINETICS,@"Increases the duration of Weaken Mind by 3 seconds.",2);
    addCharacterSkill(@"Concentration",PASSIVE,TELEKINETICS,@"Reduces the pushback suffered while activating Disturbance, Telekinetic Wave and Turbulence by 35%. In addition, Disturbance has a 50% chance to increase your Force regeneration rate by 10% for 10 seconds. Stacks up to 3 times.",2);
    addCharacterSkill(@"Telekinetic Defense",PASSIVE,TELEKINETICS,@"Increases the amount absorbed by your Force Armor by 10%.",2);
    //Tier 3
    addCharacterSkill(@"Blockout",PASSIVE,TELEKINETICS,@"Lowers the cooldown of Force Lift by 7.5 seconds and increases the lockout duration of Mind Snap by 1 seconds.",3);
    addCharacterSkill(@"Telekinetic Wave",INSTANT,TELEKINETICS,@"Sends a wave of telekinetic energy that deals 1298 - 1410 kinetic damage to up to 5 targets within 8 meters of the primary target, with a 3 second recharge.",3);
    addCharacterSkill(@"Psychic Projection",PASSIVE,TELEKINETICS,@"Weaken Mind critical hits have a 50% chance to grant Psychic Projection, causing your next Telekinetic Throw to channel and tick twice as fast. This effect cannot occur more than once every 10 seconds.",3);
    addCharacterSkill(@"Force Wake",PASSIVE,TELEKINETICS,@"Force Wave has a 50% chance to unbalance its targets, immobilizing them for 5 seconds. Damage dealt after 2 seconds ends the effect prematurely.",3);
    //Tier 4
    addCharacterSkill(@"Tidal Force",PASSIVE,TELEKINETICS,@"Your Disturbance has a 30% chance and your Forcequake has a 10% chance when dealing damage to grant Tidal Force, immediately finishing the cooldown on Telekinetic Wave and reducing the cast time of your next Telekinetic Wave by 100%. This effect cannot occur more than once every 10 seconds.",4);
    addCharacterSkill(@"Telekinetic Effusion",PASSIVE,TELEKINETICS,@"Force attacks that critically hit have a 50% chance to grant Telekinetic Effusion, lowering the Force cost of your next two Force abilities by 50%. Additionally reduces the cooldown of Force Speed by 5 seconds.",4);
    addCharacterSkill(@"Kinetic Collapse",PASSIVE,TELEKINETICS,@"Your Force Armor has a 50% chance to explode in a concussive wave when it ends, incapacitating all nearby enemies for 3 seconds. Damage causes this effect to end prematurely.",4);
    //Tier 5
    addCharacterSkill(@"Telekinetic Momentum",PASSIVE,TELEKINETICS,@"When you activate Disturbance or Telekinetic Wave, there is a 10% chance the ability will produce a second attack that strikes the same targets for 30% damage.",5);
    //Tier 6
    //Tier 7
 
    //Vengeance
    //Tier 1
    addCharacterSkill(@"Single Saber Mastery",PASSIVE,VENGEANCE,@"Increases melee damage by 2% while in Shien Form and Shii-Cho Form.",1);
    addCharacterSkill(@"Decimate",PASSIVE,VENGEANCE,@"Increases the damage dealt by Smash by 10% and lowers its cooldown by 1 second.",1);
    addCharacterSkill(@"Improved Sundering Assault",PASSIVE,VENGEANCE,@"Sundering Assault has a 50% chance to apply one additional stack of sunder armor.",1);
    //Tier 2
    addCharacterSkill(@"Accuracy",PASSIVE,VENGEANCE,@"Increases the accuracy of melee and Force attacks by 1%.",2);
    addCharacterSkill(@"Dreadnaught",PASSIVE,VENGEANCE,@"Increases total Strength by 3%.",2);
    addCharacterSkill(@"Unyielding",PASSIVE,VENGEANCE,@"Generates 2 rage when stunned, put to sleep or knocked down.",2);
    //Tier 3
    addCharacterSkill(@"Draining Scream",PASSIVE,VENGEANCE,@"Force Scream has a 50% chance to cause the target to bleed for 133 damage over 6 seconds.",3);
    addCharacterSkill(@"Shien Form",PASSIVE,VENGEANCE,@"Enters an aggressive lightsaber form, increasing all damage dealt by 6%. All attacks that cost rage will refund 1 rage when used. In addition, you generate 1 rage when attacked, but this effect cannot occur more than once every 6 seconds.",3);
    addCharacterSkill(@"Pooled Hatred",PASSIVE,VENGEANCE,@"Whenever your movement is impaired, you gain a 5% bonus to your next melee ability that costs rage. This effect can stack up to 5 times and lasts 10 seconds.",3);
    addCharacterSkill(@"Unstoppable",PASSIVE,VENGEANCE,@"Force Charge has a 50% chance to grant Unstoppable, reducing all damage taken by 20% and granting immunity to interrupts and all controlling effects for 4 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Deadly Reprisal",PASSIVE,VENGEANCE,@"Generates 1 additional rage when taking area effect damage while Shien Form is active.",4);
    addCharacterSkill(@"Vengeance",PASSIVE,VENGEANCE,@"Reduces the cooldown of Impale by 2 seconds and Force Scream by 1 second.",4);
    addCharacterSkill(@"Ruin",PASSIVE,VENGEANCE,@"Smash no longer costs rage.",4);
    //Tier 5
    addCharacterSkill(@"Savagery",PASSIVE,VENGEANCE,@"Impale and Shatter have a 50% chance to increase the critical hit chance of Force Scream and Vicious Throw by 60% for 9 seconds.",5);
    addCharacterSkill(@"Impale",INSTANT,VENGEANCE,@"Impales the target for 1935 - 2157 weapon damage.",5);
    addCharacterSkill(@"Eviscerate",INSTANT,VENGEANCE,@"Impale has a 50% chance to cause the target to bleed for 200 internal damage over 6 seconds.",5);
    addCharacterSkill(@"Huddle",PASSIVE,VENGEANCE,@"Increases total Endurance by 2%. In addition, Intercede has a 50% chance of applying its effect to you as well.",5);
    //Tier 6
    addCharacterSkill(@"Rampage",PASSIVE,VENGEANCE,@"Impale and Shatter have a 10% chance to finish the cooldown on Ravage. This effect cannot occur more than once every 15 seconds. Each rank beyond the first reduces this rate limit by 3 seconds.",6);
    addCharacterSkill(@"Deafening Defense",PASSIVE,VENGEANCE,@"Reduces all damage taken by 2%. Additionally reduces the cooldown of Intimidating Roar by 7.5 seconds.",6);
    //Tier 7
    //addCharacterSkill(@"Shatter",INSTANT,VENGEANCE,@"Channels the Force into your Lightsaber and crushes your target under its weight, dealing 569 internal damage to a target afflicted by Sundering Assault, with a further 1476 internal damage over 12 seconds.",7);

    //Vigilance
    //Tier 1
    addCharacterSkill(@"Single Saber Mastery",PASSIVE,VIGILANCE,@"Increases melee damage by 2% while in Shien and Shii-Cho forms.",1);
    addCharacterSkill(@"Swelling Winds",PASSIVE,VIGILANCE,@"Increases the damage dealt by Force Sweep by 10% and lowers its cooldown by 1 second.",1);
    addCharacterSkill(@"Improved Sundering Strike",PASSIVE,VIGILANCE,@"Sundering Strike has a 50% chance to apply one additional stack of sunder armor.",1);
    //Tier 2
    addCharacterSkill(@"Accuracy",PASSIVE,VIGILANCE,@"Increases the accuracy of melee and Force attacks by 1%.",2);
    addCharacterSkill(@"Perseverance",PASSIVE,VIGILANCE,@"Increases total Strength by 3%.",2);
    addCharacterSkill(@"Defiance",PASSIVE,VIGILANCE,@"Generates 2 Focus when stunned, slept or knocked down.",2);
    //Tier 3
    addCharacterSkill(@"Shien Form",INSTANT,VIGILANCE,@"Enter an offensive Lightsaber form, increasing all damage dealt by 6%. All attacks which cost focus will refund 1 focus when used. In addition, taking damage generates 1 focus, but this effect cannot occur more than once every 6 seconds.",3);
    addCharacterSkill(@"Burning Blade",PASSIVE,VIGILANCE,@"Blade Storm has a 50% chance to cause the target to burn for 133 damage over 6 seconds.",3);
    addCharacterSkill(@"Unremitting",PASSIVE,VIGILANCE,@"Force Leap has a 50% chance to grant Unremitting, reducing all damage taken by 20% and granting immunity to interrupts and all controlling effects for 4 seconds.",3);
    addCharacterSkill(@"Gather Strength",PASSIVE,VIGILANCE,@"Whenever your movement is impaired, you gain a 5% bonus to your next melee ability that costs focus. This effect can stack up to 5 times and lasts 10 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Narrowed Focus",PASSIVE,VIGILANCE,@"Generates 1 additional focus when taking area effect damage while Shien Form is active.",4);
    addCharacterSkill(@"Vigilance",PASSIVE,VIGILANCE,@"Reduces the cooldown of Overhead Slash by 2 seconds and Blade Storm by 1 second.",4);
    addCharacterSkill(@"Effluence",PASSIVE,VIGILANCE,@"Force Sweep no longer costs focus.",4);
    //Tier 5
    addCharacterSkill(@"Force Rush",PASSIVE,VIGILANCE,@"Overhead Slash and Plasma Brand have a 50% chance of Blade Storm and Dispatch by 60% for 9 seconds.",5);
    addCharacterSkill(@"Overhead Slash",INSTANT,VIGILANCE,@"Executes an acrobatic attack which deals (current weapon) damage.",5);
    addCharacterSkill(@"Burning Purpose",INSTANT,VIGILANCE,@"Overhead Slash has a 50% chance to set the target ablaze for <?> elemental damage for 6 seconds.",5);
    addCharacterSkill(@"Commanding Awe",PASSIVE,VIGILANCE,@"Reduces all damage taken by 2% at all times and by an additional 7.5% while Focused Defense is active. Additionally reduces the cooldown of Awe by 7.5.",5);
    //Tier 6
    //Tier 7
    
    //id forceScarring = addCharacterSkillOLD(@"Force Scarring",PASSIVE,VIGILANCE,@"Sundering Strike lowers the target's Internal and Elemental resists by 10% on its first application.");
    
    //Watchman
    //Tier 1
    addCharacterSkill(@"Momentum",PASSIVE,WATCHMAN,@"Force Leap and Zealous Leap have a 50% chance to make the next Blade Storm activated cost no focus.",1);
    addCharacterSkill(@"Quick Recovery",PASSIVE,WATCHMAN,@"Reduces the focus cost of Force Sweep and Cyclone Slash by 1 and reduces the cooldown of Force Sweep by 1.5 seconds.",1);
    addCharacterSkill(@"Focused Slash",PASSIVE,WATCHMAN,@"Slash, Dispatch, Blade Rush and Merciless Slash have a 33.33% chance to refund 1 focus when used.",1);
    //Tier 2
    addCharacterSkill(@"Juyo Mastery",PASSIVE,WATCHMAN,@"Your burn effects are 1% more likely to critically hit per stack of Juyo Form.",2);
    addCharacterSkill(@"Inflammation",PASSIVE,WATCHMAN,@"Cauterize has a 50% chance to also reduce the target's movement speed by 30% for the duration.",2);
    addCharacterSkill(@"Merciless Zeal",PASSIVE,WATCHMAN,@"Critical hits with burn effects heal you for 1% of your maximum health.",2);
    //Tier 3
    addCharacterSkill(@"Overload Saber",INSTANT,WATCHMAN,@"Charges your Lightsabers with deadly energy for 15 seconds, causing your nexfxt 3 successful melee attacks to make the target burn for (current weapon) damage over 6 seconds. Stacks up to 3 times. This effect cannot occur more than once every 1.5 seconds.",3);
    addCharacterSkill(@"Searing Saber",PASSIVE,WATCHMAN,@"Increases the critical strike damage of your burn effects by 15%.",3);
    addCharacterSkill(@"Blurred Speed",PASSIVE,WATCHMAN,@"Lowers the cooldown of Force Leap by 1.5 seconds.",3);
    //Tier 4
    addCharacterSkill(@"Valor",PASSIVE,WATCHMAN,@"Increases the Centering built by 1 when activating abilities that spend focus, and reduces the cooldown of Valorous Call by 15 seconds.",4);
    addCharacterSkill(@"Watchguard",PASSIVE,WATCHMAN,@"Reduces the cooldown of Pacify by 7.5 seconds and Force Kick by 1 second.",4);
    addCharacterSkill(@"Repelling Blows",PASSIVE,WATCHMAN,@"Increases the direct damage dealt by Cauterize by 30%.",4);
    addCharacterSkill(@"Close Quarters",PASSIVE,WATCHMAN,@"Reduces the minimum range of Force Leap by 5 meters.",4);
    //Tier 5
    //Tier 6
    //Iter 7
}
-(void)addCraftingSkill
{
     id(^addCraftingSkill)(NSString*,NSString*,NSString*,NSString*) = ^(NSString* name,NSString* result,NSString* headline,NSString* type) 
     {
         id craftingSkill = [NSEntityDescription insertNewObjectForEntityForName:@"SGCraftingSkill" inManagedObjectContext:moc];
         [craftingSkill setValue:name forKey:@"Name"];
         [craftingSkill setValue:result forKey:@"Result"];
         [craftingSkill setValue:type forKey:@"Type"];
         [craftingSkill setValue:headline forKey:@"Headline"];

         [craftingSkill setValue:[NSString stringWithFormat:@"craftingSkillPreview_%@",[name stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"PreviewBackgroundFilename"];
         return craftingSkill;
     };
    
    void(^addAvaliableClassesToSkill)(id,NSArray*) = ^(id skill,NSArray* classNames) 
    {
        NSMutableSet* avaliableClasses = [NSMutableSet new];
        for(NSString* className in classNames)
        {
            [avaliableClasses addObject:[classes objectForKey:className]];
        }
        
        [skill setValue:avaliableClasses forKey:@"characterClasses"];
    };

    //Gathering
    id scavenging = addCraftingSkill(@"Scavenging",@"Recovered technological parts",@"Scavenging is the art of salvaging useful parts and base materials such as metals, alloys and synthetic compounds from potential technological resources-junk piles, fallen droids, abandoned cargo, and broken-down vehicles.\n\n Scavengers can send their companions on missions to gather resources.",GATHERING_TYPE);
    id archaeology = addCraftingSkill(@"Archaeology",@"Ancient Artifacts",@"Archaeology is the study of crystal formations and archaeological finds. Crystal formations contain crystals that an artificer can use to construct lightsaber modifications and armor for Force users.\n\n Archaeological finds contain artifact fragments of Force-imbued technology. These valuable items contain ancient formulas and algorithms used in the crafting skills Artifice and Synthweaving. Archaeologists can send their companions on missions to gather resources.",GATHERING_TYPE);
    id bioanalysis = addCraftingSkill(@"Bioanalysis",@"Genetic samples",@"Bioanalysis is the practice of collecting genetic material from creatures and vegetation.\n\n Genetic materials include cell fibers, bacterial strains, toxic extracts and medical fluids. Biochemists use these materials to create medpacs to restore health, stimulants (single-use injections) that provide a boost to physical abilities, and biological implants that enhance combat prowess by stimulating neural networks and regulating brain system functions. Bioanalysts can send their companions on missions to gather resources.",GATHERING_TYPE);
    id slicing = addCraftingSkill(@"Slicing",@"Credits, Cybertech Schematics, Crewskill Missions",@"Slicing is not a skill required for crafting. Slicing is the art of accessing secure computer systems and lockboxes to acquire valuable items, credits and rare tech schematics.\n\n Common slicing targets include electronic safes, data stations, security mainframes and biometric footlockers. These targets contain credits, rare tech schematics used to construct Cybertech gadgets, vehicles and space upgrades, and mission discovery objects that unlock challenging missions that can potentially yield great rewards. Slicers can send their companions on missions to retrieve these valuable items. Other possible mission rewards include augments that can be slotted into exceptionally crafted items.",GATHERING_TYPE);
    
    //Mission
    id diplomacy = addCraftingSkill(@"Diplomacy",@"Light Armor & Light/Dark Points",@"Diplomacy is the art of conducting and managing negotiations. Sending your companions on diplomatic missions can influence your light side or dark side standing.\n\n In addition to light side and dark side influence, possible Diplomacy rewards include medical supplies used to construct prototype and artifact implants, medpacs, stimulants, adrenals and gifts for companions to raise their affection rating.",MISSION_TYPE);
    id investigation = addCraftingSkill(@"Investigation",@"Medium Armor & Schematics",@"Investigation is the skill of researching, gathering, analyzing and decoding secret information.\n\n Sending your companions on Investigation missions can yield valuable items in the form of researched compounds used to construct prototype and artifact weapons and blaster barrels, prototype schematics for all crafts, and gifts for companions to raise their affection rating.",MISSION_TYPE);
    id treasureHunting = addCraftingSkill(@"Treasure Hunting",@"Weapons & Cybertech",@"Treasure Hunting is the ability to track down and recover valuable items by following a series of clues.\n\n Companions sent on Treasure Hunting missions can return with rare gemstones used to construct prototype and artifact enhancement, hilts, color crystals, focii and generators. Other possible rewards include lockboxes that can hold contain valuable items or credits and gifts for companions to raise their affection rating.",MISSION_TYPE);
    id underworldTrading = addCraftingSkill(@"Underworld Trading",@"Heavy Armor, Biochem & Cybertech",@"Underworld Trading entails the exchange of goods and services on the galactic black market.\n\n Sending your companions on Underworld Trading missions can yield luxury fabrics and underworld metals used to construct prototype and artifact armor, earpieces, grenades, space upgrades and weapons and armor modifications. Other possible rewards include gifts for companions to raise their affection rating.",MISSION_TYPE);
    
    //Crafting
    id armormech = addCraftingSkill(@"Armormech",@"Non-Force Armor",@"Armormech is the ability to work with hard metals, alloys and synthetic materials to construct armor for non-Force users.\n\n Vendor-purchased fluxes are used during the armor creation process to refine the materials to ensure suitability. Armormechs can reverse engineer their crafted armor and possibly discover new ways to improve armor creation.",CRAFTING_TYPE);
    [armormech setValue:[NSSet setWithObjects:scavenging,underworldTrading,nil] forKey:@"reliesOn"];
    
    id armstech = addCraftingSkill(@"Armstech",@"Non-Force Weapons and Barrels",@"Armstech is the ability to work with hard metals, alloys and synthetic materials to craft blasters, blaster modifications and melee weapons.\n\n Vendor-purchased fluxes are used during the weapon creation process to refine the materials to ensure suitability. Crafted blasters include blaster pistols, blaster rifles, sniper rifles, assault cannons and shotguns. Blaster modifications include blaster barrels. Melee weapons include vibroblades and electrostaves. Armstechs can reverse engineer their crafted blasters and possibly discover new ways to improve their creation.",CRAFTING_TYPE);
    [armstech setValue:[NSSet setWithObjects: investigation, scavenging, nil] forKey:@"reliesOn"];
    
    id artifice = addCraftingSkill(@"Artifice",@"Color Crystals, Hilts, Off-hand Generators, Enhancements",@"Artifice is the delicate skill of constructing lightsaber modifications, enhancements, generators and focii.\n\n Lightsaber modifications include color crystals and hilts that augment a Force user's combat attributes. Color crystals determine beam and bolt color for lightsabers and blasters. Enhancements are modification upgrades for weapons and armor. Artificers can reverse engineer their crafted items and possibly discover new ways to improve their creation..",CRAFTING_TYPE);
    [artifice setValue:[NSSet setWithObjects:archaeology,treasureHunting, nil] forKey:@"reliesOn"];
    
    id synthweaving = addCraftingSkill(@"Synthweaving",@"Force Armor",@"Synthweaving is the process of fabricating synthetic materials out of crystals, various chemicals and artifact fragments to construct armor for Force users.\n\n Vendors provide premade solutions, suspensions and composites that are used during the Synthweaving process. Synthweavers can reverse engineer their crafted armor and possibly discover new ways to improve armor creating.",CRAFTING_TYPE);
    [synthweaving setValue:[NSSet setWithObjects:archaeology, underworldTrading,nil] forKey:@"reliesOn"];
    
    id biochem = addCraftingSkill(@"Biochem",@"Adrenals, Stimpacks, Health Packs, Group/Companion Med Kits, Implants",@"Biochem is the skill involved in crafting medical supplies, performance-enhancing chemical serums and biological implants.\n\n Biochemists can create medpacs to restore health, stimulants (single-use injections) that provide a boost to physical abilities, and biological implants that enhance combat prowess by stimulating neural networks and regulating brain stem functions. Biochemists can reverse engineer their crafted implants and possibly discover new ways to improve implant creation.",CRAFTING_TYPE);
    [biochem setValue:[NSSet setWithObjects:bioanalysis, diplomacy,nil] forKey:@"reliesOn"];
    
    id cybertech = addCraftingSkill(@"Cybertech",@"Armoring, Mods, Droid Parts, Ship Parts, Earpieces",@"Cybertech is the skill to assemble droid armor, earpieces, grenades, armoring, mods, ship upgrades and miscellaneous gadgets.\n\n Armoring and mods are upgrade modifications that augment combat ability. Earpieces are external mini-computers that are worn on or near the ear. They enhance combat prowess by giving audio and visual feedback to the wearer or though direct neural feedback via an external nerve relay. Cybertechs can reverse engineer their crafted items, except grenades, and possibly discover new ways to improve their creation.",CRAFTING_TYPE);
    [cybertech setValue:[NSSet setWithObjects:scavenging,underworldTrading,nil] forKey:@"reliesOn"];

    
}
-(void)addDatacron
{
#define MODIFIER_NONE @"None"
    id(^addDatacron)(NSString*,NSString*,NSString*,NSString*,NSString*,int,int,NSString*,NSString*,NSString*) = ^(NSString* name,NSString* faction,NSString* type,NSString* locationName,NSString* colour,int lat, int lon,NSString* modifier,NSString* unlocks,NSString* description) 
    {
        id datacron = [NSEntityDescription insertNewObjectForEntityForName:@"SGDatacron" inManagedObjectContext:moc];
        [datacron setValue:name forKey:@"Name"];
        [datacron setValue:description forKey:@"Description"];
        [datacron setValue:faction forKey:@"Allegiance"];
        [datacron setValue:type forKey:@"type"];
        [datacron setValue:colour forKey:@"colour"];
        [datacron setValue:modifier forKey:@"modifier"];
        [datacron setValue:unlocks forKey:@"unlocks"];
        [datacron setValue:[NSString stringWithFormat:@"%d",lat] forKey:@"lat"];
        [datacron setValue:[NSString stringWithFormat:@"%d",lon] forKey:@"lon"];
        
        id location = [locations objectForKey:locationName];
        if(location)
        {
            [datacron setValue:location forKey:@"location"];
        }
        
        [datacron setValue:[NSString stringWithFormat:@"datacronRowPreview_%@",colour]forKey:@"PreviewBackgroundFilename"];
        return datacron;
    };
    
    
    addDatacron(@"Ord Mantell #1",@"Republic",@"Matrix Shard",@"Ord Mantell",@"Red",778,134,@"None",@"Unlocks Galactic History Entry #14",@"This Datacron is North of Mannett Point. It’s located on the beach on the very North side of the island. You simply have to run around the island on the beach to reach it. It’s guarded by a couple level 6 elite mobs and a level 7 named mob.");
    
    addDatacron(@"Ord Mantell #2",@"Republic",@"Datacron",@"Ord Mantell",@"White",-656,44,@"Aim + 2",@"Unlocks Galactics History Entry #12",@"This Datacron is located on peak in the center of Savrip Island. You should be able to see the Datacron from the beach when you fist arrive onto the island. Run up the beach and follow the fork to the left. A little ways down on the right hand side you will find an area where you can very easily start jumping up the rocks. Begin your climb at -767,15.");
    
     addDatacron(@"Ord Mantell #3",@"Republic",@"Datacron",@"Ord Mantell",@"Yellow",-975,203,@"Presence + 2",@" Unlocks Galactic History Entry #13",@"This Datacron is located just west of the Volcano on the beach. If you follow the beach from the Volcano Camp you will eventually run right into this Datacron. It’s very easy to get.");
     addDatacron(@"Tython #1",@"Republic",@"Matrix Shard",@"Tython",@"Blue",-93,919,@"None",@"Unlocks Galactic History Entry #11",@"If you walk south of the Forge Remnants there is a path that leads to this Datacron. The beginning of the path can be found at -195, 812. The Datacron is at the top of the raised area and is guarded by an elite Flesh Raider.");
     addDatacron(@"Tython #2",@"Republic",@"Datacron",@"Tython",@"Green",-33,-101,@"Endurance + 2",@"Unlocks Galactic History Entry #9",@"This Datacron is located in a cave due east of the Forward Camp Speeder. The entrance to the cave is located is at -28, 22. It’s pretty easy to get to, you will have to kill a few Flesh Raiders along the way.");
     addDatacron(@"Tython #3",@"Republic",@"Datacron",@"Tython",@"Purple",-642,-70,@"Willpower + 2",@"Unlocks Galactic History Entry #10",@"Head to the Ruins of Kaleth, take the stairs to the second level of the ruins. Go into the building on the right. Inside you will see a pillar on the left coming down from the roof into the room. Walk up the pillar to reach the third level of the ruins. Turn right and walk across the fallen pillar to the forested / hill area. Your Datacron will be in front of you on the right hand side.");
     addDatacron(@"Alderaan #1",@"Shared",@"Datacron",@"Alderaan",@"Green",2721,2494,@"Endurance +3",@"Unlocks Galactic History Entry #44",@"This Datacron is hidden inside a cave wall that you must destroy. Find the entrance to the cave at 2374, 2450. Follow the path straight in. Eventually you will a blast pack on the wall. This pack can be used to blow away the rocks hiding your Datacron.");
     addDatacron(@"Alderaan #2",@"Shared",@"Datacron",@"Alderaan",@"Red",2191,-2018,@"Strength + 4",@"Unlocks Galactic History Entry #46",@"This Datacron is located on a small ledge on the face of the dam. From the backside of the dam work your way to the following location: 2240, -2026. From there jump down but use the obstacles along the way to break your fall. From here there is a \"Magnetic Stabilizer\" that hovers above the platform with your Datacron. If you click it (you should be able to reach it from the ledge you are on)it will pull you over to the platform.");
     addDatacron(@"Alderaan #3",@"Shared",@"Datacron",@"Alderaan",@"White",1105,80,@"Aim + 4",@"Unlocks Galactic History Entry #43",@"This Datacron is located on the island that is only accessible via the trolley. The trolley is very slow, so you have to be patient. The entrance to the trolley can be found at 1090, -7.");
     addDatacron(@"Alderaan #4",@"Shared",@"Datacron",@"Alderaan",@"Purple",-2507,-425,@"Willpower + 3",@"Unlocks Galactic History Entry #47",@"Start inside Castle Panteer at coordinates -2490, -368 there is a crack near a door that you can slip through. Follow the path until you’re on the 2nd floor. From there you should see the Datacron. Follow the hallway / landing to the right and all the way around to collect it.");
     addDatacron(@"Alderaan #5",@"Shared",@"Datacron",@"Alderaan",@"Yellow",-81,-268,@"Presence + 3",@"Unlocks Galactic History Entry #45",@"In Glarus Valley there is a large bridge that is held up by a giant rock. This Datacron is located about halfway up the rock. Head to coordinates -412, -209 and you will find a Thranta nest. Click on the Thranta and you will receive a codex entry and also a ride up the hill to this Datacron. Easy.");
     addDatacron(@"Balmorra #1",@"Empire",@"Matrix Shard",@"Balmorra",@"Green",-505,1989,@"None",@"Unlocks Galactic History Entry #30",@"In Neebray Warehouse. Two people are required to access this datacron. Take the elevator down to the Lower Level. Down here, you will find two switches on opposite sides of the room that must be pressed simultaneously in order for the force field that is blocking your path to the datacron to be deactivated.");
     addDatacron(@"Balmorra #2",@"Empire",@"Datacron",@"Balmorra",@"Orange",1850,111,@"Cunning + 2",@"Unlocks Galactic History Entry #29",@"Below the dock, the datacron rests upon a rock.");
     addDatacron(@"Balmorra #3",@"Empire",@"Datacron",@"Balmorra",@"White",-1019,1514,@"Aim + 2",@"Unlocks Galactic History Entry #28",@"In the Okara Droid Factory. Take the lift to the assembly line and look for the hidden entrance at (-1024,1514). Carefully drop down to the datacron.");
     addDatacron(@"Balmorra #4",@"Shared",@"Datacron",@"Balmorra",@"Purple",191,-344,@"Willpower + 4",@"Unlocks Galactic History Entry #32",@"In the Farnel Research Facility. First, purchase a Lost Code Cylinder from the vendor located at (670,38) to open the locked box this datacron is in. The locked box is on easily visible portion of a destroyed bridge.");
     addDatacron(@"Balmorra #5",@"Empire",@"Datacron",@"Balmorra",@"Red",727,2033,@"Strength + 2",@"Unlocks Galactic History Entry #31",@"In Gorinth Canyon. Head south from the Sundari outpost and across the bridge. Go to the start of a path at (695,1879) and follow it, past a white turret, to the datacron.");
     addDatacron(@"Balmorra #6",@"Republic",@"Datacron",@"Balmorra",@"Purple",-781,2067,@"Willpower + 4",@"Unlocks Galactic History Entry #55",@"Head to Gorinth Canyon. Follow the three bridges out of Gorinth Outpost. You will eventually come to a pipe, cross it and you will be able to drop down on this Datacron.");
     addDatacron(@"Balmorra #7",@"Republic",@"Datacron",@"Balmorra",@"Green",-432,-293,@"Endurance + 3",@"Unlocks Galactic History Entry #54",@"Inside the Colicoid Queen’s Nest head toward to coordinates -358,-232 and you will see a small tunnel entrance. Follow it, killing the enemies inside. Eventually you will reach the Datacron.");
     addDatacron(@"Balmorra #8",@"Republic",@"Datacron",@"Balmorra",@"Orange",-1019,1514,@"Cunning + 4",@"Unlocks Galactic History Entry #56",@"In the Okara Droid Factory. Take the lift to the assembly line and look for the hidden entrance at (-1024,1514). Carefully drop down to the datacron.");
     addDatacron(@"Balmorra #9",@"Republic",@"Datacron",@"Balmorra",@"White",192,-343,@"Aim + 4",@"Unlocks Galactic History Entry #53",@"In the Farnel Research Facility. First, purchase a Lost Code Cylinder from the vendor located at (670,38) to open the locked box this datacron is in. The locked box is on easily visible portion of a destroyed bridge.");
     addDatacron(@"Balmorra #10",@"Republic",@"Datacron",@"Balmorra",@"Yellow",727,2033,@"Presence + 4",@"Unlocks Galactic History Entry #57",@"In Gorinth Canyon. Head south from the Sundari outpost and across the bridge. Go to the start of a path at (695,1879) and follow it, past a white turret, to the datacron.");
     addDatacron(@"Belsavis #1",@"Republic",@"Datacron",@"Belsavis",@"White",-2354,-2319,@"Aim + 4",@"Unlocks Galactic History Entry #68",@"In the tomb area you will find a lava pit. Look for a laser bridge, it’s very hard to see, travel across it and collect your Datacron.");
     addDatacron(@"Belsavis #2",@"Republic",@"Matrix Shard",@"Belsavis",@"Green",-315,-2173,@"None",@"Unlocks Galactic History Entry #71",@"First find the elevator to Cave Under Tree on the Tomb map, the location is (-547, -2172). Take the elevator down and travel straight through to the far end of the room. The glowing cube is there with a quest reticule above it. Before the Datacron is a machine that is powered by 4 Rakata Cubes. Rakata Cubes are found all over Belsavis. They spawn at random hidden locations. Two of the locations I made Notes of are:\n\nMinimum Security (-154, -45) up on top of small hill at the base of a tree.\n\nHigh Security section (-2790, 955) on another hill near base of tree and beside giant orange beet.\n\nYou must place four cubes into the machine and then activate it in order to get inside the Datacron. The Rakata cubes are grey/white and are slightly smaller than Datacron cubes. Also, the Rakata cubes do not glow.");
     addDatacron(@"Belsavis #3",@"Republic",@"Datacron",@"Belsavis",@"Red",-508,768,@"Willpower + 4",@"Unlocks Galactic History Entry #72",@"In the High Security Section. The Datacron is about about 20 meters up the cliff-wall and the player cannot access it directly. Go around the North end of the mesa-like rock structure to (-831, 780).  Follow the canyon to the Datacron.");
     addDatacron(@"Belsavis #4",@"Republic",@"Datacron",@"Belsavis",@"Yellow",-1900,-475,@"Presence + 4",@"Unlocks Galactic History Entry #70",@"Enter a tiny cave at (-2135, -173) and follow the cliff-side around to the cron. To get back you have to go the opposite direction that you came in.");
     addDatacron(@"Belsavis #5",@"Republic",@"Datacron",@"Belsavis",@"Green",-2562,-839,@"Endurance + 4",@"Unlocks Galactic History Entry #69",@"Head to a cave in the Northern portion of the Belsalvis Maximum Security Section at coordinates: -2475,-775. You will find a large group of rocks that you need to walk around, then cilmb up onto them. From here you will be able to see the passage between the rocks and wall. Drop down into this gap and you will see the entrance to the cave. You will find your Datacron inside.");
     addDatacron(@"Corellia # 1",@"Republic",@"Datacron",@"Corellia",@"Red",-2755,-2005,@"Strength + 4",@"Unlocks Galactic History Entry #82",@"Starting location is on Corellia, Labor Valley – Central Workforce Habitation at -2177, -2400. \n\nYou start by running up a pipe that is attached to a canopy. Once on the canopy wait for the fighter that is connected to a crane. Once the fighter is above the canopy jump onto it and wait for it to slowly make it to the scaffolding with the stacks of missiles. Jump onto the scaffolding with the stacks of missiles and than jump down into the fenced in area with giant containers. You will see a steel beam that is leaning onto the crates. Run up that to get ontop of the crates. On the far side of the crates is an arm that goes up and down slowly, wait for it to come down and carefully jump onto it. I faced my character so the arm was to the left of my character and than jumped up and hit left arrow so I would take a small precise jump on top of the arm. Once it gets to the top jump onto the top crate from the arm. You can than jump up onto the scaffolding with more crates / missile stacks. In the middle is another beam that leads you up to the Datacron.");
     addDatacron(@"Corellia # 2",@"Republic",@"Datacron",@"Corellia",@"Purple",703,1717,@"Willpower + 4",@"",@"Notes:\n\nYou can visually see this Datacron from the surrounding areas. It is on a third level grated platform (ground being first). It is inaccessible from the surrounding area. You have to go way off East to start the climb around to it. There are really only 2 hard jumps in the entire route. One will have a soft reset where you are set back a small amount but nothing too bad. The other is right at the end and will cause you to re-run the entire route. As long as you are careful it is not bad.\n\nRoute:\n\nStart around 1130,1670. There is a large ramp going into a tunnel through a building. Do not go in the tunnel. Go West and take the molding around the side of the building. Follow it around under the grated platform holding the ships. You will hop some supports on route. When you come to the last support (you can do this earlier if you prefer), jump on it and run up it. Just above it near the top, you will see a beam running perpendicular. Jump onto this beam. You should be at 947,1780. \n\nNow for some twisting turns. Datacron map coordinates for this. Follow the beam West, then North to the pipes. Jump onto those and turn around after you move out a bit. you should have the platform with the ships on it just above. Jump on to it (if you are having trouble, make sure you are on the highest of the little pipes). Then use your Datacron hunting box jumping to get on top of the ship. (Crates -> Large Containers -> Ship) Jump on top of the cockpit area from the weapons pod. Then go over to the large crates, over them to the the equipment going West again. Travel along it and onto the lip on the equipment (small jump up). \n\nNow you are in the home stretch, if you make this jump. Jump from the SE corner onto the pipe nearby. If you miss this jump, you will end up behind some fences. Carefully edge walk East and South around the corner and back the the support that you climbed earlier. Otherwise, keep moving West. At this point you will work West, down onto a rooftop that extends over open areas. Keep going West. When it bends South, follow it to the beam that forms a ramp to more beams. Take that up and you are now on level with the Datacron. Walk over to the platform then make a careful jump cutting the corner to get on. ");
     addDatacron(@"Corellia # 3",@"Republic",@"Matrix Shard",@"Corellia",@"Blue",-2425,-1063,@"None",@"Unlocks Galactic History Entry #62",@"Datacron is located in Labor Valley. Coordinates for starting point are X:-2302, Y:-987. There will be a hologram door here. You can go through it. There is only one way through. Once you come out of the tunnel you will see the datacron shining on a container. Jump up and grab it. There are Datacron tricks, or jumps here. Long ride for republic people not to bad for empire. ");
     addDatacron(@"Coruscant # 1",@"Republic",@"Datacron",@"Coruscant",@"Yellow",2320,1055,@"Presence + 2",@"Unlocks Galactic History Entry #8",@"Head to the Old Market area. As you run up the platform to get to the second level turn to the left and head up the platform to the third level. You will a small deck with two parked ships. The Datacron is on this platform.");
     addDatacron(@"Coruscant # 2",@"Republic",@"Datacron",@"Coruscant",@"Green",-3625,150,@"Endurance + 2",@"Unlocks Galactic History Entry #4",@"Head to the Silent Sun Cantina inside the Black Sun area of Coruscant. You will be able to see and hear this Datacron from there. Across from the entrance (if you look at the entrance to the cantina, it will be to your right) you will see a bulldozer near a bunch of crates. Go around to the backside of the crates and you can climb up them. Work your way up to the top and across the pipe to the walkway. Follow the walkway until you reach the broken pipes in the wall. Jump onto the pipe and work your way across to the next platform. Run down the walkway to the next pipe and do the same. You will have to jump from pipe-to-walkway several times before making it to the appropriate platform with your Datacron.");
     addDatacron(@"Coruscant # 3",@"Republic",@"Datacron",@"Coruscant",@"Orange",1020,3969,@"Cunning + 2",@"Unlocks Galactic History Entry #5",@"This Datacron is in the Justicar Area. It will be hard to see, but it is on a platform above the hallway you are in. On the left side against the wall jump up the crates. Once on top you will have run across the pipes to make it to the platform with the Datacron. This one can be a bit tricky…time your jumps appropriately.");
     addDatacron(@"Coruscant # 4",@"Republic",@"Matrix Shard",@"Coruscant",@"Yellow",950,4541,@"None",@"Unlocks Galactic History Entry #5",@"Head to The Works section of Coruscant. On the east side of the map head to coordinates 1177, 4419. From here you can jump up onto the pipes. You will have to run along the pipes, crossing almost the entire zone to reach the platform this Datacron is located at.");
     addDatacron(@"Coruscant # 5",@"Republic",@"Datacron",@"Coruscant",@"Red",-3087,3031,@"Strength + 2",@"Unlocks Galactic History Entry #7",@"This Datacron is inside the ruins of the Jedi Temple. On the east side of the ruins you will see a leaning pillar. Run up the pillar to the second level. From there, turn to the left and jump up onto the ledge along the wall. Follow the ledge around to the left. You will reach a platform where you can drop down. There is a mini-boss you will have to get past, he is easy. Then you can drop down from onto the pillar remains to claim your Datacron.");
     addDatacron(@"Hoth #1",@"Shared",@"Matrix Shard",@"Hoth",@"Red",-735,1702,@"None",@"Unlocks Galactic History Entry #66",@"Head to Highmount Ridge located south of Leth Outpost. This Datacron is sitting out in open at the coordinates. You will need to get a Hydro-Thinner from the Cantina vendor in the first base you land in when you come to Hoth. It costs 18.000 credits. With it you can melt the ice block containing this datacron.");
     addDatacron(@"Hoth #2",@"Shared",@"Datacron",@"Hoth",@"Orange",3143,471,@"Cunning + 4",@"Unlocks Galactic History 63",@"Head to the Star of Courscant and get to the second floor. At coordinates 3248, 493 you will find a group of boxes that you can use to work your way to this Datacron. If you are having trouble finding the Star of Courscant its located in the lower right portion of the Starship Graveyard on your map.");
     addDatacron(@"Hoth #3",@"Shared",@"Datacron",@"Hoth",@"Yellow",1041,-1245,@"Presence + 4",@"Unlocks Galactic History 65",@"Head to Frostwake Outpost and travel due North towards the top of your map. You will see this Datacron on the side of a hill. At first glance it appears to be unobtainable. If you travel to coordinates 1145, -995 you will find a ledge you can jump onto. Follow the ledge until it ends. From threre you can jump down, stay as close to the wall as possible. You will land in near a cave. Follow the path through the cave to collect your Datacron.");
     addDatacron(@"Hoth #4",@"Shared",@"Datacron",@"Hoth",@"Green",2837,-374,@"Endurance + 4",@"Unlocks Galactic History 54",@"Head to coordinates 2607, -844 and start jumping / climbing up the ice. Eventually you will end up above what appears to be an ice bridge. Drop down onto the ice bridge. Follow the path as far as you can, again you will need to do some jumping / climbing. When you reach the appropriate level your Datacron will be waiting for you.");
     addDatacron(@"Hoth #5",@"Shared",@"Datacron",@"Hoth",@"Red",-4102,115,@"Strength + 4",@"None",@"To get this datacron you need to kill a level 47 Elite Champion mob named \"Ancient Probe\". It drops a Depleted Datacron. You need to charge it at the North entrance to The Star of Coruscant and you will get a functioning datacron. Once at the North entrance to the Star you need to jump onto a pipe and walk across it's ledge. Jump down to the recharge station and use it.");
     addDatacron(@"Ilum # 1",@"Shared",@"Datacron",@"Ilum",@"Green",102,-63,@"Endurance + 4",@"None",@"On the Eastern Ice Shelf. In the ravine sitting in the open at the end of the path.");
     addDatacron(@"Ilum # 2",@"Shared",@"Matrix Shard",@"Ilum",@"Red",543,544,@"None",@"None",@"On the Eastern Ice Shelf. In a tent over the Republic base camp.");
     addDatacron(@"Ilum # 3",@"Shared",@"Matrix Shard",@"Ilum",@"Yellow",543,-11,@"None",@"None",@"On Eastern Ice Shelf. Right above the Republic Base Camp inside one of the tents (the only one that you can go into).");
     addDatacron(@"Nar Shaddaa #1",@"Empire",@"Datacron",@"Nar Shaddaa",@"Red",1943,2481,@"Strength + 3",@"Unlocks Galactic History 37",@"Near the Network Access Taxi you will be able to look down and see what looks like a taxi below. You need to carefully fall to the platform that taxi is sitting on. That taxi will bring you to a Datacron. You can then use the communicator to return.");
     addDatacron(@"Nar Shaddaa #2",@"Empire",@"Datacron",@"Nar Shaddaa",@"Yellow",2930,400,@"Presence + 3",@"Unlocks Galactic History 35",@"This datacron is on a raised platform in the Rebel Refugee Section in the Duros Sector: Slums. Start platforming at 1616, -2676 (Datacron that’s not a misprint). You want to jump on the boxes, hop on the beam, run to the catwalk, jump on a \"canvas\" to the next catwalk. You will see an elevator, take it to the Residential Catwalk. At this point you are above the datacron, look around, plan your moves and claim your prize. It should be noted that if you fail to hit the beams after you take the elevator, you will either die to the fall or the groups of four elite mobs.");
     addDatacron(@"Nar Shaddaa #3",@"Empire",@"Datacron",@"Nar Shaddaa",@"White",-3700,-1692,@"Aim + 3",@"None",@"This datacron is on a raised platform in the Corellian Sector. You will notice a floating Kiosk in this area, it makes a circle around this room (takes approx 10 mins to complete a circle). You will need to jump onto the roof above the bench at -3785, -1681 (use the nearby crates and shelves to get there) and get your ride on the floating Kiosk at that location.");
     addDatacron(@"Nar Shaddaa #4",@"Republic",@"Datacron",@"Nar Shaddaa",@"Red",2192,3068,@"Strength + 3",@"Unlocks Galactic History 37",@"In Shadow Town, head to (2302,3060) where you will need to climb some crates to a walkway. Follow the walkway til you reach a overpass; cross it. Get on top of some boxes on the left and jump to the near pipe. Follow the pipe North til you reach the second perpendicular pipe on the right. Jump up the pipe along the wall and on to a circular platform. Look westward and notice a large platform. Jump up to it and then look Northward. Jump to the near pipe and follow it to the opposite wall. Drop down to the pipes along the wall on your left. Jump your way between the gaps as your cross the pipes and small platforms til you reach a ledge. You will find an elevator there that will take you to a secret area. The datacron awaits at the end of that area.");
     addDatacron(@"Nar Shaddaa #5",@"Republic",@"Datacron",@"Nar Shaddaa",@"White",-3364,-3312,@"Aim + 3",@"Unlocks Galactic History 33",@"In Nikto Sector. Head over to (-3303,-3402) where you will find small boxes next to some crates. Start climbing the crates up to a canopy. Follow up the second small pipe that intersects the canopy to a larger pipe. Cross the larger pipe as it leads to you to a wall with more pipes to follow. Jump your way to the ledge walkway, and keep following it as it turns left. Once you get to (-3397,-3336), jump down to the nearest post below. Follow the post line directly to the datacron.");
     addDatacron(@"Nar Shaddaa #6",@"Republic",@"Datacron",@"Nar Shaddaa",@"Yellow",3340,-3290,@"Presence + 3",@"Unlocks Galactic History 35",@"In the Red Light Sector. In the Gauntlet Gang Area, head to (3690,1342) where you will find a small box next to a ledge. Jump up to the ledge and follow the canopy to a second level. Take the elevator up to a new level and the datacron.");
     addDatacron(@"Nar Shaddaa #7",@"Shared",@"Datacron",@"Nar Shaddaa",@"Orange",1930,3313,@"Cunning +3",@"Unlocks Galactic History 34",@"In the High Security lockdown area, head to (2033,3355) and jump up the boxes to a ramp that leads to a walkway. Follow the walkway to a terminal that grants access to the incinerator room. Once inside, quickly make your way to the terminal and select the option that reads \"326:3839\". A door will open to the datacron and a new terminal that gives you an item you’ll need for the Yellow Matrix Shard datacron coming up.");
     addDatacron(@"Nar Shaddaa #8",@"Shared",@"Matrix Shard",@"Nar Shaddaa",@"Yellow",1781,3084,@"None",@"Unlocks Galactic History 36",@"In Network Security District, head to (1700,3089) and climb the boxes. Once upon the highest box, jump to the pipe along the wall. Jump up the pipes and platforms til you get to some boxes under a ledge. Leap up to the ledge from the boxes. The datacron will be on this terrace. Use the item from the Cunning +3 datacron to gain access to it.");
     addDatacron(@"Quesh #1",@"Shared",@"Datacron",@"Quesh",@"Green",207,769,@"Endurance + 4",@"Unlocks Galactic History 59",@"Head to the coordinates and look for a pipe with bars. From there you should be able to see your Datacron. There are entrances to each this Datacron on both the North and south sides.");
     addDatacron(@"Quesh #2",@"Shared",@"Datacron",@"Quesh",@"Orange",426,-130,@"Cunning + 4",@"Unlocks Galactic History 58",@"Head to the Republic Operation Headquarters. From there head Northwest. You will eventually find a fence with a hole in it. Go through the hole.");
     addDatacron(@"Quesh #3",@"Shared",@"Datacron",@"Quesh",@"Red",558,1422,@"Strength + 4",@"Unlocks Galactic History 60",@"The coordinates will take you to a hill which is very near the Three Families War Camp. Climb the hill and collect your Datacron.");
     addDatacron(@"Taris # 1",@"Empire",@"Datacron",@"Taris",@"Orange",-643,1606,@"Cunning + 4",@"Unlocks Galactic History 52",@"You will enter the Abandoned Pirate Cave at -768, 1191 and take the elevator in the back of the room to the bottom floor (Republic Mine). When you arrive at the room with the Datacron you will notice a bulldozer in the room. You will need to jump onto the bulldozer and then jump box to box until you reach the Datacron. The closest flight path is Bomber Command Post. ");
     addDatacron(@"Taris # 2",@"Empire",@"Datacron",@"Taris",@"Purple",444,-772,@"Willpower + 4",@"Unlocks Galactic History 50",@"This one takes a lot of well placed jumps but it is not as hard as some (unless you have a fear of heights). There is actually a break in the floor you have to watch out for once you are really close to the datacron. Check out the screenshots below marked with warning.");
     addDatacron(@"Taris # 3",@"Empire",@"Datacron",@"Taris",@"Green",-1513,-253,@"Endurance + 3",@"Unlocks Galactic History 23",@"This Datacron requires a long run around a ledge. You can gain access to the ledge at coordinates -1367, -208. At the end of the ledge you will have to jump across to the giant broken pipe. From the pipe you can jump onto the smaller pipes and walk across to the area where the Datacron is located. Drop down off the pipes onto the platform. Once on the platform, drop down again into the pipe and collect your Datacron.");
     addDatacron(@"Taris # 4",@"Empire",@"Datacron",@"Taris",@"Yellow",1187,-571,@"Presence + 4",@"Unlocks Galactic History Entry #25",@"Start at 381,31 and just jump and follow the pipeline path to the Datacron.");
     addDatacron(@"Taris # 5",@"Empire",@"Datacron",@"Taris",@"White",1047,454,@"Aim + 4",@"Unlocks Galactic History Entry #24",@"Run up the pipe at 1183, -170 til it ends and jump to the left platform. Continue on the platform to a wall; start following the wall ledge path. Once you get to 969, -173, jump right onto the silvery-gray structure. Run and jump along the structures and platforms, its a pretty straightforward path.");
     addDatacron(@"Taris # 6",@"Republic",@"Datacron",@"Taris",@"Orange",1047,454,@"Cunning + 2",@"Unlocks Galactic History Entry #24",@"Run up the pipe at 1183, -170 til it ends and jump to the left platform. Continue on the platform to a wall; start following the wall ledge path. Once you get to 969, -173, jump right onto the silvery-gray structure. Run and jump along the structures and platforms, its a pretty straightforward path.");
     addDatacron(@"Taris # 7",@"Republic",@"Datacron",@"Taris",@"Red",1187,-571,@"Strength + 2",@"Unlocks Galactic History Entry #25",@"Start at 1118, -150 and just jump and follow the pipeline path to the Datacron.");
     addDatacron(@"Taris # 8",@"Republic",@"Datacron",@"Taris",@"White",-1513,-253,@"Aim + 2",@"Unlocks Galactic History 23",@"This Datacron requires a long run around a ledge. You can gain access to the ledge at coordinates -1367, -208. At the end of the ledge you will have to jump across to the giant broken pipe. From the pipe you can jump onto the smaller pipes and walk across to the area where the Datacron is located. Drop down off the pipes onto the platform. Once on the platform, drop down again into the pipe and collect your Datacron.");
     addDatacron(@"Taris # 9",@"Republic",@"Datacron",@"Taris",@"Purple",-362,-227,@"Willpower + 2",@"Unlocks Galactic History 26",@"Start at -444, -171. Inside Dynamet General Hospital follow the hallway until you reach the big room. From there will be a door on the first floor on the right side. It’s blocked by debris which you can climb over to get through. Then follow the hallway until you reach your Datacron.");
     addDatacron(@"Taris # 10",@"Republic",@"Matrix Shard",@"Taris",@"Green",1059,1039,@"None",@"Unlocks Galactic History 27",@"You need 2 people to get this datacron. Below the datacron on the lower area, you will find a platform and a switch at 1053, -182. Stand near the middle of the platform as a second person activates the switch. The interaction launches you to a pipe. Drop down onto the lower skinnier pipe that intersects the pipe you landed on. Follow the pipe to the end, and then jump to the datacron.");
     addDatacron(@"Tatooine #1",@"Empire",@"Datacron",@"Tatooine",@"Orange",728,3133,@"Cunning + 3",@"Unlocks Galactic History Entry #39",@"This datacron is on a rooftop in Mos Ila. Start at 448, 3137.");
     addDatacron(@"Tatooine #2",@"Republic",@"Datacron",@"Tatooine",@"Orange",2139,-3671,@"Cunning + 3",@"Unlocks Galactic History Entry #39",@"In Anchorhead above the Underworld Trading Trainer you will see this Datacron. In the Northwest corner is a corner with a pile of sand you can use to climb up and get on the wall (you must be outside of the main city wall to do this). Once on the wall, follow the path jumping from rooftop to rooftop and platform to platform. Eventually you will reach your Datacron.");
     addDatacron(@"Tatooine #3",@"Shared",@"Datacron",@"Tatooine",@"Purple",2074,-577,@"Willpower + 3",@"Unlocks Galactic History Entry #42",@"Start at Coordinates 2094, -466 and head South. Eventually you will have to jump down to a big ledge which goes into a cave (you can see the ledge but not the cave). Once inside the cave you have to go through some mobs and elites but at the end of the cave is your Datacron.");
     addDatacron(@"Tatooine #4",@"Shared",@"Datacron",@"Tatooine",@"White",-628,-30,@"Aim + 3",@"Unlocks Galactic History Entry #38",@"In the Dune Sea. Head to the southwest area of Jundland: Transport Ship Crash Site. Sneak your way to the west ledge (just beyond an elite tusken-raider) that overlooks the Dune Sea. notice the datacron perched on some ship debris. Carefully drop down to it.");
     addDatacron(@"Tatooine #5",@"Shared",@"Datacron",@"Tatooine",@"Red",-3841,-600,@"Strength + 3",@"Unlocks Galactic History Entry #41",@"Start at coordinates -2339, 6 on the buried Sand Crawler and wait for the Jawa Balloon. It can take some time for it to show up. Once it does, jump into the basket and ride it (about 1/2 an hour) until you see the Sand Crawler with the Datacron at coordinates -2389 , -1393. Jump from the balloon on to the Sand Crawler. From there you drop off to the lower part of the Sand Crawler and hug the wall so you can drop down onto the ledge right next to it and get your Strength + 3 Datacron.");
     addDatacron(@"Tatooine #6",@"Shared",@"Matrix Shard",@"Tatooine",@"Blue",-3850,-600,@"None",@"Unlocks Galactic History Entry #40",@"Start at coordinates -2339, 6 on the buried Sand Crawler and wait for the Jawa Balloon. It can take some time for it to show up. Once it does, jump into the basket and ride it (about 1/2 an hour) until you see the Sand Crawler with the Datacron at coordinates -2389 , -1393. Jump from the balloon on to the Sand Crawler and claim your first Datacron for your Blue Matrix Shard. ");
     addDatacron(@"Voss #1",@"Shared",@"Datacron",@"Voss",@"Green",-1950,-2220,@"Endurance + 4",@"Unlocks Galactic History Entry #73",@"Inside the Shrine of Healing lower level -1950,-2230 When clicking tells you, you need to be worthy. In the North-east corner of the room you are in, there is a healing crystal -1910,-2305. Activate it then wait for the meditation cycle to end. Afterwards you can claim the Datacron.");
     addDatacron(@"Voss #2",@"Shared",@"Datacron",@"Voss",@"Purple",-29,371,@"Willpower + 4",@"Unlocks Galactic History Entry #77",@"Head to coordinates -442, 402, near Fort Kodentha. From there you will see a grassy trail. Follow the trail until you reach the rock formation at coordinates -432, 179. Climb up the rock formation to the top. You will see a cave entrance there. Follow the cave to the end to collect your Datacron.");
     addDatacron(@"Voss #3",@"Shared",@"Datacron",@"Voss",@"Yellow",2000,-940,@"Presence + 4",@"Unlocks Galactic History Entry #75",@"Head to the Northeast corner of the Nightmare Lands. You will find a small island that is occupied by three Voss Mystics. Near the meditating mystics you will see a Meditation Tablet. Click on the tablet, this will put you in a dream state. From there you can collect your Datacron.");
     addDatacron(@"Korriban #1",@"Empire",@"Datacron",@"Korriban",@"Green",154,81,@"Endurance + 2",@"Unlocks Galactic History Entry #15",@"Near the shuttle that you leave the planet on.");
     addDatacron(@"Korriban #2",@"Empire",@"Datacron",@"Korriban",@"Purple",529,64,@"Willpower + 2",@"Unlocks Galactic History Entry #16",@"This is located on a plateau near the first shuttle your quests will take you.");
     addDatacron(@"Korriban #3",@"Empire",@"Matrix Shard",@"Korriban",@"Red",-55,12,@"None",@"Unlocks Galactic History Entry #17",@"Located in the non-instanced group area inside the Tomb of Tulak Hord.");
     addDatacron(@"Hutta #1",@"Empire",@"Datacron",@"Hutta",@"White",-94,859,@"Aim + 2",@"Unlocks Galactic History Entry #1",@"In the Bog. Climb the pipe at -163, 911 up to the hill. Keep right and follow the path along the side of the hill. It will lead you straight to the datacron.");
     addDatacron(@"Hutta #2",@"Empire",@"Matrix Shard",@"Hutta",@"Blue",-10,322,@"None",@"Unlocks Galactic History Entry #3",@"In the Sewer Maintenance Tunnels. Behind the champion boss. ");
     addDatacron(@"Hutta #3",@"Empire",@"Datacron",@"Hutta",@"Yellow",650,-107,@"Presence + 2",@"Unlocks Galactic History Entry #2",@"In the Rustyards. This datacron is located on an island. Follow the pipeline, that starts at 497,-41, to the island and the datacron.");
     addDatacron(@"Dromund Kaas #1",@"Empire",@"Datacron",@"Dromund Kaas",@"Red",855,643,@"Strength + 2",@"Unlocks Galactic History Entry #19",@"In the dromund kaas Spaceport. Begin by going up the walkway that starts at 865, 642. Once you get to the two crates on the right, walk along the east side of the crates and drop down to the south-most pipe. Follow the pipe right over the datacron.");
     addDatacron(@"Dromund Kaas #2",@"Empire",@"Datacron",@"Dromund Kaas",@"Green",-795,1451,@"Endurance + 2",@"Unlocks Galactic History Entry #20",@"At -729, 1496 in Lord Grathan’s Estate, there is a path that leads straight to the datacron.");
     addDatacron(@"dromund kaas #3",@"Empire",@"Matrix Shard",@"Dromund Kaas",@"Yellow",-188,1737,@"None",@"Unlocks Galactic History Entry #18",@"At -63, 1693 in The Malignant Bog, there is a path that leads up to the top of the waterfall and the datacron.");
     addDatacron(@"dromund kaas #4",@"Empire",@"Datacron",@"Dromund Kaas",@"Yellow",581,796,@"Presence + 2",@"Unlocks Galactic History Entry #21",@"In the Spaceport Expanse. Follow the road that heads Southwest from the starport to its end.");
     addDatacron(@"dromund kaas #5",@"Empire",@"Datacron",@"Dromund Kaas",@"Orange",-1219,211,@"Cunning + 2",@"Unlocks Galactic History Entry #22",@"In the Dark Temple Approach. This Datacron is located on top of a rock. Head to -1089, 210 and climb the crates to jump up to the rock formation. Turn right to find and follow a path that leads to a vantage point over the datacron. Jump your way down to the datacron.");
    
    /*
     addDatacron(@"Ord Mantell #1",@"This Datacron is north of Mannett Point. It’s located on the beach on the very north side of the island. You simply have to run around the island on the beach to reach it. It’s guarded by a couple level 6 elite mobs and a level 7 named mob.",@"Matrix Shard",@"Ord Mantell",@"Red",778,134,MODIFIER_NONE,@"Galactic History Entry #14");
     
     addDatacron(@"Ord Mantell #2",@"This Datacron is located on peak in the center of Savrip Island. You should be able to see the Datacron from the beach when you fist arrive onto the island. Run up the beach and follow the fork to the left. A little ways down on the right hand side you will find an area where you can very easily start jumping up the rocks.",@"Datacron",@"Ord Mantell",@"White",-657,575,@"Aim + 2",@"Galactic History Entry #12");
     
     addDatacron(@"Ord Mantell #3",@"This Datacron is located just west of the Volcano on the beach. If you follow the beach from the Volcano Camp you will eventually run right into this Datacron. It’s very easy to get.",@"Datacron",@"Ord Mantell",@"Yellow",-975,203,@"Presence + 2",@"Galactic History Entry #13");
     
     */
}
-(IBAction)aggregate:(id)sender
{
    SWTOR_Guide_Content_AggregatorAppDelegate* delegate = [SWTOR_Guide_Content_AggregatorAppDelegate delegate];
    moc = [delegate managedObjectContext];
    //
    ships = [NSMutableDictionary new];
    classes = [NSMutableDictionary new];
    skillTrees = [NSMutableDictionary new];
    locations = [NSMutableDictionary new];
    races = [NSMutableDictionary new];
    
    [self addClasses];
    [self addLocations];
    [self addPlanets];
    [self addShips];
    [self addRacesAndClasses];
    [self addCompanions];
    [self addFlashpoints];
    [self addWarzones];
    [self addOperations];
    [self addSkillTrees];
    [self addCharacterSkills];
    [self addCraftingSkill];
    [self addDatacron];
    
    NSError* error = nil;
    
    [moc save:&error];
    NSLog(@"%@",error);
}
@end

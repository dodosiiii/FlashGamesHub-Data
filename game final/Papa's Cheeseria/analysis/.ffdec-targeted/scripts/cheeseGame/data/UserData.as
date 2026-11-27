package cheeseGame.data
{
   import flash.events.*;
   import flash.net.*;
   import package_2.*;
   import package_4.class_5;
   
   public class UserData
   {
      
      public var gameObj:class_5;
      
      public var saveSlotPrefix:String = "papascheeseria";
      
      public var saveSlotVersion:String = "1.0";
      
      public var saveSlotMaxSize:Number = 102400;
      
      public var so:SharedObject = null;
      
      public var lastMonthSeen:Number = 0;
      
      public var ranksPerMonth:Number = 5;
      
      public var papaReturnsOnDay:Number = 100;
      
      public var playedALevel:Boolean = false;
      
      public var playedLevelsToday:Number = 0;
      
      public var myRank:Number = 1;
      
      public var myName:String = "Anonymous";
      
      public var whichCharacter:String = "marty";
      
      public var waiterName:String = "Waiter";
      
      public var whichWaiter:String = "custom";
      
      public var lastRibbon:Number = 0;
      
      public var ribbonDaysActive:Number = 3;
      
      public var totalMoneyEarned:Number = 0;
      
      public var totalTicketsEarned:Number = 0;
      
      public var totalScore:Number = 0;
      
      public var totalTips:Number = 0;
      
      public var totalTickets:Number = 0;
      
      public var currentDay:Number = 1;
      
      public var todayScore:Number = 0;
      
      public var todayTickets:Number = 0;
      
      public var todayNaturalTickets:Number = 0;
      
      public var todayTips:Number = 0;
      
      public var todayWaitScore:Number = 0;
      
      public var todayCookScore:Number = 0;
      
      public var todayBuildScore:Number = 0;
      
      public var todayFryScore:Number = 0;
      
      public var todayCustomers:Number = 0;
      
      public var todayMeterTopping:Number = 0;
      
      public var customersUnlocked:Array;
      
      public var customerStars:Array;
      
      public var customerSeals:Array;
      
      public var customerVisits:Array;
      
      public var customerFirstVisit:Array;
      
      public var didShowParade:Boolean = false;
      
      public var seenFloatsInParade:Number = 0;
      
      public var didClickTwitter:Boolean = false;
      
      public var didClickFacebook:Boolean = false;
      
      public var trainingFlagNames:Array;
      
      public var trainingFlags:Array;
      
      public var hasContinuedGame:Boolean = false;
      
      public var hasVisitedUpgradeShop:Boolean = false;
      
      public var hasVisitedLobbyEditor:Boolean = false;
      
      public var hasPlacedFurniture:Boolean = false;
      
      public var hasVisitedBadgesScreen:Boolean = false;
      
      public var didCreateWaiter:Boolean = false;
      
      public var initialCustomers:Number = 6;
      
      public var fillerCustomers:Number = 5;
      
      public var spacedCustomers:Number = 4;
      
      public var closerCustomers:Number = 7;
      
      public var toppingsUnlocked:Array;
      
      public var toppingsRevealed:Array;
      
      public var toppingIndexes:Array;
      
      public var toppingNames:Array;
      
      public var initialToppings:Number = 9;
      
      public var totalBonuses:Number = 13;
      
      public var bonusUpgrades:Array;
      
      public var furniInventory:Array;
      
      public var lobbyPlacement:Array;
      
      public var furniSorting:String = "newest";
      
      public var lobbyWallpaper:Number = 1;
      
      public var lobbyFlooring:Number = 1;
      
      public var lobbyTrim:uint = 3223857;
      
      public var lobbyTop:uint = 65325;
      
      public var defaultLobbyTrim:uint = 3223857;
      
      public var defaultLobbyTop:uint = 65325;
      
      public var clothingInventory:Array;
      
      public var hasNewClothing:Boolean = false;
      
      public var hasNewFurni:Boolean = false;
      
      public var hasNewClothingTypes:Array;
      
      public var rankTitles:Array;
      
      public var rankPlateauLimit:Number = 14;
      
      public var rankMultiplier:Number = 130;
      
      public var lastRankLimit:Number = 0;
      
      public var baseWeeklyWage:Number = 10000;
      
      public var wageIncreasePerRank:Number = 500;
      
      public var whichSlot:Number = 1;
      
      public var medalsEarned:Array;
      
      public var medalProgress:Array;
      
      public var numberOfMinigames:Number = 7;
      
      public var minigamesPlayed:Array;
      
      public var minigamePrizes:Array;
      
      public var specialsOwned:Array;
      
      public var specialFromCustomer:Array;
      
      public var specialsServed:Array;
      
      public var specialStars:Array;
      
      public var specialsViewed:Array;
      
      public var currentSpecial:Number = -1;
      
      public var lastDaySpecialEarned:Number = 0;
      
      public var showSpecialSign:Number = 1;
      
      public var starsToMasterSpecial:Number = 5;
      
      public var randomSeed:Number = 56789;
      
      public function UserData(param1:class_5)
      {
         this.customersUnlocked = [];
         this.customerStars = [];
         this.customerSeals = [];
         this.customerVisits = [];
         this.customerFirstVisit = [];
         this.trainingFlagNames = ["boost","closer","critic","ribbon","decorate","inventory","poster","furni","ticket","season","toptrim","lobbypoints","minigame","server","santa","clothingbonus","bringspecial","openspecial","cheatsheet","listspecial","setspecial","bonusspecial","curlyfries","saucefries","baconfries","pausefries","dropfries","alarm","light","welldone"];
         this.trainingFlags = [];
         this.toppingsUnlocked = [];
         this.toppingsRevealed = [];
         this.toppingIndexes = [];
         this.toppingNames = [];
         this.bonusUpgrades = [];
         this.furniInventory = [];
         this.lobbyPlacement = [];
         this.clothingInventory = [];
         this.hasNewClothingTypes = [];
         this.rankTitles = ["!","Newbie","Chicken Champ","Buffalo Buddy","Focaccia Fan","Gouda Guru","BBQ Boss","Chorizo Champ","Oaxaca Wrangler","Jalapeño Pal","Southwesterner","Pepper Pro","Pineapple Fan","Hawaiian Hero","Pork Pal","Waffle Wrangler","Pumpernickel Pro","Brisket Buddy","Cheddar Champ","Chili Slinger","Provolone Pal","Onion Lover","Meatball Master","Ricotta Fan","Salami Slicer","Ciabatta Buddy","Asiago Fan","Early Riser","Maple Master","Egg Cracker","Rosemary Wrangler","Philly Fan","Slaw Slinger","Muenster Master","Lobster Lover","Sour Cream Fan","Onion Wrangler","Stuffing Server","Cheese Ball Buddy","Sweet Potato Pro","Awesome Saucer","Havarti Hero","Goose Guru","Ginger Spicer","Corned Beef Buddy","Bread Slicer","Mushroom Master","Macaroni Champ","Gruyere Guru","Pickle Pro","Chive Champion","Honey Master","Tomato Topper","Windsor Wrangler","Pretzel Pro","Crinkle Cutter","Nacho Natural","Hash Hero","Derby Server","Sauerkrauter","Gorgonzola Guru","Special Seasoner","Egg Pickler","Sirecz Server"
         ,"Olive Expert","Balsamic Buddy","Better Than Papa!"];
         this.medalsEarned = [];
         this.medalProgress = [];
         this.minigamesPlayed = [0,0,0,0,0,0,0];
         this.minigamePrizes = [0,0,0,0,0,0,0];
         this.specialsOwned = [];
         this.specialFromCustomer = [];
         this.specialsServed = [];
         this.specialStars = [];
         this.specialsViewed = [];
         super();
         var _loc2_:UserData = this;
         _loc2_.gameObj = param1;
         _loc2_.setupToppingIndexes();
      }
      
      public function loadData(param1:Number) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:UserData = this;
         _loc7_.whichSlot = param1;
         _loc7_.gameObj.var_142.resetAllTallies();
         _loc7_.so = SharedObject.getLocal(this.saveSlotPrefix + param1,"/");
         if(this.so.data.rank)
         {
            class_7.debug("Load from Existing Slot " + param1);
            _loc7_.myRank = this.so.data.rank;
            _loc7_.totalScore = this.so.data.score;
            _loc7_.totalTips = this.so.data.tips;
            _loc7_.currentDay = this.so.data.day;
            _loc7_.myName = this.so.data.playername;
            if(this.so.data.allmoney)
            {
               _loc7_.totalMoneyEarned = this.so.data.allmoney;
            }
            else
            {
               _loc7_.totalMoneyEarned = _loc7_.totalTips;
            }
            if(this.so.data.character)
            {
               _loc7_.whichCharacter = this.so.data.character;
            }
            else
            {
               _loc7_.whichCharacter = "marty";
            }
            if(this.so.data.waiter)
            {
               _loc7_.whichWaiter = this.so.data.waiter;
            }
            else
            {
               _loc7_.whichWaiter = "custom";
            }
            if(this.so.data.waitername)
            {
               _loc7_.waiterName = this.so.data.waitername;
            }
            else
            {
               _loc7_.waiterName = "Waiter";
            }
            if(this.so.data.didcreatewaiter)
            {
               _loc7_.didCreateWaiter = this.so.data.didcreatewaiter;
            }
            else
            {
               _loc7_.didCreateWaiter = false;
            }
            if(this.so.data.bonuses)
            {
               _loc7_.bonusUpgrades = this.so.data.bonuses.concat();
               _loc2_ = _loc7_.bonusUpgrades.length;
               if(_loc7_.bonusUpgrades.length < _loc7_.totalBonuses + 1)
               {
                  _loc3_ = _loc2_;
                  while(_loc3_ <= _loc7_.totalBonuses)
                  {
                     _loc7_.bonusUpgrades.push(0);
                     _loc3_++;
                  }
               }
            }
            else
            {
               _loc7_.bonusUpgrades = [];
               _loc4_ = 0;
               while(_loc4_ <= _loc7_.totalBonuses)
               {
                  _loc7_.bonusUpgrades.push(0);
                  _loc4_++;
               }
            }
            if(this.so.data.inventory)
            {
               _loc7_.furniInventory = class_19.method_120(this.so.data.inventory);
            }
            else
            {
               _loc7_.furniInventory = [];
            }
            if(this.so.data.furnisorting)
            {
               _loc7_.furniSorting = this.so.data.furnisorting;
            }
            else
            {
               _loc7_.furniSorting = "newest";
            }
            if(this.so.data.lobby)
            {
               _loc7_.lobbyPlacement = class_19.method_120(this.so.data.lobby);
            }
            else
            {
               _loc7_.lobbyPlacement = [];
            }
            if(this.so.data.wallpaper)
            {
               _loc7_.lobbyWallpaper = this.so.data.wallpaper;
            }
            else
            {
               _loc7_.lobbyWallpaper = 1;
            }
            if(this.so.data.flooring)
            {
               _loc7_.lobbyFlooring = this.so.data.flooring;
            }
            else
            {
               _loc7_.lobbyFlooring = 1;
            }
            if(this.so.data.lobbytrim)
            {
               _loc7_.lobbyTrim = this.so.data.lobbytrim;
            }
            else
            {
               _loc7_.lobbyTrim = _loc7_.defaultLobbyTrim;
            }
            if(this.so.data.lobbytop)
            {
               _loc7_.lobbyTop = this.so.data.lobbytop;
            }
            else
            {
               _loc7_.lobbyTop = _loc7_.defaultLobbyTop;
            }
            if(this.so.data.toppings)
            {
               _loc7_.toppingsUnlocked = this.so.data.toppings.concat();
            }
            else
            {
               _loc7_.setupDefaultToppingData();
            }
            if(this.so.data.toppingsrevealed)
            {
               _loc7_.toppingsRevealed = this.so.data.toppingsrevealed.concat();
            }
            else
            {
               _loc7_.toppingsRevealed = _loc7_.toppingsUnlocked.concat();
            }
            if(this.so.data.minigamesPlayed)
            {
               _loc7_.minigamesPlayed = this.so.data.minigamesPlayed.concat();
            }
            else
            {
               _loc7_.minigamesPlayed = [0,0,0,0,0,0,0];
            }
            if(this.so.data.minigamePrizes)
            {
               _loc7_.minigamePrizes = this.so.data.minigamePrizes.concat();
            }
            else
            {
               _loc7_.minigamePrizes = [0,0,0,0,0,0,0];
            }
            if(this.so.data.specialStars)
            {
               _loc7_.specialStars = this.so.data.specialStars.concat();
            }
            if(this.so.data.specialsServed)
            {
               _loc7_.specialsServed = this.so.data.specialsServed.concat();
            }
            if(this.so.data.specialFromCustomer)
            {
               _loc7_.specialFromCustomer = this.so.data.specialFromCustomer.concat();
            }
            if(this.so.data.specialsViewed)
            {
               _loc7_.specialsViewed = this.so.data.specialsViewed.concat();
            }
            if(this.so.data.specialsOwned)
            {
               _loc7_.specialsOwned = this.so.data.specialsOwned.concat();
            }
            else
            {
               _loc7_.setupDefaultSpecialData();
            }
            if(this.so.data.currentSpecial)
            {
               _loc7_.currentSpecial = this.so.data.currentSpecial;
            }
            else if(this.so.data.currentSpecial === 0)
            {
               _loc7_.currentSpecial = this.so.data.currentSpecial;
            }
            else
            {
               _loc7_.currentSpecial = -1;
            }
            if(this.so.data.lastDaySpecialEarned)
            {
               _loc7_.lastDaySpecialEarned = this.so.data.lastDaySpecialEarned;
            }
            else
            {
               _loc7_.lastDaySpecialEarned = 0;
            }
            if(this.so.data.showSpecialSign === 0)
            {
               _loc7_.showSpecialSign = 0;
            }
            else
            {
               _loc7_.showSpecialSign = 1;
            }
            if(this.so.data.ribbon)
            {
               _loc7_.lastRibbon = this.so.data.ribbon;
            }
            else
            {
               _loc7_.lastRibbon = 0;
            }
            if(this.so.data.tickets)
            {
               _loc7_.totalTickets = this.so.data.tickets;
            }
            else
            {
               _loc7_.totalTickets = 0;
            }
            if(this.so.data.alltickets)
            {
               _loc7_.totalTicketsEarned = this.so.data.alltickets;
            }
            else
            {
               _loc7_.totalTicketsEarned = _loc7_.totalTickets;
            }
            _loc7_.lastRankLimit = _loc7_.getLastRankLimit();
            if(this.so.data.lastmonth)
            {
               _loc7_.lastMonthSeen = this.so.data.lastmonth;
            }
            else
            {
               _loc7_.lastMonthSeen = 0;
            }
            _loc7_.customersUnlocked = this.so.data.unlocked.concat();
            _loc7_.customerStars = this.so.data.stars.concat();
            _loc7_.customerSeals = this.so.data.seals.concat();
            _loc7_.customerVisits = this.so.data.visits.concat();
            _loc7_.customerFirstVisit = this.so.data.first.concat();
            if(this.so.data.workerdata)
            {
               _loc7_.gameObj.workerData.populateWorkerData(this.so.data.workerdata);
            }
            else if(_loc7_.whichCharacter == "marty")
            {
               _loc7_.gameObj.workerData.setupPremadeMale();
            }
            else if(_loc7_.whichCharacter == "rita")
            {
               _loc7_.gameObj.workerData.setupPremadeFemale();
            }
            else
            {
               class_7.error("Could not load previously-saved custom worker data.");
               _loc7_.gameObj.workerData.setupDefaults();
            }
            if(this.so.data.waiterdata)
            {
               _loc7_.gameObj.var_151.populateWorkerData(this.so.data.waiterdata);
            }
            else if(_loc7_.whichWaiter == "marty")
            {
               _loc7_.gameObj.var_151.setupPremadeMale();
            }
            else if(_loc7_.whichWaiter == "rita")
            {
               _loc7_.gameObj.var_151.setupPremadeFemale();
            }
            else
            {
               class_7.error("Could not load previously-saved custom waiter data.");
               _loc7_.gameObj.var_151.setupDefaults();
            }
            if(this.so.data.clothinginventory)
            {
               _loc7_.clothingInventory = this.so.data.clothinginventory.concat();
            }
            else
            {
               class_7.method_1("Could not find clothing inventory on save slot!  Generate a fresh batch.");
               _loc7_.clothingInventory = _loc7_.gameObj.var_135.getSKUsForInventory(_loc7_.whichCharacter,_loc7_.gameObj.workerData.gender);
            }
            if(this.so.data.medalsEarned)
            {
               _loc7_.medalsEarned = this.so.data.medalsEarned.concat();
            }
            else
            {
               _loc7_.medalsEarned = [];
            }
            if(this.so.data.medalProgress)
            {
               _loc7_.medalProgress = this.so.data.medalProgress.concat();
            }
            else
            {
               _loc7_.medalProgress = [];
            }
            if(this.so.data.hasnewclothing)
            {
               _loc7_.hasNewClothing = this.so.data.hasnewclothing;
            }
            else
            {
               _loc7_.hasNewClothing = false;
            }
            if(this.so.data.hasnewclothingtypes)
            {
               _loc7_.hasNewClothingTypes = this.so.data.hasnewclothingtypes.concat();
            }
            else
            {
               _loc7_.hasNewClothingTypes = [];
            }
            if(this.so.data.hasnewfurni)
            {
               _loc7_.hasNewFurni = this.so.data.hasnewfurni;
            }
            else
            {
               _loc7_.hasNewFurni = false;
            }
            if(this.so.data.trainingflags)
            {
               _loc7_.trainingFlags = this.so.data.trainingflags.concat();
               _loc5_ = _loc7_.trainingFlags.length;
               if(_loc7_.trainingFlags.length < _loc7_.trainingFlagNames.length)
               {
                  class_7.method_1("(Added some training flags since last save. Update this progress array.)");
                  _loc6_ = _loc5_;
                  while(_loc6_ < _loc7_.trainingFlagNames.length)
                  {
                     _loc7_.trainingFlags.push(0);
                     _loc6_++;
                  }
               }
            }
            else
            {
               _loc7_.trainingFlags = [];
            }
            if(this.so.data.continuedgame)
            {
               _loc7_.hasContinuedGame = true;
            }
            else
            {
               _loc7_.hasContinuedGame = true;
            }
            if(this.so.data.shownparade)
            {
               _loc7_.didShowParade = this.so.data.shownparade;
            }
            else
            {
               _loc7_.didShowParade = false;
            }
            if(this.so.data.floatsparade)
            {
               _loc7_.seenFloatsInParade = this.so.data.floatsparade;
            }
            else
            {
               _loc7_.seenFloatsInParade = 0;
            }
            if(this.so.data.clicktwitter)
            {
               _loc7_.didClickTwitter = this.so.data.clicktwitter;
            }
            else
            {
               _loc7_.didClickTwitter = false;
            }
            if(this.so.data.clickfacebook)
            {
               _loc7_.didClickFacebook = this.so.data.clickfacebook;
            }
            else
            {
               _loc7_.didClickFacebook = false;
            }
            if(this.so.data.visitedshop)
            {
               _loc7_.hasVisitedUpgradeShop = this.so.data.visitedshop;
            }
            else
            {
               _loc7_.hasVisitedUpgradeShop = false;
            }
            if(this.so.data.visitedbadges)
            {
               _loc7_.hasVisitedBadgesScreen = this.so.data.visitedbadges;
            }
            else
            {
               _loc7_.hasVisitedBadgesScreen = false;
            }
            if(this.so.data.visitedlobby)
            {
               _loc7_.hasVisitedLobbyEditor = this.so.data.visitedlobby;
            }
            else
            {
               _loc7_.hasVisitedLobbyEditor = false;
            }
            if(this.so.data.placedfurni)
            {
               _loc7_.hasPlacedFurniture = this.so.data.placedfurni;
            }
            else
            {
               _loc7_.hasPlacedFurniture = false;
            }
            while(_loc7_.customersUnlocked.length - 1 < _loc7_.gameObj.var_130.getCustomerTotal())
            {
               _loc7_.customersUnlocked.push(0);
            }
            while(_loc7_.customerStars.length - 1 < _loc7_.gameObj.var_130.getCustomerTotal())
            {
               _loc7_.customerStars.push(0);
            }
            while(_loc7_.customerSeals.length - 1 < _loc7_.gameObj.var_130.getCustomerTotal())
            {
               _loc7_.customerSeals.push(0);
            }
            while(_loc7_.customerVisits.length - 1 < _loc7_.gameObj.var_130.getCustomerTotal())
            {
               _loc7_.customerVisits.push(0);
            }
            while(_loc7_.customerFirstVisit.length - 1 < _loc7_.gameObj.var_130.getCustomerTotal())
            {
               _loc7_.customerFirstVisit.push(0);
            }
         }
         else
         {
            class_7.error("No Existing Slot even though it thought there was, Create New Slot");
            _loc7_.createNewSlot(param1,"Nameless","marty");
         }
         _loc7_.gameObj.var_142.populateMedalProgress(_loc7_.medalProgress);
         _loc7_.clearScoresForToday();
         _loc7_.gameObj.var_132.method_156();
      }
      
      public function createNewSlot(param1:Number, param2:String, param3:String = "marty") : void
      {
         var _loc4_:UserData = null;
         _loc4_ = this;
         _loc4_.gameObj.var_142.resetAllTallies();
         if(param2 == "" || param2 == " " || param2 == "  ")
         {
            if(param3 == "marty")
            {
               param2 = "Rudy";
            }
            else
            {
               param2 = "Scarlett";
            }
         }
         _loc4_.whichSlot = param1;
         class_7.method_1("Create New Slot: " + param1);
         _loc4_.myRank = 1;
         _loc4_.totalScore = 0;
         _loc4_.totalTips = 0;
         _loc4_.totalTickets = 0;
         _loc4_.totalMoneyEarned = 0;
         _loc4_.totalTicketsEarned = 0;
         _loc4_.lastRankLimit = 0;
         _loc4_.currentDay = 1;
         _loc4_.myName = param2;
         _loc4_.whichCharacter = param3;
         _loc4_.hasNewClothing = true;
         _loc4_.lastMonthSeen = 0;
         if(param3 == "marty")
         {
            _loc4_.hasNewClothingTypes = [ClothingItem.TYPE_SHIRT,ClothingItem.TYPE_JACKET,ClothingItem.TYPE_PANTS,ClothingItem.TYPE_ACC_BELT,ClothingItem.TYPE_SHOES];
         }
         else if(param3 == "rita")
         {
            _loc4_.hasNewClothingTypes = [ClothingItem.TYPE_SHIRT,ClothingItem.TYPE_JACKET,ClothingItem.TYPE_ACC_BELT,ClothingItem.TYPE_PANTS,ClothingItem.TYPE_ACC_ARMS];
         }
         else
         {
            _loc4_.hasNewClothingTypes = [ClothingItem.TYPE_ACC_FACE];
         }
         _loc4_.didCreateWaiter = false;
         _loc4_.whichWaiter = "custom";
         _loc4_.waiterName = "Waiter";
         _loc4_.hasNewFurni = false;
         _loc4_.hasContinuedGame = false;
         _loc4_.hasVisitedUpgradeShop = false;
         _loc4_.hasVisitedLobbyEditor = false;
         _loc4_.hasPlacedFurniture = false;
         _loc4_.didShowParade = false;
         _loc4_.seenFloatsInParade = 0;
         _loc4_.didClickFacebook = false;
         _loc4_.didClickTwitter = false;
         _loc4_.lastRibbon = 0;
         _loc4_.bonusUpgrades = [];
         _loc4_.furniInventory = [];
         _loc4_.furniSorting = "newest";
         _loc4_.clothingInventory = [];
         _loc4_.lobbyPlacement = [];
         _loc4_.lobbyTrim = _loc4_.defaultLobbyTrim;
         _loc4_.lobbyTop = _loc4_.defaultLobbyTop;
         _loc4_.medalsEarned = [];
         _loc4_.medalProgress = [];
         _loc4_.minigamesPlayed = [0,0,0,0,0,0,0];
         _loc4_.minigamePrizes = [0,0,0,0,0,0,0];
         _loc4_.lastDaySpecialEarned = 0;
         _loc4_.showSpecialSign = 1;
         _loc4_.currentSpecial = -1;
         var _loc5_:Number = 0;
         while(_loc5_ <= _loc4_.totalBonuses)
         {
            _loc4_.bonusUpgrades.push(0);
            _loc5_++;
         }
         if(param3 == "marty")
         {
            _loc4_.gameObj.workerData.setupPremadeMale();
            _loc4_.clothingInventory = _loc4_.gameObj.var_135.getSKUsForInventory(param3,WorkerData.GENDER_MALE);
         }
         else if(param3 == "rita")
         {
            _loc4_.gameObj.workerData.setupPremadeFemale();
            _loc4_.clothingInventory = _loc4_.gameObj.var_135.getSKUsForInventory(param3,WorkerData.GENDER_FEMALE);
         }
         else
         {
            _loc4_.clothingInventory = _loc4_.gameObj.var_135.getSKUsForInventory("custom",_loc4_.gameObj.workerData.gender);
         }
         _loc4_.gameObj.var_151.setupDefaults();
         _loc4_.furniInventory.push(["wall1",0,1,1,0]);
         _loc4_.furniInventory.push(["floor1",0,1,1,0]);
         _loc4_.lobbyWallpaper = 1;
         _loc4_.lobbyFlooring = 1;
         _loc4_.setupDefaultCustomerData();
         _loc4_.setupDefaultToppingData();
         _loc4_.setupDefaultSpecialData();
         _loc4_.so = SharedObject.getLocal(this.saveSlotPrefix + param1,"/");
         this.so.data.playername = _loc4_.myName;
         this.so.data.rank = _loc4_.myRank;
         this.so.data.day = _loc4_.currentDay;
         this.so.data.score = _loc4_.totalScore;
         this.so.data.tips = _loc4_.totalTips;
         this.so.data.tickets = _loc4_.totalTickets;
         this.so.data.allmoney = _loc4_.totalMoneyEarned;
         this.so.data.alltickets = _loc4_.totalTicketsEarned;
         this.so.data.character = _loc4_.whichCharacter;
         this.so.data.continuedgame = false;
         this.so.data.visitedshop = false;
         this.so.data.visitedbadges = false;
         this.so.data.shownparade = false;
         this.so.data.floatsparade = 0;
         this.so.data.clicktwitter = false;
         this.so.data.clickfacebook = false;
         this.so.data.lastmonth = _loc4_.lastMonthSeen;
         this.so.data.hasnewfurni = false;
         this.so.data.hasnewclothing = _loc4_.hasNewClothing;
         this.so.data.hasnewclothingtypes = _loc4_.hasNewClothingTypes.concat();
         this.so.data.workerdata = _loc4_.gameObj.workerData.getDataToSave();
         this.so.data.waiterdata = _loc4_.gameObj.var_151.getDataToSave();
         this.so.data.waiter = _loc4_.whichWaiter;
         this.so.data.waitername = _loc4_.waiterName;
         this.so.data.didcreatewaiter = false;
         this.so.data.unlocked = _loc4_.customersUnlocked.concat();
         this.so.data.stars = _loc4_.customerStars.concat();
         this.so.data.seals = _loc4_.customerSeals.concat();
         this.so.data.visits = _loc4_.customerVisits.concat();
         this.so.data.first = _loc4_.customerFirstVisit.concat();
         this.so.data.toppings = _loc4_.toppingsUnlocked.concat();
         this.so.data.toppingsrevealed = _loc4_.toppingsRevealed.concat();
         this.so.data.bonuses = _loc4_.bonusUpgrades.concat();
         this.so.data.ribbon = _loc4_.lastRibbon;
         this.so.data.inventory = class_19.method_120(_loc4_.furniInventory);
         this.so.data.lobby = class_19.method_120(_loc4_.lobbyPlacement);
         this.so.data.wallpaper = _loc4_.lobbyWallpaper;
         this.so.data.flooring = _loc4_.lobbyFlooring;
         this.so.data.lobbytrim = _loc4_.lobbyTrim;
         this.so.data.lobbytop = _loc4_.lobbyTop;
         this.so.data.furnisorting = _loc4_.furniSorting;
         this.so.data.clothinginventory = _loc4_.clothingInventory.concat();
         this.so.data.medalsEarned = [];
         this.so.data.medalProgress = [];
         this.so.data.minigamesPlayed = _loc4_.minigamesPlayed.concat();
         this.so.data.minigamePrizes = _loc4_.minigamePrizes.concat();
         _loc4_.trainingFlags = [];
         this.so.data.trainingflags = _loc4_.trainingFlags.concat();
         this.so.data.specialsOwned = _loc4_.specialsOwned.concat();
         this.so.data.specialsViewed = _loc4_.specialsViewed.concat();
         this.so.data.specialsServed = _loc4_.specialsServed.concat();
         this.so.data.specialFromCustomer = _loc4_.specialFromCustomer.concat();
         this.so.data.specialStars = _loc4_.specialStars.concat();
         this.so.data.currentSpecial = _loc4_.currentSpecial;
         this.so.data.lastDaySpecialEarned = _loc4_.lastDaySpecialEarned;
         this.so.data.showSpecialSign = _loc4_.showSpecialSign;
         _loc4_.flushSaveSlot();
         _loc4_.clearScoresForToday();
      }
      
      private function flushSaveSlot() : void
      {
         var ob:UserData = null;
         ob = null;
         var flushStatus:String = null;
         ob = this;
         if(ob.so != null)
         {
            flushStatus = null;
            try
            {
               flushStatus = ob.so.flush(ob.saveSlotMaxSize);
            }
            catch(err:Error)
            {
               class_7.error("Error saving to Save Slot, may be disabled from saving.");
               ob.gameObj.var_132.api.method_128("Your computer won\'t let your progress be saved!  Right-click and choose \'Settings...\', then choose \'Unlimited\'.");
            }
            if(flushStatus != null)
            {
               switch(flushStatus)
               {
                  case SharedObjectFlushStatus.PENDING:
                     ob.gameObj.var_132.api.method_128("You need to Allow this site to save your game progress in the pop-up.");
                     class_7.info("Asking the player to increase storage size...");
                     ob.so.addEventListener(NetStatusEvent.NET_STATUS,ob.onFlushStatus);
                     break;
                  case SharedObjectFlushStatus.FLUSHED:
                     ob.gameObj.var_132.api.method_130();
                     class_7.info("Saved.");
               }
            }
         }
         else
         {
            class_7.error("Trying to Flush/Save, but there\'s no save slot!");
         }
      }
      
      public function onFlushStatus(param1:NetStatusEvent) : void
      {
         var _loc2_:UserData = this;
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
               class_7.info("Granted Permission to Save, data will now save.");
               _loc2_.gameObj.var_132.api.method_130();
               break;
            case "SharedObject.Flush.Failed":
               _loc2_.gameObj.var_132.api.method_128("Your game progress will not be saved!");
               class_7.info("Denied Permission to Save, no progress will be saved!");
         }
         _loc2_.so.removeEventListener(NetStatusEvent.NET_STATUS,_loc2_.onFlushStatus);
      }
      
      private function cheatLevelUp(param1:Number, param2:Number = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:UserData = this;
         _loc6_.myRank = 1;
         _loc6_.totalScore = 0;
         _loc6_.lastRankLimit = 0;
         _loc6_.currentDay = 1;
         _loc6_.unlockCustomerAndTopping(false,true);
         if(param1 > 1)
         {
            _loc3_ = 2;
            while(_loc3_ <= param1)
            {
               _loc6_.myRank = _loc3_;
               _loc6_.currentDay = _loc3_;
               _loc6_.lastRankLimit = _loc6_.getLastRankLimit();
               _loc6_.totalScore = _loc6_.lastRankLimit + 1;
               _loc5_ = false;
               if(_loc3_ < param1)
               {
                  _loc5_ = true;
               }
               _loc6_.unlockCustomerAndTopping(true,_loc5_);
               _loc3_++;
            }
            _loc4_ = 0;
            while(_loc4_ < 30)
            {
               ++_loc6_.currentDay;
               _loc6_.unlockCustomerAndTopping(false,true);
               _loc4_++;
            }
         }
      }
      
      public function eraseSlot(param1:Number) : void
      {
         var _loc2_:SharedObject = SharedObject.getLocal(this.saveSlotPrefix + param1,"/");
         _loc2_.clear();
      }
      
      public function setupDefaultSpecialData() : void
      {
         var _loc1_:UserData = this;
         var _loc2_:GameData = _loc1_.gameObj.var_133;
         _loc1_.specialsOwned = [];
         _loc1_.specialsViewed = [];
         _loc1_.specialsServed = [];
         _loc1_.specialFromCustomer = [];
         _loc1_.specialStars = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.specials.length)
         {
            _loc1_.specialsOwned.push(0);
            _loc1_.specialsViewed.push(0);
            _loc1_.specialsServed.push(0);
            _loc1_.specialFromCustomer.push(0);
            _loc1_.specialStars.push(0);
            _loc3_++;
         }
      }
      
      public function setupDefaultCustomerData() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:UserData = this;
         var _loc3_:CustomerData = _loc2_.gameObj.var_130;
         var _loc4_:GameData = _loc2_.gameObj.var_133;
         _loc2_.customersUnlocked = [0];
         _loc2_.customerSeals = [0];
         _loc2_.customerStars = [0];
         _loc2_.customerVisits = [0];
         _loc2_.customerFirstVisit = [0];
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.unlockArray.length)
         {
            if(_loc4_.unlockArray[_loc5_].type == "customer" || _loc4_.unlockArray[_loc5_].type == "filler")
            {
               _loc1_ = _loc3_.getCustomerIndex(_loc4_.unlockArray[_loc5_].tag);
               if(_loc1_ > -1)
               {
                  if(_loc4_.unlockArray[_loc5_].rank == 0 && _loc4_.unlockArray[_loc5_].type != "filler")
                  {
                     _loc2_.customersUnlocked[_loc1_] = 1;
                     _loc2_.customerFirstVisit[_loc1_] = 1;
                  }
                  else
                  {
                     _loc2_.customersUnlocked[_loc1_] = 0;
                     _loc2_.customerFirstVisit[_loc1_] = 0;
                  }
                  _loc2_.customerSeals[_loc1_] = 0;
                  _loc2_.customerStars[_loc1_] = 0;
                  _loc2_.customerVisits[_loc1_] = 0;
               }
               else
               {
                  class_7.error("Error with Default Customer Index: " + _loc4_.unlockArray[_loc5_].tag);
               }
            }
            _loc5_++;
         }
      }
      
      public function setupToppingIndexes() : void
      {
         var _loc1_:UserData = this;
         _loc1_.toppingIndexes = [];
         _loc1_.toppingNames = [];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.gameObj.var_133.unlockArray.length)
         {
            if(_loc1_.gameObj.var_133.unlockArray[_loc2_].type == "topping" || _loc1_.gameObj.var_133.unlockArray[_loc2_].type == "toppingfiller")
            {
               _loc1_.toppingIndexes.push(_loc1_.gameObj.var_133.unlockArray[_loc2_].tag);
               _loc1_.toppingNames.push(_loc1_.gameObj.var_133.unlockArray[_loc2_].title);
            }
            _loc2_++;
         }
      }
      
      public function setupDefaultToppingData() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:UserData = this;
         var _loc3_:GameData = _loc2_.gameObj.var_133;
         _loc2_.toppingsUnlocked = [];
         _loc2_.toppingsRevealed = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.unlockArray.length)
         {
            if(_loc3_.unlockArray[_loc4_].type == "topping" || _loc3_.unlockArray[_loc4_].type == "toppingfiller")
            {
               _loc1_ = _loc2_.toppingIndexes.indexOf(_loc3_.unlockArray[_loc4_].tag);
               if(_loc1_ > -1)
               {
                  if(_loc3_.unlockArray[_loc4_].rank == 0 && _loc3_.unlockArray[_loc4_].type == "topping")
                  {
                     _loc2_.toppingsUnlocked[_loc1_] = 1;
                     _loc2_.toppingsRevealed[_loc1_] = 1;
                  }
                  else
                  {
                     _loc2_.toppingsUnlocked[_loc1_] = 0;
                     _loc2_.toppingsRevealed[_loc1_] = 0;
                  }
               }
               else
               {
                  class_7.error("Error with default topping index: " + _loc3_.unlockArray[_loc4_].tag);
               }
            }
            _loc4_++;
         }
         _loc2_.gameObj.var_142.recordUnlockTopping();
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.trainingFlagNames.length)
         {
            _loc2_.trainingFlags.push(0);
            _loc5_++;
         }
      }
      
      public function getRank() : Number
      {
         var _loc1_:UserData = this;
         return _loc1_.myRank;
      }
      
      public function getRankTitle(param1:Number = -1) : String
      {
         var _loc2_:UserData = this;
         var _loc3_:String = "???";
         var _loc4_:Number = _loc2_.myRank;
         if(param1 > -1)
         {
            _loc4_ = param1;
         }
         if(_loc2_.rankTitles.length > _loc4_)
         {
            _loc3_ = _loc2_.rankTitles[_loc4_];
         }
         else
         {
            _loc3_ = _loc2_.rankTitles[_loc2_.rankTitles.length - 1];
         }
         return _loc3_;
      }
      
      public function getMeterAward(param1:String, param2:Boolean = false) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Number = 0;
         if(param1 == "awesome")
         {
            _loc8_ = 100;
         }
         else if(param1 == "great")
         {
            _loc8_ = 50;
         }
         else if(param1 == "good")
         {
            _loc8_ = 25;
         }
         if(param2)
         {
            _loc4_ = Math.floor(_loc8_ / 100);
            _loc5_ = _loc8_ - _loc4_ * 100;
            _loc6_ = String(_loc5_);
            if(_loc6_.length < 2)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc7_ = class_13.method_110(_loc4_);
            _loc3_ = "$" + _loc7_ + "." + _loc6_;
         }
         else
         {
            _loc3_ = _loc8_;
         }
         return _loc3_;
      }
      
      public function getWeeklyWage(param1:Boolean = false) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:UserData = this;
         var _loc8_:Number = _loc7_.baseWeeklyWage + _loc7_.wageIncreasePerRank * (_loc7_.myRank - 1);
         if(param1)
         {
            _loc3_ = Math.floor(_loc8_ / 100);
            _loc4_ = _loc8_ - _loc3_ * 100;
            _loc5_ = String(_loc4_);
            if(_loc5_.length < 2)
            {
               _loc5_ = "0" + _loc5_;
            }
            _loc6_ = class_13.method_110(_loc3_);
            _loc2_ = "$" + _loc6_ + "." + _loc5_;
         }
         else
         {
            _loc2_ = _loc8_;
         }
         return _loc2_;
      }
      
      public function getPaydayMessage(param1:Boolean = false) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:UserData = this;
         var _loc3_:* = "";
         _loc4_ = 7 - _loc2_.currentDay % 7;
         if(_loc4_ == 0 || _loc4_ == 7)
         {
            if(param1)
            {
               _loc3_ = "Payday! " + _loc2_.getWeeklyWage(true);
            }
            else
            {
               _loc3_ = "Payday Today!";
            }
         }
         else if(_loc4_ == 1)
         {
            _loc3_ = "Payday in 1 Day!";
         }
         else
         {
            _loc3_ = "Payday in " + _loc4_ + " Days!";
         }
         return _loc3_;
      }
      
      public function isPayday() : Boolean
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = _loc1_.currentDay % 7;
         if(_loc2_ == 0)
         {
            return true;
         }
         return false;
      }
      
      public function alreadyEarnedCustomer(param1:Number) : Boolean
      {
         var _loc2_:UserData = this;
         if(_loc2_.customersUnlocked.length > param1 && _loc2_.customersUnlocked[param1] == 1 && _loc2_.customerFirstVisit.length > param1 && _loc2_.customerFirstVisit[param1] > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getCustomerStars(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         if(_loc2_.customerStars.length > param1)
         {
            return _loc2_.customerStars[param1];
         }
         return 0;
      }
      
      public function getCustomerSeal(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         if(_loc2_.customerSeals.length > param1)
         {
            return _loc2_.customerSeals[param1];
         }
         return 0;
      }
      
      public function getCustomerFirstDay(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         if(_loc2_.customerFirstVisit.length > param1)
         {
            return _loc2_.customerFirstVisit[param1];
         }
         return 0;
      }
      
      public function getCustomerTotalOrders(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         if(_loc2_.customerVisits.length > param1)
         {
            return _loc2_.customerVisits[param1];
         }
         return 0;
      }
      
      public function earnCustomerStar(param1:Number, param2:Number) : void
      {
         var _loc3_:UserData = this;
         _loc3_.customerStars[param1] = param2;
      }
      
      public function earnCustomerSeal(param1:Number, param2:Number) : void
      {
         var _loc3_:UserData = this;
         _loc3_.customerSeals[param1] = param2;
         _loc3_.gameObj.var_142.recordCustomerSeal(param2);
      }
      
      public function earnBlueRibbon() : void
      {
         var _loc1_:UserData = this;
         _loc1_.lastRibbon = _loc1_.currentDay;
         _loc1_.gameObj.var_142.recordRibbon();
      }
      
      public function hasRibbon() : Boolean
      {
         var _loc1_:UserData = this;
         var _loc2_:Boolean = false;
         if(_loc1_.lastRibbon > 0 && _loc1_.currentDay <= _loc1_.lastRibbon + _loc1_.ribbonDaysActive)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function clearScoresForToday() : void
      {
         var _loc1_:UserData = this;
         _loc1_.todayBuildScore = 0;
         _loc1_.todayCookScore = 0;
         _loc1_.todayFryScore = 0;
         _loc1_.todayWaitScore = 0;
         _loc1_.todayScore = 0;
         _loc1_.todayTips = 0;
         _loc1_.todayTickets = 0;
         _loc1_.todayNaturalTickets = 0;
         _loc1_.todayCustomers = 0;
         _loc1_.todayMeterTopping = 0;
      }
      
      public function addToCustomersToday(param1:Number) : void
      {
         var _loc2_:UserData = this;
         ++_loc2_.todayCustomers;
         if(_loc2_.customersUnlocked[param1] == 0)
         {
            _loc2_.customersUnlocked[param1] = 1;
         }
         if(_loc2_.customerFirstVisit[param1] == 0 || _loc2_.customerVisits[param1] == 0)
         {
            _loc2_.customerFirstVisit[param1] = _loc2_.currentDay;
         }
      }
      
      public function recordCustomerVisit(param1:Number) : void
      {
         var _loc2_:UserData = this;
         ++_loc2_.customerVisits[param1];
      }
      
      public function addToDailyScore(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0) : void
      {
         var _loc8_:UserData = this;
         _loc8_.todayWaitScore += param1;
         _loc8_.todayCookScore += param2;
         _loc8_.todayBuildScore += param3;
         _loc8_.todayFryScore += param4;
         _loc8_.todayScore += param5;
         _loc8_.todayTips += param6;
         _loc8_.todayTickets += param7;
         _loc8_.todayNaturalTickets += param7;
      }
      
      public function earnExtraDailyTicket(param1:Number = 1, param2:Boolean = false) : void
      {
         var _loc3_:UserData = this;
         _loc3_.todayTickets += param1;
         if(param2 == false)
         {
            _loc3_.todayNaturalTickets += param1;
         }
      }
      
      public function getTodayWaitingAverage() : Number
      {
         var _loc1_:UserData = this;
         return Math.floor(_loc1_.todayWaitScore / _loc1_.todayCustomers);
      }
      
      public function getTodayFriesAverage() : Number
      {
         var _loc1_:UserData = this;
         return Math.floor(_loc1_.todayFryScore / _loc1_.todayCustomers);
      }
      
      public function getTodayBuildAverage() : Number
      {
         var _loc1_:UserData = this;
         return Math.floor(_loc1_.todayBuildScore / _loc1_.todayCustomers);
      }
      
      public function getTodayCookAverage() : Number
      {
         var _loc1_:UserData = this;
         return Math.floor(_loc1_.todayCookScore / _loc1_.todayCustomers);
      }
      
      public function getTodayTotalAverage() : Number
      {
         var _loc1_:UserData = this;
         return Number(Math.floor((_loc1_.getTodayWaitingAverage() + _loc1_.getTodayBuildAverage() + _loc1_.getTodayCookAverage() + _loc1_.getTodayFriesAverage()) / 4));
      }
      
      public function getCurrentPercentQuality(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = _loc2_.todayWaitScore / param1;
         var _loc4_:Number = _loc2_.todayCookScore / param1;
         var _loc5_:Number = _loc2_.todayBuildScore / param1;
         var _loc6_:Number = _loc2_.todayFryScore / param1;
         return Number(Math.floor((_loc3_ + _loc5_ + _loc4_ + _loc6_) / 4));
      }
      
      public function getTodayTotalScore() : Number
      {
         var _loc1_:UserData = this;
         return _loc1_.todayScore;
      }
      
      public function getTotalPoints(param1:Boolean = false) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = _loc2_.totalScore;
         if(param1)
         {
            _loc3_ += _loc2_.todayScore;
         }
         return _loc3_;
      }
      
      public function getTipsToday(param1:Boolean = false) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:UserData = this;
         if(param1)
         {
            _loc3_ = _loc8_.todayTips;
            _loc4_ = Math.floor(_loc3_ / 100);
            _loc5_ = _loc3_ - _loc4_ * 100;
            _loc6_ = String(_loc5_);
            if(_loc6_.length < 2)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc7_ = class_13.method_110(_loc4_);
            _loc2_ = "$" + _loc7_ + "." + _loc6_;
         }
         else
         {
            _loc2_ = _loc8_.todayTips;
         }
         return _loc2_;
      }
      
      public function getTipsTotal(param1:Boolean = false, param2:Boolean = false) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:UserData = this;
         if(param1)
         {
            _loc4_ = _loc9_.totalTips;
            if(param2)
            {
               _loc4_ += _loc9_.todayTips;
            }
            _loc5_ = Math.floor(_loc4_ / 100);
            _loc6_ = _loc4_ - _loc5_ * 100;
            _loc7_ = String(_loc6_);
            if(_loc7_.length < 2)
            {
               _loc7_ = "0" + _loc7_;
            }
            _loc8_ = class_13.method_110(_loc5_);
            _loc3_ = "$" + _loc8_ + "." + _loc7_;
         }
         else
         {
            _loc3_ = _loc9_.totalTips;
            if(param2)
            {
               _loc3_ += _loc9_.todayTips;
            }
         }
         return _loc3_;
      }
      
      public function getTicketsTotal(param1:Boolean = false) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = _loc2_.totalTickets;
         if(param1)
         {
            _loc3_ += _loc2_.todayTickets;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function useTicket(param1:Number) : void
      {
         var _loc2_:UserData = this;
         _loc2_.totalTickets -= param1;
         if(_loc2_.totalTickets < 0)
         {
            _loc2_.totalTickets = 0;
         }
      }
      
      public function saveScores() : Number
      {
         var _loc1_:UserData = this;
         _loc1_.totalScore += _loc1_.todayScore;
         _loc1_.totalTips += _loc1_.todayTips;
         _loc1_.totalMoneyEarned += _loc1_.todayTips;
         _loc1_.totalTickets += _loc1_.todayTickets;
         _loc1_.totalTicketsEarned += _loc1_.todayTickets;
         var _loc2_:Number = Number(_loc1_.getNextRankLimit());
         if(_loc1_.totalScore >= _loc2_)
         {
            ++_loc1_.myRank;
            _loc1_.lastRankLimit = _loc2_;
            _loc1_.gameObj.var_142.recordRank(_loc1_.myRank);
            _loc1_.unlockCustomerAndTopping(true);
         }
         else
         {
            _loc1_.unlockCustomerAndTopping(false);
         }
         _loc1_.updateFurniFreshness();
         ++_loc1_.currentDay;
         _loc1_.clearScoresForToday();
         _loc1_.saveData();
         return _loc1_.myRank;
      }
      
      private function unlockCustomerAndTopping(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:* = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:UserData = this;
         var _loc10_:Vector.<UnlockData> = null;
         var _loc11_:Boolean = false;
         if(param1)
         {
            _loc10_ = _loc9_.gameObj.var_133.getUnlocksAtRank(_loc9_.myRank);
            class_7.info("Unlocks at Rank " + _loc9_.myRank + ": " + _loc10_.length);
            if(_loc10_.length == 0)
            {
               _loc10_ = _loc9_.gameObj.var_133.getUnlocksAtRank(_loc9_.myRank,true);
               _loc11_ = true;
               class_7.info("Possible Fillers: " + _loc10_.length);
            }
         }
         else if(_loc9_.currentDay == 1)
         {
            _loc10_ = _loc9_.gameObj.var_133.getUnlocksAtRank(1);
            class_7.info("Unlocks at Day Two: " + _loc10_.length);
         }
         else
         {
            _loc10_ = _loc9_.gameObj.var_133.getUnlocksAtRank(_loc9_.myRank,true);
            _loc11_ = true;
            class_7.info("Possible Fillers: " + _loc10_.length);
         }
         if(_loc10_ != null && _loc10_.length > 0)
         {
            if(_loc11_ == false)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_.length)
               {
                  if(_loc10_[_loc3_].type == "customer")
                  {
                     _loc4_ = _loc9_.gameObj.var_130.getCustomerIndex(_loc10_[_loc3_].tag);
                     if(_loc4_ > -1)
                     {
                        _loc9_.customersUnlocked[_loc4_] = 1;
                        if(param2)
                        {
                           _loc9_.customerFirstVisit[_loc4_] = _loc9_.currentDay;
                           _loc9_.customerVisits[_loc4_] = 1;
                        }
                        if(_loc9_.gameObj.var_130.getCustomerClipName(_loc4_) == "Santa")
                        {
                           class_7.method_1("Santa Starts with Silver");
                           _loc9_.customerSeals[_loc4_] = 2;
                        }
                        class_7.method_1("Unlock " + _loc10_[_loc3_].tag + " (" + _loc4_ + ")");
                     }
                     else
                     {
                        class_7.error("Could not find customer data for unlocking: " + _loc10_[_loc3_].tag);
                     }
                  }
                  else if(_loc10_[_loc3_].type == "topping")
                  {
                     _loc5_ = _loc9_.toppingIndexes.indexOf(_loc10_[_loc3_].tag);
                     if(_loc5_ > -1)
                     {
                        _loc9_.toppingsUnlocked[_loc5_] = 1;
                        if(param2)
                        {
                           _loc9_.toppingsRevealed[_loc5_] = 1;
                        }
                        class_7.method_1("Unlock " + _loc10_[_loc3_].tag + " (" + _loc5_ + ")");
                     }
                     else
                     {
                        class_7.error("Cound not find topping index for unlocking:" + _loc10_[_loc3_].tag);
                     }
                  }
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_.length)
               {
                  _loc6_ = _loc9_.gameObj.var_130.getCustomerIndex(_loc10_[_loc3_].tag);
                  if(_loc6_ > -1)
                  {
                     if(_loc9_.customersUnlocked[_loc6_] == 0)
                     {
                        _loc9_.customersUnlocked[_loc6_] = 1;
                        if(param2)
                        {
                           _loc9_.customerFirstVisit[_loc6_] = _loc9_.currentDay;
                           _loc9_.customerVisits[_loc6_] = 1;
                        }
                        if(_loc9_.gameObj.var_130.getCustomerClipName(_loc6_) == "Santa")
                        {
                           class_7.method_1("Santa Starts with Silver");
                           _loc9_.customerSeals[_loc6_] = 2;
                        }
                        class_7.method_1("Unlock Filler: " + _loc10_[_loc3_].tag + " (" + _loc6_ + ")");
                        break;
                     }
                  }
                  else
                  {
                     class_7.error("Could not find customer data for unlocking filler: " + _loc10_[_loc3_].tag);
                  }
                  _loc3_++;
               }
            }
         }
         _loc10_ = null;
         var _loc12_:Number = _loc9_.myRank;
         _loc12_ = _loc9_.myRank % (_loc9_.ranksPerMonth * 12);
         if(_loc12_ == 0)
         {
            _loc12_ = _loc9_.ranksPerMonth * 12;
         }
         if(_loc9_.isNewYear() && _loc12_ <= _loc9_.ranksPerMonth)
         {
            _loc12_ += _loc9_.ranksPerMonth * 12;
         }
         _loc10_ = _loc9_.gameObj.var_133.getFillerToppingsAtRank(_loc12_,param1);
         var _loc13_:Boolean = false;
         if(_loc10_ != null && _loc10_.length > 0)
         {
            _loc7_ = "Possible Filler Toppings at Rank " + _loc9_.myRank + " (" + _loc12_ + "): ";
            _loc3_ = 0;
            while(_loc3_ < _loc10_.length)
            {
               _loc7_ += _loc10_[_loc3_].tag + " (" + _loc10_[_loc3_].rank + " - " + _loc10_[_loc3_].maxRank + "), ";
               _loc3_++;
            }
            class_7.method_1(_loc7_);
            _loc3_ = 0;
            while(_loc3_ < _loc10_.length)
            {
               _loc8_ = _loc9_.toppingIndexes.indexOf(_loc10_[_loc3_].tag);
               if(_loc8_ > -1)
               {
                  if(_loc9_.toppingsUnlocked[_loc8_] == 0)
                  {
                     if(!_loc13_ || _loc10_[_loc3_].maxRank == _loc12_)
                     {
                        _loc9_.toppingsUnlocked[_loc8_] = 1;
                        if(param2)
                        {
                           _loc9_.toppingsRevealed[_loc8_] = 1;
                        }
                        class_7.method_1("Topping Filler Unlock " + _loc10_[_loc3_].tag + " (" + _loc8_ + "). Range " + _loc10_[_loc3_].rank + " - " + _loc10_[_loc3_].maxRank + ".");
                        _loc13_ = true;
                     }
                  }
               }
               else
               {
                  class_7.error("Could not find topping data for unlocking filler: " + _loc10_[_loc3_].tag);
               }
               _loc3_++;
            }
         }
      }
      
      public function saveCharacterData() : void
      {
         var _loc1_:UserData = this;
         if(_loc1_.so == null)
         {
            class_7.error("Saved data was missing for this character save.  Generating a new one.");
            _loc1_.so = SharedObject.getLocal(this.saveSlotPrefix + _loc1_.whichSlot,"/");
         }
         this.so.data.workerdata = _loc1_.gameObj.workerData.getDataToSave();
         this.so.data.waiterdata = _loc1_.gameObj.var_151.getDataToSave();
         this.so.data.waiter = _loc1_.whichWaiter;
         this.so.data.waitername = _loc1_.waiterName;
         this.so.data.didcreatewaiter = _loc1_.didCreateWaiter;
         this.so.data.playername = _loc1_.myName;
         this.so.data.hasnewclothing = _loc1_.hasNewClothing;
         this.so.data.hasnewclothingtypes = _loc1_.hasNewClothingTypes.concat();
         _loc1_.flushSaveSlot();
      }
      
      public function saveSpecialData() : void
      {
         var _loc1_:UserData = this;
         if(_loc1_.so == null)
         {
            class_7.error("Saved data was missing for this character save.  Generating a new one.");
            _loc1_.so = SharedObject.getLocal(this.saveSlotPrefix + _loc1_.whichSlot,"/");
         }
         this.so.data.specialsOwned = _loc1_.specialsOwned.concat();
         this.so.data.specialsViewed = _loc1_.specialsViewed.concat();
         this.so.data.specialsServed = _loc1_.specialsServed.concat();
         this.so.data.specialFromCustomer = _loc1_.specialFromCustomer.concat();
         this.so.data.specialStars = _loc1_.specialStars.concat();
         this.so.data.currentSpecial = _loc1_.currentSpecial;
         this.so.data.showSpecialSign = _loc1_.showSpecialSign;
         _loc1_.flushSaveSlot();
      }
      
      public function saveData() : void
      {
         var _loc1_:UserData = this;
         if(_loc1_.so == null)
         {
            class_7.error("Saved data was missing for this save.  Generating a new one.");
            _loc1_.so = SharedObject.getLocal(this.saveSlotPrefix + _loc1_.whichSlot,"/");
         }
         this.so.data.day = _loc1_.currentDay;
         this.so.data.rank = _loc1_.myRank;
         this.so.data.tips = _loc1_.totalTips;
         this.so.data.tickets = _loc1_.totalTickets;
         this.so.data.score = _loc1_.totalScore;
         this.so.data.allmoney = _loc1_.totalMoneyEarned;
         this.so.data.alltickets = _loc1_.totalTicketsEarned;
         this.so.data.lastmonth = _loc1_.lastMonthSeen;
         this.so.data.playername = _loc1_.myName;
         this.so.data.workerdata = _loc1_.gameObj.workerData.getDataToSave();
         this.so.data.waiterdata = _loc1_.gameObj.var_151.getDataToSave();
         this.so.data.waiter = _loc1_.whichWaiter;
         this.so.data.waitername = _loc1_.waiterName;
         this.so.data.didcreatewaiter = _loc1_.didCreateWaiter;
         this.so.data.unlocked = _loc1_.customersUnlocked.concat();
         this.so.data.stars = _loc1_.customerStars.concat();
         this.so.data.seals = _loc1_.customerSeals.concat();
         this.so.data.visits = _loc1_.customerVisits.concat();
         this.so.data.first = _loc1_.customerFirstVisit.concat();
         this.so.data.bonuses = _loc1_.bonusUpgrades.concat();
         this.so.data.ribbon = _loc1_.lastRibbon;
         this.so.data.inventory = class_19.method_120(_loc1_.furniInventory);
         this.so.data.lobby = class_19.method_120(_loc1_.lobbyPlacement);
         this.so.data.wallpaper = _loc1_.lobbyWallpaper;
         this.so.data.flooring = _loc1_.lobbyFlooring;
         this.so.data.lobbytrim = _loc1_.lobbyTrim;
         this.so.data.lobbytop = _loc1_.lobbyTop;
         this.so.data.furnisorting = _loc1_.furniSorting;
         this.so.data.clothinginventory = _loc1_.clothingInventory.concat();
         this.so.data.hasnewclothing = _loc1_.hasNewClothing;
         this.so.data.hasnewclothingtypes = _loc1_.hasNewClothingTypes.concat();
         this.so.data.hasnewfurni = _loc1_.hasNewFurni;
         this.so.data.toppings = _loc1_.toppingsUnlocked.concat();
         this.so.data.toppingsrevealed = _loc1_.toppingsRevealed.concat();
         this.so.data.medalsEarned = _loc1_.medalsEarned.concat();
         this.so.data.medalProgress = _loc1_.gameObj.var_142.getMedalProgressArray();
         this.so.data.minigamesPlayed = _loc1_.minigamesPlayed.concat();
         this.so.data.minigamePrizes = _loc1_.minigamePrizes.concat();
         this.so.data.version = _loc1_.saveSlotVersion;
         this.so.data.continuedgame = _loc1_.hasContinuedGame;
         this.so.data.visitedshop = _loc1_.hasVisitedUpgradeShop;
         this.so.data.visitedbadges = _loc1_.hasVisitedBadgesScreen;
         this.so.data.visitedlobby = _loc1_.hasVisitedLobbyEditor;
         this.so.data.placedfurni = _loc1_.hasPlacedFurniture;
         this.so.data.shownparade = _loc1_.didShowParade;
         this.so.data.floatsparade = _loc1_.seenFloatsInParade;
         this.so.data.clicktwitter = _loc1_.didClickTwitter;
         this.so.data.clickfacebook = _loc1_.didClickFacebook;
         this.so.data.trainingflags = _loc1_.trainingFlags.concat();
         this.so.data.specialsOwned = _loc1_.specialsOwned.concat();
         this.so.data.specialsViewed = _loc1_.specialsViewed.concat();
         this.so.data.specialsServed = _loc1_.specialsServed.concat();
         this.so.data.specialFromCustomer = _loc1_.specialFromCustomer.concat();
         this.so.data.specialStars = _loc1_.specialStars.concat();
         this.so.data.currentSpecial = _loc1_.currentSpecial;
         this.so.data.lastDaySpecialEarned = _loc1_.lastDaySpecialEarned;
         this.so.data.showSpecialSign = _loc1_.showSpecialSign;
         _loc1_.flushSaveSlot();
         _loc1_.gameObj.var_132.method_156();
      }
      
      public function saveAfterBadge() : void
      {
      }
      
      public function purchaseBonus(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc4_:Upgrade = null;
         var _loc5_:GameData = null;
         var _loc3_:UserData = this;
         _loc5_ = _loc3_.gameObj.var_133;
         _loc4_ = _loc5_.getUpgradeFromTag(param1);
         var _loc6_:Number = _loc4_.price;
         if(_loc3_.totalTips >= _loc6_)
         {
            if(_loc3_.bonusUpgrades.indexOf(param1) == -1)
            {
               _loc3_.bonusUpgrades.push(param1);
            }
            _loc3_.totalTips -= _loc6_;
            _loc3_.gameObj.var_142.recordUpgrade(_loc4_.tag);
            _loc3_.gameObj.var_142.recordPurchase("upgrade");
            if(!param2)
            {
               _loc3_.saveData();
            }
            return true;
         }
         return false;
      }
      
      public function recordMinigamePlayed(param1:Number) : void
      {
         var _loc2_:UserData = this;
         if(param1 > -1)
         {
            ++_loc2_.minigamesPlayed[param1];
            _loc2_.gameObj.var_142.recordPlayingMinigame();
         }
      }
      
      public function earnMinigameFurniture(param1:String, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc4_:GameData = null;
         var _loc5_:UserData = null;
         var _loc7_:Number = NaN;
         _loc5_ = this;
         _loc4_ = _loc5_.gameObj.var_133;
         var _loc6_:FurniData = _loc4_.getFurniFromTag(param1);
         _loc7_ = Number(_loc5_.getExistingFurniIndex(_loc6_.tag));
         if(_loc7_ > -1)
         {
            _loc5_.furniInventory[_loc7_][1] += 1;
         }
         else
         {
            _loc5_.furniInventory.push([_loc6_.tag,1,0,1,0]);
         }
         if(param3 == false)
         {
            if(param2 > -1)
            {
               ++_loc5_.minigamePrizes[param2];
            }
            _loc5_.gameObj.var_142.recordEarningPrize();
         }
         else
         {
            _loc5_.gameObj.var_142.recordEarningSpecialPrize();
         }
         _loc5_.hasNewFurni = true;
         if(!param3)
         {
            _loc5_.saveData();
         }
      }
      
      public function earnMinigameClothing(param1:String, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc4_:ClothingData = null;
         var _loc5_:UserData = null;
         _loc5_ = this;
         _loc4_ = _loc5_.gameObj.var_135;
         var _loc6_:ClothingItem = _loc4_.getItemFromSKU(param1);
         _loc5_.clothingInventory.push(param1);
         if(param3 == false)
         {
            if(param2 > -1)
            {
               ++_loc5_.minigamePrizes[param2];
            }
            _loc5_.gameObj.var_142.recordEarningPrize();
         }
         else
         {
            _loc5_.gameObj.var_142.recordEarningSpecialPrize();
         }
         _loc5_.hasNewClothing = true;
         _loc5_.addNewClothingFlag(_loc6_.type);
         if(!param3)
         {
            _loc5_.saveData();
         }
      }
      
      public function addNewClothingFlag(param1:String) : void
      {
         var _loc2_:UserData = this;
         if(_loc2_.hasNewClothingTypes.indexOf(param1) == -1)
         {
            _loc2_.hasNewClothingTypes.push(param1);
         }
      }
      
      public function removeNewClothingFlag(param1:String) : void
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = _loc2_.hasNewClothingTypes.indexOf(param1);
         if(_loc3_ > -1)
         {
            _loc2_.hasNewClothingTypes.splice(_loc3_,1);
         }
      }
      
      public function hasNewClothingFlag(param1:String) : Boolean
      {
         var _loc2_:UserData = this;
         if(_loc2_.hasNewClothingTypes.indexOf(param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      public function earnMinigameTips(param1:Number) : void
      {
         var _loc2_:UserData = this;
         _loc2_.totalTips += param1;
         _loc2_.saveData();
      }
      
      public function earnMinigameTickets(param1:Number) : void
      {
         var _loc2_:UserData = this;
         _loc2_.totalTickets += param1;
         _loc2_.saveData();
      }
      
      public function getHolidayClothingItemsWorn(param1:Boolean = false) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:ClothingData = _loc2_.gameObj.var_135;
         var _loc4_:Number = 0;
         var _loc5_:Number = _loc2_.getMonth();
         var _loc6_:WorkerData = _loc2_.gameObj.workerData;
         if(param1)
         {
            _loc6_ = _loc2_.gameObj.var_151;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.shirt,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.pants,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.acca,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.accb,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.accc,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.accd,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.jacket,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.hat,_loc5_))
         {
            _loc4_++;
         }
         if(_loc3_.clothingHasHolidayBonus(_loc6_.shoes,_loc5_))
         {
            _loc4_++;
         }
         return _loc4_;
      }
      
      public function purchaseClothing(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc4_:ClothingItem = null;
         var _loc5_:ClothingData = null;
         var _loc3_:UserData = this;
         _loc5_ = _loc3_.gameObj.var_135;
         _loc4_ = _loc5_.getItemFromSKU(param1);
         var _loc6_:Number = _loc4_.price;
         if(_loc3_.totalTips >= _loc6_)
         {
            _loc3_.clothingInventory.push(param1);
            _loc3_.totalTips -= _loc6_;
            _loc3_.gameObj.var_142.recordPurchase("clothing");
            _loc3_.hasNewClothing = true;
            _loc3_.addNewClothingFlag(_loc4_.type);
            if(!param2)
            {
               _loc3_.saveData();
            }
            return true;
         }
         return false;
      }
      
      public function purchaseFurniture(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc6_:FurniData = null;
         var _loc7_:GameData = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         var _loc5_:UserData = this;
         _loc7_ = _loc5_.gameObj.var_133;
         _loc6_ = _loc7_.getFurniFromTag(param1);
         var _loc8_:Number = _loc6_.price;
         if(_loc5_.totalTips >= _loc8_)
         {
            _loc3_ = Number(_loc5_.getExistingFurniIndex(_loc6_.tag));
            if(_loc3_ > -1)
            {
               _loc5_.furniInventory[_loc3_][1] += 1;
            }
            else
            {
               _loc5_.furniInventory.push([_loc6_.tag,1,0,1,0]);
            }
            _loc5_.totalTips -= _loc8_;
            _loc4_ = _loc6_.type;
            if(_loc4_ == FurniData.TYPE_FLOORING || _loc4_ == FurniData.TYPE_WALLPAPER)
            {
               _loc4_ = "wallfloor";
            }
            _loc5_.gameObj.var_142.recordPurchase(_loc4_);
            _loc5_.hasNewFurni = true;
            if(!param2)
            {
               _loc5_.saveData();
            }
            return true;
         }
         return false;
      }
      
      private function getExistingFurniIndex(param1:String) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = -1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.furniInventory.length)
         {
            if(_loc2_.furniInventory[_loc4_][0] == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getFurniAmount(param1:String, param2:Boolean = false) : Number
      {
         var _loc3_:UserData = this;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.furniInventory.length)
         {
            if(_loc3_.furniInventory[_loc5_][0] == param1)
            {
               _loc4_ = Number(_loc3_.furniInventory[_loc5_][1]);
               if(param2 == true)
               {
                  _loc4_ += _loc3_.furniInventory[_loc5_][2];
               }
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getFurniAvailable(param1:String = "any") : Array
      {
         var _loc2_:* = 0;
         var _loc3_:FurniData = null;
         var _loc4_:Array = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:int = 0;
         var _loc7_:FurniData = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:UserData = this;
         var _loc11_:Array = [];
         if(_loc10_.furniSorting == "newest")
         {
            _loc2_ = int(_loc10_.furniInventory.length - 1);
            while(_loc2_ >= 0)
            {
               if(_loc10_.furniInventory[_loc2_][1] > 0 || param1 == "wallpaper" || param1 == "flooring")
               {
                  if(param1 == "any")
                  {
                     _loc11_.push(_loc10_.furniInventory[_loc2_][0]);
                  }
                  else
                  {
                     _loc3_ = _loc10_.gameObj.var_133.getFurniFromTag(_loc10_.furniInventory[_loc2_][0]);
                     if(_loc3_ != null && _loc3_.type == param1)
                     {
                        _loc11_.push(_loc10_.furniInventory[_loc2_][0]);
                     }
                  }
               }
               _loc2_--;
            }
         }
         else if(_loc10_.furniSorting == "holiday")
         {
            _loc4_ = [[],[],[],[],[],[],[],[],[],[],[],[],[]];
            _loc2_ = int(_loc10_.furniInventory.length - 1);
            while(_loc2_ >= 0)
            {
               if(_loc10_.furniInventory[_loc2_][1] > 0 || param1 == "wallpaper" || param1 == "flooring")
               {
                  _loc7_ = _loc10_.gameObj.var_133.getFurniFromTag(_loc10_.furniInventory[_loc2_][0]);
                  if(_loc7_ != null && _loc7_.type == param1)
                  {
                     _loc8_ = _loc10_.gameObj.var_133.themeTagsPerMonth.indexOf(_loc7_.theme);
                     if(_loc8_ == -1)
                     {
                        _loc4_[0].push(_loc10_.furniInventory[_loc2_][0]);
                     }
                     else
                     {
                        _loc4_[_loc8_].push(_loc10_.furniInventory[_loc2_][0]);
                     }
                  }
               }
               _loc2_--;
            }
            _loc5_ = _loc10_.getHolidayMonth();
            if(_loc5_ == 0)
            {
               _loc5_ = _loc10_.getMonth() + 1;
               if(_loc5_ > 12)
               {
                  _loc5_ = 1;
               }
            }
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc9_ = _loc6_ + _loc5_;
               if(_loc9_ >= _loc4_.length)
               {
                  _loc9_ -= _loc4_.length;
               }
               _loc11_ = _loc11_.concat(_loc4_[_loc9_]);
               _loc6_++;
            }
         }
         return _loc11_;
      }
      
      public function isFurniInLobby(param1:String) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:UserData = this;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.lobbyPlacement.length)
         {
            _loc2_ = _loc3_.lobbyPlacement[_loc5_][0];
            if(param1 == _loc2_)
            {
               _loc4_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function placeFurniInLobby(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc6_:Number = NaN;
         var _loc4_:UserData = this;
         var _loc5_:Boolean = false;
         _loc6_ = Number(_loc4_.getExistingFurniIndex(param1));
         if(_loc6_ > -1)
         {
            if(_loc4_.furniInventory[_loc6_][1] > 0)
            {
               _loc4_.furniInventory[_loc6_][1] = _loc4_.furniInventory[_loc6_][1] - 1;
               _loc4_.furniInventory[_loc6_][2] += 1;
               _loc4_.lobbyPlacement.push([param1,param2,param3]);
               _loc5_ = true;
            }
         }
         return _loc5_;
      }
      
      public function placeFlooringInLobby(param1:String, param2:Number) : Boolean
      {
         var ob:UserData = null;
         var previousFlooring:Number = NaN;
         ob = null;
         var i:int = 0;
         previousFlooring = Number(NaN);
         var didRemove:Boolean = false;
         var tag:String = param1;
         var num:Number = param2;
         ob = this;
         var success:Boolean = false;
         previousFlooring = ob.lobbyFlooring;
         try
         {
            didRemove = false;
            i = 0;
            while(i < ob.furniInventory.length)
            {
               if(ob.furniInventory[i][0] == "floor" + previousFlooring)
               {
                  ob.furniInventory[i][1] = 1;
                  ob.furniInventory[i][2] = 0;
                  didRemove = true;
                  break;
               }
               i++;
            }
            if(didRemove)
            {
               i = 0;
               while(i < ob.furniInventory.length)
               {
                  if(ob.furniInventory[i][0] == tag)
                  {
                     ob.furniInventory[i][1] = 0;
                     ob.furniInventory[i][2] = 1;
                     break;
                  }
                  i++;
               }
               ob.lobbyFlooring = num;
               success = true;
            }
         }
         catch(err:Error)
         {
            ob.lobbyFlooring = previousFlooring;
         }
         return success;
      }
      
      public function placeWallpaperInLobby(param1:String, param2:Number) : Boolean
      {
         var ob:UserData = null;
         var previousWallpaper:Number = NaN;
         ob = null;
         var i:int = 0;
         previousWallpaper = Number(NaN);
         var didRemove:Boolean = false;
         var tag:String = param1;
         var num:Number = param2;
         ob = this;
         var success:Boolean = false;
         previousWallpaper = ob.lobbyWallpaper;
         try
         {
            didRemove = false;
            i = 0;
            while(i < ob.furniInventory.length)
            {
               if(ob.furniInventory[i][0] == "wall" + previousWallpaper)
               {
                  ob.furniInventory[i][1] = 1;
                  ob.furniInventory[i][2] = 0;
                  didRemove = true;
                  break;
               }
               i++;
            }
            if(didRemove)
            {
               i = 0;
               while(i < ob.furniInventory.length)
               {
                  if(ob.furniInventory[i][0] == tag)
                  {
                     ob.furniInventory[i][1] = 0;
                     ob.furniInventory[i][2] = 1;
                     break;
                  }
                  i++;
               }
               ob.lobbyWallpaper = num;
               success = true;
            }
         }
         catch(err:Error)
         {
            ob.lobbyWallpaper = previousWallpaper;
         }
         return success;
      }
      
      public function removeFurniFromLobby(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Number = Number(NaN);
         var _loc5_:UserData = this;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.lobbyPlacement.length)
         {
            if(_loc5_.lobbyPlacement[_loc7_][0] == param1 && _loc5_.lobbyPlacement[_loc7_][1] == param2 && _loc5_.lobbyPlacement[_loc7_][2] == param3)
            {
               _loc5_.lobbyPlacement.splice(_loc7_,1);
               _loc4_ = Number(_loc5_.getExistingFurniIndex(param1));
               if(_loc4_ > -1)
               {
                  _loc5_.furniInventory[_loc4_][1] += 1;
                  _loc5_.furniInventory[_loc4_][2] = _loc5_.furniInventory[_loc4_][2] - 1;
                  _loc6_ = true;
               }
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function getDay() : Number
      {
         var _loc1_:UserData = this;
         return _loc1_.currentDay;
      }
      
      public function getDaysUntilPapa() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = _loc1_.papaReturnsOnDay - _loc1_.getDay();
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function getLastRankLimit() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:Number = 2;
         while(_loc3_ <= _loc1_.myRank)
         {
            if(_loc3_ < _loc1_.rankPlateauLimit)
            {
               _loc2_ += _loc3_;
            }
            else
            {
               _loc2_ += _loc1_.rankPlateauLimit;
            }
            _loc3_++;
         }
         return _loc2_ * _loc1_.rankMultiplier;
      }
      
      private function getNextRankLimit() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:Number = Number(_loc1_.getLastRankLimit());
         if(_loc1_.myRank + 1 < _loc1_.rankPlateauLimit)
         {
            _loc2_ = _loc3_ + (_loc1_.myRank + 1) * _loc1_.rankMultiplier;
         }
         else
         {
            _loc2_ = _loc3_ + _loc1_.rankPlateauLimit * _loc1_.rankMultiplier;
         }
         return _loc2_;
      }
      
      public function getPointsUntilNextRank(param1:Boolean = false) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = Number(_loc2_.getNextRankLimit());
         var _loc4_:Number = _loc3_ - _loc2_.totalScore;
         if(param1)
         {
            _loc4_ -= _loc2_.todayScore;
         }
         return _loc4_;
      }
      
      public function getCurrentPointPercentage() : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:UserData = this;
         var _loc2_:Number = _loc1_.lastRankLimit;
         var _loc3_:Number = Number(_loc1_.getNextRankLimit());
         _loc5_ = _loc1_.totalScore + _loc1_.todayScore;
         _loc4_ = (_loc5_ - _loc2_) / (_loc3_ - _loc2_);
         if(_loc4_ > 1)
         {
            _loc4_ = 1;
         }
         else if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         return _loc4_;
      }
      
      public function loadLabelsForSlot(param1:Number) : Object
      {
         var _loc4_:SharedObject = null;
         var _loc2_:UserData = this;
         var _loc3_:Object = null;
         _loc4_ = SharedObject.getLocal(this.saveSlotPrefix + param1,"/");
         if(_loc4_.data.rank)
         {
            _loc3_ = {};
            if(_loc4_.data.playername)
            {
               _loc3_.name = _loc4_.data.playername;
            }
            else
            {
               _loc3_.name = "Anonymous";
            }
            _loc3_.score = _loc4_.data.score;
            _loc3_.tips = _loc4_.data.tips;
            _loc3_.rank = _loc4_.data.rank;
            _loc3_.title = _loc2_.getRankTitle(Number(_loc4_.data.rank));
            _loc3_.day = _loc4_.data.day;
         }
         return _loc3_;
      }
      
      public function loadSlotDataForBackup(param1:Number) : Object
      {
         var _loc3_:SharedObject = null;
         var _loc2_:Object = null;
         _loc3_ = SharedObject.getLocal(this.saveSlotPrefix + param1,"/");
         if(_loc3_.data.rank)
         {
            _loc2_ = _loc3_.data;
         }
         return _loc2_;
      }
      
      public function readyToShowPapa() : Boolean
      {
         return false;
      }
      
      public function isEveryoneGold() : Boolean
      {
         var _loc1_:UserData = this;
         var _loc2_:Boolean = true;
         var _loc3_:Number = 1;
         _loc3_ = 8;
         var _loc4_:int = _loc3_;
         while(_loc4_ < _loc1_.customerSeals.length - 1)
         {
            if(_loc1_.customerSeals[_loc4_] < 3)
            {
               _loc2_ = false;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function hasBonus(param1:String) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.bonusUpgrades.length)
         {
            if(_loc2_.bonusUpgrades.length > _loc4_ && _loc2_.bonusUpgrades[_loc4_] == param1)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function hasSpecial(param1:Number) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Boolean = false;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            if(_loc2_.specialsOwned[param1] == 1)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function hasAllSpecialToppings(param1:Number) : Boolean
      {
         var _loc5_:SpecialItem = null;
         var _loc2_:int = 0;
         var _loc3_:UserData = this;
         var _loc4_:Boolean = true;
         _loc5_ = _loc3_.gameObj.var_133.getSpecial(param1);
         if(_loc5_ == null)
         {
            _loc4_ = false;
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc5_.ingredients.length)
            {
               if(_loc3_.hasTopping(_loc5_.ingredients[_loc2_]) == false)
               {
                  _loc4_ = false;
                  break;
               }
               _loc2_++;
            }
         }
         return _loc4_;
      }
      
      public function setSpecialViewed(param1:Number) : void
      {
         var _loc2_:UserData = this;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            _loc2_.specialsViewed[param1] = 1;
         }
      }
      
      public function recordSpecialServed(param1:Number) : void
      {
         var _loc2_:UserData = this;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            ++_loc2_.specialsServed[param1];
         }
      }
      
      public function recordSpecialStar(param1:Number) : void
      {
         var _loc2_:UserData = this;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            ++_loc2_.specialStars[param1];
         }
      }
      
      public function isSpecialViewed(param1:Number) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Boolean = false;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            if(_loc2_.specialsViewed[param1] == 1)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function getSpecialStars(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = 0;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            _loc3_ = Number(_loc2_.specialStars[param1]);
         }
         return _loc3_;
      }
      
      public function getSpecialsServed(param1:Number) : Number
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = 0;
         if(param1 >= 0 && param1 < _loc2_.specialsOwned.length)
         {
            _loc3_ = Number(_loc2_.specialsServed[param1]);
         }
         return _loc3_;
      }
      
      public function getSpecialCustomerName(param1:Number) : String
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:UserData = this;
         var _loc4_:String = "???";
         if(param1 >= 0 && param1 < _loc3_.specialsOwned.length)
         {
            _loc2_ = Number(_loc3_.specialFromCustomer[param1]);
            _loc4_ = _loc3_.gameObj.var_130.getCustomerName(_loc2_);
         }
         return _loc4_;
      }
      
      public function earnSpecial(param1:Number, param2:Number) : void
      {
         var _loc3_:UserData = this;
         if(param1 >= 0 && param1 < _loc3_.specialsOwned.length)
         {
            _loc3_.specialsOwned[param1] = 1;
            _loc3_.specialFromCustomer[param1] = param2;
            _loc3_.gameObj.var_142.recordEarningSpecialRecipe();
         }
      }
      
      public function hasNewSpecials() : Boolean
      {
         var _loc1_:UserData = this;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.specialsViewed.length)
         {
            if(_loc1_.specialsOwned[_loc3_] == 1 && _loc1_.specialsViewed[_loc3_] == 0)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function hasAnySpecials() : Boolean
      {
         var _loc1_:UserData = this;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.specialsOwned.length)
         {
            if(_loc1_.specialsOwned[_loc3_] == 1)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function hasTopping(param1:String = null, param2:Number = -1) : Boolean
      {
         var _loc3_:UserData = this;
         var _loc4_:Boolean = false;
         var _loc5_:Number = -1;
         if(param1 != null)
         {
            _loc5_ = _loc3_.toppingIndexes.indexOf(param1);
         }
         else
         {
            _loc5_ = param2;
         }
         if(_loc5_ > -1 && _loc3_.toppingsUnlocked.length > _loc5_ && _loc3_.toppingsUnlocked[_loc5_] == 1)
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         return _loc4_;
      }
      
      public function getAvailableBonuses() : Array
      {
         var _loc1_:UserData = this;
         var _loc2_:Array = [];
         var _loc3_:int = 1;
         while(_loc3_ <= _loc1_.totalBonuses)
         {
            if(_loc1_.bonusUpgrades[_loc3_] == 0)
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTotalBonuses() : Number
      {
         var _loc1_:UserData = this;
         return _loc1_.totalBonuses;
      }
      
      public function getBonusWaitOffset() : Number
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:String = null;
         var _loc3_:UserData = this;
         var _loc4_:GameData = _loc3_.gameObj.var_133;
         var _loc5_:Number = 0;
         var _loc6_:String = "Get Bonus Wait Offset: ";
         _loc1_ = 1;
         while(_loc1_ <= _loc3_.totalBonuses)
         {
            if(_loc3_.bonusUpgrades[_loc1_] == 1)
            {
               _loc5_ += Upgrade(_loc4_.shopItems[_loc1_ - 1]).waitingOffset;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_.lobbyPlacement.length)
         {
            _loc2_ = _loc3_.lobbyPlacement[_loc1_][0];
            _loc5_ += _loc4_.getFurniFromTag(_loc2_).waitingOffset;
            _loc1_++;
         }
         _loc6_ += _loc5_ + ". ";
         class_7.debug(_loc6_);
         return _loc5_;
      }
      
      public function hasBonusFurniture(param1:String, param2:String) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:FurniData = null;
         var _loc5_:UserData = this;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.lobbyPlacement.length)
         {
            _loc3_ = _loc5_.lobbyPlacement[_loc7_][0];
            _loc4_ = _loc5_.gameObj.var_133.getFurniFromTag(_loc3_);
            if((_loc4_.special == FurniData.SPECIAL_SCORE || _loc4_.special == FurniData.SPECIAL_SCOREBUBBLEGUM) && _loc4_.scoreType == param1 && _loc4_.toppingType == param2)
            {
               _loc6_ = true;
               break;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function alreadyOwnsFurniture(param1:String) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.furniInventory.length)
         {
            if(_loc2_.furniInventory[_loc4_][0] == param1)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function alreadyOwnsClothing(param1:String) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.clothingInventory.length)
         {
            if(_loc2_.clothingInventory[_loc4_] == param1)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getCustomerPool(param1:Number, param2:Boolean = false) : Array
      {
         var _loc8_:Number = NaN;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Array = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:UserData = this;
         var _loc7_:Array = [];
         _loc3_ = 1 + _loc6_.closerCustomers;
         while(_loc3_ < _loc6_.customersUnlocked.length)
         {
            if(_loc6_.customersUnlocked[_loc3_] == 1 && _loc6_.gameObj.var_130.getCustomerInPool(_loc3_))
            {
               if(_loc6_.getCustomerSeal(_loc3_) < 3)
               {
                  if(param2 == false || _loc6_.customerVisits[_loc3_] > 0)
                  {
                     _loc7_.push(_loc3_);
                  }
               }
            }
            _loc3_++;
         }
         _loc8_ = param1 - _loc7_.length;
         if(_loc8_ > 0)
         {
            _loc4_ = [];
            _loc3_ = 1 + _loc6_.closerCustomers;
            while(_loc3_ < _loc6_.customersUnlocked.length)
            {
               if(_loc6_.customersUnlocked[_loc3_] == 1 && _loc6_.gameObj.var_130.getCustomerInPool(_loc3_))
               {
                  if(_loc7_.indexOf(_loc3_) == -1)
                  {
                     _loc4_.push(_loc3_);
                  }
               }
               _loc3_++;
            }
            while(_loc7_.length < param1 && _loc4_.length > 0)
            {
               _loc5_ = Math.floor(Math.random() * _loc4_.length);
               _loc7_.unshift(_loc4_[_loc5_]);
               _loc4_.splice(_loc5_,1);
            }
         }
         _loc7_.sort(Array.NUMERIC);
         return _loc7_;
      }
      
      public function getNewestCustomer() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = 1 + _loc1_.closerCustomers;
         while(_loc4_ < _loc1_.customersUnlocked.length)
         {
            if(_loc1_.customersUnlocked[_loc4_] == 1 && _loc1_.customerFirstVisit[_loc4_] == 0)
            {
               _loc2_ = _loc4_;
               break;
            }
            if(_loc1_.customersUnlocked[_loc4_] == 1 && _loc1_.customerFirstVisit[_loc4_] > _loc3_)
            {
               _loc2_ = _loc4_;
               _loc3_ = Number(_loc1_.customerFirstVisit[_loc4_]);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getCloserCustomer() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = _loc1_.currentDay % _loc1_.closerCustomers;
         if(_loc2_ == 0)
         {
            _loc2_ = _loc1_.closerCustomers;
         }
         return _loc2_;
      }
      
      public function getToppingToReveal() : String
      {
         var _loc1_:UserData = this;
         var _loc2_:String = "none";
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.toppingsUnlocked.length)
         {
            if(_loc1_.toppingsUnlocked[_loc3_] == 1 && _loc1_.toppingsRevealed[_loc3_] == 0)
            {
               _loc2_ = _loc1_.toppingIndexes[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getAllToppingsToReveal() : Array
      {
         var _loc1_:UserData = this;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.toppingsUnlocked.length)
         {
            if(_loc1_.toppingsUnlocked[_loc3_] == 1 && _loc1_.toppingsRevealed[_loc3_] == 0)
            {
               _loc2_.push(_loc1_.toppingIndexes[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function rememberRevealedTopping(param1:String) : void
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = _loc2_.toppingIndexes.indexOf(param1);
         if(_loc3_ > -1 && _loc3_ < _loc2_.toppingsRevealed.length)
         {
            _loc2_.toppingsRevealed[_loc3_] = 1;
         }
      }
      
      public function hasBadge(param1:Number) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Boolean = false;
         if(_loc2_.medalsEarned.length > param1)
         {
            if(_loc2_.medalsEarned[param1] == 1)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function earnBadge(param1:Number, param2:String = "", param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:UserData = null;
         _loc5_ = this;
         _loc5_.medalsEarned[param1] = 1;
         _loc5_.totalTips += param3;
         _loc5_.totalTickets += param4;
      }
      
      public function getTotalBadgesEarned() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.medalsEarned.length)
         {
            if(_loc1_.medalsEarned[_loc3_] == 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getStatCustomersUnlocked() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.customersUnlocked.length)
         {
            if(_loc1_.customersUnlocked[_loc3_] == 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getStatCustomersBronze() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.customerSeals.length)
         {
            if(_loc1_.customerSeals[_loc3_] >= 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getStatCustomersSilver() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.customerSeals.length)
         {
            if(_loc1_.customerSeals[_loc3_] >= 2)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getStatCustomersGold() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.customerSeals.length)
         {
            if(_loc1_.customerSeals[_loc3_] == 3)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getStatUpgradesUnlocked() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.bonusUpgrades.length)
         {
            if(_loc1_.bonusUpgrades[_loc3_] == 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getMonth(param1:Number = -1) : Number
      {
         var _loc4_:Number = NaN;
         var _loc2_:UserData = this;
         var _loc3_:Number = 1;
         if(param1 > -1)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = _loc2_.getRank();
         }
         _loc4_ = Math.ceil(_loc3_ / _loc2_.ranksPerMonth) - 1 + GameData.STARTER_MONTH;
         _loc4_ = _loc4_ % 12;
         if(_loc4_ == 0)
         {
            _loc4_ = 12;
         }
         return _loc4_;
      }
      
      public function isNewYear(param1:Number = -1) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = 1;
         if(param1 > -1)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = _loc2_.getRank();
         }
         if(_loc3_ > _loc2_.ranksPerMonth * 12)
         {
            return true;
         }
         return false;
      }
      
      public function getHolidayMonth() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = _loc1_.getMonth();
         if(_loc2_ == GameData.STARTER_MONTH && _loc1_.isNewYear() == false)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function isBeyondFullYear(param1:Number = -1) : Boolean
      {
         var _loc2_:UserData = this;
         var _loc3_:Number = 1;
         if(param1 > -1)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = _loc2_.getRank();
         }
         if(_loc3_ > _loc2_.ranksPerMonth * 13)
         {
            return true;
         }
         return false;
      }
      
      public function getHomeTeam() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = Math.ceil(_loc1_.getDay() / 7);
         return (_loc2_ - 1) % 12 + 1;
      }
      
      public function getAwayTeam() : Number
      {
         var _loc1_:UserData = this;
         var _loc2_:Number = _loc1_.getHomeTeam();
         var _loc3_:Array = [];
         var _loc4_:int = 1;
         while(_loc4_ <= 12)
         {
            if(_loc4_ != _loc2_)
            {
               _loc3_.push(_loc4_);
            }
            _loc4_++;
         }
         _loc1_.setRandomSeed(_loc1_.getDay());
         _loc1_.randomize();
         _loc1_.randomize();
         var _loc5_:Number = Math.floor(_loc1_.randomize() * _loc3_.length);
         return _loc3_[_loc5_];
      }
      
      public function getHolidayThemeThisMonth() : String
      {
         var _loc1_:UserData = this;
         var _loc2_:String = "unknown";
         var _loc3_:Array = _loc1_.gameObj.var_133.themeTagsPerMonth;
         if(_loc1_.getMonth() < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc1_.getMonth()];
         }
         if(_loc1_.getMonth() == GameData.STARTER_MONTH && _loc1_.isNewYear() == false)
         {
            _loc2_ = "nothing";
         }
         return _loc2_;
      }
      
      public function getLobbyMaxPoints() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:FurniData = null;
         var _loc3_:UserData = this;
         var _loc4_:Number = 0;
         var _loc5_:String = _loc3_.getHolidayThemeThisMonth();
         _loc1_ = 0;
         while(_loc1_ < _loc3_.lobbyPlacement.length)
         {
            _loc2_ = _loc3_.gameObj.var_133.getFurniFromTag(_loc3_.lobbyPlacement[_loc1_][0]);
            _loc4_ += _loc2_.getMaxPoints(_loc5_);
            _loc1_++;
         }
         var _loc6_:FurniData = _loc3_.gameObj.var_133.getFurniFromTag("wall" + _loc3_.lobbyWallpaper);
         _loc4_ += _loc6_.getMaxPoints(_loc5_);
         var _loc7_:FurniData = _loc3_.gameObj.var_133.getFurniFromTag("floor" + _loc3_.lobbyFlooring);
         return Number(_loc4_ + _loc7_.getMaxPoints(_loc5_));
      }
      
      public function getLobbyMatchingPoints() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:FurniData = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:int = 0;
         var _loc5_:UserData = this;
         var _loc6_:Number = 0;
         var _loc7_:String = _loc5_.getHolidayThemeThisMonth();
         var _loc8_:Array = [];
         var _loc9_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < _loc5_.lobbyPlacement.length)
         {
            _loc2_ = _loc5_.gameObj.var_133.getFurniFromTag(_loc5_.lobbyPlacement[_loc1_][0]);
            if(_loc8_.indexOf(_loc2_.theme) == -1)
            {
               _loc8_.push(_loc2_.theme);
               _loc9_.push([]);
            }
            _loc9_[_loc8_.indexOf(_loc2_.theme)].push(_loc2_.getMaxPoints(_loc7_));
            _loc1_++;
         }
         var _loc10_:FurniData = _loc5_.gameObj.var_133.getFurniFromTag("wall" + _loc5_.lobbyWallpaper);
         if(_loc8_.indexOf(_loc10_.theme) == -1)
         {
            _loc8_.push(_loc10_.theme);
            _loc9_.push([]);
         }
         _loc9_[_loc8_.indexOf(_loc10_.theme)].push(_loc10_.getMaxPoints(_loc7_));
         var _loc11_:FurniData = _loc5_.gameObj.var_133.getFurniFromTag("floor" + _loc5_.lobbyFlooring);
         if(_loc8_.indexOf(_loc11_.theme) == -1)
         {
            _loc8_.push(_loc11_.theme);
            _loc9_.push([]);
         }
         _loc9_[_loc8_.indexOf(_loc11_.theme)].push(_loc11_.getMaxPoints(_loc7_));
         _loc1_ = 0;
         while(_loc1_ < _loc9_.length)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc9_[_loc1_].length)
            {
               _loc3_ += _loc9_[_loc1_][_loc4_];
               _loc4_++;
            }
            if(_loc9_[_loc1_].length == 1)
            {
               _loc3_ *= 0.5;
            }
            else if(_loc9_[_loc1_].length == 2)
            {
               _loc3_ *= 0.75;
            }
            _loc6_ += Math.ceil(_loc3_);
            _loc1_++;
         }
         return _loc6_;
      }
      
      public function getLobbyMatchingInTheme(param1:String) : Number
      {
         var _loc2_:int = 0;
         var _loc4_:UserData = null;
         var _loc5_:Number = NaN;
         var _loc6_:FurniData = null;
         var _loc7_:FurniData = null;
         _loc2_ = 0;
         var _loc3_:FurniData = null;
         _loc4_ = this;
         _loc5_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc4_.lobbyPlacement.length)
         {
            _loc3_ = _loc4_.gameObj.var_133.getFurniFromTag(_loc4_.lobbyPlacement[_loc2_][0]);
            if(_loc3_.theme == param1)
            {
               _loc5_++;
            }
            _loc2_++;
         }
         _loc6_ = _loc4_.gameObj.var_133.getFurniFromTag("wall" + _loc4_.lobbyWallpaper);
         if(_loc6_.theme == param1)
         {
            _loc5_++;
         }
         _loc7_ = _loc4_.gameObj.var_133.getFurniFromTag("floor" + _loc4_.lobbyFlooring);
         if(_loc7_.theme == param1)
         {
            _loc5_++;
         }
         return _loc5_;
      }
      
      public function getLobbyItemsPerTheme() : Array
      {
         var _loc1_:FurniData = null;
         var _loc2_:UserData = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:FurniData = null;
         var _loc7_:FurniData = null;
         _loc1_ = null;
         _loc2_ = this;
         _loc3_ = [];
         _loc4_ = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.lobbyPlacement.length)
         {
            _loc1_ = _loc2_.gameObj.var_133.getFurniFromTag(_loc2_.lobbyPlacement[_loc5_][0]);
            if(_loc3_.indexOf(_loc1_.theme) == -1)
            {
               _loc3_.push(_loc1_.theme);
               _loc4_.push(1);
            }
            else
            {
               _loc4_[_loc3_.indexOf(_loc1_.theme)] = _loc4_[_loc3_.indexOf(_loc1_.theme)] + 1;
            }
            _loc5_++;
         }
         _loc6_ = _loc2_.gameObj.var_133.getFurniFromTag("wall" + _loc2_.lobbyWallpaper);
         if(_loc3_.indexOf(_loc6_.theme) == -1)
         {
            _loc3_.push(_loc6_.theme);
            _loc4_.push(1);
         }
         else
         {
            _loc4_[_loc3_.indexOf(_loc6_.theme)] = _loc4_[_loc3_.indexOf(_loc6_.theme)] + 1;
         }
         _loc7_ = _loc2_.gameObj.var_133.getFurniFromTag("floor" + _loc2_.lobbyFlooring);
         if(_loc3_.indexOf(_loc7_.theme) == -1)
         {
            _loc3_.push(_loc7_.theme);
            _loc4_.push(1);
         }
         else
         {
            _loc4_[_loc3_.indexOf(_loc7_.theme)] = _loc4_[_loc3_.indexOf(_loc7_.theme)] + 1;
         }
         return _loc4_;
      }
      
      public function getLobbyFreshness() : Number
      {
         var _loc1_:UserData = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         _loc1_ = this;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.furniInventory.length)
         {
            if(_loc1_.furniInventory[_loc4_][2] > 0)
            {
               if(_loc1_.furniInventory[_loc4_].length < 4)
               {
                  _loc2_ += 1 * _loc1_.furniInventory[_loc4_][2];
                  _loc3_ += _loc1_.furniInventory[_loc4_][2];
               }
               else
               {
                  _loc2_ += _loc1_.furniInventory[_loc4_][3] * _loc1_.furniInventory[_loc4_][2];
                  _loc3_ += _loc1_.furniInventory[_loc4_][2];
               }
            }
            _loc4_++;
         }
         _loc5_ = _loc2_ / _loc3_;
         if(_loc3_ == 0)
         {
            _loc5_ = 1;
         }
         return _loc5_;
      }
      
      public function getLobbyPercent() : Number
      {
         var _loc1_:UserData = null;
         _loc1_ = this;
         return 0.667 + 0.333 * (_loc1_.getLobbyMatchingPoints() / _loc1_.getLobbyMaxPoints()) * _loc1_.getLobbyFreshness();
      }
      
      public function getFurniItemFreshness(param1:String) : Number
      {
         var _loc2_:UserData = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         _loc2_ = this;
         _loc3_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.furniInventory.length)
         {
            if(_loc2_.furniInventory[_loc4_][0] == param1)
            {
               if(_loc2_.furniInventory[_loc4_].length < 4)
               {
                  _loc3_ = 1;
                  break;
               }
               _loc3_ = Number(_loc2_.furniInventory[_loc4_][3]);
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function updateFurniFreshness() : void
      {
         var _loc1_:UserData = null;
         var _loc2_:int = 0;
         _loc1_ = this;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.furniInventory.length)
         {
            if(_loc1_.furniInventory[_loc2_][2] == 0)
            {
               _loc1_.furniInventory[_loc2_][3] = 1;
               _loc1_.furniInventory[_loc2_][4] = 0;
            }
            else
            {
               if(_loc1_.furniInventory[_loc2_].length < 3)
               {
                  _loc1_.furniInventory[_loc2_][3] = 1;
                  _loc1_.furniInventory[_loc2_][4] = 0;
               }
               ++_loc1_.furniInventory[_loc2_][4];
               if(_loc1_.furniInventory[_loc2_][4] >= 3)
               {
                  _loc1_.furniInventory[_loc2_][3] -= 0.02;
                  if(_loc1_.furniInventory[_loc2_][3] < 0)
                  {
                     _loc1_.furniInventory[_loc2_][3] = 0;
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function isValidTrainingFlag(param1:String) : Boolean
      {
         var _loc2_:UserData = null;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         _loc2_ = this;
         _loc3_ = false;
         _loc4_ = _loc2_.trainingFlagNames.indexOf(param1);
         if(_loc4_ > -1)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function hasTrained(param1:String) : Boolean
      {
         var _loc2_:UserData = null;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         _loc2_ = this;
         _loc3_ = false;
         _loc4_ = _loc2_.trainingFlagNames.indexOf(param1);
         if(_loc4_ > -1 && _loc2_.trainingFlags.length > _loc4_)
         {
            if(_loc2_.trainingFlags[_loc4_] == 1)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function setTrained(param1:String) : void
      {
         var _loc2_:UserData = null;
         var _loc3_:Number = NaN;
         _loc2_ = this;
         _loc3_ = _loc2_.trainingFlagNames.indexOf(param1);
         if(_loc3_ > -1)
         {
            _loc2_.trainingFlags[_loc3_] = 1;
         }
      }
      
      public function setWaiter(param1:String, param2:String, param3:Array) : void
      {
         var _loc4_:UserData = null;
         var _loc5_:int = 0;
         _loc4_ = this;
         _loc4_.waiterName = param1;
         _loc4_.whichWaiter = param2;
         _loc5_ = 0;
         while(_loc5_ < param3.length)
         {
            if(_loc4_.clothingInventory.indexOf(param3[_loc5_]) == -1)
            {
               _loc4_.clothingInventory.push(param3[_loc5_]);
            }
            _loc5_++;
         }
         _loc4_.didCreateWaiter = true;
         _loc4_.gameObj.var_132.method_156();
      }
      
      public function randomize(param1:Boolean = true) : Number
      {
         var _loc2_:UserData = null;
         _loc2_ = this;
         if(param1)
         {
            return (_loc2_.randomSeed = _loc2_.randomSeed * 16807 % 2147483647) / 2147483647 + 2.33e-10;
         }
         return Math.random();
      }
      
      public function setRandomSeed(param1:Number) : void
      {
         var _loc2_:UserData = null;
         _loc2_ = this;
         _loc2_.randomSeed = param1;
         _loc2_.randomize();
      }
   }
}


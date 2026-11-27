package cheeseGame.managers
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import package_2.*;
   import package_4.class_5;
   
   public class ChallengeManager
   {
      
      public var gameObj:class_5;
      
      public var badges:Array;
      
      public var badgeDropdown:MovieClip = null;
      
      public var badgeQueue:Array;
      
      public var badgeQueueType:Array;
      
      public var badgeDropdownBitmap:Bitmap = null;
      
      public var dropdownX:Number = 158;
      
      public var dropdownStartY:Number = 0;
      
      public var dropdownHeight:Number = 48;
      
      public var dropdownSpeed:Number = 4;
      
      public var dropdownOnScreenWait:Number = 120;
      
      public var dropdownOnScreenTimer:Number = 0;
      
      public function ChallengeManager(param1:class_5)
      {
         this.badges = [new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_TORTILLA,FoodData.CHEESE_OAXACA,FoodData.TOPPING_CHORIZO,FoodData.SAUCE_GUACAMOLE],
            "title":"Food Fiesta",
            "description":"Unlock all Cinco de Mayo toppings",
            "rewardMoney":4000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_HAWAIIAN,FoodData.CHEESE_MANGO,FoodData.TOPPING_PINEAPPLE,FoodData.SAUCE_CALYPSO],
            "title":"Summer Fun",
            "description":"Unlock all Summer Luau toppings",
            "rewardMoney":5000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_TEXASTOAST,FoodData.CHEESE_SMOKEDCHEDDAR,FoodData.TOPPING_BEEFBRISKET,FoodData.SAUCE_PITSAUCE],
            "title":"Backyard BBQ",
            "description":"Unlock all Starlight BBQ toppings",
            "rewardMoney":5000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_PEPPERONI,FoodData.CHEESE_RICOTTA,FoodData.TOPPING_MEATBALLS,FoodData.SAUCE_MARINARA],
            "title":"Cheesy Feast",
            "description":"Unlock all Portallini Feast toppings",
            "rewardMoney":6000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_CINNAMON,FoodData.CHEESE_MAPLEJACK,FoodData.TOPPING_SAUSAGE,FoodData.SAUCE_MAPLESYRUP],
            "title":"Rise and Shine",
            "description":"Unlock all Maple Mornings toppings",
            "rewardMoney":6000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_ECTOBREAD,FoodData.CHEESE_MUENSTER,FoodData.TOPPING_SPOOKYSLAW,FoodData.SAUCE_JACKOMOLE],
            "title":"Trick or Treat",
            "description":"Unlock all Halloween toppings",
            "rewardMoney":7000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_PUMPKIN,FoodData.CHEESE_CHEESEBALL,FoodData.TOPPING_STUFFING,FoodData.SAUCE_GRAVY],
            "title":"Thankful",
            "description":"Unlock all Thanksgiving toppings",
            "rewardMoney":7000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_FRUITCAKE,FoodData.CHEESE_GINGERSPICE,FoodData.TOPPING_GOOSE,FoodData.SAUCE_CRANBERRY],
            "title":"Holiday Sandwiches",
            "description":"Unlock all Christmas toppings",
            "rewardMoney":8000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_CHEDDARSWIRL,FoodData.CHEESE_GRUYERE,FoodData.TOPPING_MACNCHEESE,FoodData.SAUCE_PARMESAN],
            "title":"Cheesy New Year",
            "description":"Unlock all New Year toppings",
            "rewardMoney":8000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_BEET,FoodData.CHEESE_REDWINDSOR,FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.SAUCE_STRAWBERRY],
            "title":"Playing Cupid",
            "description":"Unlock all Valentine\'s Day toppings",
            "rewardMoney":3000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_BARMBRACK,FoodData.CHEESE_SAGEDERBY,FoodData.TOPPING_BEEFHASH,FoodData.SAUCE_IRISHPARSLEY],
            "title":"Go Green",
            "description":"Unlock all St. Paddy\'s Day toppings",
            "rewardMoney":3000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":4,
            "toppings":[FoodData.BREAD_PASKA,FoodData.CHEESE_SIRECZ,FoodData.TOPPING_PICKLEDEGGS,FoodData.SAUCE_HOLLANDAISE],
            "title":"Easter Basket",
            "description":"Unlock all Easter toppings",
            "rewardMoney":4000,
            "tickets":1,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKCUSTOMER,{
            "targetAmount":1,
            "customers":["Papa Louie"],
            "title":"Papa\'s Return",
            "description":"Unlock Papa Louie",
            "rewardMoney":15000,
            "tickets":10
         }),new Challenge(Challenge.UNLOCKSEASON,{
            "targetAmount":1,
            "tagName":"summer",
            "title":"Summer Vacation",
            "description":"Reach Summer",
            "rewardMoney":10000
         }),new Challenge(Challenge.UNLOCKSEASON,{
            "targetAmount":1,
            "tagName":"fall",
            "title":"Fall Harvest",
            "description":"Reach Autumn",
            "rewardMoney":4000
         }),new Challenge(Challenge.UNLOCKSEASON,{
            "targetAmount":1,
            "tagName":"winter",
            "title":"Winter Wonderland",
            "description":"Reach Winter",
            "rewardMoney":6000
         }),new Challenge(Challenge.UNLOCKSEASON,{
            "targetAmount":1,
            "tagName":"spring",
            "title":"Spring Has Sprung",
            "description":"Reach Spring",
            "rewardMoney":8000
         }),new Challenge(Challenge.UNLOCKHOLIDAY,{
            "targetAmount":4,
            "title":"Completed Calendar",
            "description":"Unlock all of the Holidays",
            "rewardMoney":12000
         }),new Challenge(Challenge.SEALS,{
            "targetAmount":5,
            "sealType":"bronze",
            "title":"Bronze Beginning",
            "description":"Earn 5 Bronze Customer Awards",
            "rewardMoney":3000,
            "showTally":true
         }),new Challenge(Challenge.SEALS,{
            "targetAmount":15,
            "sealType":"bronze",
            "title":"Repeat Customers",
            "description":"Earn 15 Bronze Customer Awards",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.SEALS,{
            "targetAmount":10,
            "sealType":"silver",
            "title":"Silver Medal",
            "description":"Earn 10 Silver Customer Awards",
            "rewardMoney":7000,
            "showTally":true
         }),new Challenge(Challenge.SEALS,{
            "targetAmount":15,
            "sealType":"gold",
            "title":"Restaurant Regulars",
            "description":"Earn 15 Gold Customer Awards",
            "rewardMoney":10000,
            "showTally":true
         }),new Challenge(Challenge.SEALS,{
            "targetAmount":48,
            "sealType":"gold",
            "title":"Halfway There",
            "description":"Earn 48 Gold Customer Awards",
            "rewardMoney":25000,
            "showTally":true
         }),new Challenge(Challenge.SEALS,{
            "targetAmount":96,
            "sealType":"gold",
            "title":"Go For the Gold",
            "description":"Earn Gold Customer Awards on all customers!",
            "rewardMoney":50000,
            "tickets":5,
            "showTally":true
         }),new Challenge(Challenge.SCORE,{
            "targetAmount":20,
            "customer":"any",
            "score":100,
            "scoreType":"Waiting",
            "title":"Order Expert",
            "description":"Get a 100% Waiting Score on 20 orders",
            "rewardMoney":7000,
            "showTally":true
         }),new Challenge(Challenge.SCORE,{
            "targetAmount":20,
            "customer":"any",
            "score":100,
            "scoreType":"Build",
            "title":"Build Expert",
            "description":"Get a 100% Build Score on 20 orders",
            "rewardMoney":7000,
            "showTally":true
         }),new Challenge(Challenge.SCORE,{
            "targetAmount":20,
            "customer":"any",
            "score":100,
            "scoreType":"Cook",
            "title":"Grill Expert",
            "description":"Get a 100% Grilling Score on 20 orders",
            "rewardMoney":7000,
            "showTally":true
         }),new Challenge(Challenge.SCORE,{
            "targetAmount":20,
            "customer":"any",
            "score":100,
            "scoreType":"Fries",
            "title":"Fry Expert",
            "description":"Get a 100% Fry Score on 20 orders",
            "rewardMoney":7000,
            "showTally":true
         }),new Challenge(Challenge.RIBBON,{
            "targetAmount":1,
            "title":"Critically Acclaimed",
            "description":"Get a Blue Ribbon from Jojo the Food Critic",
            "rewardMoney":4000
         }),new Challenge(Challenge.RIBBON,{
            "targetAmount":5,
            "title":"Award Winning Sandwiches",
            "description":"Get 5 Blue Ribbons from Jojo the Food Critic",
            "rewardMoney":10000,
            "showTally":true
         }),new Challenge(Challenge.SERVICEQUALITY,{
            "targetAmount":5,
            "percentQuality":90,
            "title":"Quality Assurance",
            "description":"Get 90% Service Quality or higher on five different days",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.SERVICEQUALITY,{
            "targetAmount":20,
            "percentQuality":95,
            "title":"High Quality",
            "description":"Get 95% Service Quality or higher on 20 different days",
            "rewardMoney":10000,
            "showTally":true
         }),new Challenge(Challenge.PAYDAY,{
            "targetAmount":1,
            "title":"First Paycheck",
            "description":"Get your first paycheck on Pay Day",
            "rewardMoney":1000
         }),new Challenge(Challenge.PAYDAY,{
            "targetAmount":4,
            "title":"Month\'s Pay",
            "description":"Receive your wages on four Pay Days",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.SCORE,{
            "targetAmount":30,
            "customer":"any",
            "score":100,
            "scoreType":"Overall",
            "title":"Perfect!",
            "description":"Get a Perfect Score on 30 orders",
            "rewardMoney":10000,
            "tickets":3,
            "showTally":true
         }),new Challenge(Challenge.PURCHASES,{
            "targetAmount":50,
            "upgrades":"any",
            "title":"One-Stop Shopping",
            "description":"Buy any 50 items from the Shop",
            "rewardMoney":5000,
            "tickets":3,
            "showTally":true
         }),new Challenge(Challenge.PURCHASES,{
            "targetAmount":8,
            "upgrades":"poster",
            "title":"Advertiser",
            "description":"Buy any 8 Posters from the Shop",
            "rewardMoney":1500,
            "showTally":true
         }),new Challenge(Challenge.PURCHASES,{
            "targetAmount":8,
            "upgrades":"furni",
            "title":"Interior Decorator",
            "description":"Buy any 8 Furniture items from the Shop",
            "rewardMoney":1500,
            "showTally":true
         }),new Challenge(Challenge.PURCHASES,{
            "targetAmount":8,
            "upgrades":"clothing",
            "title":"Updated Wardrobe",
            "description":"Buy any 8 Clothing items from the Shop",
            "rewardMoney":1500,
            "showTally":true
         }),new Challenge(Challenge.PURCHASES,{
            "targetAmount":4,
            "upgrades":"wallfloor",
            "title":"New Coat of Paint",
            "description":"Buy any 4 Flooring or Wallpaper from the Shop",
            "rewardMoney":1500,
            "showTally":true
         }),new Challenge(Challenge.UPGRADES,{
            "targetAmount":13,
            "upgrades":["booster0","booster1","booster2","booster3","doorbell","lightalarm","mediumalarm","wellalarm","fryboost0","fryboost1","fryalarm0","fryalarm1","specialsign"],
            "title":"Upgrade Master",
            "description":"Buy all of the Upgrades in the Shop",
            "rewardMoney":10000,
            "showTally":true
         }),new Challenge(Challenge.TAGGED,{
            "targetAmount":1,
            "tagName":"changeclothes",
            "title":"New Threads",
            "description":"Change your worker\'s shirt, pants, jacket, and shoes.",
            "rewardMoney":2000,
            "showTally":false
         }),new Challenge(Challenge.SERVECUSTOMERS,{
            "targetAmount":4,
            "customers":["Bruna Romano","Gino Romano","Carlo Romano","Little Edoardo"],
            "title":"Romano Family",
            "description":"Serve everyone in the Romano Family Quartet",
            "rewardMoney":15000,
            "showTally":true
         }),new Challenge(Challenge.SERVECUSTOMERS,{
            "targetAmount":7,
            "customers":["Xolo","Rhonda","Radlynn","Quinn","Hank","Chester","Jojo"],
            "title":"Toastwood Closers",
            "description":"Serve all of the Closers",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.SERVECUSTOMERS,{
            "targetAmount":5,
            "customers":["Rhonda","Chester","Austin","Brody","Perri"],
            "title":"New Faces",
            "description":"Serve all of the new customers",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.SERVECUSTOMERS,{
            "targetAmount":19,
            "customers":["Taylor","Peggy","Roy","Marty","Rita","Mitch","Maggie","Penny","Alberto","Cooper","Prudence","Chuck","Mandi","James","Willow","Doan","Utah","Tony","Scooter"],
            "title":"Worker Reunion",
            "description":"Serve all of the workers from Papa\'s other restaurants",
            "rewardMoney":6000,
            "showTally":true
         }),new Challenge(Challenge.SERVECUSTOMERS,{
            "targetAmount":96,
            "customers":"all",
            "title":"The Gang\'s All Here",
            "description":"Serve all of the customers!",
            "rewardMoney":30000,
            "tickets":5,
            "showTally":true
         }),new Challenge(Challenge.SERVECUSTOMERSINMONTH,{
            "targetAmount":7,
            "month":10,
            "customers":["Xolo","Chester","Radlynn","Quinn","Rhonda","Hank","Jojo"],
            "title":"Costumed Closers",
            "description":"Serve all of the Costumed Closers during Halloween",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.MINIGAME,{
            "targetAmount":7,
            "title":"Game Show Contestant",
            "description":"Play all of Foodini\'s Mini-Games",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.PRIZE,{
            "targetAmount":1,
            "title":"Winner!",
            "description":"Earn a Prize in one of Foodini\'s Mini-Games",
            "rewardMoney":1500
         }),new Challenge(Challenge.MULTIPRIZE,{
            "targetAmount":7,
            "title":"Skillful Contestant",
            "description":"Earn a Prize in each of Foodini\'s Mini-Games",
            "rewardMoney":2000,
            "showTally":true
         }),new Challenge(Challenge.PRIZE,{
            "targetAmount":20,
            "title":"Big Winner",
            "description":"Earn 20 Prizes in Foodini\'s Mini-Games",
            "rewardMoney":3000,
            "showTally":true
         }),new Challenge(Challenge.MULTIPRIZE,{
            "targetAmount":35,
            "title":"Grand Prize Winner",
            "description":"Earn 5 Prizes or more in each of Foodini\'s Mini-Games",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.TAGGED,{
            "targetAmount":1,
            "tagName":"rareprize",
            "title":"Rare Reward",
            "description":"Win a Rare Bonus Prize in a Mini-Game by earning a Star Medal",
            "rewardMoney":2500
         }),new Challenge(Challenge.SPECIALS,{
            "targetAmount":1,
            "title":"The Envelope Please",
            "description":"Earn a Special Recipe from a customer",
            "rewardMoney":1500
         }),new Challenge(Challenge.SPECIALS,{
            "targetAmount":20,
            "title":"Recipe Collection",
            "description":"Earn 20 Special Recipes from customers",
            "rewardMoney":3000,
            "showTally":true
         }),new Challenge(Challenge.SPECIALS,{
            "targetAmount":40,
            "title":"Complete Cookbook",
            "description":"Earn 40 Special Recipes from customers",
            "rewardMoney":9000,
            "showTally":true
         }),new Challenge(Challenge.SPECIALSTAR,{
            "targetAmount":3,
            "title":"Successful Specials",
            "description":"Earn 3 Special Stars when serving Today\'s Special",
            "rewardMoney":1500,
            "showTally":true
         }),new Challenge(Challenge.SPECIALSTAR,{
            "targetAmount":25,
            "title":"Special Server",
            "description":"Earn 25 Special Stars when serving Today\'s Special",
            "rewardMoney":3000,
            "showTally":true
         }),new Challenge(Challenge.SPECIALSTAR,{
            "targetAmount":100,
            "title":"Very Special Sandwiches",
            "description":"Earn 100 Special Stars when serving Today\'s Special",
            "rewardMoney":6000,
            "showTally":true
         }),new Challenge(Challenge.SPECIALPRIZE,{
            "targetAmount":1,
            "title":"Recipe Master",
            "description":"Master a Special Recipe by earning 5 Special Stars",
            "rewardMoney":2500
         }),new Challenge(Challenge.SPECIALPRIZE,{
            "targetAmount":10,
            "title":"Super Special",
            "description":"Master 10 Special Recipes by earning 5 Stars on each",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.SPECIALPRIZE,{
            "targetAmount":20,
            "title":"Cookbook Mastery",
            "description":"Master 20 Special Recipes by earning 5 Stars on each",
            "rewardMoney":7500,
            "showTally":true
         }),new Challenge(Challenge.TAGGED,{
            "targetAmount":10,
            "tagName":"diningroom",
            "title":"Super Server",
            "description":"Serve 10 customers in the Dining Room",
            "rewardMoney":3000,
            "showTally":true
         }),new Challenge(Challenge.SERVECLOTHING,{
            "targetAmount":1,
            "clothing":["easter_hat_1"],
            "customers":["Cletus"],
            "title":"Bunny Buddies",
            "description":"Serve Cletus while wearing the Bunny Ears",
            "rewardMoney":3000
         }),new Challenge(Challenge.SERVECLOTHINGTHEME,{
            "targetAmount":20,
            "theme":"H",
            "month":GameData.MONTH_OCTOBER,
            "customers":"any",
            "title":"Spooktacular",
            "description":"Serve 20 customers during Halloween wearing any Halloween clothing",
            "rewardMoney":4000,
            "showTally":true
         }),new Challenge(Challenge.SERVECLOTHINGTHEME,{
            "targetAmount":100,
            "theme":"any",
            "customers":"any",
            "title":"Holiday Spirit",
            "description":"Serve 100 customers while wearing clothing that matches the season",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.TAGGED,{
            "targetAmount":250,
            "tagName":"kartcoin",
            "title":"Loose Change",
            "description":"Grab 250 coins while playing Papa\'s Raceway",
            "rewardMoney":3500,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":11,
            "toppings":[FoodData.BREAD_WHITE,FoodData.BREAD_WHEAT,FoodData.BREAD_SOURDOUGH,FoodData.BREAD_RYE,FoodData.BREAD_MULTIGRAIN,FoodData.BREAD_FLATBREAD,FoodData.BREAD_CIABATTA,FoodData.BREAD_FOCACCIA,FoodData.BREAD_THREECHEESE,FoodData.BREAD_PRETZEL,FoodData.BREAD_PUMPERNICKEL],
            "title":"Bread Basket",
            "description":"Unlock all of the Standard Breads",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":4,
            "topping":"any",
            "title":"Learning the Basics",
            "description":"Serve 4 sandwich orders",
            "rewardMoney":1000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_WHITE,
            "title":"Basic White",
            "description":"Serve 30 orders with White Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_WHEAT,
            "title":"Wheat Wrangler",
            "description":"Serve 30 orders with Wheat Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_SOURDOUGH,
            "title":"Sourdough Sandwiches",
            "description":"Serve 30 orders with Sourdough Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_RYE,
            "title":"Rye Catcher",
            "description":"Serve 30 orders with Marble Rye Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_MULTIGRAIN,
            "title":"Multigrain Master",
            "description":"Serve 30 orders with Multigrain Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_FLATBREAD,
            "title":"Flat Sandwiches",
            "description":"Serve 30 orders with Flatbread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_FOCACCIA,
            "title":"Oven Baked",
            "description":"Serve 30 orders with Rosemary Focaccia",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_PUMPERNICKEL,
            "title":"Pump It Up",
            "description":"Serve 30 orders with Pumpernickel Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_CIABATTA,
            "title":"Wanna Ciabatta",
            "description":"Serve 30 orders with Ciabatta",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_THREECHEESE,
            "title":"Extra Cheese",
            "description":"Serve 30 orders with Three Cheese Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.BREAD_PRETZEL,
            "title":"Pretzel Provider",
            "description":"Serve 30 orders with Pretzel Bread",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":11,
            "toppings":[FoodData.CHEESE_AMERICAN,FoodData.CHEESE_SWISS,FoodData.CHEESE_PEPPERJACK,FoodData.CHEESE_CHEDDAR,FoodData.CHEESE_COLBY,FoodData.CHEESE_MOZZARELLA,FoodData.CHEESE_PROVOLONE,FoodData.CHEESE_GORGONZOLA,FoodData.CHEESE_ASIAGO,FoodData.CHEESE_AGEDGOUDA,FoodData.CHEESE_HAVARTI],
            "title":"Cheese Please",
            "description":"Unlock all of the Standard Cheeses",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_AMERICAN,
            "title":"Classic Cheese",
            "description":"Serve 30 orders with American Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_SWISS,
            "title":"Don\'t Miss the Swiss",
            "description":"Serve 30 orders with Swiss Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_PEPPERJACK,
            "title":"Jack Attack",
            "description":"Serve 30 orders with Pepperjack Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_CHEDDAR,
            "title":"Cheddar is Better",
            "description":"Serve 30 orders with Shredded Cheddar Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_MOZZARELLA,
            "title":"Shred the Mozzarella",
            "description":"Serve 30 orders with Shredded Mozzarella",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_COLBY,
            "title":"Keepin\' it Colby",
            "description":"Serve 30 orders with Marble Colby Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_AGEDGOUDA,
            "title":"Aged to Perfection",
            "description":"Serve 30 orders with Aged Gouda",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_PROVOLONE,
            "title":"Go with the Pro",
            "description":"Serve 30 orders with Provolone Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_ASIAGO,
            "title":"Asiago Expert",
            "description":"Serve 30 orders with Asiago Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_HAVARTI,
            "title":"Havarti Party",
            "description":"Serve 30 orders with Havarti Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.CHEESE_GORGONZOLA,
            "title":"Go Go Gorgonzola!",
            "description":"Serve 30 orders with Gorgonzola Cheese",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":19,
            "toppings":[FoodData.TOPPING_TOMATO,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_TURKEY,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_OLIVES,FoodData.TOPPING_PICKLES,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_ONIONS,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_SALAMI],
            "title":"Sandwich Stuffer",
            "description":"Unlock all of the Standard Toppings",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_HAM,
            "title":"Hamazing",
            "description":"Serve 30 orders with Sliced Ham",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_TURKEY,
            "title":"Gobble it Up",
            "description":"Serve 30 orders with Sliced Turkey",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_LETTUCE,
            "title":"Lots of Lettuce",
            "description":"Serve 30 orders with Lettuce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_TOMATO,
            "title":"Tomato Topper",
            "description":"Serve 30 orders with Tomatoes",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_BACON,
            "title":"Bacon Boss",
            "description":"Serve 30 orders with Bacon",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_CHICKEN,
            "title":"Chicken Griller",
            "description":"Serve 30 orders with Grilled Chicken",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_JALAPENOS,
            "title":"Spicy Sandwich",
            "description":"Serve 30 orders with Jalapeños",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_PEPPERS,
            "title":"Can\'t Beat the Fajita",
            "description":"Serve 30 orders with Fajita Peppers",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_PULLEDPORK,
            "title":"Piled with Pork",
            "description":"Serve 30 orders with Pulled Pork",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_ONIONS,
            "title":"Tears of Joy",
            "description":"Serve 30 orders with Sauteed Onions",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_SALAMI,
            "title":"Salami Server",
            "description":"Serve 30 orders with Sliced Salami",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_FRIEDEGG,
            "title":"Over Easy",
            "description":"Serve 30 orders with Fried Eggs",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_PHILLYSTEAK,
            "title":"Steak Sandwich",
            "description":"Serve 30 orders with Philly Steak",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_LOBSTER,
            "title":"Seafood Special",
            "description":"Serve 30 orders with Lobster Chunks",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_CORNEDBEEF,
            "title":"Fresh from the Deli",
            "description":"Serve 30 orders with Corned Beef",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_MUSHROOMS,
            "title":"Room for Shrooms",
            "description":"Serve 30 orders with Mushrooms",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_PICKLES,
            "title":"Pickle Chips",
            "description":"Serve 30 orders with Deep-Fried Pickles",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_SAUERKRAUT,
            "title":"Cabbage Patch",
            "description":"Serve 30 orders with Sauerkraut",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.TOPPING_OLIVES,
            "title":"Olives for All",
            "description":"Serve 30 orders with Olives",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":10,
            "toppings":[FoodData.SAUCE_KETCHUP,FoodData.SAUCE_MUSTARD,FoodData.SAUCE_RANCH,FoodData.SAUCE_BBQ,FoodData.SAUCE_BUFFALO,FoodData.SAUCE_HONEYMUSTARD,FoodData.SAUCE_SOUTHWEST,FoodData.SAUCE_WILDONION,FoodData.SAUCE_AWESOME,FoodData.SAUCE_BALSAMIC],
            "title":"Saucy Sandwiches",
            "description":"Unlock all of the Standard Sauces",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_KETCHUP,
            "title":"Classic Condiment",
            "description":"Serve 30 orders with Ketchup",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_MUSTARD,
            "title":"Master the Mustard",
            "description":"Serve 30 orders with Mustard",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_RANCH,
            "title":"Ranch Hand",
            "description":"Serve 30 orders with Ranch",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_BUFFALO,
            "title":"Big Buffalo",
            "description":"Serve 30 orders with Buffalo Sauce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_BBQ,
            "title":"Sweet and Smoky",
            "description":"Serve 30 orders with BBQ Sauce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_SOUTHWEST,
            "title":"South of the Border",
            "description":"Serve 30 orders with Southwest Sauce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_WILDONION,
            "title":"Wild Side",
            "description":"Serve 30 orders with Wild Onion Sauce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_AWESOME,
            "title":"Awesomesauce!",
            "description":"Serve 30 orders with Awesome Sauce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_HONEYMUSTARD,
            "title":"Bee\'s Knees",
            "description":"Serve 30 orders with Honey Mustard",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.SAUCE_BALSAMIC,
            "title":"Salad on a Sandwich",
            "description":"Serve 30 orders with Balsamic Dressing",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":5,
            "toppings":[FoodData.FRIES_REGULAR,FoodData.FRIES_CRINKLE,FoodData.FRIES_CURLY,FoodData.FRIES_SWEETPOTATO,FoodData.FRIES_WAFFLE],
            "title":"Side of Fries",
            "description":"Unlock all of the Standard Fries",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRIES_REGULAR,
            "title":"French Fried",
            "description":"Serve 30 orders with French Fries",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRIES_CURLY,
            "title":"Springy Side",
            "description":"Serve 30 orders with Curly Fries",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRIES_WAFFLE,
            "title":"Waffle Wrangler",
            "description":"Serve 30 orders with Waffle Fries",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRIES_SWEETPOTATO,
            "title":"So Sweet",
            "description":"Serve 30 orders with Sweet Potato Wedges",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRIES_CRINKLE,
            "title":"Crinkle Cutter",
            "description":"Serve 30 orders with Crinkle Cut Fries",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.UNLOCKTOPPING,{
            "targetAmount":14,
            "toppings":[FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON,FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_CHIVES,FoodData.TOPPING_JALAPENOS,FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_SEASONING,FoodData.FRYSAUCE_NACHO,FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYSAUCE_POUTINE,FoodData.SAUCE_RANCH,FoodData.SAUCE_BBQ,FoodData.SAUCE_KETCHUP,FoodData.SAUCE_AWESOME],
            "title":"Loaded Fries",
            "description":"Unlock all of the Fry Toppings",
            "rewardMoney":5000,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYTOPPING_CHEDDAR,
            "title":"Cheddar on Top",
            "description":"Serve 30 orders with Cheddar Topping",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYTOPPING_BACON,
            "title":"Better with Bacon",
            "description":"Serve 30 orders with Bacobites",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYTOPPING_CHILI,
            "title":"Chunky Chili",
            "description":"Serve 30 orders with Rico\'s Chili",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYTOPPING_ROSEMARY,
            "title":"Fancy Fries",
            "description":"Serve 30 orders with Rosemary",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYSAUCE_SOURCREAM,
            "title":"Cool and Creamy",
            "description":"Serve 30 orders with Sour Cream",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYTOPPING_CHIVES,
            "title":"Alive with Chives",
            "description":"Serve 30 orders with Chives",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYSAUCE_NACHO,
            "title":"Cheese Whiz",
            "description":"Serve 30 orders with Nacho Sauce",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYTOPPING_SEASONING,
            "title":"\'Tis the Season",
            "description":"Serve 30 orders with Steak Seasoning",
            "rewardMoney":2500,
            "showTally":true
         }),new Challenge(Challenge.USETOPPING,{
            "targetAmount":30,
            "topping":FoodData.FRYSAUCE_POUTINE,
            "title":"Curds and Gravy",
            "description":"Serve 30 orders with Poutine",
            "rewardMoney":2500,
            "showTally":true
         })];
         this.badgeQueue = [];
         this.badgeQueueType = [];
         super();
         this.gameObj = param1;
      }
      
      public function destroy() : void
      {
      }
      
      public function getChallengeTitle(param1:Number = -1) : String
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Challenge = null;
         var _loc4_:ChallengeManager = this;
         var _loc5_:String = "";
         if(param1 > -1)
         {
            if(param1 < _loc4_.badges.length)
            {
               _loc3_ = _loc4_.badges[param1];
               _loc5_ = _loc3_.title;
            }
         }
         return _loc5_;
      }
      
      public function getChallengeDescription(param1:Number = -1) : String
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Challenge = null;
         var _loc4_:ChallengeManager = this;
         var _loc5_:String = "";
         if(param1 > -1)
         {
            if(param1 < _loc4_.badges.length)
            {
               _loc3_ = _loc4_.badges[param1];
               _loc5_ = _loc3_.description;
            }
         }
         return _loc5_;
      }
      
      public function getChallengeRewardAmount(param1:Number = -1) : Number
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Challenge = null;
         var _loc4_:ChallengeManager = this;
         var _loc5_:Number = 0;
         if(param1 > -1)
         {
            if(param1 < _loc4_.badges.length)
            {
               _loc3_ = _loc4_.badges[param1];
               _loc5_ = _loc3_.rewardMoney;
            }
         }
         return _loc5_;
      }
      
      public function getChallengeTicketAmount(param1:Number = -1) : Number
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Challenge = null;
         var _loc4_:ChallengeManager = this;
         var _loc5_:Number = 0;
         if(param1 > -1)
         {
            if(param1 < _loc4_.badges.length)
            {
               _loc3_ = _loc4_.badges[param1];
               _loc5_ = _loc3_.tickets;
            }
         }
         return _loc5_;
      }
      
      public function getBadgeTallyString(param1:Number) : String
      {
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         var _loc4_:* = "";
         if(param1 < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[param1];
            if(_loc2_.showTally)
            {
               if(_loc2_.tally < _loc2_.targetAmount)
               {
                  _loc4_ = "(" + _loc2_.tally + "/" + _loc2_.targetAmount + ")";
               }
            }
         }
         return _loc4_;
      }
      
      public function getBadgeTally(param1:Number) : Number
      {
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         var _loc4_:Number = 0;
         if(param1 < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[param1];
            _loc4_ = _loc2_.tally;
         }
         return _loc4_;
      }
      
      public function getNumberOfBadges() : Number
      {
         var _loc1_:ChallengeManager = this;
         return _loc1_.badges.length;
      }
      
      public function shouldLockBadge(param1:Number) : Boolean
      {
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         var _loc4_:Boolean = false;
         if(param1 < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[param1];
            if(_loc2_.challengeType == Challenge.USETOPPING)
            {
               if(_loc3_.gameObj.var_128.hasTopping(_loc2_.topping) == false && _loc2_.topping != "any")
               {
                  _loc4_ = true;
               }
            }
         }
         return _loc4_;
      }
      
      public function recordRank(param1:Number) : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[_loc5_];
            if(_loc2_.challengeType == Challenge.RANK)
            {
               if(_loc2_.targetAmount <= param1 && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordUnlockCustomer(param1:String) : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Boolean = false;
         var _loc7_:ChallengeManager = this;
         var _loc8_:UserData = _loc7_.gameObj.var_128;
         var _loc9_:Number = _loc7_.gameObj.var_130.getCustomerIndex(param1);
         var _loc10_:int = 0;
         while(_loc10_ < _loc7_.badges.length)
         {
            _loc2_ = _loc7_.badges[_loc10_];
            if(_loc2_.challengeType == Challenge.UNLOCKCUSTOMER)
            {
               _loc4_ = [];
               _loc5_ = 0;
               if(_loc2_.customers == "all")
               {
                  _loc3_ = 1;
                  while(_loc3_ <= _loc7_.gameObj.var_130.getCustomerTotal())
                  {
                     _loc4_.push(_loc3_);
                     _loc3_++;
                  }
               }
               else
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.customers.length)
                  {
                     _loc4_.push(_loc7_.gameObj.var_130.getCustomerIndex(_loc2_.customers[_loc3_]));
                     _loc3_++;
                  }
               }
               if(_loc4_.indexOf(_loc9_) > -1)
               {
                  _loc6_ = _loc2_.addToTally();
                  if((_loc6_) && !_loc8_.hasBadge(_loc10_))
                  {
                     _loc8_.earnBadge(_loc10_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                     _loc8_.saveAfterBadge();
                     _loc7_.showEarningBadge(_loc10_);
                  }
               }
            }
            _loc10_++;
         }
      }
      
      public function recordUnlockSeason(param1:String) : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[_loc5_];
            if(_loc2_.challengeType == Challenge.UNLOCKSEASON)
            {
               if(_loc2_.tagName == param1 && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordUnlockHoliday(param1:Number) : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[_loc5_];
            if(_loc2_.challengeType == Challenge.UNLOCKHOLIDAY)
            {
               if(_loc2_.targetAmount == param1 && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordUnlockTopping() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Challenge = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:ChallengeManager = this;
         var _loc6_:UserData = _loc5_.gameObj.var_128;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.badges.length)
         {
            _loc2_ = _loc5_.badges[_loc7_];
            if(_loc2_.challengeType == Challenge.UNLOCKTOPPING)
            {
               _loc3_ = 0;
               _loc4_ = 0;
               if(_loc2_.toppings == "all")
               {
                  _loc3_ = _loc6_.toppingIndexes.length;
                  _loc1_ = 0;
                  while(_loc1_ < _loc6_.toppingIndexes.length)
                  {
                     if(_loc6_.hasTopping(_loc6_.toppingIndexes[_loc1_]))
                     {
                        _loc4_++;
                     }
                     _loc1_++;
                  }
               }
               else
               {
                  _loc3_ = Number(_loc2_.toppings.length);
                  _loc1_ = 0;
                  while(_loc1_ < _loc2_.toppings.length)
                  {
                     if(_loc6_.hasTopping(_loc2_.toppings[_loc1_]))
                     {
                        _loc4_++;
                     }
                     _loc1_++;
                  }
               }
               _loc2_.setTally(_loc4_);
               if(_loc4_ >= _loc3_ && !_loc6_.hasBadge(_loc7_))
               {
                  _loc6_.earnBadge(_loc7_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                  _loc6_.saveAfterBadge();
                  _loc5_.showEarningBadge(_loc7_);
               }
            }
            _loc7_++;
         }
      }
      
      public function recordPlayingMinigame() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.minigamesPlayed.length)
         {
            if(_loc4_.minigamesPlayed[_loc6_] > 0)
            {
               _loc5_++;
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.badges.length)
         {
            _loc1_ = _loc3_.badges[_loc7_];
            if(_loc1_.challengeType == Challenge.MINIGAME)
            {
               _loc2_ = _loc1_.setTally(_loc5_);
               if((_loc2_) && !_loc4_.hasBadge(_loc7_))
               {
                  _loc4_.earnBadge(_loc7_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc7_);
               }
            }
            _loc7_++;
         }
      }
      
      public function recordEarningPrize() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:ChallengeManager = this;
         var _loc8_:UserData = _loc7_.gameObj.var_128;
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_.badges.length)
         {
            _loc1_ = _loc7_.badges[_loc9_];
            if(_loc1_.challengeType == Challenge.PRIZE)
            {
               _loc2_ = _loc1_.addToTally();
               if((_loc2_) && !_loc8_.hasBadge(_loc9_))
               {
                  _loc8_.earnBadge(_loc9_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc8_.saveAfterBadge();
                  _loc7_.showEarningBadge(_loc9_);
               }
            }
            else if(_loc1_.challengeType == Challenge.MULTIPRIZE)
            {
               _loc3_ = Math.round(_loc1_.targetAmount / _loc8_.numberOfMinigames);
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.minigamePrizes.length)
               {
                  _loc4_ += Math.min(_loc3_,_loc8_.minigamePrizes[_loc5_]);
                  _loc5_++;
               }
               _loc6_ = _loc1_.setTally(_loc4_);
               if((_loc6_) && !_loc8_.hasBadge(_loc9_))
               {
                  _loc8_.earnBadge(_loc9_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc8_.saveAfterBadge();
                  _loc7_.showEarningBadge(_loc9_);
               }
            }
            _loc9_++;
         }
      }
      
      public function recordEarningSpecialPrize() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc1_ = _loc3_.badges[_loc5_];
            if(_loc1_.challengeType == Challenge.SPECIALPRIZE)
            {
               _loc2_ = _loc1_.addToTally();
               if((_loc2_) && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordEarningSpecialRecipe() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc1_ = _loc3_.badges[_loc5_];
            if(_loc1_.challengeType == Challenge.SPECIALS)
            {
               _loc2_ = _loc1_.addToTally();
               if((_loc2_) && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordUpgrade(param1:String) : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:Boolean = false;
         var _loc4_:ChallengeManager = this;
         var _loc5_:UserData = _loc4_.gameObj.var_128;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.badges.length)
         {
            _loc2_ = _loc4_.badges[_loc6_];
            if(_loc2_.challengeType == Challenge.UPGRADES)
            {
               if(_loc2_.upgrades == "any" || _loc2_.upgrades.indexOf(param1) > -1)
               {
                  _loc3_ = _loc2_.addToTally();
                  if((_loc3_) && !_loc5_.hasBadge(_loc6_))
                  {
                     _loc5_.earnBadge(_loc6_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                     _loc5_.saveAfterBadge();
                     _loc4_.showEarningBadge(_loc6_);
                  }
               }
            }
            _loc6_++;
         }
      }
      
      public function recordTagged(param1:String, param2:Number = 1) : void
      {
         var _loc3_:Challenge = null;
         var _loc4_:Boolean = false;
         var _loc5_:ChallengeManager = this;
         var _loc6_:UserData = _loc5_.gameObj.var_128;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.badges.length)
         {
            _loc3_ = _loc5_.badges[_loc7_];
            if(_loc3_.challengeType == Challenge.TAGGED)
            {
               if(_loc3_.tagName == param1)
               {
                  _loc4_ = _loc3_.addToTally(param2);
                  if((_loc4_) && !_loc6_.hasBadge(_loc7_))
                  {
                     _loc6_.earnBadge(_loc7_,_loc3_.title,_loc3_.rewardMoney,_loc3_.tickets);
                     _loc6_.saveAfterBadge();
                     _loc5_.showEarningBadge(_loc7_);
                  }
               }
            }
            _loc7_++;
         }
      }
      
      public function recordPurchase(param1:String = "furniture") : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:Boolean = false;
         var _loc4_:ChallengeManager = this;
         var _loc5_:UserData = _loc4_.gameObj.var_128;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.badges.length)
         {
            _loc2_ = _loc4_.badges[_loc6_];
            if(_loc2_.challengeType == Challenge.PURCHASES)
            {
               if(_loc2_.upgrades == "any" || _loc2_.upgrades == param1)
               {
                  _loc3_ = _loc2_.addToTally();
                  if((_loc3_) && !_loc5_.hasBadge(_loc6_))
                  {
                     _loc5_.earnBadge(_loc6_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                     _loc5_.saveAfterBadge();
                     _loc4_.showEarningBadge(_loc6_);
                  }
               }
            }
            _loc6_++;
         }
      }
      
      public function recordFurniture(param1:String, param2:String = "furniture", param3:Boolean = false) : void
      {
         var _loc6_:ChallengeManager = null;
         var _loc4_:Challenge = null;
         var _loc5_:Boolean = false;
         _loc6_ = this;
         var _loc7_:UserData = _loc6_.gameObj.var_128;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.badges.length)
         {
            _loc4_ = _loc6_.badges[_loc8_];
            if(_loc4_.challengeType == Challenge.FURNITURE && param3 == false || (_loc4_.challengeType == Challenge.REWARDFURNI || _loc4_.challengeType == Challenge.REWARDANY) && param3 == true)
            {
               if(_loc4_.upgrades == "any" || _loc4_.upgrades.indexOf(param1) > -1 || _loc4_.upgrades == param2)
               {
                  _loc5_ = _loc4_.addToTally();
                  if((_loc5_) && !_loc7_.hasBadge(_loc8_))
                  {
                     _loc7_.earnBadge(_loc8_,_loc4_.title,_loc4_.rewardMoney,_loc4_.tickets);
                     _loc7_.saveAfterBadge();
                     _loc6_.showEarningBadge(_loc8_);
                  }
               }
            }
            _loc8_++;
         }
      }
      
      public function recordClothing(param1:String, param2:String = "furniture", param3:Boolean = false) : void
      {
         var _loc6_:ChallengeManager = null;
         var _loc4_:Challenge = null;
         var _loc5_:Boolean = false;
         _loc6_ = this;
         var _loc7_:UserData = _loc6_.gameObj.var_128;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.badges.length)
         {
            _loc4_ = _loc6_.badges[_loc8_];
            if(_loc4_.challengeType == Challenge.CLOTHING && param3 == false || (_loc4_.challengeType == Challenge.REWARDCLOTHING || _loc4_.challengeType == Challenge.REWARDANY) && param3 == true)
            {
               if(_loc4_.upgrades == "any" || _loc4_.upgrades.indexOf(param1) > -1 || _loc4_.upgrades == param2)
               {
                  _loc5_ = _loc4_.addToTally();
                  if((_loc5_) && !_loc7_.hasBadge(_loc8_))
                  {
                     _loc7_.earnBadge(_loc8_,_loc4_.title,_loc4_.rewardMoney,_loc4_.tickets);
                     _loc7_.saveAfterBadge();
                     _loc6_.showEarningBadge(_loc8_);
                  }
               }
            }
            _loc8_++;
         }
      }
      
      public function recordCustomerSeal(param1:Number = 0, param2:String = "") : void
      {
         var _loc3_:Challenge = null;
         var _loc4_:Boolean = false;
         var _loc5_:ChallengeManager = this;
         var _loc6_:UserData = _loc5_.gameObj.var_128;
         var _loc7_:String = "";
         if(param1 == 1)
         {
            _loc7_ = "bronze";
         }
         else if(param1 == 2)
         {
            _loc7_ = "silver";
         }
         else if(param1 == 3)
         {
            _loc7_ = "gold";
         }
         else
         {
            _loc7_ = param2;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.badges.length)
         {
            _loc3_ = _loc5_.badges[_loc8_];
            if(_loc3_.challengeType == Challenge.SEALS && _loc3_.sealType == _loc7_)
            {
               _loc4_ = _loc3_.addToTally();
               if((_loc4_) && !_loc6_.hasBadge(_loc8_))
               {
                  _loc6_.earnBadge(_loc8_,_loc3_.title,_loc3_.rewardMoney,_loc3_.tickets);
                  _loc6_.saveAfterBadge();
                  _loc5_.showEarningBadge(_loc8_);
               }
            }
            _loc8_++;
         }
      }
      
      public function recordRibbon() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc1_ = _loc3_.badges[_loc5_];
            if(_loc1_.challengeType == Challenge.RIBBON)
            {
               _loc2_ = _loc1_.addToTally();
               if((_loc2_) && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordSpecialStar() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc1_ = _loc3_.badges[_loc5_];
            if(_loc1_.challengeType == Challenge.SPECIALSTAR)
            {
               _loc2_ = _loc1_.addToTally();
               if((_loc2_) && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordPayDay() : void
      {
         var _loc1_:Challenge = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChallengeManager = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.badges.length)
         {
            _loc1_ = _loc3_.badges[_loc5_];
            if(_loc1_.challengeType == Challenge.PAYDAY)
            {
               _loc2_ = _loc1_.addToTally();
               if((_loc2_) && !_loc4_.hasBadge(_loc5_))
               {
                  _loc4_.earnBadge(_loc5_,_loc1_.title,_loc1_.rewardMoney,_loc1_.tickets);
                  _loc4_.saveAfterBadge();
                  _loc3_.showEarningBadge(_loc5_);
               }
            }
            _loc5_++;
         }
      }
      
      public function recordMeterAward(param1:String, param2:String) : void
      {
         var _loc3_:Challenge = null;
         var _loc4_:Boolean = false;
         var _loc5_:ChallengeManager = this;
         var _loc6_:UserData = _loc5_.gameObj.var_128;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.badges.length)
         {
            _loc3_ = _loc5_.badges[_loc7_];
            if(_loc3_.challengeType == Challenge.METER)
            {
               if((_loc3_.scoreType == "any" || _loc3_.scoreType.indexOf(param2) > -1) && (_loc3_.machine == "any" || _loc3_.machine == param1))
               {
                  _loc4_ = _loc3_.addToTally();
                  if((_loc4_) && !_loc6_.hasBadge(_loc7_))
                  {
                     _loc6_.earnBadge(_loc7_,_loc3_.title,_loc3_.rewardMoney,_loc3_.tickets);
                     _loc6_.saveAfterBadge();
                     _loc5_.showEarningBadge(_loc7_);
                  }
               }
            }
            _loc7_++;
         }
      }
      
      public function recordServiceQuality(param1:Number = 100) : void
      {
         var _loc2_:Challenge = null;
         var _loc3_:Boolean = false;
         var _loc4_:ChallengeManager = this;
         var _loc5_:UserData = _loc4_.gameObj.var_128;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.badges.length)
         {
            _loc2_ = _loc4_.badges[_loc6_];
            if(_loc2_.challengeType == Challenge.SERVICEQUALITY && _loc2_.percentQuality <= param1)
            {
               _loc3_ = _loc2_.addToTally();
               if((_loc3_) && !_loc5_.hasBadge(_loc6_))
               {
                  _loc5_.earnBadge(_loc6_,_loc2_.title,_loc2_.rewardMoney,_loc2_.tickets);
                  _loc5_.saveAfterBadge();
                  _loc4_.showEarningBadge(_loc6_);
               }
            }
            _loc6_++;
         }
      }
      
      public function recordServeOrder(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Array, param8:Array) : void
      {
         var _loc35_:ChallengeManager = null;
         var _loc9_:Challenge = null;
         var _loc10_:Boolean = false;
         var _loc11_:Array = null;
         var _loc12_:Number = Number(NaN);
         var _loc13_:int = 0;
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Array = null;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Number = Number(NaN);
         var _loc20_:int = 0;
         var _loc21_:ClothingItem = null;
         var _loc22_:Number = Number(NaN);
         var _loc23_:Number = Number(NaN);
         var _loc24_:Array = null;
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:Number = Number(NaN);
         var _loc28_:Number = Number(NaN);
         var _loc29_:Array = null;
         var _loc30_:Number = Number(NaN);
         var _loc31_:Number = Number(NaN);
         var _loc32_:Number = Number(NaN);
         var _loc33_:Number = Number(NaN);
         var _loc34_:Array = null;
         _loc35_ = this;
         var _loc36_:UserData = _loc35_.gameObj.var_128;
         var _loc37_:Number = Math.floor((param2 + param3 + param4 + param5) / 4);
         var _loc38_:Array = param7.concat();
         var _loc39_:Boolean = false;
         var _loc40_:int = 0;
         while(_loc40_ < _loc35_.badges.length)
         {
            _loc9_ = _loc35_.badges[_loc40_];
            _loc10_ = false;
            if(_loc38_.indexOf(_loc9_.topping) > -1)
            {
               _loc10_ = true;
            }
            else if(_loc9_.topping == "any")
            {
               _loc10_ = true;
            }
            if(_loc9_.challengeType == Challenge.USETOPPING && _loc10_)
            {
               _loc39_ = _loc9_.addToTally();
               if((_loc39_) && !_loc36_.hasBadge(_loc40_))
               {
                  _loc36_.earnBadge(_loc40_,_loc9_.title,_loc9_.rewardMoney,_loc9_.tickets);
                  _loc36_.saveAfterBadge();
                  _loc35_.showEarningBadge(_loc40_);
               }
            }
            else if(_loc9_.challengeType == Challenge.SERVECLOTHING)
            {
               _loc11_ = _loc9_.clothing.concat();
               _loc12_ = 0;
               if(Boolean(param8) && param8.length > 0)
               {
                  _loc13_ = 0;
                  while(_loc13_ < param8.length)
                  {
                     if(_loc11_.indexOf(param8[_loc13_]) > -1)
                     {
                        _loc12_++;
                     }
                     _loc13_++;
                  }
                  if(_loc12_ >= _loc11_.length)
                  {
                     _loc15_ = _loc35_.gameObj.var_130.getCustomerIndex(param1);
                     _loc16_ = [];
                     if(_loc9_.customers != "any")
                     {
                        _loc14_ = 0;
                        while(_loc14_ < _loc9_.customers.length)
                        {
                           _loc16_.push(_loc35_.gameObj.var_130.getCustomerIndex(_loc9_.customers[_loc14_]));
                           _loc14_++;
                        }
                     }
                     if(_loc9_.customers == "any" || _loc16_.indexOf(_loc15_) > -1)
                     {
                        _loc17_ = _loc9_.addToTally();
                        if((_loc17_) && !_loc36_.hasBadge(_loc40_))
                        {
                           _loc36_.earnBadge(_loc40_,_loc9_.title,_loc9_.rewardMoney,_loc9_.tickets);
                           _loc36_.saveAfterBadge();
                           _loc35_.showEarningBadge(_loc40_);
                        }
                     }
                  }
               }
            }
            else if(_loc9_.challengeType == Challenge.SERVECLOTHINGTHEME)
            {
               _loc18_ = false;
               _loc19_ = _loc9_.month;
               if(_loc19_ == -1)
               {
                  _loc19_ = _loc36_.getHolidayMonth();
               }
               if(Boolean(_loc19_ > 0) && Boolean(param8) && param8.length > 0)
               {
                  _loc20_ = 0;
                  while(_loc20_ < param8.length)
                  {
                     _loc21_ = this.gameObj.var_135.getItemFromSKU(param8[_loc20_]);
                     if(_loc21_ != null && _loc21_.holidayBonus == _loc19_)
                     {
                        _loc18_ = true;
                        break;
                     }
                     _loc20_++;
                  }
                  if(_loc18_)
                  {
                     class_7.method_1("Outfit matched challenge theme (" + _loc19_ + ")");
                     _loc23_ = _loc35_.gameObj.var_130.getCustomerIndex(param1);
                     _loc24_ = [];
                     if(_loc9_.customers != "any")
                     {
                        _loc22_ = 0;
                        while(_loc22_ < _loc9_.customers.length)
                        {
                           _loc24_.push(_loc35_.gameObj.var_130.getCustomerIndex(_loc9_.customers[_loc22_]));
                           _loc22_++;
                        }
                     }
                     if(_loc9_.customers == "any" || _loc24_.indexOf(_loc23_) > -1)
                     {
                        _loc25_ = _loc9_.addToTally();
                        if((_loc25_) && !_loc36_.hasBadge(_loc40_))
                        {
                           _loc36_.earnBadge(_loc40_,_loc9_.title,_loc9_.rewardMoney,_loc9_.tickets);
                           _loc36_.saveAfterBadge();
                           _loc35_.showEarningBadge(_loc40_);
                        }
                     }
                  }
               }
            }
            else if(_loc9_.challengeType == Challenge.SCORE)
            {
               _loc26_ = false;
               if(_loc9_.scoreType == "Waiting" && param2 >= _loc9_.score && (_loc9_.customer == "any" || _loc9_.customer == param1))
               {
                  _loc26_ = true;
               }
               else if(_loc9_.scoreType == "Fries" && param5 >= _loc9_.score && (_loc9_.customer == "any" || _loc9_.customer == param1))
               {
                  _loc26_ = true;
               }
               else if(_loc9_.scoreType == "Cook" && param3 >= _loc9_.score && (_loc9_.customer == "any" || _loc9_.customer == param1))
               {
                  _loc26_ = true;
               }
               else if(_loc9_.scoreType == "Build" && param4 >= _loc9_.score && (_loc9_.customer == "any" || _loc9_.customer == param1))
               {
                  _loc26_ = true;
               }
               else if(_loc9_.scoreType == "Overall" && _loc37_ >= _loc9_.score && (_loc9_.customer == "any" || _loc9_.customer == param1))
               {
                  _loc26_ = true;
               }
               else if(_loc9_.scoreType == "Points" && param6 >= _loc9_.score && (_loc9_.customer == "any" || _loc9_.customer == param1))
               {
                  _loc26_ = true;
               }
               if(_loc26_)
               {
                  _loc39_ = _loc9_.addToTally();
                  if((_loc39_) && !_loc36_.hasBadge(_loc40_))
                  {
                     _loc36_.earnBadge(_loc40_,_loc9_.title,_loc9_.rewardMoney,_loc9_.tickets);
                     _loc36_.saveAfterBadge();
                     _loc35_.showEarningBadge(_loc40_);
                  }
               }
            }
            else if(_loc9_.challengeType == Challenge.SERVECUSTOMERS)
            {
               _loc28_ = _loc35_.gameObj.var_130.getCustomerIndex(param1);
               _loc29_ = [];
               _loc30_ = 0;
               if(_loc9_.customers == "all")
               {
                  _loc27_ = 1;
                  while(_loc27_ <= _loc35_.gameObj.var_130.getCustomerTotal())
                  {
                     _loc29_.push(_loc27_);
                     _loc27_++;
                  }
               }
               else
               {
                  _loc27_ = 0;
                  while(_loc27_ < _loc9_.customers.length)
                  {
                     _loc29_.push(_loc35_.gameObj.var_130.getCustomerIndex(_loc9_.customers[_loc27_]));
                     _loc27_++;
                  }
               }
               _loc27_ = 0;
               while(_loc27_ < _loc29_.length)
               {
                  if(_loc36_.customerVisits[_loc29_[_loc27_]] > 0)
                  {
                     _loc30_++;
                  }
                  _loc27_++;
               }
               if(_loc29_.indexOf(_loc28_) > -1)
               {
                  _loc9_.setTally(_loc30_);
                  if(_loc30_ >= _loc29_.length && !_loc36_.hasBadge(_loc40_))
                  {
                     _loc36_.earnBadge(_loc40_,_loc9_.title,_loc9_.rewardMoney,_loc9_.tickets);
                     _loc36_.saveAfterBadge();
                     _loc35_.showEarningBadge(_loc40_);
                  }
               }
            }
            else if(_loc9_.challengeType == Challenge.SERVECUSTOMERSINMONTH)
            {
               _loc31_ = _loc35_.gameObj.var_128.getMonth();
               if(_loc31_ == GameData.STARTER_MONTH && _loc35_.gameObj.var_128.isNewYear() == false)
               {
                  _loc31_ = 0;
               }
               _loc33_ = _loc35_.gameObj.var_130.getCustomerIndex(param1);
               _loc34_ = [];
               _loc32_ = 0;
               while(_loc32_ < _loc9_.customers.length)
               {
                  _loc34_.push(_loc35_.gameObj.var_130.getCustomerIndex(_loc9_.customers[_loc32_]));
                  _loc32_++;
               }
               if(_loc9_.month == _loc31_ && _loc34_.indexOf(_loc33_) > -1)
               {
                  _loc39_ = _loc9_.addToTally();
                  if((_loc39_) && !_loc36_.hasBadge(_loc40_))
                  {
                     _loc36_.earnBadge(_loc40_,_loc9_.title,_loc9_.rewardMoney,_loc9_.tickets);
                     _loc36_.saveAfterBadge();
                     _loc35_.showEarningBadge(_loc40_);
                  }
               }
            }
            _loc40_++;
         }
      }
      
      public function getMedalProgressArray() : Array
      {
         var _loc1_:Challenge = null;
         var _loc2_:ChallengeManager = this;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.badges.length)
         {
            _loc1_ = _loc2_.badges[_loc4_];
            _loc3_[_loc4_] = _loc1_.tally;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function populateMedalProgress(param1:Array) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Challenge = null;
         var _loc4_:ChallengeManager = this;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = 0;
            if(param1[_loc5_])
            {
               _loc2_ = Number(param1[_loc5_]);
            }
            if(_loc4_.badges.length > _loc5_)
            {
               _loc3_ = _loc4_.badges[_loc5_];
               _loc3_.setTally(_loc2_);
            }
            _loc5_++;
         }
      }
      
      public function resetAllTallies() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Challenge = null;
         var _loc3_:ChallengeManager = this;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.badges.length)
         {
            _loc2_ = _loc3_.badges[_loc1_];
            _loc2_.clearTally(true);
            _loc1_++;
         }
      }
      
      public function showSpecialProgress(param1:Number) : void
      {
         var _loc2_:ChallengeManager = this;
         class_7.method_1("SHOW PROGRESS ON TODAY\'S SPECIAL");
         _loc2_.badgeQueue.push(param1);
         _loc2_.badgeQueueType.push("special");
         _loc2_.checkForDisplayingBadges();
      }
      
      public function showEarningBadge(param1:Number) : void
      {
         var _loc2_:ChallengeManager = this;
         class_7.method_1("EARN BADGE #" + param1 + ". ADD TO QUEUE!");
         _loc2_.badgeQueue.push(param1);
         _loc2_.badgeQueueType.push("badge");
         _loc2_.checkForDisplayingBadges();
      }
      
      public function checkForDisplayingBadges() : void
      {
         var which:Number = Number(NaN);
         var whichType:String = null;
         var special:SpecialItem = null;
         var numStars:Number = Number(NaN);
         var s:int = 0;
         var manager:ChallengeManager = this;
         var dropdownDisabled:Boolean = false;
         if(dropdownDisabled == false && manager.badgeDropdown == null && manager.badgeQueue.length > 0)
         {
            which = Number(manager.badgeQueue[0]);
            whichType = manager.badgeQueueType[0];
            manager.badgeDropdown = new badgeDropdownMC();
            manager.badgeDropdown.buttonMode = true;
            manager.badgeDropdown.mouseEnabled = true;
            manager.badgeDropdown.mouseChildren = false;
            manager.badgeDropdown.tabEnabled = false;
            manager.badgeDropdown.x = manager.dropdownX;
            if(whichType == "badge")
            {
               manager.badgeDropdown.special.visible = false;
               manager.badgeDropdown.panel.title_txt.text = manager.getChallengeTitle(which);
               manager.badgeDropdown.panel.description_txt.text = manager.getChallengeDescription(which);
               manager.badgeDropdown.panel.reward_txt.text = "+ $" + class_13.method_110(manager.getChallengeRewardAmount(which) / 100);
               if(manager.getChallengeTicketAmount(which) > 0)
               {
                  manager.badgeDropdown.panel.tickets_txt.text = String(manager.getChallengeTicketAmount(which));
                  manager.badgeDropdown.panel.ticketicon.visible = true;
               }
               else
               {
                  manager.badgeDropdown.panel.tickets_txt.text = "";
                  manager.badgeDropdown.panel.ticketicon.visible = false;
               }
               manager.badgeDropdown.panel.thumb.gotoAndStop(which + 1);
               manager.gameObj.var_129.playSound("getstar.wav");
            }
            else if(whichType == "special")
            {
               manager.badgeDropdown.panel.visible = false;
               manager.badgeDropdown.panel.thumb.stop();
               special = manager.gameObj.var_133.getSpecial(which);
               if(special != null)
               {
                  manager.badgeDropdown.special.title_txt.text = special.title;
                  manager.badgeDropdown.special.bonus_txt.text = special.getBonusString();
                  numStars = manager.gameObj.var_128.getSpecialStars(which);
                  s = 1;
                  while(s <= 5)
                  {
                     if(numStars >= s)
                     {
                        manager.badgeDropdown.special["star" + s].visible = true;
                     }
                     else
                     {
                        manager.badgeDropdown.special["star" + s].visible = false;
                     }
                     s++;
                  }
                  try
                  {
                     manager.badgeDropdownBitmap = new Bitmap(manager.gameObj.var_134.specialBMP,"auto",true);
                     manager.badgeDropdownBitmap.scaleX = 0.3;
                     manager.badgeDropdownBitmap.scaleY = 0.3;
                     manager.badgeDropdownBitmap.x = 5;
                     manager.badgeDropdownBitmap.y = 0;
                     manager.badgeDropdown.special.addChild(manager.badgeDropdownBitmap);
                  }
                  catch(err:Error)
                  {
                     class_7.error("Error adding special icon: " + err.message);
                  }
               }
               else
               {
                  class_7.error("Error with special dropdown.");
               }
               manager.gameObj.var_129.playSound("getstar.wav");
            }
            manager.dropdownOnScreenTimer = 0;
            manager.dropdownStartY = 0 - manager.dropdownHeight;
            if(manager.gameObj.var_132.api.var_140.length == 0)
            {
               manager.badgeDropdown.y = this.dropdownStartY;
               manager.gameObj.addChild(manager.badgeDropdown);
            }
            else
            {
               manager.badgeDropdown.y = this.dropdownStartY;
               manager.gameObj.addChild(manager.badgeDropdown);
            }
            manager.badgeDropdown.addEventListener(Event.ENTER_FRAME,manager.animateBadgeDropdown);
            manager.badgeDropdown.addEventListener(MouseEvent.CLICK,manager.clickBadgeDropdown);
         }
      }
      
      public function clickBadgeDropdown(param1:MouseEvent) : void
      {
         var _loc2_:ChallengeManager = this;
         _loc2_.dropdownOnScreenTimer = _loc2_.dropdownOnScreenWait - 1;
      }
      
      public function animateBadgeDropdown(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:ChallengeManager = this;
         if(_loc3_.badgeDropdown != null)
         {
            if(_loc3_.dropdownOnScreenTimer == 0)
            {
               if(_loc3_.badgeDropdown.y < _loc3_.dropdownStartY + _loc3_.dropdownHeight)
               {
                  _loc2_ = _loc3_.dropdownStartY + _loc3_.dropdownHeight - _loc3_.badgeDropdown.y;
                  _loc3_.badgeDropdown.y += _loc2_ / _loc3_.dropdownSpeed;
                  if(_loc2_ >= -1 && _loc2_ <= 1)
                  {
                     _loc3_.badgeDropdown.y = _loc3_.dropdownStartY + _loc3_.dropdownHeight;
                     ++_loc3_.dropdownOnScreenTimer;
                  }
               }
            }
            else if(_loc3_.dropdownOnScreenTimer == _loc3_.dropdownOnScreenWait)
            {
               if(_loc3_.badgeDropdown.y > _loc3_.dropdownStartY)
               {
                  _loc2_ = _loc3_.dropdownStartY - _loc3_.badgeDropdown.y;
                  _loc3_.badgeDropdown.y += _loc2_ / _loc3_.dropdownSpeed;
                  if(_loc2_ >= -1 && _loc2_ <= 1)
                  {
                     if(_loc3_.badgeDropdownBitmap != null)
                     {
                        _loc3_.badgeDropdownBitmap.bitmapData = null;
                        if(_loc3_.badgeDropdownBitmap.parent)
                        {
                           _loc3_.badgeDropdownBitmap.parent.removeChild(_loc3_.badgeDropdownBitmap);
                        }
                        _loc3_.badgeDropdownBitmap = null;
                     }
                     _loc3_.badgeDropdown.removeEventListener(Event.ENTER_FRAME,_loc3_.animateBadgeDropdown);
                     _loc3_.badgeDropdown.removeEventListener(MouseEvent.CLICK,_loc3_.clickBadgeDropdown);
                     _loc3_.badgeDropdown.parent.removeChild(_loc3_.badgeDropdown);
                     _loc3_.badgeDropdown = null;
                     _loc3_.badgeQueue.shift();
                     _loc3_.badgeQueueType.shift();
                     _loc3_.checkForDisplayingBadges();
                  }
               }
            }
            else
            {
               ++_loc3_.dropdownOnScreenTimer;
            }
         }
      }
   }
}


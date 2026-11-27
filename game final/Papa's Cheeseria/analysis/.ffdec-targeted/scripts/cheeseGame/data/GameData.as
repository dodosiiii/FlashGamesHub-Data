package cheeseGame.data
{
   import flash.display.*;
   import package_2.*;
   import package_4.*;
   
   public class GameData
   {
      
      public static const DAY_TO_HIRE:Number = 5;
      
      public static const DELAY_BETWEEN_BRINGING_SPECIALS:Number = 3;
      
      public static const MONTH_NAMES:Array = ["Month 0","January","February","March","April","May","June","July","August","September","October","November","December"];
      
      public static const MONTH_JANUARY:Number = 1;
      
      public static const MONTH_FEBRUARY:Number = 2;
      
      public static const MONTH_MARCH:Number = 3;
      
      public static const MONTH_APRIL:Number = 4;
      
      public static const MONTH_MAY:Number = 5;
      
      public static const MONTH_JUNE:Number = 6;
      
      public static const MONTH_JULY:Number = 7;
      
      public static const MONTH_AUGUST:Number = 8;
      
      public static const MONTH_SEPTEMBER:Number = 9;
      
      public static const MONTH_OCTOBER:Number = 10;
      
      public static const MONTH_NOVEMBER:Number = 11;
      
      public static const MONTH_DECEMBER:Number = 12;
      
      public static const STARTER_MONTH:Number = 4;
      
      public var gameObj:class_5;
      
      public var shopItems:Array;
      
      public var boomboxTag:String = "";
      
      public var jukeboxTag:String = "";
      
      public var phonographTag:String = "";
      
      public var themeTagsPerMonth:Array;
      
      public var themeTagNames:Array;
      
      public var furniItems:Array;
      
      public var minigamePrizes:Array;
      
      public var unlockArray:Array;
      
      public var specials:Array;
      
      public function GameData(param1:class_5)
      {
         this.shopItems = [new Upgrade("doorbell","Doorbell",450,"","You\'ll hear when new customers enter, no matter where you are.",0),new Upgrade("booster0","Cook Booster 1",12000,"","Hold down the booster to grill sandwiches faster.",0),new Upgrade("booster1","Cook Booster 2",12000,"","Hold down the booster to grill sandwiches faster.",0),new Upgrade("booster2","Cook Booster 3",12000,"","Hold down the booster to grill sandwiches faster.",0),new Upgrade("booster3","Cook Booster 4",12000,"","Hold down the booster to grill sandwiches faster.",0),new Upgrade("lightalarm","Light Alarm",8000,"","Alerts you when to flip and remove Light sandwiches.",0),new Upgrade("mediumalarm","Regular Alarm",8000,"","Alerts you when to flip and remove Regular sandwiches.",0),new Upgrade("wellalarm","Well-Done Alarm",8000,"","Alerts you when to flip and remove Well Done sandwiches.",0),new Upgrade("fryboost0","Fry Booster 1",12000,"","Hold down the booster to cook \nfries faster.",0),new Upgrade("fryboost1","Fry Booster 2"
         ,12000,"","Hold down the booster to cook \nfries faster.",0),new Upgrade("fryalarm0","Fry Alarm 1",8000,"","This will alert you when fries are done cooking.",0),new Upgrade("fryalarm1","Fry Alarm 2",8000,"","This will alert you when fries are done cooking.",0),new Upgrade("specialsign","Special Sign",25000,"","More customers will order Today\'s Special!",0)];
         this.themeTagsPerMonth = ["","N","V","P","E","D","L","S","F","M","H","T","C"];
         this.themeTagNames = ["","New Year","Valentine\'s Day","St. Paddy\'s Day","Easter","Cinco de Mayo","Summer Luau","Starlight BBQ","Portallini Feast","Maple Mornings","Halloween","Thanksgiving","Christmas"];
         this.furniItems = [new FurniData("g","poster_window","Large Window",7500,"Waiting","Get a view of the outside.",FurniData.TYPE_POSTER,3,3,3),new FurniData("g","poster_window2","Thin Window",4500,"Waiting","Get a (smaller) view of the outside.",FurniData.TYPE_POSTER,3,1,2),new FurniData("g","poster_window3","Tall Window",7500,"Waiting","Let some light in.",FurniData.TYPE_POSTER,2,4,3),new FurniData("g","poster_window4","Round Window",5500,"Waiting","Peek out the porthole.",FurniData.TYPE_POSTER,2,2,2,"none","none","none"),new FurniData("g","wall1","Starter Wall",6000,"Waiting","Your original wall.",FurniData.TYPE_WALLPAPER,1,1,1,"none","none","none",false),new FurniData("g","floor1","Starter Floor",6000,"Waiting","Your original flooring.",FurniData.TYPE_FLOORING,1,1,1,"none","none","none",false),new FurniData("D","furni_cincodemayo_table_small","Sm. Cinco Table",3500,"Waiting","",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("D","furni_cincodemayo_table_medium","Md. Cinco Table"
         ,5500,"Waiting","",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("D","furni_cincodemayo_table_large","Lg. Cinco Table",7500,"Waiting","",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("D","furni_cincodemayo_fence","Cinco Fence",6500,"Waiting","",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("D","furni_cincodemayo_cactus","Cactus",7500,"Waiting","",FurniData.TYPE_FURNI,3,1,3,"none","none","none",true),new FurniData("D","furni_cincodemayo_jukebox","Jukebox",45000,"Waiting","Put on some tunes for your guests.",FurniData.TYPE_FURNI,3,1,6,FurniData.SPECIAL_MUSIC,"jukebox","none",true),new FurniData("D","furni_cincodemayo_gumball_mango","Mango Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("D","poster_cincodemayo","Cinco Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2,"none","none","none"),new FurniData("D","poster_jalapenos","Spicy Poster",4500,"Jalapeños","",FurniData.TYPE_POSTER
         ,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_JALAPENOS,true),new FurniData("D","poster_nachochees","Nacho Poster",4500,"Nacho Sauce","",FurniData.TYPE_POSTER,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRYSAUCE_NACHO,true),new FurniData("D","poster_fajita","Fajita Poster",3500,"Fajita Peppers","",FurniData.TYPE_POSTER,1,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_PEPPERS,true),new FurniData("D","wall11","Cinco Festival Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("D","wall12","Cinco Stripe Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("D","wall13","Cinco Dot Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("D","floor8","Cobblestone Floor",6000,"Waiting","",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("D","floor9","Colored Planks",6000,"Waiting","",FurniData.TYPE_FLOORING,1,1,2,"none","none","none")
         ,new FurniData("L","furni_luau_table_small","Sm. Luau Table",3500,"Waiting","A small Luau table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("L","furni_luau_table_medium","Luau Boombox",6500,"Waiting","Table with a Boombox!",FurniData.TYPE_FURNI,3,1,2,FurniData.SPECIAL_MUSIC,"boombox","none",true),new FurniData("L","furni_luau_table_large","Luau Punch Table",7500,"Waiting","A table with tropical punch.",FurniData.TYPE_FURNI,4,1,3,FurniData.SPECIAL_PUNCH,"none","none",true),new FurniData("L","furni_luau_umbrella","Luau Umbrella",8500,"Waiting","Stay in the shade.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("L","furni_luau_surfboard","Surfboard",15000,"Waiting","Straight from the Surf Shack!",FurniData.TYPE_FURNI,2,1,3,"none","none","none",true),new FurniData("L","furni_luau_plants","Planter Box",4000,"Waiting","A bit of flowers to spruce up the place.",FurniData.TYPE_FURNI,4,1,2,"none","none","none"),new FurniData("L","furni_luau_gumball_banana"
         ,"Banana Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("L","poster_summerluau","Luau Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2,"none","none","none"),new FurniData("L","poster_sauerkraut","Kraut Poster",4000,"Sauerkraut","",FurniData.TYPE_POSTER,3,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_SAUERKRAUT,true),new FurniData("L","poster_lobster","Lobster Poster",4500,"Lobster Chunks","",FurniData.TYPE_POSTER,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_LOBSTER,true),new FurniData("L","poster_mustard","Mustard Poster",3500,"Mustard","",FurniData.TYPE_POSTER,1,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_MUSTARD,true),new FurniData("L","poster_crinklefries","Crinkle Poster",4000,"Crinkle Cut Fries","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRIES_CRINKLE,true),new FurniData("L","wall14","Yellow Lattice",6000,"Waiting","A yellow lattice wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none"
         ,"none"),new FurniData("L","wall15","Sunset Wall",6000,"Waiting","A fading sunset wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("L","wall16","Teal Stripe Wall",6000,"Waiting","A teal striped wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("L","floor10","Teal Zigzag Floor",6000,"Waiting","Teal zig-zag floor for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("L","floor11","White Sand Floor",6000,"Waiting","Bring the beach inside.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("S","furni_jubilee_table_small","Sm. Starlight Table",3500,"Waiting","A small patriotic table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("S","furni_jubilee_table_medium","Md. Starlight Table",5500,"Waiting","A medium Jubilee table.",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("S","furni_jubilee_table_large","Lg. Starlight Table",7500,"Waiting","A large Jubilee table."
         ,FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("S","furni_jubilee_fence","Starry Fence",3000,"Waiting","Show your pride on your fence!",FurniData.TYPE_FURNI,4,1,3,"none","none","none"),new FurniData("S","furni_jubilee_flag2","Red Flag",2500,"Waiting","Fly the flag of tastiness.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("S","furni_jubilee_flag1","Blue Flag",5000,"Waiting","A large Jubilee flag.",FurniData.TYPE_FURNI,2,1,2,"none","none","none",true),new FurniData("S","furni_jubilee_gumball_powsicle","Powsicle Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("S","poster_starlightbbq","Starlight Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("S","poster_ranch","Ranch Poster",4000,"Ranch","",FurniData.TYPE_POSTER,3,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_RANCH),new FurniData("S","poster_bbq","BBQ Poster",4000,"BBQ Sauce","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE
         ,"build",FoodData.SAUCE_BBQ,true),new FurniData("S","poster_bacon","Bacon Poster",4000,"Bacon","",FurniData.TYPE_POSTER,1,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_BACON,true),new FurniData("S","wall17","Blue Brick Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("S","wall18","Patriotic Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("S","wall19","Starstripe Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("S","floor12","Dark Star Carpet",6000,"Waiting","Dark star carpeting for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("S","floor13","Blue Plaid Floor",6000,"Waiting","Blue plaid floor.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("F","furni_portallinifeast_table_small","Sm. Feast Table",3500,"Waiting","A small classic table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("F"
         ,"furni_portallinifeast_table_medium","Md. Feast Table",5500,"Waiting","A medium classic table",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("F","furni_portallinifeast_table_large","Lg. Feast Table",7500,"Waiting","A large classic table.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("F","furni_portallinifeast_rope","Feast Velvet Rope",8500,"Waiting","",FurniData.TYPE_FURNI,5,1,3,"none","none","none",true),new FurniData("F","furni_portallinifeast_pillar","Tomato Column",10000,"Waiting","",FurniData.TYPE_FURNI,2,1,4,"none","none","none",true),new FurniData("F","furni_portallinifeast_painting","Romano Painting",12000,"Waiting & Romano","",FurniData.TYPE_FURNI,4,1,3,FurniData.SPECIAL_SCORE,"customer","romano",true),new FurniData("F","furni_portallinifeast_gumball_cherry","Cherry Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("F","poster_portallinifeast","Portallini Poster",4500,"Waiting","",FurniData
         .TYPE_POSTER,3,2,2),new FurniData("F","poster_mushrooms","Shrooms Poster",4000,"Mushrooms","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_MUSHROOMS,true),new FurniData("F","poster_salami","Salami Poster",4500,"Sliced Salami","",FurniData.TYPE_POSTER,2,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_SALAMI,true),new FurniData("F","poster_ketchup","Ketchup Poster",3500,"Ketchup","",FurniData.TYPE_POSTER,1,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_KETCHUP,true),new FurniData("F","poster_curleyfries","Curly Poster",4000,"Curly Fries","",FurniData.TYPE_POSTER,1,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRIES_CURLY,true),new FurniData("F","wall20","Feast Dot Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("F","wall21","Orange Sky Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("F","wall22","White Pattern Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER
         ,1,1,2,"none","none","none"),new FurniData("F","floor14","Lime Zigzag Floor",6000,"Waiting","",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("F","floor15","Marinara Carpet",6000,"Waiting","",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("M","furni_maple_table_small","Sm. Maple Table",3500,"Waiting","",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("M","furni_maple_table_medium","Md. Maple Table",5500,"Waiting","",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("M","furni_maple_waffletable","Waffle Table",7500,"Waiting","",FurniData.TYPE_FURNI,4,1,4,"none","none","none",true),new FurniData("M","furni_maple_fence","Log Fence",5000,"Waiting","",FurniData.TYPE_FURNI,4,1,3,"none","none","none"),new FurniData("M","furni_maple_log","Lumberjack Log",6000,"Waiting","",FurniData.TYPE_FURNI,3,1,3),new FurniData("M","furni_maple_pinetree","Pine Tree",5500,"Waiting","",FurniData.TYPE_FURNI,3,1,3,"none","none","none"
         ,true),new FurniData("M","furni_maple_gumball_chocolate","Chocolate Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("M","poster_maplemornings","Mornings Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("M","poster_honeymustard","Honey Mustard Poster",4000,"Honey Mustard","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_HONEYMUSTARD,true),new FurniData("M","poster_chicken","Chicken Poster",4000,"Grilled Chicken","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_CHICKEN,true),new FurniData("M","poster_wafflefries","Waffle Poster",4500,"Waffle Fries","",FurniData.TYPE_POSTER,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRIES_WAFFLE,true),new FurniData("M","poster_friedegg","Egg Poster",3500,"Fried Egg","",FurniData.TYPE_POSTER,2,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_FRIEDEGG,true),new FurniData("M","wall23","Log Cabin Wall",6000,"Waiting","",FurniData
         .TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("M","wall24","Wood Grain Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("M","wall25","Flatware Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("M","floor16","Wood Planks",6000,"Waiting","Swirly.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("M","floor17","Green Thick Carpet",6000,"Waiting","Red carpet for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("H","furni_halloween_table_small","Sm. Halloween Table",3500,"Waiting","A small Halloween table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("H","furni_halloween_table_medium","Md. Halloween Table",5500,"Waiting","A medium Ghoul table.",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("H","furni_halloween_table_large","Lg. Halloween Table",7500,"Waiting","A large Jack O\' Lantern table.",FurniData
         .TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("H","furni_halloween_belltower_ghost","Belltower Ghost",6000,"Waiting","Boooooo!",FurniData.TYPE_FURNI,2,1,2,"none","none","none",true),new FurniData("H","furni_halloween_spider","Spindly Spider",8500,"Waiting","A fuzzy monster for the shop.",FurniData.TYPE_FURNI,3,1,3,"none","none","none"),new FurniData("H","furni_halloween_bats","Hanging Bats",10000,"Waiting","A swarm of hanging bats.",FurniData.TYPE_FURNI,4,1,4,"none","none","none",true),new FurniData("H","furni_halloween_gumball_licorice","Licorice Gum",8500,"Waiting","A Halloween favorite.",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("H","poster_halloween","Halloween Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("H","poster_wildonion","Wild Onion Poster",4500,"Wild Onion Sauce","",FurniData.TYPE_POSTER,2,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_WILDONION),new FurniData("H","poster_buffalosauce","Buffalo Poster",4000
         ,"Buffalo Sauce","",FurniData.TYPE_POSTER,3,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_BUFFALO,true),new FurniData("H","poster_sweetpotatofries","Sweet Poster",4000,"Sweet Potato","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRIES_SWEETPOTATO,true),new FurniData("H","poster_balsamic","Balsamic Poster",3000,"Balsamic Dressing","",FurniData.TYPE_POSTER,1,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_BALSAMIC,true),new FurniData("H","wall26","Orange Stripe Wall",6000,"Waiting","An orange stripe wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("H","wall27","Purple Plaid Wall",6000,"Waiting","A purple plaid wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("H","wall28","Halloween Wall",6000,"Waiting","Orange wallpaper with dark wood trim.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("H","floor18","Dark Wood Floor",6000,"Waiting","Dark wood flooring for the shop.",FurniData
         .TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("H","floor19","Spooky Tile",6000,"Waiting","Puple and black tile floor.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("T","furni_thanksgiving_table_small","Sm. Harvest Table",3500,"Waiting","A small harvest table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("T","furni_thanksgiving_table_medium","Md. Harvest Table",5500,"Waiting","A medium harvest table.",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("T","furni_thanksgiving_table_large","Lg. Harvest Table",7500,"Waiting","A large harvest table.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("T","furni_thanksgiving_newspapers","Newspaper Stand",8000,"Waiting","Set out some reading material.",FurniData.TYPE_FURNI,3,1,4,FurniData.SPECIAL_NEWSPAPER,"none","none",true),new FurniData("T","furni_thanksgiving_cornstalks","Corn Stalks",7000,"Waiting","A box of corn stalks.",FurniData.TYPE_FURNI,4,1
         ,3,"none","none","none"),new FurniData("T","furni_thanksgiving_tree","Autumn Tree",13000,"Waiting","Bring the trees inside!",FurniData.TYPE_FURNI,4,1,4,"none","none","none",true),new FurniData("T","furni_thanksgiving_gumball_cloudberry","Pumpkin Pie Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("T","poster_thanksgiving","Thanks Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("T","poster_fryseasoning","Seasoning Poster",4500,"Fry Seasoning","",FurniData.TYPE_POSTER,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRYTOPPING_SEASONING,true),new FurniData("T","poster_turkey","Turkeys Poster",4000,"Sliced Turkey","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_TURKEY,true),new FurniData("T","poster_phillysteak","Philly Poster",3500,"Philly Steak","",FurniData.TYPE_POSTER,2,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_PHILLYSTEAK,true),new FurniData("T","wall29","Multigrain Wall",6000,"Waiting"
         ,"A multigrain wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("T","wall30","Harvest Wall",6000,"Waiting","A harvest wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("T","wall31","Orange Zigzag Wall",6000,"Waiting","A log cabin wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("T","floor20","Multigrain Floor",6000,"Waiting","Multigrain flooring for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("T","floor21","Walnut Floor",6000,"Waiting","A deep walnut wood floor.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("C","furni_christmas_table_small","Sm. Holiday Table",3500,"Waiting","A small Christmas table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("C","furni_christmas_table_medium","Festive Phonograph",5500,"Waiting","A Christmas table with a Phonograph.",FurniData.TYPE_FURNI,3,1,2,FurniData.SPECIAL_MUSIC,"phonograph","none",true)
         ,new FurniData("C","furni_christmas_table_large","Lg. Holiday Table",7500,"Waiting","A large holiday coffee table.",FurniData.TYPE_FURNI,4,1,3,FurniData.SPECIAL_COFFEE,"none","none",true),new FurniData("C","furni_christmas_tree","Christmas Tree",9500,"Waiting","A festive decorated tree for the shop!",FurniData.TYPE_FURNI,4,1,4,"none","none","none",true),new FurniData("C","furni_christmas_fireplace","Fireplace",12000,"Waiting","Stockings included!",FurniData.TYPE_FURNI,5,1,4,"none","none","none",true),new FurniData("C","furni_christmas_poinsettia","Poinsettia Box",7500,"Waiting","Some winter flowers for the shop.",FurniData.TYPE_FURNI,4,1,2,"none","none","none"),new FurniData("C","furni_christmas_gumball_candycane","Candy Cane Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("C","poster_christmas","Wreath Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("C","poster_tomatoes","Tomato Poster",4500,"Tomato","",FurniData.TYPE_POSTER
         ,2,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_TOMATO),new FurniData("C","poster_pulledpork","Pork Poster",4500,"Pulled Pork","",FurniData.TYPE_POSTER,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_PULLEDPORK,true),new FurniData("C","poster_rosemary","Rosemary Poster",4000,"Rosemary","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRYTOPPING_ROSEMARY,true),new FurniData("C","wall32","Forest Wall",6000,"Waiting","A forest wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("C","wall33","Christmas Wall",6000,"Waiting","A red and green wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("C","wall34","Candy Stripe Wall",6000,"Waiting","A candy-striped wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("C","floor22","Red Floor",6000,"Waiting","A red brick floor for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("C","floor23","Snow Floor",6000
         ,"Waiting","Snow flooring.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("N","furni_newyear_table_small","Sm. Rainbow Table",3500,"Waiting","A small rainbow table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("N","furni_newyear_table_medium","Md. Rainbow Table",5500,"Waiting","A medium rainbow table.",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("N","furni_newyear_table_large","Lg. Rainbow Table",7500,"Waiting","A large rainbow table.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("N","furni_newyear_streetlamp","Stache Lamp",10000,"Waiting","Bring the street inside!",FurniData.TYPE_FURNI,2,1,3,"none","none","none",true),new FurniData("N","furni_newyear_fence","New Year Fence",3000,"Waiting","A rainbow fence for the New Year.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("N","furni_newyear_comicbooks","Comic Books",15000,"Waiting","Flip through some comics while you wait!",FurniData
         .TYPE_FURNI,2,1,3,FurniData.SPECIAL_COMICS,"none","none"),new FurniData("N","furni_newyear_gumball_rainblow","Rainblow Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("N","poster_newyear","New Year Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("N","poster_chilifest","Chili Poster",4500,"Rico\'s Chili","",FurniData.TYPE_POSTER,3,2,3,FurniData.SPECIAL_SCORE,"build",FoodData.FRYTOPPING_CHILI,true),new FurniData("N","poster_olives","Olives Poster",3500,"Olives","",FurniData.TYPE_POSTER,1,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_OLIVES,true),new FurniData("N","poster_cheddar","Cheddar Poster",4000,"Cheddar Topping","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRYTOPPING_CHEDDAR,true),new FurniData("N","wall35","Prism Wall",6000,"Waiting","A prism beam wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("N","wall36","Rainbow Stripe Wall",6000,"Waiting","A rainbow stripe wall."
         ,FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("N","wall37","Color Swirl Wall",6000,"Waiting","A rainbow swirl wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("N","floor24","Lattice Floor",6000,"Waiting","Rainbow lattice flooring for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("N","floor25","Circle Floor",6000,"Waiting","A colored circle floor.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("V","furni_valentine_table_small","Sm. Valentine Table",3500,"Waiting","A small Valentine table.",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("V","furni_valentine_table_medium","Md. Valentine Table",5500,"Waiting","A medium Valentine table",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("V","furni_valentine_table_large","Lg. Valentine Table",7500,"Waiting","A large Valentine table.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("V"
         ,"furni_valentine_balloons","Valentine Balloons",4000,"Waiting","Some balloons for the holiday.",FurniData.TYPE_FURNI,3,1,3,"none","none","none"),new FurniData("V","furni_valentine_fence","Valentine Fence",6500,"Waiting","A Valentine-themed fence.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("V","furni_valentine_bonsai","Valentine Bonsai",8000,"Waiting","",FurniData.TYPE_FURNI,2,1,3,"none","none","none",true),new FurniData("V","furni_valentine_gumball_strawberry","Strawberry Gum",8500,"Waiting","Very berry gum!",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("V","poster_valentinesday","Valentine\'s Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2,"none","none","none"),new FurniData("V","poster_cornedbeef","Corned Beef Poster",4000,"Corned Beef","",FurniData.TYPE_POSTER,3,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_CORNEDBEEF,true),new FurniData("V","poster_poutine","Poutine Poster",4500,"Poutine","",FurniData.TYPE_POSTER,3,2,2
         ,FurniData.SPECIAL_SCORE,"build",FoodData.FRYSAUCE_POUTINE,true),new FurniData("V","poster_ham","Ham Poster",4500,"Sliced Ham","",FurniData.TYPE_POSTER,2,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_HAM,true),new FurniData("V","wall2","Pink Zag Wall",6000,"Waiting","A pink zig-zag wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("V","wall3","Valentine Block Wall",6000,"Waiting","A Valentine block wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("V","wall4","Heart Wall",6000,"Waiting","Celebrate Valentine\'s Day!",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("V","floor2","Pink Carpet",6000,"Waiting","Pink carpeting for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("V","floor3","White Tile",6000,"Waiting","White tile floor.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("P","furni_stpaddy_table_small","Sm. Shamrock Table",3500,"Waiting","A small Shamrock table."
         ,FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("P","furni_stpaddy_table_medium","Md. Shamrock Table",5500,"Waiting","A medium Shamrock table",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("P","furni_stpaddy_table_large","Lg. Shamrock Table",7500,"Waiting","A large Shamrock table.",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("P","furni_stpaddy_potogold","Pot O\' Gold",8500,"Waiting","A lucky pot of gold!",FurniData.TYPE_FURNI,3,1,3,"none","none","none",true),new FurniData("P","furni_stpaddy_arcade_mccoy","McCoy Arcade Game",45000,"Waiting","Keep customers busy with McCoy\'s game!",FurniData.TYPE_FURNI,5,1,6,FurniData.SPECIAL_ARCADE,"none","none",true),new FurniData("P","furni_stpaddy_hangingplant","Hanging Plant",8000,"Waiting","Bring some nature inside the restaurant.",FurniData.TYPE_FURNI,2,1,2,"none","none","none"),new FurniData("P","furni_stpaddy_gumball_mint","Mint Gum",8500,"Waiting","Freshens your breath!",FurniData
         .TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("P","poster_stpaddysday","Paddy\'s Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2,"none","none","none"),new FurniData("P","poster_pickledisk","Pickle Poster",4000,"Deep-Fried Pickles","",FurniData.TYPE_POSTER,3,1,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_PICKLES,true),new FurniData("P","poster_lettuce","Leafy Poster",4500,"Shredded Lettuce","",FurniData.TYPE_POSTER,3,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_LETTUCE,true),new FurniData("P","poster_regularfries","Fries Poster",4500,"French Fries","",FurniData.TYPE_POSTER,2,3,3,FurniData.SPECIAL_SCORE,"build",FoodData.FRIES_REGULAR,true),new FurniData("P","poster_chives","Chives Poster",3500,"Chives","",FurniData.TYPE_POSTER,1,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRYTOPPING_CHIVES,true),new FurniData("P","wall5","Lime Stripe Wall",6000,"Waiting","A green striped wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("P","wall6"
         ,"Shamrock Wall",6000,"Waiting","A lucky shamrock wall.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("P","wall7","Green Striped Wall",6000,"Waiting","Green stripes with wood trim.",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("P","floor4","Green Carpet",6000,"Waiting","Green carpeting for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("P","floor5","Golden Tile",6000,"Waiting","Golden tile floor.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("E","furni_easter_table_small","Sm. Easter Table",3500,"Waiting","",FurniData.TYPE_FURNI,2,1,1,"none","none","none",true),new FurniData("E","furni_easter_table_medium","Md. Easter Table",5500,"Waiting","",FurniData.TYPE_FURNI,3,1,2,"none","none","none",true),new FurniData("E","furni_easter_table_large","Lg. Easter Table",7500,"Waiting","",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("E","furni_easter_fence","Easter Glass Block"
         ,12000,"Waiting","",FurniData.TYPE_FURNI,4,1,3,"none","none","none",true),new FurniData("E","furni_easter_arcade_steaknjake","SnJ Arcade Game",50000,"Waiting","",FurniData.TYPE_FURNI,5,1,6,FurniData.SPECIAL_ARCADE,"none","none",true),new FurniData("E","furni_easter_freezietreats","Treats Cooler",12000,"Waiting","",FurniData.TYPE_FURNI,5,1,4,"none","none","none"),new FurniData("E","furni_easter_gumball_pinklemonade","Pink Lemonade Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,2,FurniData.SPECIAL_BUBBLEGUM),new FurniData("E","poster_easter","Easter Poster",4500,"Waiting","",FurniData.TYPE_POSTER,3,2,2),new FurniData("E","poster_sourcream","Sour Cream Poster",4000,"Sour Cream","",FurniData.TYPE_POSTER,2,2,2,FurniData.SPECIAL_SCORE,"build",FoodData.FRYSAUCE_SOURCREAM,true),new FurniData("E","poster_awesomesauce","Awesome Poster",4500,"Awesome Sauce","",FurniData.TYPE_POSTER,2,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.SAUCE_AWESOME,true),new FurniData("E","poster_sauteedonions","Onion Poster"
         ,4500,"Sauteed Onions","",FurniData.TYPE_POSTER,2,3,2,FurniData.SPECIAL_SCORE,"build",FoodData.TOPPING_ONIONS,true),new FurniData("E","poster_fliplinestudios","Flipline Poster",3500,"Waiting","",FurniData.TYPE_POSTER,2,1,2),new FurniData("E","wall8","Blue Diamond Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none"),new FurniData("E","wall9","Egg Yolk Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("E","wall10","Easter Stripe Wall",6000,"Waiting","",FurniData.TYPE_WALLPAPER,1,1,2,"none","none","none",true),new FurniData("E","floor6","Blue Polkadot Floor",6000,"Waiting","Blue Polkadot flooring for the shop.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none"),new FurniData("E","floor7","Yellow Stripe Floor",6000,"Waiting","Yellow striped flooring.",FurniData.TYPE_FLOORING,1,1,2,"none","none","none",true),new FurniData("mgb","furni_bronze_arcade_papalouie","Papa Arcade Game",50000,"Waiting","",FurniData.TYPE_FURNI,5,1,12
         ,FurniData.SPECIAL_ARCADE,"none","none",true),new FurniData("mgb","furni_bronze_thegreatonion","The Great Onion",13000,"Waiting","",FurniData.TYPE_FURNI,4,1,10,"none","none","none",true),new FurniData("mgb","furni_bronze_arch","Wedding Arch",12000,"Waiting","",FurniData.TYPE_FURNI,4,1,6,"none","none","none",true),new FurniData("mgb","furni_bronze_crate_large","Lg. Onion Crate",7500,"Waiting","",FurniData.TYPE_FURNI,4,1,6,"none","none","none",true),new FurniData("mgb","furni_bronze_ball_lamp2","High Ball Lamp",8000,"Waiting","",FurniData.TYPE_FURNI,2,1,6,"none","none","none",true),new FurniData("mgb","furni_bronze_gumball_anchovy","Anchovy Gum",8500,"Waiting","",FurniData.TYPE_FURNI,2,1,6,FurniData.SPECIAL_BUBBLEGUM,"none","none",true),new FurniData("mgs","furni_silver_arcade_rico","Rowdy Rico Game",50000,"Waiting","",FurniData.TYPE_FURNI,5,1,12,FurniData.SPECIAL_ARCADE,"none","none",true),new FurniData("mgs","furni_silver_skyninjaflag","Sky Ninja Flag",10000,"Waiting","",FurniData.TYPE_FURNI
         ,2,1,6,"none","none","none",true),new FurniData("mgs","furni_silver_bookshelf","Trophy Case",15000,"Waiting","",FurniData.TYPE_FURNI,5,1,8,FurniData.SPECIAL_BOOK,"none","none",true),new FurniData("mgs","furni_silver_tires","Pile of Tires",13000,"Waiting","",FurniData.TYPE_FURNI,5,1,8,"none","none","none",true),new FurniData("mgs","furni_silver_flag","Jolly Roger Flag",5000,"Waiting","",FurniData.TYPE_FURNI,2,1,6,"none","none","none",true),new FurniData("mgs","furni_silver_fencewings","Wing Sign",8500,"Waiting","",FurniData.TYPE_FURNI,4,1,6,"none","none","none",true),new FurniData("mgg","furni_gold_arcade_jacksmith","Jacksmith Arcade",50000,"Waiting","",FurniData.TYPE_FURNI,5,1,12,FurniData.SPECIAL_ARCADE,"none","none",true),new FurniData("mgg","furni_gold_palm_tree","Palm Tree",10000,"Waiting","",FurniData.TYPE_FURNI,3,1,6,"none","none","none",true),new FurniData("mgg","furni_gold_popmachine","Soda Machine",25000,"Waiting","",FurniData.TYPE_FURNI,4,1,8,FurniData.SPECIAL_SODA,"none","none"
         ,true),new FurniData("mgg","furni_gold_papalouie_bust","Papa Bust",25000,"Waiting","",FurniData.TYPE_FURNI,2,1,8,"none","none","none",true),new FurniData("mgg","furni_gold_peanuts","Peanut Barrel",5500,"Waiting","",FurniData.TYPE_FURNI,3,1,3,"none","none","none",true),new FurniData("mgg","furni_gold_piratebash_cannon","Pirate Cannon",12000,"Waiting","",FurniData.TYPE_FURNI,4,1,8,"none","none","none",true)];
         this.minigamePrizes = [["tint_tshirt_maracas_a","floor3","tint_vneck_striped_e","poster_cincodemayo","tint_gloves1_h","furni_luau_gumball_banana","tint_winterhat2_e","wall12","tint_belt_1_b","poster_fajita","helmet02","furni_newyear_streetlamp","tint_powerglove_a","furni_bronze_arcade_papalouie","furni_silver_skyninjaflag","furni_gold_peanuts"],["poster_mustard","tint_polo_5_r","furni_cincodemayo_table_medium","tint_bandana_o","wall16","poster_summerluau","tint_belt_3_g","floor22","tint_sweater_3alt_k","furni_valentine_balloons","tint_gloves4_b","helmet03","smartwatch2","furni_bronze_thegreatonion","furni_silver_tires","furni_gold_palm_tree"],["poster_bacon","tint_buttondown_8_f","furni_jubilee_flag1","tint_gloves5_b","furni_stpaddy_hangingplant","tint_belt_4_c","tint_turtleneck_1_f","wall24","tint_beanie_j","poster_buffalosauce","floor18","tint_shoes1_g","hat13","furni_bronze_crate_large","furni_silver_arcade_rico","furni_gold_popmachine"],["tint_shoes4_i","furni_maple_fence","floor13"
         ,"tint_hawaiian_1_q","poster_chicken","tint_cadet_g","furni_easter_gumball_pinklemonade","hat16","tint_sweater_2_c","wall29","tint_belt_6_f","poster_christmas","tint_gloves6_e","furni_bronze_ball_lamp2","furni_silver_bookshelf","furni_gold_papalouie_bust"],["poster_tomatoes","tint_suspenders_1_m","floor10","tint_armwarmer_h","furni_jubilee_table_small","tint_hockey_1_c","poster_halloween","tint_fedora3_d","wall19","tint_wristband_f","hat07","furni_halloween_spider","tint_bomberjacket_b","body_bronzeaward","body_silveraward","body_goldaward"],["tint_logocap_r","poster_ham","tint_hooligan_2_o","furni_luau_plants","tint_bball_1_b","floor8","tint_thermal_e","poster_cheddar","tint_wristwatch_d","wall2","tint_trenchcoat_b","furni_thanksgiving_table_large","hat20","furni_bronze_gumball_anchovy","furni_silver_flag","furni_gold_arcade_jacksmith"],["tint_shortthermal_n","poster_regularfries","tint_beadbracelet_i","wall10","tint_trapper2_o","poster_fliplinestudios","tint_tank_flames_f","hat06","floor16"
         ,"tint_windbreaker_2_f","furni_portallinifeast_painting","tint_eyepatch_d","furni_christmas_fireplace","furni_bronze_arch","furni_silver_fencewings","furni_gold_piratebash_cannon"]];
         this.unlockArray = [new UnlockData(0,"topping",FoodData.BREAD_WHITE,"White Bread"),new UnlockData(0,"topping",FoodData.BREAD_WHEAT,"Wheat Bread"),new UnlockData(0,"topping",FoodData.BREAD_RYE,"Marble Rye"),new UnlockData(0,"topping",FoodData.BREAD_SOURDOUGH,"Sourdough"),new UnlockData(0,"topping",FoodData.BREAD_MULTIGRAIN,"Multigrain Bread"),new UnlockData(0,"topping",FoodData.BREAD_FLATBREAD,"Flatbread"),new UnlockData(3,"topping",FoodData.BREAD_FOCACCIA,"Rosemary Focaccia"),new UnlockData(15,"topping",FoodData.BREAD_PUMPERNICKEL,"Pumpernickel"),new UnlockData(24,"topping",FoodData.BREAD_CIABATTA,"Ciabatta"),new UnlockData(44,"topping",FoodData.BREAD_THREECHEESE,"Three Cheese Bread"),new UnlockData(53,"topping",FoodData.BREAD_PRETZEL,"Pretzel Bread"),new UnlockData(0,"topping",FoodData.CHEESE_AMERICAN,"American Cheese"),new UnlockData(0,"topping",FoodData.CHEESE_SWISS,"Swiss Cheese"),new UnlockData(0,"topping",FoodData.CHEESE_PEPPERJACK,"Pepperjack Cheese"),new UnlockData(0,"topping",FoodData
         .CHEESE_CHEDDAR,"Shredded Cheddar"),new UnlockData(0,"topping",FoodData.CHEESE_MOZZARELLA,"Shredded Mozzarella"),new UnlockData(0,"topping",FoodData.CHEESE_COLBY,"Marble Colby Cheese"),new UnlockData(4,"topping",FoodData.CHEESE_AGEDGOUDA,"Aged Gouda"),new UnlockData(19,"topping",FoodData.CHEESE_PROVOLONE,"Provolone Cheese"),new UnlockData(25,"topping",FoodData.CHEESE_ASIAGO,"Asiago Cheese"),new UnlockData(40,"topping",FoodData.CHEESE_HAVARTI,"Havarti Cheese"),new UnlockData(59,"topping",FoodData.CHEESE_GORGONZOLA,"Gorgonzola Cheese"),new UnlockData(0,"topping",FoodData.TOPPING_HAM,"Sliced Ham"),new UnlockData(0,"topping",FoodData.TOPPING_TURKEY,"Sliced Turkey"),new UnlockData(0,"topping",FoodData.TOPPING_LETTUCE,"Shredded Lettuce"),new UnlockData(0,"topping",FoodData.TOPPING_TOMATO,"Tomato"),new UnlockData(0,"topping",FoodData.TOPPING_BACON,"Bacon"),new UnlockData(1,"topping",FoodData.TOPPING_CHICKEN,"Grilled Chicken"),new UnlockData(8,"topping",FoodData.TOPPING_JALAPENOS,"Jalapeños"),new UnlockData(10
         ,"topping",FoodData.TOPPING_PEPPERS,"Fajita Peppers"),new UnlockData(13,"topping",FoodData.TOPPING_PULLEDPORK,"Pulled Pork"),new UnlockData(20,"topping",FoodData.TOPPING_ONIONS,"Sauteed Onions"),new UnlockData(23,"topping",FoodData.TOPPING_SALAMI,"Sliced Salami"),new UnlockData(28,"topping",FoodData.TOPPING_FRIEDEGG,"Fried Egg"),new UnlockData(30,"topping",FoodData.TOPPING_PHILLYSTEAK,"Philly Steak"),new UnlockData(33,"topping",FoodData.TOPPING_LOBSTER,"Lobster Chunks"),new UnlockData(43,"topping",FoodData.TOPPING_CORNEDBEEF,"Corned Beef"),new UnlockData(45,"topping",FoodData.TOPPING_MUSHROOMS,"Mushrooms"),new UnlockData(48,"topping",FoodData.TOPPING_PICKLES,"Deep-Fried Pickles"),new UnlockData(58,"topping",FoodData.TOPPING_SAUERKRAUT,"Sauerkraut"),new UnlockData(63,"topping",FoodData.TOPPING_OLIVES,"Olives"),new UnlockData(0,"topping",FoodData.SAUCE_RANCH,"Ranch"),new UnlockData(0,"topping",FoodData.SAUCE_MUSTARD,"Mustard"),new UnlockData(0,"topping",FoodData.SAUCE_KETCHUP,"Ketchup"),new UnlockData(2
         ,"topping",FoodData.SAUCE_BUFFALO,"Buffalo Sauce"),new UnlockData(5,"topping",FoodData.SAUCE_BBQ,"BBQ Sauce"),new UnlockData(9,"topping",FoodData.SAUCE_SOUTHWEST,"Southwest Sauce"),new UnlockData(35,"topping",FoodData.SAUCE_WILDONION,"Wild Onion Sauce"),new UnlockData(39,"topping",FoodData.SAUCE_AWESOME,"Awesome Sauce"),new UnlockData(50,"topping",FoodData.SAUCE_HONEYMUSTARD,"Honey Mustard"),new UnlockData(64,"topping",FoodData.SAUCE_BALSAMIC,"Balsamic Dressing"),new UnlockData(0,"topping",FoodData.FRIES_REGULAR,"French Fries"),new UnlockData(0,"topping",FoodData.FRIES_CURLY,"Curly Fries"),new UnlockData(14,"topping",FoodData.FRIES_WAFFLE,"Waffle Fries"),new UnlockData(38,"topping",FoodData.FRIES_SWEETPOTATO,"Sweet Potato Wedges"),new UnlockData(54,"topping",FoodData.FRIES_CRINKLE,"Crinkle Cut Fries"),new UnlockData(0,"topping",FoodData.FRYTOPPING_CHEDDAR,"Cheddar Topping"),new UnlockData(0,"topping",FoodData.FRYTOPPING_BACON,"Bacobites"),new UnlockData(18,"topping",FoodData.FRYTOPPING_CHILI
         ,"Rico\'s Chili"),new UnlockData(29,"topping",FoodData.FRYTOPPING_ROSEMARY,"Rosemary"),new UnlockData(34,"topping",FoodData.FRYSAUCE_SOURCREAM,"Sour Cream"),new UnlockData(49,"topping",FoodData.FRYTOPPING_CHIVES,"Chives"),new UnlockData(55,"topping",FoodData.FRYSAUCE_NACHO,"Nacho Sauce"),new UnlockData(60,"topping",FoodData.FRYTOPPING_SEASONING,"Fry Seasoning"),new UnlockData(65,"topping",FoodData.FRYSAUCE_POUTINE,"Poutine"),new UnlockData(6,"topping",FoodData.TOPPING_CHORIZO,"Chorizo Sausage"),new UnlockData(6,"toppingfiller",FoodData.BREAD_TORTILLA,"Tortilla",7),new UnlockData(7,"topping",FoodData.CHEESE_OAXACA,"Oaxaca Cheese"),new UnlockData(7,"toppingfiller",FoodData.SAUCE_GUACAMOLE,"Guacamole",8),new UnlockData(11,"topping",FoodData.TOPPING_PINEAPPLE,"Pineapple"),new UnlockData(11,"toppingfiller",FoodData.BREAD_HAWAIIAN,"Hawaiian Roll",12),new UnlockData(12,"topping",FoodData.CHEESE_MANGO,"Mango Cream Cheese"),new UnlockData(12,"toppingfiller",FoodData.SAUCE_CALYPSO,"Calypso Sauce"
         ,13),new UnlockData(16,"topping",FoodData.TOPPING_BEEFBRISKET,"Sliced Beef Brisket"),new UnlockData(16,"toppingfiller",FoodData.BREAD_TEXASTOAST,"Texas Toast",17),new UnlockData(17,"topping",FoodData.CHEESE_SMOKEDCHEDDAR,"Smoked Cheddar"),new UnlockData(17,"toppingfiller",FoodData.SAUCE_PITSAUCE,"Lone Star Pit Sauce",18),new UnlockData(21,"topping",FoodData.TOPPING_MEATBALLS,"Meatballs"),new UnlockData(21,"toppingfiller",FoodData.BREAD_PEPPERONI,"Pepperoni Bread",22),new UnlockData(22,"topping",FoodData.CHEESE_RICOTTA,"Ricotta Cheese"),new UnlockData(22,"toppingfiller",FoodData.SAUCE_MARINARA,"Marinara Sauce",23),new UnlockData(26,"topping",FoodData.TOPPING_SAUSAGE,"Maple Mini Sausages"),new UnlockData(26,"toppingfiller",FoodData.BREAD_CINNAMON,"Cinnamon Toast",27),new UnlockData(27,"topping",FoodData.CHEESE_MAPLEJACK,"Maple Jack Cheese"),new UnlockData(27,"toppingfiller",FoodData.SAUCE_MAPLESYRUP,"Maple Syrup",28),new UnlockData(31,"topping",FoodData.TOPPING_SPOOKYSLAW,"Spooky Slaw"),new UnlockData(31
         ,"toppingfiller",FoodData.BREAD_ECTOBREAD,"Ecto Bread",32),new UnlockData(32,"topping",FoodData.CHEESE_MUENSTER,"Monster Muenster"),new UnlockData(32,"toppingfiller",FoodData.SAUCE_JACKOMOLE,"Jackmomole",33),new UnlockData(36,"topping",FoodData.TOPPING_STUFFING,"Stuffing"),new UnlockData(36,"toppingfiller",FoodData.BREAD_PUMPKIN,"Pumpkin Bread",37),new UnlockData(37,"topping",FoodData.CHEESE_CHEESEBALL,"Cheese Ball Spread"),new UnlockData(37,"toppingfiller",FoodData.SAUCE_GRAVY,"Gravy",38),new UnlockData(41,"topping",FoodData.TOPPING_GOOSE,"Roasted Goose"),new UnlockData(41,"toppingfiller",FoodData.BREAD_FRUITCAKE,"Fruitcake",42),new UnlockData(42,"topping",FoodData.CHEESE_GINGERSPICE,"Ginger Spice Cheese"),new UnlockData(42,"toppingfiller",FoodData.SAUCE_CRANBERRY,"Cranberry Chutney",43),new UnlockData(46,"topping",FoodData.TOPPING_MACNCHEESE,"Mac n\' Cheese"),new UnlockData(46,"toppingfiller",FoodData.BREAD_CHEDDARSWIRL,"Cheddar Swirl Bread",47),new UnlockData(47,"topping",FoodData.CHEESE_GRUYERE
         ,"Gruyere Cheese"),new UnlockData(47,"toppingfiller",FoodData.SAUCE_PARMESAN,"Parmesan Sauce",48),new UnlockData(51,"topping",FoodData.TOPPING_SUNDRIEDTOMATOES,"Sun Dried Tomatoes"),new UnlockData(51,"toppingfiller",FoodData.BREAD_BEET,"Beetbread",52),new UnlockData(52,"topping",FoodData.CHEESE_REDWINDSOR,"Red Windsor Cheese"),new UnlockData(52,"toppingfiller",FoodData.SAUCE_STRAWBERRY,"Strawberry Vinaigrette",53),new UnlockData(56,"topping",FoodData.TOPPING_BEEFHASH,"Corned Beef Hash"),new UnlockData(56,"toppingfiller",FoodData.BREAD_BARMBRACK,"Barmbrack Bread",57),new UnlockData(57,"topping",FoodData.CHEESE_SAGEDERBY,"Sage Derby Cheese"),new UnlockData(57,"toppingfiller",FoodData.SAUCE_IRISHPARSLEY,"Irish Parsley Sauce",58),new UnlockData(61,"topping",FoodData.TOPPING_PICKLEDEGGS,"Pickled Eggs"),new UnlockData(61,"toppingfiller",FoodData.BREAD_PASKA,"Paska Bread",62),new UnlockData(62,"topping",FoodData.CHEESE_SIRECZ,"Sirecz Cheese"),new UnlockData(62,"toppingfiller",FoodData.SAUCE_HOLLANDAISE
         ,"Hollandaise Sauce",63),new UnlockData(0,"customer","Jojo"),new UnlockData(0,"customer","Rhonda"),new UnlockData(0,"customer","Hank"),new UnlockData(0,"customer","Radlynn"),new UnlockData(0,"customer","Chester"),new UnlockData(0,"customer","Quinn"),new UnlockData(0,"customer","Xolo"),new UnlockData(0,"customer","Sasha"),new UnlockData(0,"customer","Roy"),new UnlockData(0,"customer","Rita"),new UnlockData(0,"customer","Connor"),new UnlockData(0,"customer","Ivy"),new UnlockData(0,"customer","Kenji"),new UnlockData(0,"filler","Nevada"),new UnlockData(0,"filler","Brody"),new UnlockData(0,"filler","Julep"),new UnlockData(0,"filler","Nick"),new UnlockData(0,"filler","Mandi"),new UnlockData(0,"filler","Pinch Hitwell"),new UnlockData(0,"filler","Bertha"),new UnlockData(0,"filler","Scooter"),new UnlockData(0,"filler","Vicky"),new UnlockData(36,"filler","Perri"),new UnlockData(36,"filler","Mayor Mallow"),new UnlockData(36,"filler","Clover"),new UnlockData(36,"filler","Skyler"),new UnlockData(36,"filler"
         ,"Akari"),new UnlockData(36,"filler","Iggy"),new UnlockData(36,"filler","Utah"),new UnlockData(36,"filler","Shannon"),new UnlockData(36,"filler","Mindy"),new UnlockData(1,"customer","Doan"),new UnlockData(2,"customer","Ember"),new UnlockData(3,"customer","Taylor"),new UnlockData(4,"customer","Yui"),new UnlockData(5,"customer","Chuck"),new UnlockData(6,"customer","Maggie"),new UnlockData(7,"customer","Franco"),new UnlockData(8,"customer","Peggy"),new UnlockData(9,"customer","Timm"),new UnlockData(10,"customer","Clair"),new UnlockData(11,"customer","Kahuna"),new UnlockData(12,"customer","Hacky Zak"),new UnlockData(13,"customer","Alberto"),new UnlockData(14,"customer","Trishna"),new UnlockData(15,"customer","Captain Cori"),new UnlockData(16,"customer","Marty"),new UnlockData(17,"customer","Lisa"),new UnlockData(18,"customer","Rico"),new UnlockData(19,"customer","Boomer"),new UnlockData(20,"customer","Matt"),new UnlockData(21,"customer","Allan"),new UnlockData(22,"customer","Olga"),new UnlockData(23
         ,"customer","Carlo Romano"),new UnlockData(24,"customer","Hope"),new UnlockData(25,"customer","Deano"),new UnlockData(26,"customer","Cooper"),new UnlockData(27,"customer","Johnny"),new UnlockData(28,"customer","Tohru"),new UnlockData(29,"customer","Zoe"),new UnlockData(30,"customer","James"),new UnlockData(31,"customer","Willow"),new UnlockData(32,"customer","Mitch"),new UnlockData(33,"customer","Gremmie"),new UnlockData(34,"customer","Ninjoy"),new UnlockData(35,"customer","Sarge Fan"),new UnlockData(36,"customer","Sienna"),new UnlockData(37,"customer","Big Pauly"),new UnlockData(38,"customer","Mary"),new UnlockData(39,"customer","Austin"),new UnlockData(40,"customer","Edna"),new UnlockData(41,"customer","Santa"),new UnlockData(42,"customer","Cecilia"),new UnlockData(43,"customer","Wally"),new UnlockData(44,"customer","Crystal"),new UnlockData(45,"customer","Kingsley"),new UnlockData(46,"customer","Xandra"),new UnlockData(47,"customer","Professor Fitz"),new UnlockData(48,"customer","Prudence")
         ,new UnlockData(49,"customer","Kayla"),new UnlockData(50,"customer","Hugo"),new UnlockData(51,"customer","Greg"),new UnlockData(52,"customer","Sue"),new UnlockData(53,"customer","Foodini"),new UnlockData(54,"customer","Yippy"),new UnlockData(55,"customer","Robby"),new UnlockData(56,"customer","Georgito"),new UnlockData(57,"customer","Wendy"),new UnlockData(58,"customer","Gino Romano"),new UnlockData(59,"customer","Bruna Romano"),new UnlockData(60,"customer","Tony"),new UnlockData(61,"customer","Little Edoardo"),new UnlockData(62,"customer","Penny"),new UnlockData(63,"customer","Olivia"),new UnlockData(64,"customer","Cletus"),new UnlockData(65,"customer","Papa Louie")];
         this.specials = [new SpecialItem(0,"Cheesy BLT","cheesyblt","tips",1.5,1,[FoodData.BREAD_WHEAT,FoodData.CHEESE_CHEDDAR,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH],[FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO],"hat12",true),new SpecialItem(1,"Classic Club","classicclub","points",140,1,[FoodData.BREAD_WHITE,FoodData.CHEESE_SWISS,FoodData.TOPPING_HAM,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO],[FoodData.TOPPING_HAM,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON],"tint_longovershirt_h",true),new SpecialItem(2,"Bird Buster","birdbuster","tickets",2,1,[FoodData.BREAD_MULTIGRAIN,FoodData.CHEESE_SWISS,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TURKEY,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TURKEY,FoodData.SAUCE_RANCH],[FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TURKEY],"tint_letterjacket_j",true),new SpecialItem(3,"Fiery Flatbread","fieryflatbread","points",150,2,[FoodData
         .BREAD_FLATBREAD,FoodData.CHEESE_PEPPERJACK,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TOMATO],[FoodData.BREAD_FLATBREAD,FoodData.SAUCE_BUFFALO],"tint_polo_flames_f",true),new SpecialItem(4,"Rosemary Ranch","rosemaryranch","tips",2,3,[FoodData.BREAD_FOCACCIA,FoodData.CHEESE_MOZZARELLA,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_RANCH,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH],[FoodData.BREAD_FOCACCIA,FoodData.SAUCE_RANCH],"tint_flatcap_n",true),new SpecialItem(5,"Hot Hamwich","hothamwich","tickets",1,4,[FoodData.BREAD_SOURDOUGH,FoodData.CHEESE_AGEDGOUDA,FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BUFFALO],[FoodData.TOPPING_HAM,FoodData.SAUCE_BUFFALO],"tint_camppack_f",true),new SpecialItem(6,"Sauce Pocket","saucepocket","points",155,5,[FoodData.BREAD_WHITE,FoodData.CHEESE_AMERICAN,FoodData.SAUCE_KETCHUP,FoodData.SAUCE_MUSTARD,FoodData.SAUCE_RANCH,FoodData
         .SAUCE_BBQ,FoodData.SAUCE_BUFFALO],[FoodData.SAUCE_KETCHUP,FoodData.SAUCE_MUSTARD,FoodData.SAUCE_RANCH,FoodData.SAUCE_BBQ,FoodData.SAUCE_BUFFALO],"tint_knapsack_q",true),new SpecialItem(7,"BBQ Bacon","bbqbacon","stars",1,5,[FoodData.BREAD_MULTIGRAIN,FoodData.CHEESE_COLBY,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON,FoodData.SAUCE_BBQ,FoodData.TOPPING_BACON],[FoodData.SAUCE_BBQ,FoodData.TOPPING_BACON],"tint_pants_6_c",true),new SpecialItem(8,"Kickin\' Chicken","kickinchicken","tips",2.5,8,[FoodData.BREAD_RYE,FoodData.CHEESE_CHEDDAR,FoodData.SAUCE_BBQ,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_BACON,FoodData.SAUCE_BBQ],[FoodData.TOPPING_CHICKEN,FoodData.TOPPING_JALAPENOS],"tint_shoes8_m",true),new SpecialItem(9,"Toastwood Turkey","toastwoodturkey","points",160,9,[FoodData.BREAD_SOURDOUGH,FoodData.CHEESE_PEPPERJACK,FoodData.TOPPING_TURKEY,FoodData.TOPPING_BACON,FoodData.TOPPING_TURKEY,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_SOUTHWEST],[FoodData
         .TOPPING_TURKEY,FoodData.SAUCE_SOUTHWEST],"tint_shortshrug_d",true),new SpecialItem(10,"Veggie Melt","veggiemelt","stars",1,10,[FoodData.BREAD_FOCACCIA,FoodData.CHEESE_MOZZARELLA,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PEPPERS],[FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO],"tint_puffyvest_k",true),new SpecialItem(11,"Porky Pepper","porkypepper","tips",2,13,[FoodData.BREAD_MULTIGRAIN,FoodData.CHEESE_AGEDGOUDA,FoodData.TOPPING_HAM,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_PEPPERS],[FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_PEPPERS],"tint_pants_5_d",true),new SpecialItem(12,"Toastie Dijon","toastiedijon","points",160,15,[FoodData.BREAD_PUMPERNICKEL,FoodData.CHEESE_AGEDGOUDA,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_MUSTARD,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_MUSTARD],[FoodData.BREAD_PUMPERNICKEL,FoodData.SAUCE_MUSTARD]
         ,"tint_sunglasses05_j",true),new SpecialItem(13,"Cluck and Onion","cluckandonion","stars",1,20,[FoodData.BREAD_FLATBREAD,FoodData.CHEESE_PROVOLONE,FoodData.TOPPING_ONIONS,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_ONIONS,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_ONIONS],[FoodData.TOPPING_CHICKEN,FoodData.TOPPING_ONIONS],"tint_scarfwrap_f",true),new SpecialItem(14,"The Pumperjack","pumperjack","tickets",2,23,[FoodData.BREAD_PUMPERNICKEL,FoodData.CHEESE_PEPPERJACK,FoodData.TOPPING_SALAMI,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_SOUTHWEST,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_SALAMI],[FoodData.BREAD_PUMPERNICKEL,FoodData.CHEESE_PEPPERJACK],"tint_pants_3_g",true),new SpecialItem(15,"Portallini Panini","portallinipanini","points",155,23,[FoodData.BREAD_FOCACCIA,FoodData.CHEESE_MOZZARELLA,FoodData.SAUCE_KETCHUP,FoodData.TOPPING_SALAMI,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_SALAMI,FoodData.SAUCE_KETCHUP],[FoodData.CHEESE_MOZZARELLA,FoodData.TOPPING_SALAMI,FoodData.SAUCE_KETCHUP],"tint_boater_f"
         ,true),new SpecialItem(16,"Meat Lover\'s","meatlovers","stars",1,24,[FoodData.BREAD_CIABATTA,FoodData.CHEESE_COLBY,FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_CHICKEN],[FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_SALAMI,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_CHICKEN],"tint_wintercoat_l",true),new SpecialItem(17,"Sunrise Sandwich","sunrisesandwich","tips",2,28,[FoodData.BREAD_WHITE,FoodData.CHEESE_AMERICAN,FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_FRIEDEGG],[FoodData.TOPPING_FRIEDEGG],"tint_sunglasses06_j",true),new SpecialItem(18,"Western Omelette","westernomelette","tickets",1,28,[FoodData.BREAD_CIABATTA,FoodData.CHEESE_ASIAGO,FoodData.TOPPING_HAM,FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.TOPPING_FRIEDEGG],[FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_PEPPERS],"tint_deepv_2_c",true),new SpecialItem(19
         ,"Blazin\' Beef","blazinbeef","points",170,30,[FoodData.BREAD_WHEAT,FoodData.CHEESE_CHEDDAR,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_JALAPENOS,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_PHILLYSTEAK],[FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_JALAPENOS,FoodData.SAUCE_BUFFALO],"tint_blazer_l",true),new SpecialItem(20,"Southwest Steakhouse","southweststeakhouse","tips",2,30,[FoodData.BREAD_CIABATTA,FoodData.CHEESE_PEPPERJACK,FoodData.TOPPING_PHILLYSTEAK,FoodData.SAUCE_SOUTHWEST,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_SOUTHWEST],[FoodData.TOPPING_PHILLYSTEAK,FoodData.SAUCE_SOUTHWEST],"tint_backwardscap_g",true),new SpecialItem(21,"Surf and Turf","surfandturf","stars",1,33,[FoodData.BREAD_FOCACCIA,FoodData.CHEESE_MOZZARELLA,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_LOBSTER,FoodData.SAUCE_RANCH],[FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_LOBSTER],"tint_sunglasses04b_e",true),new SpecialItem(22,"Wild Western"
         ,"wildwestern","tickets",1,35,[FoodData.BREAD_FLATBREAD,FoodData.CHEESE_COLBY,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_SOUTHWEST,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION],[FoodData.SAUCE_WILDONION,FoodData.SAUCE_SOUTHWEST],"tint_cowboy_g",true),new SpecialItem(23,"Heaping Hoggy","heapinghoggy","tips",2.3,39,[FoodData.BREAD_RYE,FoodData.CHEESE_PROVOLONE,FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_AWESOME,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_ONIONS,FoodData.SAUCE_AWESOME],[FoodData.TOPPING_PULLEDPORK],"tint_shoes7_f",true),new SpecialItem(24,"Awesome Onion","awesomeonion","points",180,40,[FoodData.BREAD_FOCACCIA,FoodData.CHEESE_HAVARTI,FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS,FoodData.SAUCE_AWESOME,FoodData.TOPPING_ONIONS,FoodData.SAUCE_AWESOME],[FoodData.SAUCE_AWESOME,FoodData.TOPPING_ONIONS],"hat26",true),new SpecialItem(25,"Beef Buster","beefbuster","tips",2,43,[FoodData.BREAD_PUMPERNICKEL,FoodData.CHEESE_HAVARTI,FoodData.TOPPING_CORNEDBEEF
         ,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_CORNEDBEEF],[FoodData.TOPPING_CORNEDBEEF],"tint_polo_skull_b",true),new SpecialItem(26,"Cheesy Chick","cheesychick","stars",1,44,[FoodData.BREAD_THREECHEESE,FoodData.CHEESE_CHEDDAR,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_AWESOME,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_AWESOME,FoodData.TOPPING_LETTUCE],[FoodData.BREAD_THREECHEESE,FoodData.CHEESE_CHEDDAR,FoodData.TOPPING_CHICKEN],"tint_trackjacket_n",true),new SpecialItem(27,"Grilled Cheesesteak","grilledcheesesteak","tips",2,45,[FoodData.BREAD_SOURDOUGH,FoodData.CHEESE_PROVOLONE,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PHILLYSTEAK],[FoodData.CHEESE_PROVOLONE,FoodData.TOPPING_PHILLYSTEAK],"tint_hoodie_r",true),new SpecialItem(28,"Gobbledy Gouda","gobbledygouda","points",190,45,[FoodData.BREAD_WHEAT,FoodData.CHEESE_AGEDGOUDA,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_TURKEY,FoodData
         .TOPPING_TOMATO,FoodData.TOPPING_TURKEY,FoodData.SAUCE_KETCHUP],[FoodData.CHEESE_AGEDGOUDA,FoodData.TOPPING_TURKEY],"glasses_monocle",true),new SpecialItem(29,"Marbled Mushroom","marbledmushroom","tickets",2,45,[FoodData.BREAD_RYE,FoodData.CHEESE_SWISS,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_BACON,FoodData.SAUCE_AWESOME,FoodData.TOPPING_MUSHROOMS],[FoodData.BREAD_RYE,FoodData.TOPPING_MUSHROOMS],"tint_pants_10_g",true),new SpecialItem(30,"Classic Cuban","classiccuban","points",185,48,[FoodData.BREAD_SOURDOUGH,FoodData.CHEESE_SWISS,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_HAM,FoodData.TOPPING_PICKLES,FoodData.SAUCE_MUSTARD],[FoodData.TOPPING_HAM,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_PICKLES],"tint_sunglasses02_f",true),new SpecialItem(31,"Lobster Po\' Boy","lobsterpoboy","tips",2.2,48,[FoodData.BREAD_FLATBREAD,FoodData.CHEESE_PROVOLONE,FoodData.TOPPING_LOBSTER,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_PICKLES,FoodData.SAUCE_BUFFALO],[FoodData.TOPPING_LOBSTER]
         ,"hat05",true),new SpecialItem(32,"Pickled Peppers","pickledpeppers","stars",1,48,[FoodData.BREAD_WHITE,FoodData.CHEESE_HAVARTI,FoodData.TOPPING_PICKLES,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PICKLES,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PICKLES],[FoodData.TOPPING_PICKLES,FoodData.TOPPING_PEPPERS],"tint_backpack_c",true),new SpecialItem(33,"Cordon Bleu","cordonbleu","points",190,50,[FoodData.BREAD_CIABATTA,FoodData.CHEESE_SWISS,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_HAM,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.SAUCE_HONEYMUSTARD],[FoodData.TOPPING_HAM,FoodData.TOPPING_CHICKEN],"tint_beret_p",true),new SpecialItem(34,"Butterbrezel","butterbrezel","tips",2,53,[FoodData.BREAD_PRETZEL,FoodData.CHEESE_CHEDDAR,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_ONIONS,FoodData.SAUCE_HONEYMUSTARD],[FoodData.BREAD_PRETZEL,FoodData.SAUCE_HONEYMUSTARD],"tint_classicvest_h",true),new SpecialItem(35,"Rudy\'s Reuben","rudysreuben","tickets",1,58,[FoodData
         .BREAD_RYE,FoodData.CHEESE_SWISS,FoodData.TOPPING_CORNEDBEEF,FoodData.SAUCE_AWESOME,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_SAUERKRAUT],[FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_SAUERKRAUT],"tint_tornovershirt_d",true),new SpecialItem(36,"Sour Salad","soursalad","tips",2.5,58,[FoodData.BREAD_SOURDOUGH,FoodData.CHEESE_HAVARTI,FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_RANCH],[FoodData.TOPPING_SAUERKRAUT],"tint_cape_l",true),new SpecialItem(37,"Sarge\'s Revenge","sargesrevenge","stars",1,59,[FoodData.BREAD_PUMPERNICKEL,FoodData.CHEESE_GORGONZOLA,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION],[FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS],"helmet_01",true),new SpecialItem(38,"Gorgonzilla","gorgonzilla","tips",2.6,59,[FoodData.BREAD_FOCACCIA,FoodData.CHEESE_GORGONZOLA,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_OLIVES,FoodData.TOPPING_ONIONS,FoodData.TOPPING_LETTUCE
         ,FoodData.SAUCE_WILDONION],[FoodData.CHEESE_GORGONZOLA],"tint_headphones_m",true),new SpecialItem(39,"Health Nut","healthnut","points",250,64,[FoodData.BREAD_MULTIGRAIN,FoodData.CHEESE_ASIAGO,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_BALSAMIC],[FoodData.BREAD_MULTIGRAIN,FoodData.SAUCE_BALSAMIC],"tint_powerglove_b",true)];
         super();
         var _loc2_:GameData = this;
         _loc2_.gameObj = param1;
         _loc2_.setMusicTags();
         _loc2_.checkFurniTags();
      }
      
      public function getSpecial(param1:Number) : SpecialItem
      {
         var _loc2_:GameData = this;
         var _loc3_:SpecialItem = null;
         if(param1 >= 0 && param1 < _loc2_.specials.length)
         {
            _loc3_ = _loc2_.specials[param1];
         }
         return _loc3_;
      }
      
      public function getSpecials(param1:String) : Array
      {
         var _loc2_:GameData = this;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.specials.length)
         {
            if(_loc2_.gameObj.var_128.hasSpecial(_loc5_))
            {
               _loc3_.push(_loc2_.specials[_loc5_]);
            }
            else
            {
               _loc4_.push(_loc2_.specials[_loc5_]);
            }
            _loc5_++;
         }
         if(param1 == "abc")
         {
            _loc3_.sortOn("title");
         }
         else if(param1 == "new")
         {
            _loc3_.sort(this.specialSortFunction);
         }
         else if(param1 == "holiday")
         {
            _loc3_.sortOn("title");
         }
         return _loc3_.concat(_loc4_);
      }
      
      public function getPossibleSpecialsToEarn() : Array
      {
         var _loc1_:GameData = this;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.specials.length)
         {
            if(_loc1_.gameObj.var_128.hasSpecial(_loc3_) == false && _loc1_.gameObj.var_128.hasAllSpecialToppings(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function specialSortFunction(param1:SpecialItem, param2:SpecialItem) : int
      {
         var _loc4_:UserData = null;
         var _loc3_:GameData = this;
         _loc4_ = _loc3_.gameObj.var_128;
         if(_loc4_.isSpecialViewed(param1.index) && !_loc4_.isSpecialViewed(param2.index))
         {
            return 1;
         }
         if(!_loc4_.isSpecialViewed(param1.index) && _loc4_.isSpecialViewed(param2.index))
         {
            return -1;
         }
         if(param1.index < param2.index)
         {
            return 1;
         }
         if(param1.index > param2.index)
         {
            return -1;
         }
         return 0;
      }
      
      public function getSpecialLogo(param1:Number) : BitmapData
      {
         var specialIndex:Number = NaN;
         var logo:MovieClip = null;
         specialIndex = param1;
         var ob:GameData = this;
         var returnBMP:BitmapData = null;
         var special:SpecialItem = ob.getSpecial(specialIndex);
         try
         {
            if(special != null)
            {
               logo = class_12.method_103("specials_" + special.tag + "_logo",false,false);
               returnBMP = new BitmapData(Math.max(157,Math.round(logo.width)),Math.max(157,Math.round(logo.height)),true,0);
               returnBMP.draw(logo,null,null,null,null,true);
               class_7.method_1("Special Logo w/h: " + returnBMP.width + ", " + returnBMP.height);
               logo = null;
            }
         }
         catch(err:Error)
         {
            class_7.error("Error getting special logo:" + err.message + ". Special " + specialIndex);
            returnBMP = null;
         }
         return returnBMP;
      }
      
      public function getIngredients(param1:String) : Array
      {
         var _loc2_:Object = null;
         var _loc3_:GameData = this;
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.unlockArray.length)
         {
            if(_loc3_.unlockArray[_loc6_].type == "topping" || _loc3_.unlockArray[_loc6_].type == "toppingfiller")
            {
               _loc2_ = new Object();
               _loc2_.title = _loc3_.unlockArray[_loc6_].title;
               _loc2_.tag = _loc3_.unlockArray[_loc6_].tag;
               _loc2_.rank = _loc3_.unlockArray[_loc6_].rank;
               _loc2_.holiday = FoodData.getHolidayForItem(_loc3_.unlockArray[_loc6_].tag);
               if(_loc2_.holiday == 0)
               {
                  _loc2_.holiday = 13;
               }
               if(_loc3_.gameObj.var_128.hasTopping(_loc2_.tag) == false)
               {
                  _loc2_.title = "ZZZZZZ???";
                  _loc5_.push(_loc2_);
               }
               else
               {
                  _loc4_.push(_loc2_);
               }
            }
            _loc6_++;
         }
         if(param1 == "abc")
         {
            _loc4_.sortOn("title");
         }
         else if(param1 == "new")
         {
            _loc4_.sortOn("rank",Array.NUMERIC | Array.DESCENDING);
         }
         else if(param1 == "holiday")
         {
            _loc4_.sortOn("holiday",Array.NUMERIC);
         }
         return _loc4_.concat(_loc5_);
      }
      
      public function getUnlocksAtRank(param1:Number, param2:Boolean = false) : Vector.<UnlockData>
      {
         var _loc3_:GameData = this;
         var _loc4_:Vector.<UnlockData> = new Vector.<UnlockData>();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.unlockArray.length)
         {
            if(_loc3_.unlockArray[_loc5_].type != "filler" && param2 == false || _loc3_.unlockArray[_loc5_].type == "filler" && param2 == true)
            {
               if(_loc3_.unlockArray[_loc5_].rank == param1 || _loc3_.unlockArray[_loc5_].rank <= param1 && param2 == true)
               {
                  _loc4_.push(_loc3_.unlockArray[_loc5_]);
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getFillerToppingsAtRank(param1:Number, param2:Boolean = false) : Vector.<UnlockData>
      {
         var _loc3_:GameData = this;
         var _loc4_:Vector.<UnlockData> = new Vector.<UnlockData>();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.unlockArray.length)
         {
            if(_loc3_.unlockArray[_loc5_].type == "toppingfiller")
            {
               if(param1 <= _loc3_.unlockArray[_loc5_].maxRank && (param1 > _loc3_.unlockArray[_loc5_].rank || param1 == _loc3_.unlockArray[_loc5_].rank && !param2))
               {
                  _loc4_.push(_loc3_.unlockArray[_loc5_]);
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getUnlockByTag(param1:String) : UnlockData
      {
         var _loc2_:GameData = this;
         var _loc3_:UnlockData = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.unlockArray.length)
         {
            if(_loc2_.unlockArray[_loc4_].tag == param1)
            {
               _loc3_ = _loc2_.unlockArray[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getUpgradeFromTag(param1:String) : Upgrade
      {
         var _loc2_:Upgrade = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.shopItems.length)
         {
            if(Upgrade(this.shopItems[_loc3_]).tag == param1)
            {
               _loc2_ = this.shopItems[_loc3_];
               _loc2_.index = _loc3_ + 1;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function setMusicTags() : void
      {
         var _loc1_:GameData = this;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.furniItems.length)
         {
            if(_loc1_.furniItems[_loc2_].special == FurniData.SPECIAL_MUSIC)
            {
               if(_loc1_.furniItems[_loc2_].scoreType == "boombox")
               {
                  _loc1_.boomboxTag = _loc1_.furniItems[_loc2_].tag;
               }
               else if(_loc1_.furniItems[_loc2_].scoreType == "phonograph")
               {
                  _loc1_.phonographTag = _loc1_.furniItems[_loc2_].tag;
               }
               else if(_loc1_.furniItems[_loc2_].scoreType == "jukebox")
               {
                  _loc1_.jukeboxTag = _loc1_.furniItems[_loc2_].tag;
               }
               else
               {
                  class_7.error("Unknown music furniture - scoreType needs to be set to the music type: " + _loc1_.furniItems[_loc2_].tag);
               }
            }
            _loc2_++;
         }
      }
      
      private function checkFurniTags() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:GameData = this;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.themeTagsPerMonth.length)
         {
            _loc1_ = false;
            _loc2_ = _loc4_.themeTagsPerMonth[_loc5_];
            if(_loc2_ != "")
            {
               _loc3_ = 0;
               while(_loc3_ < _loc4_.furniItems.length)
               {
                  if(_loc4_.furniItems[_loc3_].theme == _loc2_)
                  {
                     _loc1_ = true;
                     break;
                  }
                  _loc3_++;
               }
               if(_loc1_ == false)
               {
                  class_7.error("Theme Setup Error: Could not find any furniture for Theme \"" + _loc2_ + "\".  Make sure themeTagsPerMonth array has the correct themes listed.");
               }
            }
            _loc5_++;
         }
      }
      
      public function getFurniFromTag(param1:String) : FurniData
      {
         var _loc2_:GameData = this;
         var _loc3_:FurniData = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.furniItems.length)
         {
            if(FurniData(_loc2_.furniItems[_loc4_]).tag == param1)
            {
               _loc3_ = _loc2_.furniItems[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getFurniStoreTags() : Array
      {
         var _loc1_:GameData = this;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.furniItems.length)
         {
            if(_loc1_.furniItems[_loc3_].tag != "wall1" && _loc1_.furniItems[_loc3_].tag != "floor1" && _loc1_.furniItems[_loc3_].inStore == true)
            {
               _loc2_.push(_loc1_.furniItems[_loc3_].tag);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getStoreTags(param1:String, param2:String = "all", param3:Number = -1) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:GameData = this;
         var _loc8_:Array = [];
         if(param1 == "furniture" || param1 == "poster" || param1 == "wallfloor")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc7_.furniItems.length)
            {
               if(_loc7_.furniItems[_loc4_].tag != "wall1" && _loc7_.furniItems[_loc4_].tag != "floor1" && _loc7_.furniItems[_loc4_].inStore == true)
               {
                  if(!((_loc7_.furniItems[_loc4_].special == FurniData.SPECIAL_SCORE || _loc7_.furniItems[_loc4_].special == FurniData.SPECIAL_SCOREBUBBLEGUM) && (_loc7_.furniItems[_loc4_].scoreType == "build" || _loc7_.furniItems[_loc4_].scoreType == "grill") && _loc7_.gameObj.var_128.hasTopping(_loc7_.furniItems[_loc4_].toppingType) == false))
                  {
                     _loc5_ = "all";
                     if(param3 == 0)
                     {
                        _loc5_ = "g";
                     }
                     else if(param3 > 0 && param3 <= 12)
                     {
                        _loc5_ = _loc7_.themeTagsPerMonth[param3];
                     }
                     if(_loc5_ == "all" || _loc7_.furniItems[_loc4_].theme == _loc5_)
                     {
                        if(param2 == "all" || param2 == "owned" && _loc7_.gameObj.var_128.alreadyOwnsFurniture(_loc7_.furniItems[_loc4_].tag) || param2 == "notowned" && _loc7_.gameObj.var_128.alreadyOwnsFurniture(_loc7_.furniItems[_loc4_].tag) == false)
                        {
                           if(param1 == "furniture" && _loc7_.furniItems[_loc4_].type == FurniData.TYPE_FURNI)
                           {
                              _loc8_.push(_loc7_.furniItems[_loc4_].tag);
                           }
                           else if(param1 == "poster" && _loc7_.furniItems[_loc4_].type == FurniData.TYPE_POSTER)
                           {
                              _loc8_.push(_loc7_.furniItems[_loc4_].tag);
                           }
                           else if(param1 == "wallfloor" && (_loc7_.furniItems[_loc4_].type == FurniData.TYPE_WALLPAPER || _loc7_.furniItems[_loc4_].type == FurniData.TYPE_FLOORING) && !_loc7_.gameObj.var_128.alreadyOwnsFurniture(_loc7_.furniItems[_loc4_].tag))
                           {
                              _loc8_.push(_loc7_.furniItems[_loc4_].tag);
                           }
                        }
                     }
                  }
               }
               _loc4_++;
            }
         }
         else if(param1 == "upgrades")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc7_.shopItems.length)
            {
               if(_loc7_.shopItems[_loc4_].tag == "napkin")
               {
                  _loc8_.push(_loc7_.shopItems[_loc4_].tag);
               }
               else if(!(_loc7_.shopItems[_loc4_].toppingType != null && _loc7_.gameObj.var_128.hasTopping(_loc7_.shopItems[_loc4_].toppingType) == false))
               {
                  if(!_loc7_.gameObj.var_128.hasBonus(_loc7_.shopItems[_loc4_].tag))
                  {
                     _loc8_.push(_loc7_.shopItems[_loc4_].tag);
                  }
               }
               _loc4_++;
            }
         }
         else if(param1 == "clothing")
         {
            _loc6_ = false;
            if(_loc7_.gameObj.var_128.whichCharacter == "marty" || _loc7_.gameObj.var_128.whichCharacter == "rita")
            {
               _loc6_ = true;
            }
            if(param2 == "all")
            {
               _loc8_ = _loc7_.gameObj.var_135.getAvailableClothingTags("any",_loc7_.gameObj.workerData.gender,true,false,_loc6_,param3);
            }
            else
            {
               _loc8_ = _loc7_.gameObj.var_135.getAvailableClothingTags(param2,_loc7_.gameObj.workerData.gender,true,false,_loc6_,param3);
            }
         }
         return _loc8_;
      }
      
      public function getTeamSKU(param1:Number) : String
      {
         var _loc2_:Array = ["tomatoes","sizzlers","hardshells","coconuts","flapjacks","buffaloes","crushers"];
         if(param1 > 0 && param1 <= _loc2_.length)
         {
            return _loc2_[param1 + 1];
         }
         return "";
      }
      
      public function getSkyStartingFrame() : Number
      {
         var _loc1_:GameData = this;
         var _loc2_:Number = _loc1_.gameObj.var_128.getMonth();
         if(_loc2_ == 0 || _loc2_ == 1 || _loc2_ == 12)
         {
            return 1;
         }
         if(_loc2_ == 2 || _loc2_ == 11)
         {
            return 8;
         }
         if(_loc2_ == 3)
         {
            return 15;
         }
         if(_loc2_ == 4)
         {
            return 29;
         }
         if(_loc2_ == 5 || _loc2_ == 9)
         {
            return 36;
         }
         if(_loc2_ == 6 || _loc2_ == 8)
         {
            return 43;
         }
         if(_loc2_ == 7)
         {
            return 50;
         }
         if(_loc2_ == 10)
         {
            return 57;
         }
         return 1;
      }
      
      public function setPrizes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:FurniData = null;
         var _loc5_:ClothingItem = null;
         var _loc6_:SpecialItem = null;
         var _loc7_:FurniData = null;
         var _loc8_:ClothingItem = null;
         var _loc9_:GameData = this;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc9_.minigamePrizes.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc9_.minigamePrizes[_loc1_].length)
            {
               _loc3_ = _loc9_.minigamePrizes[_loc1_][_loc2_];
               _loc4_ = _loc9_.getFurniFromTag(_loc3_);
               if(_loc4_ != null)
               {
                  if(_loc4_.inStore == true)
                  {
                     _loc4_.inStore = false;
                     _loc10_++;
                  }
                  else
                  {
                     class_7.error("This prize is added more than once: " + _loc3_);
                  }
               }
               else
               {
                  _loc5_ = _loc9_.gameObj.var_135.getItemFromSKU(_loc3_);
                  if(_loc5_ != null)
                  {
                     if(_loc5_.inStore == true)
                     {
                        _loc5_.inStore = false;
                        _loc11_++;
                     }
                     else
                     {
                        class_7.error("This prize is added more than once: " + _loc3_);
                     }
                  }
                  else
                  {
                     class_7.error("Unknown prize for Mini-Game -- can\'t find it to remove from store: " + _loc3_);
                  }
               }
               _loc2_++;
            }
            if(_loc9_.minigamePrizes[_loc1_].length != 16)
            {
               class_7.error("Not enough Prizes for Set " + _loc1_ + " (" + _loc9_.minigamePrizes[_loc1_].length + " instead of 16)");
            }
            _loc1_++;
         }
         class_7.info("Removed Mini-Game Prizes from Store: " + _loc10_ + " Furni, " + _loc11_ + " Clothing.");
         class_7.info("");
         class_7.info("Remove Special Recipe Prizes:");
         _loc1_ = 0;
         while(_loc1_ < _loc9_.specials.length)
         {
            _loc6_ = _loc9_.specials[_loc1_];
            if(_loc6_.prizeSKU != null)
            {
               if(_loc6_.removePrizeFromStore)
               {
                  _loc7_ = _loc9_.getFurniFromTag(_loc6_.prizeSKU);
                  if(_loc7_ != null)
                  {
                     if(_loc7_.inStore == true)
                     {
                        _loc4_.inStore = false;
                     }
                     else
                     {
                        class_7.error(" -- Error -- " + _loc6_.prizeSKU + " was already removed from store.");
                     }
                  }
                  else
                  {
                     _loc8_ = _loc9_.gameObj.var_135.getItemFromSKU(_loc6_.prizeSKU);
                     if(_loc8_ != null)
                     {
                        if(_loc8_.inStore == true)
                        {
                           _loc8_.inStore = false;
                        }
                        else
                        {
                           class_7.error(" -- Error -- " + _loc6_.prizeSKU + " was already removed from store.");
                        }
                     }
                  }
               }
            }
            _loc1_++;
         }
      }
      
      public function isRarePrize(param1:String) : Boolean
      {
         var _loc2_:GameData = this;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.minigamePrizes.length)
         {
            if(_loc2_.minigamePrizes[_loc4_].indexOf(param1) >= 13)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getHolidayName(param1:Number) : String
      {
         var _loc2_:GameData = this;
         if(param1 > 0 && param1 < _loc2_.themeTagNames.length)
         {
            return _loc2_.themeTagNames[param1];
         }
         return "";
      }
   }
}


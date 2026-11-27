package cheeseGame.data
{
   import package_4.class_5;
   
   public class ToppingData
   {
      
      public var gameObj:class_5;
      
      public var toppingItems:Array;
      
      public var breadHeights:Array;
      
      public function ToppingData(param1:class_5)
      {
         this.toppingItems = [new ToppingItem(FoodData.TOPPING_TOMATO,"topping_" + FoodData.TOPPING_TOMATO + "_pieces",0,20,6,6,0,2,9,false,null,0,0,360,true),new ToppingItem(FoodData.TOPPING_JALAPENOS,"topping_" + FoodData.TOPPING_JALAPENOS + "_pieces",0,14,6,6,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_CHICKEN,"topping_" + FoodData.TOPPING_CHICKEN + "_pieces",0,12,20,10,0,2,9,false,null,0,-10,10,true),new ToppingItem(FoodData.TOPPING_PHILLYSTEAK,"topping_" + FoodData.TOPPING_PHILLYSTEAK + "_pieces",0,14,20,10,0,2,9,false,null,0,-10,10,true),new ToppingItem(FoodData.TOPPING_PULLEDPORK,"topping_" + FoodData.TOPPING_PULLEDPORK + "_pieces",0,16,20,10,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_LOBSTER,"topping_" + FoodData.TOPPING_LOBSTER + "_pieces",0,26,20,10,0,2,9,false,null,0,-40,40,true),new ToppingItem(FoodData.TOPPING_OLIVES,"topping_" + FoodData.TOPPING_OLIVES + "_pieces",0,18,20,10,0,2,9,false,null,0,160,200,true),new ToppingItem(FoodData.TOPPING_ONIONS
         ,"topping_" + FoodData.TOPPING_ONIONS + "_pieces",0,14,20,10,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_PEPPERS,"topping_" + FoodData.TOPPING_PEPPERS + "_pieces",0,12,20,10,0,2,9,false,null,0,-20,20,true),new ToppingItem(FoodData.TOPPING_MUSHROOMS,"topping_" + FoodData.TOPPING_MUSHROOMS + "_pieces",0,20,20,10,0,2,9,false,null,0,-10,10,true),new ToppingItem(FoodData.TOPPING_SAUERKRAUT,"topping_" + FoodData.TOPPING_SAUERKRAUT + "_pieces",0,30,20,10,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_LETTUCE,"topping_" + FoodData.TOPPING_LETTUCE + "_pieces",0,30,20,10,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_PICKLES,"topping_" + FoodData.TOPPING_PICKLES + "_pieces",0,10,6,6,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_SAUSAGE,"topping_" + FoodData.TOPPING_SAUSAGE + "_pieces",0,9,20,10,0,2,9,false,null,0,-10,10,true),new ToppingItem(FoodData.TOPPING_MACNCHEESE,"topping_" + FoodData.TOPPING_MACNCHEESE + "_pieces",GameData
         .MONTH_JANUARY,30,6,6,0,2,9,false,null,0,0,360,true),new ToppingItem(FoodData.TOPPING_SUNDRIEDTOMATOES,"topping_" + FoodData.TOPPING_SUNDRIEDTOMATOES + "_pieces",GameData.MONTH_FEBRUARY,10,6,6,0,2,9,false,null,0,-20,20,true),new ToppingItem(FoodData.TOPPING_BEEFHASH,"topping_" + FoodData.TOPPING_BEEFHASH + "_pieces",GameData.MONTH_MARCH,20,6,6,0,2,9,false,null,0,0,360,true),new ToppingItem(FoodData.TOPPING_PICKLEDEGGS,"topping_" + FoodData.TOPPING_PICKLEDEGGS + "_pieces",GameData.MONTH_APRIL,4,6,6,0,2,9,false,null,0,-10,10,true),new ToppingItem(FoodData.TOPPING_CHORIZO,"topping_" + FoodData.TOPPING_CHORIZO + "_pieces",GameData.MONTH_MAY,10,6,6,0,2,9,false,null,0,-10,10,true),new ToppingItem(FoodData.TOPPING_PINEAPPLE,"topping_" + FoodData.TOPPING_PINEAPPLE + "_pieces",GameData.MONTH_JUNE,14,6,6,0,2,9,false,null,0,-20,20,true),new ToppingItem(FoodData.TOPPING_MEATBALLS,"topping_" + FoodData.TOPPING_MEATBALLS + "_pieces",GameData.MONTH_AUGUST,7,6,6,0,2,9,false,null,0,-5,5,true),new ToppingItem(FoodData
         .TOPPING_SPOOKYSLAW,"topping_" + FoodData.TOPPING_SPOOKYSLAW + "_pieces",GameData.MONTH_OCTOBER,30,20,10,0,2,9,false,null,0,-15,15,true),new ToppingItem(FoodData.TOPPING_STUFFING,"topping_" + FoodData.TOPPING_STUFFING + "_pieces",GameData.MONTH_NOVEMBER,26,6,6,0,2,9,false,null,0,0,360,true),new ToppingItem(FoodData.TOPPING_TURKEY,"topping_" + FoodData.TOPPING_TURKEY + "_slice",0,10,11,-55,-80,25,70,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_BACON,"topping_" + FoodData.TOPPING_BACON + "_slice",0,10,11,-55,-57,25,70,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_FRIEDEGG,"topping_" + FoodData.TOPPING_FRIEDEGG + "_slice",0,10,11,-55,-69,25,70,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_HAM,"topping_" + FoodData.TOPPING_HAM + "_slice",0,10,11,-55,-67,25,70,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_CORNEDBEEF,"topping_" + FoodData.TOPPING_CORNEDBEEF + "_slice",0,10,11,-55,-72,25,70,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_SALAMI,"topping_" + FoodData
         .TOPPING_SALAMI + "_slice",0,10,11,-55,-60,25,70,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_BEEFBRISKET,"topping_" + FoodData.TOPPING_BEEFBRISKET + "_slice",GameData.MONTH_JULY,10,11,-55,-80,20,60,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_GOOSE,"topping_" + FoodData.TOPPING_GOOSE + "_slice",GameData.MONTH_DECEMBER,10,11,-55,-65,15,60,false,null,0,0,0,true),new ToppingItem(FoodData.TOPPING_SAUSAGE,"topping_" + FoodData.TOPPING_SAUSAGE + "_slice",GameData.MONTH_SEPTEMBER,10,11,-55,-67,10,45,false,null,0,0,0,true),new ToppingItem(FoodData.FRYTOPPING_CHEDDAR,"topping_" + FoodData.FRYTOPPING_CHEDDAR + "_fries_pieces",0,40,2,2,1,2,9),new ToppingItem(FoodData.FRYTOPPING_BACON,"topping_" + FoodData.FRYTOPPING_BACON + "_fries_pieces",0,20,2,2,1,3,9),new ToppingItem(FoodData.FRYTOPPING_CHILI,"topping_" + FoodData.FRYTOPPING_CHILI + "_fries_pieces",0,30,2,2,1,2,9),new ToppingItem(FoodData.TOPPING_JALAPENOS,"topping_" + FoodData.TOPPING_JALAPENOS + "_fries_pieces",0,15,2,2
         ,1,4,9,false,null,0,-20,20),new ToppingItem(FoodData.FRYTOPPING_CHIVES,"topping_" + FoodData.FRYTOPPING_CHIVES + "_pieces",0,30,2,2,1,2,9),new ToppingItem(FoodData.FRYTOPPING_ROSEMARY,"topping_" + FoodData.FRYTOPPING_ROSEMARY + "_pieces",0,20,2,2,1,4,9),new ToppingItem(FoodData.FRYTOPPING_SEASONING,"topping_" + FoodData.FRYTOPPING_SEASONING + "_pieces",0,20,2,2,1,4,9),new ToppingItem(FoodData.FRYSAUCE_SOURCREAM,"topping_sourcream_pieces",0,30,2,2,1,2,9,false),new ToppingItem(FoodData.FRYSAUCE_NACHO,"topping_sauce_chunk",0,50,2,2,1,2,9,true,[15645952,15646464,15647232,15647744,15648256,15648768,15649280],16067840),new ToppingItem(FoodData.FRYSAUCE_POUTINE,"topping_poutine_pieces",0,50,2,2,1,2,9,true,[10973226,11104812,11368241,11631413,11960122,12223551,12355137],7224331),new ToppingItem(FoodData.SAUCE_KETCHUP,"topping_sauce_chunk",0,50,2,2,1,2,9,true,[16711680,16712192,16712704,16713216,16713728,16714240,16714752,16715264,16715776,16716288,16716800,16717312,16717824,16718336,16718848],3342336)
         ,new ToppingItem(FoodData.SAUCE_RANCH,"topping_sauce_chunk",0,50,2,2,1,2,9,true,[15596031,15661823,15727615,15793407,15859199,15924991,15925247,15990783,16056319,16121855,16187391,16252927],1118515),new ToppingItem(FoodData.SAUCE_BBQ,"topping_sauce_chunk",0,50,2,2,1,2,9,true,[5576203,5838604,6101261,6363662,6626319,6954513,7217170],3355443),new ToppingItem(FoodData.SAUCE_AWESOME,"topping_sauce_chunk",0,50,2,2,1,2,9,true,[14258472,14521901,14850610,15114039,15443004,15706433,16035398],3355443)];
         this.breadHeights = [[FoodData.BREAD_WHITE,14],[FoodData.BREAD_WHEAT,14],[FoodData.BREAD_SOURDOUGH,18],[FoodData.BREAD_RYE,14],[FoodData.BREAD_MULTIGRAIN,19],[FoodData.BREAD_FLATBREAD,5],[FoodData.BREAD_CIABATTA,12],[FoodData.BREAD_FOCACCIA,9],[FoodData.BREAD_THREECHEESE,15],[FoodData.BREAD_PRETZEL,19],[FoodData.BREAD_PUMPERNICKEL,10],[FoodData.BREAD_TORTILLA,2],[FoodData.BREAD_HAWAIIAN,14],[FoodData.BREAD_TEXASTOAST,30],[FoodData.BREAD_PEPPERONI,14],[FoodData.BREAD_CINNAMON,14],[FoodData.BREAD_ECTOBREAD,14],[FoodData.BREAD_PUMPKIN,19],[FoodData.BREAD_FRUITCAKE,14],[FoodData.BREAD_CHEDDARSWIRL,16],[FoodData.BREAD_BEET,14],[FoodData.BREAD_BARMBRACK,14],[FoodData.BREAD_PASKA,22]];
         super();
         this.gameObj = param1;
      }
      
      public function getToppingItemData(param1:String, param2:Boolean = false) : ToppingItem
      {
         var _loc3_:ToppingData = this;
         var _loc4_:ToppingItem = null;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.toppingItems.length)
         {
            if(_loc3_.toppingItems[_loc5_].type == param1 && _loc3_.toppingItems[_loc5_].isSandwich == param2)
            {
               _loc4_ = _loc3_.toppingItems[_loc5_];
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getBreadHeight(param1:String) : Number
      {
         var _loc2_:ToppingData = this;
         var _loc3_:Number = 1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.breadHeights.length)
         {
            if(_loc2_.breadHeights[_loc4_][0] == param1)
            {
               _loc3_ = Number(_loc2_.breadHeights[_loc4_][1]);
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}


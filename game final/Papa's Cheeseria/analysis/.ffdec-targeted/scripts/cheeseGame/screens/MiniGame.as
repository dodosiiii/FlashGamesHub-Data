package cheeseGame.screens
{
   import cheeseGame.data.*;
   import flash.display.MovieClip;
   import package_2.*;
   
   public class MiniGame
   {
      
      public static const TYPE_HALLWAY:String = "hallway";
      
      public static const TYPE_MESS:String = "mess";
      
      public static const TYPE_GOKART:String = "gokart";
      
      public static const TYPE_SHOT:String = "shot";
      
      public static const TYPE_CHILI:String = "chili";
      
      public static const TYPE_PACHINKO:String = "pachinko";
      
      public static const TYPE_SKEEBALL:String = "skeeball";
      
      public var screen:MiniGameScreen;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var prizeSKUs:Array;
      
      public var prizeIsClothing:Array;
      
      public var prizeClothingMode:Array;
      
      public var allowedForRandom:Array;
      
      public var type:String;
      
      public var skuToWin:String = null;
      
      public var amountToWin:Number = 0;
      
      public var skuIsClothing:Boolean = false;
      
      public var skuClothingMode:String = "";
      
      public function MiniGame(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         var _loc4_:MiniGame = null;
         this.prizeSKUs = [];
         this.prizeIsClothing = [];
         this.prizeClothingMode = [];
         this.allowedForRandom = [];
         super();
         _loc4_ = this;
         _loc4_.screen = param1;
         _loc4_.container = param2;
         _loc4_.type = param3;
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
      }
      
      public function updateScreen() : void
      {
      }
      
      public function destroy() : void
      {
      }
      
      public function decidePrize() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Array = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:int = 0;
         var _loc5_:Number = Number(NaN);
         var _loc6_:MiniGame = this;
         var _loc7_:Number = _loc6_.screen.possibleGames.indexOf(_loc6_.type);
         var _loc8_:Number = Number(_loc6_.screen.gameObj.var_128.minigamePrizes[_loc7_]);
         if(_loc8_ == 13)
         {
            _loc6_.skuToWin = _loc6_.prizeSKUs[13];
            _loc6_.skuIsClothing = _loc6_.prizeIsClothing[13];
            _loc6_.skuClothingMode = _loc6_.prizeClothingMode[13];
            class_7.method_1("BIG BRONZE PRIZE");
         }
         else if(_loc8_ == 27)
         {
            _loc6_.skuToWin = _loc6_.prizeSKUs[14];
            _loc6_.skuIsClothing = _loc6_.prizeIsClothing[14];
            _loc6_.skuClothingMode = _loc6_.prizeClothingMode[14];
            class_7.method_1("BIG SILVER PRIZE");
         }
         else if(_loc8_ == 41)
         {
            _loc6_.skuToWin = _loc6_.prizeSKUs[15];
            _loc6_.skuIsClothing = _loc6_.prizeIsClothing[15];
            _loc6_.skuClothingMode = _loc6_.prizeClothingMode[15];
            class_7.method_1("BIG GOLD PRIZE");
         }
         else if(_loc8_ < 13)
         {
            _loc6_.skuToWin = _loc6_.prizeSKUs[_loc8_];
            _loc6_.skuIsClothing = _loc6_.prizeIsClothing[_loc8_];
            _loc6_.skuClothingMode = _loc6_.prizeClothingMode[_loc8_];
            class_7.method_1("Regular Prize");
         }
         else
         {
            _loc1_ = _loc8_ % 14;
            if(_loc1_ != 13 && _loc1_ < _loc6_.prizeSKUs.length && _loc6_.allowedForRandom[_loc1_] == 1)
            {
               _loc6_.skuToWin = _loc6_.prizeSKUs[_loc1_];
               _loc6_.skuIsClothing = _loc6_.prizeIsClothing[_loc1_];
               _loc6_.skuClothingMode = _loc6_.prizeClothingMode[_loc1_];
               class_7.method_1("Duplicate Prize (#" + _loc1_ + ")");
            }
            else
            {
               _loc2_ = [];
               _loc3_ = 13;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  if(_loc6_.allowedForRandom[_loc4_] == 1)
                  {
                     _loc2_.push(_loc6_.prizeSKUs[_loc4_]);
                  }
                  _loc4_++;
               }
               _loc5_ = Math.floor(Math.random() * _loc2_.length);
               _loc6_.skuToWin = _loc2_[_loc5_];
               _loc6_.skuIsClothing = _loc6_.prizeIsClothing[_loc6_.prizeSKUs.indexOf(_loc6_.skuToWin)];
               _loc6_.skuClothingMode = _loc6_.prizeClothingMode[_loc6_.prizeSKUs.indexOf(_loc6_.skuToWin)];
               class_7.method_1("Random Prize");
            }
         }
         class_7.method_1("(" + _loc6_.skuToWin + ")");
         _loc6_.amountToWin = 1;
      }
      
      public function getStartingLevel() : Number
      {
         var _loc5_:Number = NaN;
         var _loc1_:MiniGame = this;
         var _loc2_:UserData = _loc1_.screen.gameObj.var_128;
         var _loc3_:Number = 0;
         var _loc4_:Number = _loc1_.screen.possibleGames.indexOf(_loc1_.type);
         _loc5_ = Number(_loc2_.minigamePrizes[_loc4_]);
         if(_loc5_ < 14)
         {
            _loc3_ = _loc5_;
         }
         else
         {
            _loc3_ = 14;
         }
         class_7.method_1("Get starting level: " + _loc3_);
         return _loc3_;
      }
      
      public function tempCheckPrizes(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc9_:MiniGame = null;
         var _loc4_:int = 0;
         var _loc5_:FurniData = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:ClothingItem = null;
         _loc9_ = this;
         var _loc10_:UserData = _loc9_.screen.gameObj.var_128;
         class_7.method_1("____CHECK PRIZES IN STORE______");
         var _loc11_:int = 0;
         while(_loc11_ < param1.length)
         {
            if(param2[_loc11_] != false)
            {
               _loc6_ = param1[_loc11_];
               _loc7_ = [];
               if(param3[_loc11_] == "gender")
               {
                  _loc7_.push(_loc6_ + "_male");
                  _loc7_.push(_loc6_ + "_female");
               }
               else
               {
                  _loc7_.push(_loc6_);
               }
               _loc4_ = 0;
               while(_loc4_ < _loc9_.screen.gameObj.var_135.clothing.length)
               {
                  _loc8_ = _loc9_.screen.gameObj.var_135.clothing[_loc4_];
                  if(_loc7_.indexOf(_loc8_.tag) > -1)
                  {
                     if(_loc8_.inStore == true)
                     {
                        class_7.error("WARNING!!! " + _loc8_.tag + " -- inStore = " + _loc8_.inStore);
                     }
                  }
                  _loc4_++;
               }
            }
            else
            {
               _loc4_ = 0;
               while(true)
               {
                  if(_loc4_ >= _loc9_.screen.gameObj.var_133.furniItems.length)
                  {
                     break;
                  }
                  _loc5_ = _loc9_.screen.gameObj.var_133.furniItems[_loc4_];
                  if(_loc5_.tag == param1[_loc11_])
                  {
                     if(_loc5_.inStore == true)
                     {
                        class_7.error("WARNING!!! " + _loc5_.tag + " -- inStore = " + _loc5_.inStore);
                     }
                     break;
                  }
                  _loc4_++;
               }
            }
            _loc11_++;
         }
      }
      
      public function setupPrizes(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:FurniData = null;
         var _loc4_:MiniGame = this;
         var _loc5_:ClothingData = _loc4_.screen.gameObj.var_135;
         var _loc6_:String = _loc4_.screen.prizeSets[_loc4_.screen.possibleGames.indexOf(param1)];
         var _loc7_:Array = _loc4_.screen.gameObj.var_133.minigamePrizes[_loc6_];
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc2_ = _loc7_[_loc8_];
            if(_loc5_.clothingExists(_loc2_))
            {
               _loc4_.prizeSKUs.push(_loc2_);
               _loc4_.prizeIsClothing.push(true);
               _loc4_.prizeClothingMode.push("");
               _loc4_.allowedForRandom.push(0);
            }
            else if(_loc5_.clothingExists(_loc2_,true))
            {
               class_7.method_1("GENDERED CLOTHING STILL EXISTS?????? " + _loc2_);
               _loc4_.prizeSKUs.push(_loc2_);
               _loc4_.prizeIsClothing.push(true);
               _loc4_.prizeClothingMode.push("gender");
               _loc4_.allowedForRandom.push(0);
            }
            else
            {
               _loc4_.prizeSKUs.push(_loc2_);
               _loc4_.prizeIsClothing.push(false);
               _loc4_.prizeClothingMode.push("");
               _loc3_ = _loc4_.screen.gameObj.var_133.getFurniFromTag(_loc2_);
               if(_loc3_ == null)
               {
                  class_7.error("ERROR - UNKNOWN FURNI FOR MINIGAME: " + _loc2_);
               }
               else if(_loc3_.type == FurniData.TYPE_FLOORING || _loc3_.type == FurniData.TYPE_WALLPAPER)
               {
                  _loc4_.allowedForRandom.push(0);
               }
               else
               {
                  _loc4_.allowedForRandom.push(1);
               }
            }
            _loc8_++;
         }
      }
   }
}


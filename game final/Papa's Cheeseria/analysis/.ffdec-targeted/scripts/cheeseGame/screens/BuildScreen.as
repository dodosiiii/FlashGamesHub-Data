package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import package_2.*;
   import package_4.*;
   
   public class BuildScreen
   {
      
      public var clip:MovieClip;
      
      public var isActive:Boolean = false;
      
      public var gameObj:class_5;
      
      public var breadStartX:Number = 92;
      
      public var breadStartY:Number = 168;
      
      public var breadSpacingX:Number = 154;
      
      public var breadSpacingY:Number = 82;
      
      public var breadsPerRow:Number = 3;
      
      public var breadRows:Number = 4;
      
      public var cheeseStartX:Number = 67;
      
      public var cheeseStartY:Number = 168;
      
      public var cheeseSpacingX:Number = 118;
      
      public var cheeseSpacingY:Number = 72;
      
      public var cheesesPerRow:Number = 4;
      
      public var cheeseRows:Number = 3;
      
      public var binStartX:Number = 5;
      
      public var binStartY:Number = 86;
      
      public var binSpacingX:Number = 81;
      
      public var binSpacingY:Number = 60;
      
      public var binsPerRow:Number = 6;
      
      public var binRows:Number = 4;
      
      public var bottleStartX:Number = 68;
      
      public var bottleStartY:Number = 414;
      
      public var bottleSpacing:Number = 45;
      
      public var breadClips:Vector.<MovieClip> = null;
      
      public var breadTypes:Vector.<String> = null;
      
      public var cheeseClips:Vector.<MovieClip> = null;
      
      public var cheeseTypes:Vector.<String> = null;
      
      public var cheeseInStack:Vector.<int> = null;
      
      public var binClips:Vector.<MovieClip> = null;
      
      public var binTypes:Vector.<String> = null;
      
      public var bottles:Vector.<SauceBottle> = null;
      
      public var trashButtonOffscreenX:Number = -40;
      
      public var trashButtonTargetX:Number = 0;
      
      public var trashButtonCheeseY:Number = 360;
      
      public var trashButtonToppingY:Number = 316;
      
      private const MODE_BREAD:String = "bread";
      
      private const MODE_CHEESE:String = "cheese";
      
      private const MODE_TOPPING:String = "topping";
      
      public var mode:String = "bread";
      
      public var isChangingModes:Boolean = false;
      
      public var currentOrder:Sandwich = null;
      
      public var leavingSandwiches:Vector.<Sandwich> = null;
      
      public var draggingCheese:MovieClip = null;
      
      public var draggingCheeseType:String = null;
      
      public var draggingCheeseStartY:Number = 0;
      
      public var draggingCheeseStartX:Number = 0;
      
      public var returningCheese:MovieClip = null;
      
      public var returningCheeseType:String = null;
      
      public var returningCheeseTargetX:Number = 0;
      
      public var returningCheeseTargetY:Number = 0;
      
      public var returningCheeseSpeed:Number = 10;
      
      public var returningCheeseSpeedMin:Number = 20;
      
      public var returningCheeseSpeedChange:Number = 5;
      
      public var returningCheeseSpeedMax:Number = 50;
      
      public var cheeseStackScale:Number = 0.9;
      
      public var cheeseDragScale:Number = 1;
      
      public var cheeseDragScaleMaxY:Number = 320;
      
      public var draggingTopping:Topping = null;
      
      public var returningToppings:Vector.<Topping> = null;
      
      public var toppingSpiralDirection:Number = 1;
      
      public function BuildScreen(param1:class_5)
      {
         super();
         var _loc2_:BuildScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:BuildScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.clip = new buildScreenMC();
         _loc1_.clip.mouseEnabled = false;
         _loc1_.clip.bg.mouseEnabled = false;
         _loc1_.clip.bg.inside.cacheAsBitmap = true;
         _loc1_.leavingSandwiches = new Vector.<Sandwich>();
         _loc1_.clip.trash_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickTrash);
         _loc1_.gameObj.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickScreen);
         _loc1_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc1_.releaseScreen);
         _loc1_.setupToppings(true);
         _loc1_.setupBreads();
         _loc1_.setupCheeses();
         _loc1_.switchMode("bread");
      }
      
      public function setupBreads(param1:Boolean = true, param2:Number = -1) : void
      {
         var _loc3_:* = 0;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Boolean = false;
         var _loc6_:Array = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:BuildScreen = this;
         var _loc10_:UserData = _loc9_.gameObj.var_128;
         if(param1)
         {
            if(_loc9_.breadClips == null)
            {
               _loc9_.breadClips = new Vector.<MovieClip>();
            }
            if(_loc9_.breadTypes == null)
            {
               _loc9_.breadTypes = new Vector.<String>();
            }
            _loc4_ = _loc9_.gameObj.var_128.getMonth();
            _loc5_ = _loc9_.gameObj.var_128.isNewYear();
            if(param2 > -1)
            {
               _loc4_ = param2;
               _loc5_ = true;
            }
            _loc6_ = FoodData.getBreads(_loc4_,_loc5_);
            if(_loc6_.length == 11)
            {
               _loc6_.push("holidaynotused");
            }
            _loc3_ = 0;
            while(_loc3_ < _loc6_.length)
            {
               if(_loc10_.hasTopping(_loc6_[_loc3_]))
               {
                  _loc7_ = class_12.method_103("choose_" + _loc6_[_loc3_]);
                  _loc7_.gotoAndStop(1);
                  _loc7_.buttonMode = true;
                  _loc7_.useHandCursor = true;
                  _loc7_.addEventListener(MouseEvent.MOUSE_DOWN,_loc9_.clickBreadClip);
                  _loc7_.addEventListener(MouseEvent.ROLL_OVER,_loc9_.rolloverBreadClip);
                  _loc7_.addEventListener(MouseEvent.ROLL_OUT,_loc9_.rolloutBreadClip);
                  _loc7_.y = _loc9_.breadStartY + Math.floor(_loc3_ / _loc9_.breadsPerRow) * _loc9_.breadSpacingY;
                  _loc7_.x = _loc9_.breadStartX + _loc3_ % _loc9_.breadsPerRow * _loc9_.breadSpacingX;
                  _loc7_.normalY = _loc7_.y;
                  _loc7_.cacheAsBitmap = true;
                  this.breadClips.push(_loc7_);
                  this.breadTypes.push(_loc6_[_loc3_]);
                  _loc9_.clip.bg.breadholder.addChild(_loc7_);
               }
               else
               {
                  _loc8_ = new build_breadstack_lines();
                  _loc8_.y = _loc9_.breadStartY + Math.floor(_loc3_ / _loc9_.breadsPerRow) * _loc9_.breadSpacingY;
                  _loc8_.x = _loc9_.breadStartX + _loc3_ % _loc9_.breadsPerRow * _loc9_.breadSpacingX;
                  _loc9_.breadClips.push(_loc8_);
                  _loc9_.breadTypes.push(null);
                  _loc9_.clip.bg.breadholder.addChild(_loc8_);
               }
               _loc3_++;
            }
         }
         else if(_loc9_.breadClips != null)
         {
            _loc3_ = int(_loc9_.breadClips.length - 1);
            while(_loc3_ >= 0)
            {
               if(_loc9_.breadClips[_loc3_] != null)
               {
                  _loc9_.breadClips[_loc3_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc9_.clickBreadClip);
                  _loc9_.breadClips[_loc3_].removeEventListener(MouseEvent.ROLL_OVER,_loc9_.rolloverBreadClip);
                  _loc9_.breadClips[_loc3_].removeEventListener(MouseEvent.ROLL_OUT,_loc9_.rolloutBreadClip);
                  _loc9_.breadClips[_loc3_].parent.removeChild(_loc9_.breadClips[_loc3_]);
                  _loc9_.breadClips[_loc3_] = null;
                  _loc9_.breadClips.splice(_loc3_,1);
                  _loc9_.breadTypes.splice(_loc3_,1);
               }
               _loc3_--;
            }
            _loc9_.breadClips = null;
            _loc9_.breadTypes = null;
         }
      }
      
      public function clickBreadClip(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         var _loc5_:BuildScreen = this;
         if(_loc5_.mode == _loc5_.MODE_BREAD)
         {
            _loc2_ = MovieClip(param1.currentTarget);
            _loc3_ = _loc5_.breadClips.indexOf(_loc2_);
            _loc4_ = null;
            if(_loc2_ != null && _loc3_ > -1 && _loc3_ < _loc5_.breadTypes.length)
            {
               class_7.method_1("Clicked Bread: " + _loc5_.breadTypes[_loc3_]);
               _loc4_ = _loc5_.breadTypes[_loc3_];
            }
            else
            {
               class_7.method_1("Unknown bread clicked: " + param1.currentTarget);
            }
            if(!_loc5_.gameObj.training || _loc4_ == FoodData.BREAD_WHITE)
            {
               if(_loc4_ != null)
               {
                  if(_loc5_.currentOrder == null)
                  {
                     _loc5_.currentOrder = new Sandwich(_loc5_.gameObj,_loc4_,_loc2_.x,_loc2_.y);
                     _loc5_.gameObj.var_129.playSound("grabtopping.wav");
                     _loc5_.switchMode(_loc5_.MODE_CHEESE);
                     _loc2_.gotoAndStop(2);
                     if(_loc4_ == FoodData.BREAD_WHITE)
                     {
                        _loc5_.gameObj.method_104(5);
                     }
                  }
                  else
                  {
                     class_7.error("You already have a sandwich, how are you clicking bread again?");
                  }
               }
            }
         }
      }
      
      public function rolloverBreadClip(param1:MouseEvent) : void
      {
         param1.currentTarget.y = param1.currentTarget.normalY - 5;
      }
      
      public function rolloutBreadClip(param1:MouseEvent) : void
      {
         param1.currentTarget.y = param1.currentTarget.normalY;
      }
      
      public function setupCheeses(param1:Boolean = true, param2:Number = -1) : void
      {
         var _loc3_:* = 0;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Boolean = false;
         var _loc6_:Array = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:BuildScreen = this;
         var _loc10_:UserData = _loc9_.gameObj.var_128;
         if(param1)
         {
            if(_loc9_.cheeseClips == null)
            {
               _loc9_.cheeseClips = new Vector.<MovieClip>();
            }
            if(_loc9_.cheeseTypes == null)
            {
               _loc9_.cheeseTypes = new Vector.<String>();
            }
            if(_loc9_.cheeseInStack == null)
            {
               _loc9_.cheeseInStack = new Vector.<int>();
            }
            _loc4_ = _loc9_.gameObj.var_128.getMonth();
            _loc5_ = _loc9_.gameObj.var_128.isNewYear();
            if(param2 > -1)
            {
               _loc4_ = param2;
               _loc5_ = true;
            }
            _loc6_ = FoodData.getCheeses(_loc4_,_loc5_);
            if(_loc6_.length == 11)
            {
               _loc6_.push("holidaynotused");
            }
            _loc3_ = 0;
            while(_loc3_ < _loc6_.length)
            {
               if(_loc10_.hasTopping(_loc6_[_loc3_]))
               {
                  _loc7_ = class_12.method_103("choose_" + _loc6_[_loc3_]);
                  _loc7_.gotoAndStop(1);
                  _loc7_.buttonMode = true;
                  _loc7_.useHandCursor = true;
                  _loc7_.addEventListener(MouseEvent.MOUSE_DOWN,_loc9_.clickCheeseClip);
                  _loc7_.addEventListener(MouseEvent.ROLL_OVER,_loc9_.rolloverCheeseClip);
                  _loc7_.addEventListener(MouseEvent.ROLL_OUT,_loc9_.rolloutCheeseClip);
                  _loc7_.y = _loc9_.cheeseStartY + Math.floor(_loc3_ / _loc9_.cheesesPerRow) * _loc9_.cheeseSpacingY;
                  _loc7_.x = _loc9_.cheeseStartX + _loc3_ % _loc9_.cheesesPerRow * _loc9_.cheeseSpacingX;
                  _loc9_.cheeseClips.push(_loc7_);
                  _loc9_.cheeseTypes.push(_loc6_[_loc3_]);
                  _loc9_.cheeseInStack.push(2);
                  _loc9_.clip.bg.cheeseholder.addChild(_loc7_);
               }
               else
               {
                  _loc8_ = new build_cheesestack_lines();
                  _loc8_.y = _loc9_.cheeseStartY + Math.floor(_loc3_ / _loc9_.cheesesPerRow) * _loc9_.cheeseSpacingY;
                  _loc8_.x = _loc9_.cheeseStartX + _loc3_ % _loc9_.cheesesPerRow * _loc9_.cheeseSpacingX;
                  _loc9_.cheeseClips.push(_loc8_);
                  _loc9_.cheeseTypes.push(null);
                  _loc9_.cheeseInStack.push(0);
                  _loc9_.clip.bg.cheeseholder.addChild(_loc8_);
               }
               _loc3_++;
            }
         }
         else if(_loc9_.cheeseClips != null)
         {
            _loc3_ = int(_loc9_.cheeseClips.length - 1);
            while(_loc3_ >= 0)
            {
               if(_loc9_.cheeseClips[_loc3_] != null)
               {
                  _loc9_.cheeseClips[_loc3_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc9_.clickCheeseClip);
                  _loc9_.cheeseClips[_loc3_].removeEventListener(MouseEvent.ROLL_OVER,_loc9_.rolloverCheeseClip);
                  _loc9_.cheeseClips[_loc3_].removeEventListener(MouseEvent.ROLL_OUT,_loc9_.rolloutCheeseClip);
                  _loc9_.cheeseClips[_loc3_].parent.removeChild(_loc9_.cheeseClips[_loc3_]);
                  _loc9_.cheeseClips[_loc3_] = null;
                  _loc9_.cheeseClips.splice(_loc3_,1);
                  _loc9_.cheeseTypes.splice(_loc3_,1);
                  _loc9_.cheeseInStack.splice(_loc3_,1);
               }
               _loc3_--;
            }
            _loc9_.cheeseClips = null;
            _loc9_.cheeseTypes = null;
            _loc9_.cheeseInStack = null;
         }
      }
      
      public function clickCheeseClip(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         var _loc5_:BuildScreen = this;
         if(_loc5_.mode == _loc5_.MODE_CHEESE && _loc5_.currentOrder != null && _loc5_.currentOrder.canAddCheese)
         {
            _loc2_ = MovieClip(param1.currentTarget);
            _loc3_ = _loc5_.cheeseClips.indexOf(_loc2_);
            _loc4_ = null;
            if(_loc2_ != null && _loc3_ > -1 && _loc3_ < _loc5_.cheeseTypes.length)
            {
               class_7.method_1("Clicked Cheese: " + _loc5_.cheeseTypes[_loc3_]);
               _loc4_ = _loc5_.cheeseTypes[_loc3_];
            }
            else
            {
               class_7.method_1("Unknown cheese clicked: " + param1.currentTarget);
            }
            if(!_loc5_.gameObj.training || _loc4_ == FoodData.CHEESE_COLBY)
            {
               if(_loc4_ != null && _loc5_.draggingCheese == null)
               {
                  _loc5_.draggingCheese = class_12.method_103("clip_" + _loc4_ + "_bottom",true,false);
                  _loc5_.draggingCheese.gotoAndStop(1);
                  _loc5_.draggingCheese.scaleX = _loc5_.cheeseStackScale;
                  _loc5_.draggingCheese.scaleY = _loc5_.cheeseStackScale;
                  _loc5_.draggingCheese.x = _loc2_.x;
                  _loc5_.draggingCheese.y = _loc2_.y;
                  _loc5_.draggingCheeseType = _loc4_;
                  _loc5_.draggingCheeseStartX = _loc2_.x;
                  _loc5_.draggingCheeseStartY = _loc2_.y;
                  _loc5_.clip.dragholder.addChild(_loc5_.draggingCheese);
                  _loc5_.gameObj.var_129.playSound("grabtopping.wav");
                  --_loc5_.cheeseInStack[_loc3_];
                  if(_loc5_.cheeseInStack[_loc3_] == 1)
                  {
                     _loc2_.gotoAndStop(3);
                  }
                  else if(_loc5_.cheeseInStack[_loc3_] <= 0)
                  {
                     _loc2_.gotoAndStop(5);
                     _loc2_.mouseEnabled = false;
                     _loc2_.mouseChildren = false;
                  }
               }
            }
         }
      }
      
      public function rolloverCheeseClip(param1:MouseEvent) : void
      {
         if(param1.currentTarget.currentFrame == 1)
         {
            param1.currentTarget.gotoAndStop(2);
         }
         else if(param1.currentTarget.currentFrame == 3)
         {
            param1.currentTarget.gotoAndStop(4);
         }
      }
      
      public function rolloutCheeseClip(param1:MouseEvent) : void
      {
         if(param1.currentTarget.currentFrame == 2)
         {
            param1.currentTarget.gotoAndStop(1);
         }
         else if(param1.currentTarget.currentFrame == 4)
         {
            param1.currentTarget.gotoAndStop(3);
         }
      }
      
      public function setupToppings(param1:Boolean = true, param2:Number = -1) : void
      {
         var _loc3_:* = 0;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Boolean = false;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Number = Number(NaN);
         var _loc12_:SauceBottle = null;
         var _loc13_:BuildScreen = this;
         var _loc14_:UserData = _loc13_.gameObj.var_128;
         if(param1)
         {
            if(_loc13_.binClips == null)
            {
               _loc13_.binClips = new Vector.<MovieClip>();
            }
            if(_loc13_.binTypes == null)
            {
               _loc13_.binTypes = new Vector.<String>();
            }
            _loc4_ = _loc13_.gameObj.var_128.getMonth();
            _loc5_ = _loc13_.gameObj.var_128.isNewYear();
            if(param2 > -1)
            {
               _loc4_ = param2;
               _loc5_ = true;
            }
            _loc6_ = FoodData.getToppings(_loc4_,_loc5_);
            _loc6_.splice(14,0,null);
            _loc6_.splice(14,0,null);
            _loc6_.splice(20,0,null);
            _loc6_.splice(20,0,null);
            if(_loc6_.length < _loc13_.binsPerRow * _loc13_.binRows)
            {
               class_7.method_1("Build fill-in topping for no holiday");
               _loc6_.push("holidaynotused");
            }
            _loc3_ = 0;
            while(_loc3_ < _loc6_.length)
            {
               if(_loc6_[_loc3_] != null)
               {
                  if(_loc14_.hasTopping(_loc6_[_loc3_]))
                  {
                     _loc9_ = class_12.method_103("topping_" + _loc6_[_loc3_] + "_bin");
                     _loc9_.gotoAndStop(1);
                     _loc9_.buttonMode = true;
                     _loc9_.useHandCursor = true;
                     _loc9_.addEventListener(MouseEvent.MOUSE_DOWN,_loc13_.clickBin);
                     _loc9_.addEventListener(MouseEvent.ROLL_OVER,_loc13_.rolloverBin);
                     _loc9_.addEventListener(MouseEvent.ROLL_OUT,_loc13_.rolloutBin);
                     _loc9_.y = _loc13_.binStartY + Math.floor(_loc3_ / _loc13_.binsPerRow) * _loc13_.binSpacingY;
                     _loc9_.x = _loc13_.binStartX + _loc3_ % _loc13_.binsPerRow * _loc13_.binSpacingX;
                     _loc13_.binClips.push(_loc9_);
                     _loc13_.binTypes.push(_loc6_[_loc3_]);
                     _loc13_.clip.bg.toppingholder.addChild(_loc9_);
                     _loc9_.cacheAsBitmap = true;
                  }
                  else
                  {
                     _loc10_ = new topping_empty_bin();
                     _loc10_.y = _loc13_.binStartY + Math.floor(_loc3_ / _loc13_.binsPerRow) * _loc13_.binSpacingY;
                     _loc10_.x = _loc13_.binStartX + _loc3_ % _loc13_.binsPerRow * _loc13_.binSpacingX;
                     _loc13_.binClips.push(_loc10_);
                     _loc13_.binTypes.push(null);
                     _loc13_.clip.bg.toppingholder.addChild(_loc10_);
                     _loc10_.cacheAsBitmap = true;
                  }
               }
               _loc3_++;
            }
            if(_loc13_.bottles == null)
            {
               _loc13_.bottles = new Vector.<SauceBottle>();
            }
            _loc7_ = FoodData.getSauces(_loc4_,_loc5_);
            _loc8_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc7_.length)
            {
               if(_loc7_[_loc3_] != null)
               {
                  if(_loc14_.hasTopping(_loc7_[_loc3_]))
                  {
                     _loc11_ = _loc13_.bottleStartX + _loc13_.bottleSpacing * _loc8_;
                     if(FoodData.isHolidayItem(_loc7_[_loc3_]))
                     {
                        _loc11_ = _loc13_.bottleStartX - _loc13_.bottleSpacing;
                     }
                     else
                     {
                        _loc8_++;
                     }
                     _loc12_ = new SauceBottle(_loc13_.gameObj,_loc7_[_loc3_],_loc13_.clip.fg.toppingholder,_loc11_,_loc13_.bottleStartY);
                     _loc13_.bottles.push(_loc12_);
                  }
               }
               _loc3_++;
            }
            _loc13_.returningToppings = new Vector.<Topping>();
         }
         else
         {
            if(_loc13_.binClips != null)
            {
               _loc3_ = int(_loc13_.binClips.length - 1);
               while(_loc3_ >= 0)
               {
                  if(_loc13_.binClips[_loc3_] != null)
                  {
                     _loc13_.binClips[_loc3_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc13_.clickBin);
                     _loc13_.binClips[_loc3_].removeEventListener(MouseEvent.ROLL_OVER,_loc13_.rolloverBin);
                     _loc13_.binClips[_loc3_].removeEventListener(MouseEvent.ROLL_OUT,_loc13_.rolloutBin);
                     _loc13_.binClips[_loc3_].parent.removeChild(_loc13_.binClips[_loc3_]);
                     _loc13_.binClips[_loc3_] = null;
                     _loc13_.binClips.splice(_loc3_,1);
                     _loc13_.binTypes.splice(_loc3_,1);
                  }
                  _loc3_--;
               }
               _loc13_.binClips = null;
               _loc13_.binTypes = null;
            }
            if(_loc13_.bottles != null)
            {
               _loc3_ = int(_loc13_.bottles.length - 1);
               while(_loc3_ >= 0)
               {
                  if(_loc13_.bottles[_loc3_] != null)
                  {
                     _loc13_.bottles[_loc3_].destroy();
                     _loc13_.bottles[_loc3_] = null;
                     _loc13_.bottles.splice(_loc3_,1);
                  }
                  _loc3_--;
               }
               _loc13_.bottles = null;
            }
            if(_loc13_.draggingTopping != null)
            {
               _loc13_.draggingTopping.destroy();
               _loc13_.draggingTopping = null;
            }
            if(_loc13_.returningToppings != null && _loc13_.returningToppings.length > 0)
            {
               _loc3_ = int(_loc13_.returningToppings.length - 1);
               while(_loc3_ >= 0)
               {
                  if(_loc13_.returningToppings[_loc3_] != null)
                  {
                     _loc13_.returningToppings[_loc3_].destroy();
                     _loc13_.returningToppings[_loc3_] = null;
                  }
                  _loc13_.returningToppings.splice(_loc3_,1);
                  _loc3_--;
               }
            }
            _loc13_.returningToppings = null;
         }
      }
      
      public function clickBin(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         var _loc5_:BuildScreen = this;
         if(_loc5_.mode == _loc5_.MODE_TOPPING)
         {
            _loc2_ = MovieClip(param1.currentTarget);
            _loc3_ = _loc5_.binClips.indexOf(_loc2_);
            _loc4_ = null;
            if(_loc2_ != null && _loc3_ > -1 && _loc3_ < _loc5_.binTypes.length)
            {
               class_7.method_1("Clicked Bin: " + _loc5_.binTypes[_loc3_]);
               _loc4_ = _loc5_.binTypes[_loc3_];
            }
            else
            {
               class_7.method_1("Unknown bin clicked: " + param1.currentTarget);
            }
            if(_loc4_ != null && _loc5_.draggingTopping == null)
            {
               _loc5_.toppingSpiralDirection *= -1;
               _loc5_.draggingTopping = new Topping(_loc5_.gameObj,_loc4_,_loc5_.toppingSpiralDirection);
            }
            if(_loc5_.gameObj.hud.whichContextTraining == "season")
            {
               _loc5_.gameObj.hud.removeContextTraining();
            }
         }
      }
      
      public function rolloverBin(param1:MouseEvent) : void
      {
         var _loc2_:BuildScreen = this;
         if(_loc2_.draggingTopping == null)
         {
            if(param1.currentTarget.currentFrame == 1)
            {
               param1.currentTarget.gotoAndStop(2);
            }
         }
      }
      
      public function rolloutBin(param1:MouseEvent) : void
      {
         if(param1.currentTarget.currentFrame == 2)
         {
            param1.currentTarget.gotoAndStop(1);
         }
      }
      
      public function getBinClip(param1:String) : MovieClip
      {
         var _loc2_:BuildScreen = this;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.binTypes.length)
         {
            if(_loc2_.binTypes[_loc4_] == param1)
            {
               _loc3_ = _loc2_.binClips[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function cheatChangeMonth(param1:Number) : void
      {
         var _loc2_:BuildScreen = this;
         _loc2_.setupBreads(false);
         _loc2_.setupBreads(true,param1);
         _loc2_.setupCheeses(false);
         _loc2_.setupCheeses(true,param1);
         _loc2_.setupToppings(false);
         _loc2_.setupToppings(true,param1);
      }
      
      public function destroy() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:BuildScreen = this;
         _loc2_.clip.trash_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickTrash);
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickScreen);
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseScreen);
         if(_loc2_.currentOrder)
         {
            _loc2_.currentOrder.destroy();
            _loc2_.currentOrder = null;
         }
         if(_loc2_.returningCheese != null)
         {
            if(_loc2_.returningCheese.parent)
            {
               _loc2_.returningCheese.parent.removeChild(_loc2_.returningCheese);
               _loc2_.returningCheese = null;
            }
         }
         _loc2_.setupToppings(false);
         _loc2_.setupBreads(false);
         _loc2_.setupCheeses(false);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.leavingSandwiches.length)
         {
            _loc2_.leavingSandwiches[_loc1_].destroy();
            _loc2_.leavingSandwiches[_loc1_] = null;
            _loc1_++;
         }
         _loc2_.leavingSandwiches = null;
         if(_loc2_.gameObj.var_138.contains(_loc2_.clip))
         {
            _loc2_.gameObj.var_138.removeChild(_loc2_.clip);
         }
         _loc2_.clip = null;
      }
      
      public function activateScreen() : void
      {
         var _loc1_:BuildScreen = this;
         if(!_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         }
         _loc1_.gameObj.var_129.switchMusic("build");
         _loc1_.isActive = true;
         if(_loc1_.currentOrder == null && _loc1_.mode != _loc1_.MODE_BREAD)
         {
            _loc1_.switchMode(_loc1_.MODE_BREAD,true);
         }
         if(Boolean(_loc1_.gameObj.var_147.hangerTicket) && Boolean(_loc1_.gameObj.var_147.hangerTicket.orderData.isSpecial) && !_loc1_.gameObj.var_128.hasTrained("cheatsheet"))
         {
            _loc1_.gameObj.hud.showContextTraining("cheatsheet");
         }
      }
      
      public function deactivateScreen() : void
      {
         var _loc1_:BuildScreen = this;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.isActive = false;
      }
      
      public function updateScreen() : void
      {
         var _loc1_:* = 0;
         var _loc2_:BuildScreen = this;
         var _loc3_:Number = 0;
         if(_loc2_.mode == _loc2_.MODE_CHEESE)
         {
            _loc3_ = -640;
         }
         else if(_loc2_.mode == _loc2_.MODE_TOPPING)
         {
            _loc3_ = -1280;
         }
         var _loc4_:Number = _loc3_ - _loc2_.clip.bg.x;
         _loc2_.clip.bg.x += _loc4_ / 3;
         if(Math.abs(_loc4_) <= 1)
         {
            _loc2_.clip.bg.x = _loc3_;
            _loc2_.isChangingModes = false;
         }
         _loc2_.clip.fg.x = _loc2_.clip.bg.x;
         if(Math.abs(_loc4_) <= 10)
         {
            _loc2_.clip.bg.mouseChildren = true;
            _loc2_.clip.bg.cacheAsBitmap = false;
         }
         if(_loc2_.mode == _loc2_.MODE_CHEESE && !_loc2_.isChangingModes)
         {
            _loc2_.clip.trash_btn.x += (_loc2_.trashButtonTargetX - _loc2_.clip.trash_btn.x) / 2;
            _loc2_.clip.trash_btn.y = _loc2_.trashButtonCheeseY;
         }
         else if(_loc2_.mode == _loc2_.MODE_TOPPING)
         {
            _loc2_.clip.trash_btn.x += (_loc2_.trashButtonTargetX - _loc2_.clip.trash_btn.x) / 2;
            _loc2_.clip.trash_btn.y += (_loc2_.trashButtonToppingY - _loc2_.clip.trash_btn.y) / 2;
         }
         if(_loc2_.currentOrder != null)
         {
            _loc2_.currentOrder.updateSandwichOnBuild();
         }
         if(_loc2_.leavingSandwiches != null && _loc2_.leavingSandwiches.length > 0)
         {
            _loc1_ = int(_loc2_.leavingSandwiches.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc2_.leavingSandwiches[_loc1_] != null)
               {
                  _loc2_.leavingSandwiches[_loc1_].updateSandwichOnBuild();
               }
               _loc1_--;
            }
         }
         _loc2_.animateMovingItems();
      }
      
      public function removeCurrentOrder(param1:Boolean = false) : void
      {
         var _loc2_:BuildScreen = this;
         if(_loc2_.currentOrder != null)
         {
            if(param1)
            {
               _loc2_.currentOrder.destroy();
            }
            _loc2_.currentOrder = null;
         }
      }
      
      public function switchMode(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BuildScreen = this;
         var _loc5_:String = _loc4_.mode;
         _loc4_.mode = param1;
         _loc4_.isChangingModes = true;
         _loc4_.gameObj.var_129.playSound("trayslide.wav");
         _loc4_.clip.bg.mouseChildren = false;
         _loc4_.clip.bg.cacheAsBitmap = true;
         if(_loc4_.mode == _loc4_.MODE_BREAD)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.breadClips.length)
            {
               if(_loc4_.breadClips[_loc3_] != null)
               {
                  _loc4_.breadClips[_loc3_].gotoAndStop(1);
               }
               _loc3_++;
            }
            _loc4_.clip.trash_btn.x = _loc4_.trashButtonOffscreenX;
            _loc4_.clip.trash_btn.y = _loc4_.trashButtonCheeseY;
         }
         else if(_loc4_.mode == _loc4_.MODE_CHEESE)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.cheeseClips.length)
            {
               if(_loc4_.cheeseClips[_loc3_] != null)
               {
                  _loc4_.cheeseClips[_loc3_].gotoAndStop(1);
                  _loc4_.cheeseClips[_loc3_].mouseEnabled = true;
                  _loc4_.cheeseClips[_loc3_].mouseChildren = true;
                  _loc4_.cheeseInStack[_loc3_] = 2;
               }
               _loc3_++;
            }
            _loc4_.clip.trash_btn.x = _loc4_.trashButtonOffscreenX;
            _loc4_.clip.trash_btn.y = _loc4_.trashButtonCheeseY;
         }
         else if(_loc4_.mode == _loc4_.MODE_TOPPING)
         {
            if(_loc4_.currentOrder)
            {
               _loc4_.currentOrder.prepareForTopping();
            }
            if(_loc4_.gameObj.var_128.getMonth() > GameData.STARTER_MONTH + 1 && !_loc4_.gameObj.var_128.hasTrained("season"))
            {
               _loc4_.gameObj.hud.showContextTraining("season");
               _loc4_.gameObj.var_128.setTrained("season");
            }
         }
         if(param2)
         {
            if(_loc4_.mode == _loc4_.MODE_BREAD)
            {
               _loc4_.clip.bg.mouseChildren = true;
               _loc4_.clip.bg.cacheAsBitmap = false;
               _loc4_.clip.bg.x = 0;
               _loc4_.clip.fg.x = 0;
            }
         }
      }
      
      public function initStationUpgrades() : void
      {
      }
      
      public function restoreSoundAfterAd() : void
      {
      }
      
      public function clickTrash(param1:MouseEvent) : void
      {
         var _loc2_:BuildScreen = this;
         if(!_loc2_.isChangingModes && !_loc2_.gameObj.training)
         {
            if(_loc2_.currentOrder)
            {
               _loc2_.currentOrder.sendToBuildTrash();
               _loc2_.addToLeavingSandwiches(_loc2_.currentOrder);
               _loc2_.removeCurrentOrder(false);
               _loc2_.switchMode(_loc2_.MODE_BREAD);
            }
         }
         else if(_loc2_.gameObj.training)
         {
            _loc2_.gameObj.hud.showTrainingWarning("garbage");
         }
      }
      
      public function addToLeavingSandwiches(param1:Sandwich) : void
      {
         var _loc2_:BuildScreen = this;
         _loc2_.leavingSandwiches.push(param1);
      }
      
      public function removeFromLeavingSandwiches(param1:Sandwich, param2:Boolean = false) : void
      {
         var _loc3_:BuildScreen = this;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.leavingSandwiches.length)
         {
            if(_loc3_.leavingSandwiches[_loc4_] == param1)
            {
               if(param2)
               {
                  _loc3_.leavingSandwiches[_loc4_].destroy();
               }
               _loc3_.leavingSandwiches[_loc4_] = null;
               _loc3_.leavingSandwiches.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function addToReturningToppings(param1:Topping) : void
      {
         var _loc2_:BuildScreen = this;
         _loc2_.returningToppings.push(param1);
      }
      
      public function removeFromReturningToppings(param1:Topping) : void
      {
         var _loc2_:BuildScreen = this;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.returningToppings.length)
         {
            if(_loc2_.returningToppings[_loc3_] == param1)
            {
               _loc2_.returningToppings[_loc3_].destroy();
               _loc2_.returningToppings[_loc3_] = null;
               _loc2_.returningToppings.splice(_loc3_,1);
               class_7.method_1("(Removed)");
               break;
            }
            _loc3_++;
         }
      }
      
      public function clickScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:BuildScreen = this;
         if(_loc2_.isActive && !_loc2_.gameObj.var_169)
         {
         }
      }
      
      public function releaseScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:BuildScreen = this;
         if(_loc2_.isActive && !_loc2_.gameObj.var_169)
         {
            if(_loc2_.mode == _loc2_.MODE_CHEESE && _loc2_.draggingCheese != null)
            {
               _loc2_.releaseDraggingCheese();
            }
            else if(_loc2_.mode == _loc2_.MODE_TOPPING && _loc2_.draggingTopping != null)
            {
               _loc2_.releaseDraggingTopping();
            }
            else if(_loc2_.mode == _loc2_.MODE_TOPPING && _loc2_.currentOrder != null && _loc2_.currentOrder.isDraggingTopBread)
            {
               _loc2_.currentOrder.tryToAddTopBread();
            }
         }
      }
      
      public function releaseDraggingCheese() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:BuildScreen = this;
         class_7.method_1("Released some cheese!");
         var _loc5_:Boolean = false;
         if(_loc4_.currentOrder)
         {
            _loc5_ = _loc4_.currentOrder.tryToAddCheese(_loc4_.draggingCheese,_loc4_.draggingCheeseType);
         }
         if(!_loc5_)
         {
            if(_loc4_.returningCheese != null)
            {
               if(_loc4_.returningCheese.parent)
               {
                  _loc4_.returningCheese.parent.removeChild(_loc4_.returningCheese);
                  _loc4_.returningCheese = null;
               }
            }
            _loc4_.returningCheese = _loc4_.draggingCheese;
            _loc4_.returningCheeseSpeed = _loc4_.returningCheeseSpeedMin;
            _loc4_.returningCheeseTargetX = _loc4_.draggingCheeseStartX;
            _loc4_.returningCheeseTargetY = _loc4_.draggingCheeseStartY;
            _loc4_.returningCheeseType = _loc4_.draggingCheeseType;
            _loc1_ = _loc4_.returningCheeseTargetX - _loc4_.returningCheese.x;
            _loc2_ = _loc4_.returningCheeseTargetY - _loc4_.returningCheese.y;
            _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
            _loc4_.returningCheeseSpeed = Math.round(_loc3_ / 15);
         }
         else if(_loc5_)
         {
            if(_loc4_.draggingCheese.parent)
            {
               _loc4_.draggingCheese.parent.removeChild(_loc4_.draggingCheese);
            }
         }
         _loc4_.draggingCheese = null;
         _loc4_.draggingCheeseType = null;
         if(Boolean(_loc4_.currentOrder) && _loc4_.currentOrder.hasBothCheeses())
         {
            _loc4_.switchMode(_loc4_.MODE_TOPPING);
         }
      }
      
      public function releaseDraggingTopping() : void
      {
         var _loc1_:BuildScreen = this;
         var _loc2_:Boolean = false;
         if(Boolean(_loc1_.currentOrder) && Boolean(_loc1_.draggingTopping))
         {
            _loc2_ = _loc1_.currentOrder.tryToAddTopping(_loc1_.draggingTopping);
         }
         if(!_loc2_)
         {
            _loc1_.draggingTopping.returnToBin();
            _loc1_.addToReturningToppings(_loc1_.draggingTopping);
         }
         _loc1_.draggingTopping = null;
      }
      
      public function animateMovingItems() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:MovieClip = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:BuildScreen = this;
         if(_loc6_.returningCheese != null)
         {
            if(_loc6_.returningCheeseSpeed < _loc6_.returningCheeseSpeedMax)
            {
               _loc6_.returningCheeseSpeed += _loc6_.returningCheeseSpeedChange;
               if(_loc6_.returningCheeseSpeed > _loc6_.returningCheeseSpeedMax)
               {
                  _loc6_.returningCheeseSpeed = _loc6_.returningCheeseSpeedMax;
               }
            }
            _loc6_.tweenToTarget(_loc6_.returningCheese,_loc6_.returningCheeseTargetX,_loc6_.returningCheeseTargetY,_loc6_.returningCheeseSpeed,true);
            _loc2_ = Math.min(1,Math.max(0,(_loc6_.returningCheese.y - _loc6_.returningCheeseTargetY) / (_loc6_.cheeseDragScaleMaxY - _loc6_.returningCheeseTargetY)));
            _loc6_.returningCheese.scaleX = _loc6_.cheeseStackScale + _loc2_ * (_loc6_.cheeseDragScale - _loc6_.cheeseStackScale);
            _loc6_.returningCheese.scaleY = _loc6_.returningCheese.scaleX;
            if(Math.abs(_loc6_.returningCheeseTargetX - _loc6_.returningCheese.x) <= 1 && Math.abs(_loc6_.returningCheeseTargetY - _loc6_.returningCheese.y) <= 1)
            {
               class_7.method_1("Remove this returning " + _loc6_.returningCheeseType);
               _loc3_ = _loc6_.cheeseTypes.indexOf(_loc6_.returningCheeseType);
               if(_loc3_ > -1 && _loc3_ < _loc6_.cheeseClips.length)
               {
                  _loc6_.cheeseInStack[_loc3_] += 1;
                  _loc4_ = _loc6_.cheeseClips[_loc3_];
                  if(_loc4_ != null)
                  {
                     if(_loc6_.cheeseInStack[_loc3_] >= 2)
                     {
                        _loc4_.gotoAndStop(1);
                        _loc4_.mouseEnabled = true;
                        _loc4_.mouseChildren = true;
                     }
                     else if(_loc6_.cheeseInStack[_loc3_] == 1)
                     {
                        _loc4_.gotoAndStop(3);
                        _loc4_.mouseEnabled = true;
                        _loc4_.mouseChildren = true;
                     }
                     else if(_loc6_.cheeseInStack[_loc3_] <= 0)
                     {
                        _loc4_.gotoAndStop(5);
                        _loc4_.mouseEnabled = false;
                        _loc4_.mouseChildren = false;
                     }
                  }
               }
               _loc6_.gameObj.var_129.playSound("droptopping.wav");
               if(_loc6_.returningCheese.parent)
               {
                  _loc6_.returningCheese.parent.removeChild(_loc6_.returningCheese);
               }
               _loc6_.returningCheese = null;
               _loc6_.returningCheeseType = null;
            }
         }
         if(_loc6_.draggingCheese != null)
         {
            _loc6_.draggingCheese.x = _loc6_.clip.mouseX;
            _loc6_.draggingCheese.y = _loc6_.clip.mouseY + _loc6_.draggingCheese.height / 2;
            _loc5_ = Math.min(1,Math.max(0,(_loc6_.draggingCheese.y - _loc6_.draggingCheeseStartY) / (_loc6_.cheeseDragScaleMaxY - _loc6_.draggingCheeseStartY)));
            _loc6_.draggingCheese.scaleX = _loc6_.cheeseStackScale + _loc5_ * (_loc6_.cheeseDragScale - _loc6_.cheeseStackScale);
            _loc6_.draggingCheese.scaleY = _loc6_.draggingCheese.scaleX;
         }
         if(_loc6_.draggingTopping != null)
         {
            _loc6_.draggingTopping.updateTopping();
         }
         if(_loc6_.returningToppings != null && _loc6_.returningToppings.length > 0)
         {
            _loc1_ = int(_loc6_.returningToppings.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc6_.returningToppings[_loc1_] != null)
               {
                  _loc6_.returningToppings[_loc1_].updateTopping();
               }
               _loc1_--;
            }
         }
      }
      
      public function tweenToTarget(param1:MovieClip, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : void
      {
         var _loc6_:Number = param2 - param1.x;
         var _loc7_:Number = param3 - param1.y;
         var _loc8_:Number = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_);
         var _loc9_:Number = Math.atan2(_loc7_,_loc6_);
         if(param4 > _loc8_ && param5)
         {
            param4 = _loc8_;
         }
         var _loc10_:Number = Math.cos(_loc9_) * param4;
         var _loc11_:Number = Math.sin(_loc9_) * param4;
         param1.x += _loc10_;
         param1.y += _loc11_;
      }
   }
}


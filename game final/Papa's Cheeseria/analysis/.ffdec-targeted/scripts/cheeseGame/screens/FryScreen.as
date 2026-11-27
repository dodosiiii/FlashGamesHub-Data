package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import package_2.*;
   import package_4.*;
   
   public class FryScreen
   {
      
      public var clip:MovieClip;
      
      public var isActive:Boolean = false;
      
      public var gameObj:class_5;
      
      public var currentOrder:FoodOrder = null;
      
      public var waitingSandwiches:Vector.<Sandwich>;
      
      public var leavingOrders:Vector.<FoodOrder>;
      
      public var trashButtonTargetX:Number = 640;
      
      public var trashButtonOffscreenX:Number = 680;
      
      public var baskets:Vector.<FryerBasket>;
      
      public var isDraggingBasket:Boolean = false;
      
      public var isPouringFries:Boolean = false;
      
      public var isThrowingAwayFries:Boolean = false;
      
      public var alarmsRunning:Number = 0;
      
      public var alarmSound:SoundChannel = null;
      
      public var alarmBaseVolume:Number = 0.5;
      
      public var alarmExtraVolume:Number = 0.2;
      
      public var grillSound:SoundChannel;
      
      public var grillVolume:Number = 0;
      
      public var boostSound:SoundChannel;
      
      public var isBoosting:Boolean = false;
      
      public var boostingWhich:Number = 0;
      
      public var trashTrayOffscreenX:Number = 0;
      
      public var trashTrayOnscreenX:Number = 190;
      
      public var trashFries:MovieClip = null;
      
      public var trashFriesTargetScale:Number = 0.85;
      
      public var toppingBins:Vector.<MovieClip> = null;
      
      public var toppingTypes:Array;
      
      public var toppingBinsX:Array;
      
      public var toppingBinsY:Array;
      
      public var bottles:Vector.<ToppingShaker> = null;
      
      public var bottleTypes:Array;
      
      public var bottlesX:Array;
      
      public var bottlesY:Array;
      
      public var shakersX:Array;
      
      public var shakersY:Array;
      
      public var isSelectingBin:Boolean = false;
      
      public var clickingWhichBin:String = "none";
      
      public var isSelectingBottle:Boolean = false;
      
      public var clickingWhichBottle:String = "none";
      
      public var shouldDeselect:Boolean = false;
      
      public var shouldStartPouring:Boolean = false;
      
      public var selectedTopping:String = "none";
      
      public var toppingData:ToppingItem;
      
      public var toppingCapacity:Number = 5;
      
      public var toppingRemaining:Number = 5;
      
      public var pouringSound:SoundChannel;
      
      public var spoons:Array;
      
      public function FryScreen(param1:class_5)
      {
         this.toppingTypes = [];
         this.toppingBinsX = [3,81,3,81];
         this.toppingBinsY = [168,187,216,235];
         this.bottleTypes = [];
         this.bottlesX = [23,64,105,146,28,69,110];
         this.bottlesY = [124,124,124,124,409,409,409];
         this.shakersX = [33,88,143];
         this.shakersY = [326,326,326];
         this.spoons = [];
         super();
         var _loc2_:FryScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FryerBasket = null;
         var _loc3_:FryScreen = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         _loc3_.clip = new fryScreenMC();
         _loc3_.clip.mouseEnabled = false;
         _loc3_.clip.bg.cacheAsBitmap = true;
         _loc3_.waitingSandwiches = new Vector.<Sandwich>();
         _loc3_.leavingOrders = new Vector.<FoodOrder>();
         _loc3_.baskets = new Vector.<FryerBasket>();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = new FryerBasket(_loc3_.gameObj,_loc3_.clip["basket" + _loc1_],_loc1_,0);
            _loc3_.baskets.push(_loc2_);
            _loc1_++;
         }
         _loc3_.clip.trash_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickTrash);
         _loc3_.setupFryToppings();
         _loc3_.gameObj.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickScreen);
         _loc3_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc3_.releaseScreen);
         _loc3_.gameObj.var_129.addEventListener("soundIsMuted",_loc3_.onSoundIsMuted);
         _loc3_.gameObj.var_129.addEventListener("soundIsNotMuted",_loc3_.onSoundIsNotMuted);
      }
      
      public function onSoundIsMuted(param1:Event) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.updateAlarmSound();
      }
      
      public function onSoundIsNotMuted(param1:Event) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.updateAlarmSound();
      }
      
      public function destroy() : void
      {
         var _loc1_:* = 0;
         var _loc2_:FryScreen = this;
         _loc2_.stopSounds();
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickScreen);
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseScreen);
         _loc2_.gameObj.var_129.removeEventListener("soundIsMuted",_loc2_.onSoundIsMuted);
         _loc2_.gameObj.var_129.removeEventListener("soundIsNotMuted",_loc2_.onSoundIsNotMuted);
         _loc2_.setupFryToppings(false);
         if(_loc2_.trashFries != null)
         {
            if(_loc2_.trashFries.parent)
            {
               _loc2_.trashFries.parent.removeChild(_loc2_.trashFries);
            }
            _loc2_.trashFries = null;
         }
         _loc2_.clip.trash_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickTrash);
         _loc1_ = int(_loc2_.waitingSandwiches.length - 1);
         while(_loc1_ >= 0)
         {
            if(_loc2_.waitingSandwiches[_loc1_] != null)
            {
               _loc2_.waitingSandwiches[_loc1_].destroy();
               _loc2_.waitingSandwiches[_loc1_] = null;
            }
            _loc2_.waitingSandwiches.splice(_loc1_,1);
            _loc1_--;
         }
         _loc2_.waitingSandwiches = null;
         _loc1_ = int(_loc2_.leavingOrders.length - 1);
         while(_loc1_ >= 0)
         {
            if(_loc2_.leavingOrders[_loc1_] != null)
            {
               _loc2_.leavingOrders[_loc1_].destroy();
               _loc2_.leavingOrders[_loc1_] = null;
            }
            _loc2_.leavingOrders.splice(_loc1_,1);
            _loc1_--;
         }
         _loc2_.leavingOrders = null;
         _loc1_ = int(_loc2_.baskets.length - 1);
         while(_loc1_ >= 0)
         {
            if(_loc2_.baskets[_loc1_] != null)
            {
               _loc2_.baskets[_loc1_].destroy();
               _loc2_.baskets[_loc1_] = null;
            }
            _loc2_.baskets.splice(_loc1_,1);
            _loc1_--;
         }
         _loc2_.baskets = null;
         _loc2_.clip.boost_0.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.pressBoostButton);
         _loc2_.clip.boost_1.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.pressBoostButton);
         if(_loc2_.gameObj.var_138.contains(_loc2_.clip))
         {
            _loc2_.gameObj.var_138.removeChild(_loc2_.clip);
         }
         _loc2_.clip = null;
      }
      
      public function restoreSoundAfterAd() : void
      {
         var _loc1_:FryScreen = this;
         if(_loc1_.grillSound)
         {
            _loc1_.grillSound.stop();
         }
         _loc1_.grillSound = null;
         _loc1_.grillSound = _loc1_.gameObj.var_129.playSound("fryeroil.wav",true,0);
      }
      
      public function activateScreen() : void
      {
         var _loc1_:FryScreen = this;
         if(!_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         }
         _loc1_.gameObj.hud.hideTimerAlerts("fry");
         _loc1_.gameObj.var_129.switchMusic("other");
         _loc1_.isActive = true;
         _loc1_.checkForFoodOrder();
         if(_loc1_.gameObj.var_128.currentDay == 1 && !_loc1_.gameObj.training && _loc1_.gameObj.var_147.hangerTicket != null && _loc1_.isFryerFree(0) && _loc1_.gameObj.var_134.totalCustomers == 2 && _loc1_.gameObj.var_134.orderline.length == 0 && _loc1_.gameObj.var_134.waitline.length == 1 && _loc1_.getTotalFryersCooking() == 0)
         {
            if(!_loc1_.gameObj.var_128.hasTrained("curlyfries"))
            {
               _loc1_.gameObj.hud.showContextTraining("curlyfries");
            }
         }
      }
      
      public function deactivateScreen() : void
      {
         var _loc1_:FryScreen = this;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.isActive = false;
      }
      
      public function updateScreen() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FryScreen = this;
         if(_loc2_.currentOrder)
         {
            _loc2_.currentOrder.updateOrder();
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.baskets.length)
         {
            _loc2_.baskets[_loc1_].updateBasket();
            _loc1_++;
         }
         if(_loc2_.currentOrder != null)
         {
            _loc2_.clip.trash_btn.x += (_loc2_.trashButtonTargetX - _loc2_.clip.trash_btn.x) / 2;
         }
         else
         {
            _loc2_.clip.trash_btn.x += (_loc2_.trashButtonOffscreenX - _loc2_.clip.trash_btn.x) / 2;
         }
         if(_loc2_.isDraggingBasket || _loc2_.isThrowingAwayFries)
         {
            _loc2_.clip.trashtray.x += (_loc2_.trashTrayOnscreenX - _loc2_.clip.trashtray.x) / 2;
         }
         else if(_loc2_.trashFries == null || _loc2_.trashFries != null && Math.round(_loc2_.trashFries.scaleX * 100) == Math.round(_loc2_.trashFriesTargetScale * 100))
         {
            _loc2_.clip.trashtray.x += (_loc2_.trashTrayOffscreenX - _loc2_.clip.trashtray.x) / 3;
            if(Math.abs(_loc2_.trashTrayOffscreenX - _loc2_.clip.trashtray.x) <= 1)
            {
               _loc2_.clip.trashtray.x = _loc2_.trashTrayOffscreenX;
               if(_loc2_.trashFries != null)
               {
                  if(_loc2_.trashFries.parent)
                  {
                     _loc2_.trashFries.parent.removeChild(_loc2_.trashFries);
                  }
                  _loc2_.trashFries = null;
               }
            }
         }
         if(_loc2_.trashFries != null)
         {
            if(_loc2_.trashFries.scaleX != _loc2_.trashFriesTargetScale)
            {
               _loc2_.trashFries.scaleX += (_loc2_.trashFriesTargetScale - _loc2_.trashFries.scaleX) / 4;
               _loc2_.trashFries.scaleY = _loc2_.trashFries.scaleX;
               if(Math.abs(_loc2_.trashFriesTargetScale - _loc2_.trashFries.scaleX) <= 0.02)
               {
                  _loc2_.trashFries.scaleX = _loc2_.trashFriesTargetScale;
                  _loc2_.trashFries.scaleY = _loc2_.trashFriesTargetScale;
                  _loc2_.trashFries.cacheAsBitmap = true;
               }
            }
         }
         _loc2_.updateGrillSound();
         if(_loc2_.shouldDeselect)
         {
            _loc2_.deselectToppings();
            _loc2_.shouldDeselect = false;
         }
      }
      
      public function throwAwayFries(param1:String, param2:Number) : void
      {
         var _loc3_:FryScreen = this;
         if(_loc3_.trashFries != null)
         {
            if(_loc3_.trashFries.parent)
            {
               _loc3_.trashFries.parent.removeChild(_loc3_.trashFries);
            }
            _loc3_.trashFries = null;
         }
         _loc3_.trashFries = class_12.method_103(param1 + "_clump",false,false);
         _loc3_.trashFries.gotoAndStop(param2);
         _loc3_.trashFries.scaleX = 0.5;
         _loc3_.trashFries.scaleY = 0.5;
         _loc3_.trashFries.x = 85;
         _loc3_.trashFries.y = 53;
         _loc3_.clip.trashtray.addChild(_loc3_.trashFries);
      }
      
      public function initStationUpgrades() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FryScreen = this;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.baskets.length)
         {
            _loc2_.baskets[_loc1_].initUpgrades();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.baskets.length)
         {
            if(_loc2_.gameObj.var_128.hasBonus("fryboost" + _loc1_))
            {
               _loc2_.clip["boost_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.pressBoostButton);
               _loc2_.clip["boost_" + _loc1_].visible = true;
            }
            else
            {
               _loc2_.clip["boost_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public function cheatChangeMonth(param1:Number) : void
      {
      }
      
      public function restoreAfterServing() : void
      {
         var _loc1_:FryScreen = this;
         _loc1_.removeCurrentOrder(true);
         _loc1_.checkForFoodOrder();
      }
      
      public function isSandwichWaiting() : Boolean
      {
         var _loc1_:FryScreen = this;
         if(_loc1_.waitingSandwiches.length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function addToWaitingSandwiches(param1:Sandwich) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.waitingSandwiches.push(param1);
      }
      
      public function removeFromWaitingSandwiches(param1:Sandwich, param2:Boolean = false) : void
      {
         var _loc3_:FryScreen = this;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.waitingSandwiches.length)
         {
            if(_loc3_.waitingSandwiches[_loc4_] == param1)
            {
               if(param2)
               {
                  _loc3_.waitingSandwiches[_loc4_].destroy();
               }
               _loc3_.waitingSandwiches[_loc4_] = null;
               _loc3_.waitingSandwiches.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function removeCurrentOrder(param1:Boolean = false) : void
      {
         var _loc2_:FryScreen = this;
         if(_loc2_.currentOrder != null)
         {
            if(param1)
            {
               _loc2_.currentOrder.destroy();
            }
            _loc2_.currentOrder = null;
         }
         _loc2_.checkForFoodOrder();
      }
      
      public function checkForFoodOrder() : void
      {
         var _loc1_:Sandwich = null;
         var _loc2_:FryScreen = this;
         if(_loc2_.currentOrder == null)
         {
            if(Boolean(_loc2_.waitingSandwiches) && _loc2_.waitingSandwiches.length > 0)
            {
               _loc1_ = _loc2_.waitingSandwiches.shift();
               _loc2_.currentOrder = new FoodOrder(_loc2_.gameObj,_loc1_);
            }
            _loc2_.clip.trash_btn.visible = true;
         }
      }
      
      public function clickTrash(param1:MouseEvent) : void
      {
         var _loc2_:FryScreen = this;
         if(!_loc2_.gameObj.training)
         {
            if(_loc2_.currentOrder)
            {
               class_7.method_1("Click trash, trash order!");
               _loc2_.currentOrder.moveToFryTrash();
               _loc2_.addToLeavingOrders(_loc2_.currentOrder);
               _loc2_.removeCurrentOrder(false);
               _loc2_.clip.trash_btn.x = _loc2_.trashButtonOffscreenX;
            }
         }
         else
         {
            _loc2_.gameObj.hud.showTrainingWarning("garbage");
         }
      }
      
      public function addToLeavingOrders(param1:FoodOrder) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.leavingOrders.push(param1);
      }
      
      public function removeFromLeavingOrders(param1:FoodOrder, param2:Boolean = false) : void
      {
         var _loc3_:FryScreen = this;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.leavingOrders.length)
         {
            if(_loc3_.leavingOrders[_loc4_] == param1)
            {
               if(param2)
               {
                  _loc3_.leavingOrders[_loc4_].destroy();
               }
               _loc3_.leavingOrders.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function soundAlarm(param1:Number, param2:Number) : void
      {
         var _loc3_:FryScreen = this;
         if(_loc3_.gameObj.var_128.hasBonus("fryalarm" + param1))
         {
            _loc3_.gameObj.hud.showTimerAlert("fry");
            ++_loc3_.alarmsRunning;
            _loc3_.updateAlarmSound();
         }
      }
      
      public function stopAlarm(param1:Number, param2:Number) : void
      {
         var _loc3_:FryScreen = this;
         if(_loc3_.gameObj.var_128.hasBonus("fryalarm" + param1))
         {
            --_loc3_.alarmsRunning;
            _loc3_.updateAlarmSound();
         }
      }
      
      public function updateAlarmSound() : void
      {
         var _loc1_:FryScreen = this;
         if(_loc1_.alarmSound != null)
         {
            _loc1_.alarmSound.stop();
            _loc1_.alarmSound = null;
         }
         var _loc2_:Number = _loc1_.alarmBaseVolume + (_loc1_.alarmsRunning - 1) * _loc1_.alarmExtraVolume;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         if(_loc1_.gameObj.var_169)
         {
            _loc2_ = 0;
         }
         else if(_loc1_.gameObj.var_129.isMute)
         {
            _loc2_ = 0;
         }
         if(_loc1_.alarmsRunning > 0)
         {
            _loc1_.alarmSound = _loc1_.gameObj.var_129.playSound("timeralarm.wav",true,_loc2_);
         }
      }
      
      public function pressBoostButton(param1:MouseEvent) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseBoostButton);
         _loc2_.isBoosting = true;
         _loc2_.boostingWhich = Number(String(param1.currentTarget.name).split("_")[1]);
         _loc2_.gameObj.var_129.playSound("press_machine_button.wav");
         if(_loc2_.boostSound)
         {
            _loc2_.boostSound.stop();
            _loc2_.boostSound = null;
         }
         _loc2_.boostSound = _loc2_.gameObj.var_129.playSound("fryer_bubbling.wav",true);
         if(_loc2_.gameObj.hud.whichContextTraining == "boost")
         {
            _loc2_.gameObj.var_128.setTrained("boost");
            _loc2_.gameObj.hud.removeContextTraining();
         }
      }
      
      public function releaseBoostButton(param1:MouseEvent) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseBoostButton);
         _loc2_.isBoosting = false;
         _loc2_.boostingWhich = 0;
         _loc2_.gameObj.var_129.playSound("release_button.wav");
         if(_loc2_.boostSound)
         {
            _loc2_.boostSound.stop();
            _loc2_.boostSound = null;
         }
      }
      
      public function updateGrillSound() : void
      {
         var _loc1_:SoundTransform = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:FryScreen = this;
         try
         {
            _loc1_ = new SoundTransform();
            _loc2_ = _loc5_.grillSound.soundTransform.volume;
            _loc3_ = Math.min(2,_loc5_.getTotalFryersCooking()) / 2;
            _loc4_ = _loc5_.grillVolume;
            if(_loc3_ > _loc4_)
            {
               _loc4_ += 0.01;
            }
            else if(_loc3_ < _loc4_)
            {
               _loc4_ -= 0.01;
            }
            if(!_loc5_.isActive && _loc3_ > 0)
            {
               _loc4_ = 0.15;
            }
            else if(!_loc5_.isActive && _loc3_ == 0)
            {
               _loc4_ = 0;
            }
            else
            {
               _loc5_.grillVolume = _loc4_;
            }
            if(_loc5_.gameObj.var_129.isMute)
            {
               _loc4_ = 0;
            }
            _loc1_.volume = _loc4_;
            _loc5_.grillSound.soundTransform = _loc1_;
         }
         catch(err:Error)
         {
         }
      }
      
      public function quietSoundWhenPaused() : void
      {
         var _loc1_:SoundTransform = null;
         var _loc2_:FryScreen = this;
         if(_loc2_.grillSound)
         {
            _loc1_ = new SoundTransform();
            _loc1_.volume = 0;
            _loc2_.grillSound.soundTransform = _loc1_;
         }
         _loc2_.updateAlarmSound();
      }
      
      public function resumeSoundAfterPaused() : void
      {
         var _loc1_:FryScreen = this;
         _loc1_.updateAlarmSound();
      }
      
      public function getTotalFryersCooking() : Number
      {
         var _loc1_:FryScreen = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.baskets.length)
         {
            if(_loc1_.baskets[_loc3_].isCooking && !_loc1_.baskets[_loc3_].isRollingOver)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function isFryerFree(param1:Number) : Boolean
      {
         var _loc2_:FryScreen = this;
         var _loc3_:Boolean = true;
         if(param1 < 0 || param1 > 1)
         {
            _loc3_ = false;
         }
         else if(_loc2_.baskets[param1].isFree() == false)
         {
            _loc3_ = false;
         }
         if(_loc2_.gameObj.training)
         {
            if(param1 == 0)
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      public function setupFryToppings(param1:Boolean = true) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:MovieClip = null;
         var _loc7_:ToppingShaker = null;
         var _loc8_:ToppingShaker = null;
         var _loc9_:FryScreen = this;
         var _loc10_:UserData = _loc9_.gameObj.var_128;
         if(param1)
         {
            _loc3_ = FoodData.getFryToppings();
            _loc9_.toppingBins = new Vector.<MovieClip>();
            _loc2_ = int(_loc3_.length - 1);
            while(_loc2_ >= 0)
            {
               if(_loc10_.hasTopping(_loc3_[_loc2_]) == false)
               {
                  _loc3_.splice(_loc2_,1);
               }
               _loc2_--;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc6_ = class_12.method_103("topping_" + _loc3_[_loc2_] + "_frybin",true,false);
               _loc6_.gotoAndStop("unlocked");
               _loc6_.mouseEnabled = true;
               _loc6_.buttonMode = true;
               _loc6_.useHandCursor = true;
               _loc6_.tabEnabled = false;
               _loc6_.name = "topping_" + _loc3_[_loc2_] + "_bin";
               _loc6_.x = _loc9_.toppingBinsX[_loc2_];
               _loc6_.y = _loc9_.toppingBinsY[_loc2_];
               _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,_loc9_.clickBin);
               _loc6_.addEventListener(MouseEvent.ROLL_OVER,_loc9_.rolloverBin);
               _loc6_.addEventListener(MouseEvent.ROLL_OUT,_loc9_.rolloutBin);
               _loc9_.toppingBins.push(_loc6_);
               _loc9_.toppingTypes.push(_loc3_[_loc2_]);
               _loc9_.clip.holder.addChild(_loc6_);
               _loc6_.cacheAsBitmap = true;
               _loc2_++;
            }
            _loc4_ = FoodData.getFrySauces();
            _loc9_.bottles = new Vector.<ToppingShaker>();
            _loc2_ = int(_loc4_.length - 1);
            while(_loc2_ >= 0)
            {
               if(_loc10_.hasTopping(_loc4_[_loc2_]) == false)
               {
                  _loc4_.splice(_loc2_,1);
               }
               _loc2_--;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               _loc7_ = new ToppingShaker(_loc9_.gameObj,_loc4_[_loc2_],_loc9_.clip.holder,_loc9_.clip.topholder,this.bottlesX[_loc2_],this.bottlesY[_loc2_]);
               _loc9_.bottles.push(_loc7_);
               _loc9_.bottleTypes.push(_loc4_[_loc2_]);
               _loc2_++;
            }
            _loc5_ = FoodData.getFryShakers();
            _loc2_ = int(_loc5_.length - 1);
            while(_loc2_ >= 0)
            {
               if(_loc10_.hasTopping(_loc5_[_loc2_]) == false)
               {
                  _loc5_.splice(_loc2_,1);
               }
               _loc2_--;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               _loc8_ = new ToppingShaker(_loc9_.gameObj,_loc5_[_loc2_],_loc9_.clip.holder,_loc9_.clip.topholder,this.shakersX[_loc2_],this.shakersY[_loc2_]);
               _loc9_.bottles.push(_loc8_);
               _loc9_.bottleTypes.push(_loc5_[_loc2_]);
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = int(_loc9_.toppingBins.length - 1);
            while(_loc2_ >= 0)
            {
               _loc9_.toppingBins[_loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc9_.clickBin);
               _loc9_.toppingBins[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,_loc9_.rolloverBin);
               _loc9_.toppingBins[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,_loc9_.rolloutBin);
               if(_loc9_.toppingBins[_loc2_].parent)
               {
                  _loc9_.toppingBins[_loc2_].parent.removeChild(_loc9_.toppingBins[_loc2_]);
               }
               _loc9_.toppingBins[_loc2_] = null;
               _loc9_.toppingBins.splice(_loc2_,1);
               _loc2_--;
            }
            _loc9_.toppingBins = null;
            _loc2_ = int(_loc9_.bottles.length - 1);
            while(_loc2_ >= 0)
            {
               _loc9_.bottles[_loc2_].destroy();
               _loc9_.bottles[_loc2_] = null;
               _loc9_.bottles.splice(_loc2_,1);
               _loc2_--;
            }
            _loc9_.bottles = null;
         }
      }
      
      public function getBinCoords(param1:String) : Point
      {
         var _loc2_:FryScreen = this;
         var _loc3_:Point = new Point(0,0);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.toppingBins.length)
         {
            if(_loc2_.toppingTypes[_loc4_] == param1)
            {
               _loc3_.x = _loc2_.toppingBins[_loc4_].x;
               _loc3_.y = _loc2_.toppingBins[_loc4_].y;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getBin(param1:String) : MovieClip
      {
         var _loc2_:FryScreen = this;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.toppingBins.length)
         {
            if(_loc2_.toppingTypes[_loc4_] == param1)
            {
               _loc3_ = _loc2_.toppingBins[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function clickBin(param1:MouseEvent) : void
      {
         var _loc2_:FryScreen = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_")[1];
         var _loc4_:MovieClip = _loc2_.getBin(_loc3_);
         if(_loc2_.currentOrder != null && _loc2_.currentOrder.fries != null && !_loc2_.currentOrder.isPouring())
         {
            _loc2_.handlePreviousTopping(_loc3_);
            if(_loc2_.selectedTopping != _loc3_)
            {
               _loc4_.gotoAndStop("clicked");
               _loc2_.setNewTopping(_loc3_);
               if(_loc2_.getSpoon(_loc3_) != null)
               {
                  _loc2_.restoreSpoonInBin(_loc3_,false);
               }
               _loc2_.addSpoon(_loc3_,_loc4_.x,_loc4_.y);
               _loc2_.gameObj.var_129.playSound("grabtopping.wav");
            }
            _loc2_.isSelectingBin = true;
         }
      }
      
      public function rolloverBin(param1:MouseEvent) : void
      {
         var _loc2_:FryScreen = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_")[1];
         if(_loc2_.selectedTopping == "none")
         {
            param1.currentTarget.gotoAndPlay("rollover");
         }
      }
      
      public function rolloutBin(param1:MouseEvent) : void
      {
         var _loc2_:FryScreen = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_")[1];
         if(_loc2_.selectedTopping == "none")
         {
            param1.currentTarget.gotoAndPlay("rollout");
         }
      }
      
      public function clickScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:FryScreen = this;
         if(_loc2_.isActive && !_loc2_.gameObj.var_169)
         {
            if(!_loc2_.isSelectingBin)
            {
               if(!_loc2_.isSelectingBottle)
               {
                  if(_loc2_.currentOrder != null)
                  {
                     if(_loc2_.selectedTopping != "none")
                     {
                        _loc2_.currentOrder.stopPouring();
                        if(_loc2_.toppingData.isSauce)
                        {
                           _loc2_.isSelectingBottle = true;
                        }
                        else
                        {
                           _loc2_.isSelectingBin = true;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function releaseScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:FryScreen = this;
         if(_loc2_.isActive && !_loc2_.gameObj.var_169)
         {
            if(_loc2_.isSelectingBin)
            {
               _loc2_.releaseBin();
            }
            else if(_loc2_.isSelectingBottle)
            {
               _loc2_.releaseBottle();
            }
         }
      }
      
      public function getSauceBottle(param1:String) : ToppingShaker
      {
         var _loc2_:FryScreen = this;
         var _loc3_:ToppingShaker = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.bottles.length)
         {
            if(_loc2_.bottles[_loc4_].type == param1)
            {
               _loc3_ = _loc2_.bottles[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function releaseBottle(param1:MouseEvent = null) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.isSelectingBottle = false;
         var _loc3_:ToppingShaker = _loc2_.getSauceBottle(_loc2_.selectedTopping);
         if(_loc3_ != null)
         {
            if(_loc2_.clip.mouseX < 175 || _loc2_.clip.mouseX > 345 || _loc2_.currentOrder == null || _loc2_.currentOrder.fries == null)
            {
               _loc2_.shouldDeselect = true;
            }
            else
            {
               _loc2_.shouldStartPouring = true;
            }
         }
      }
      
      public function releaseBin(param1:MouseEvent = null) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.isSelectingBin = false;
         if(_loc2_.clip.mouseX < 175 || _loc2_.clip.mouseX > 345 || _loc2_.currentOrder == null || _loc2_.currentOrder.fries == null)
         {
            _loc2_.shouldDeselect = true;
         }
         else
         {
            _loc2_.shouldStartPouring = true;
         }
      }
      
      public function getSpoon(param1:String) : ToppingSpoon
      {
         var _loc2_:FryScreen = this;
         var _loc3_:ToppingSpoon = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.spoons.length)
         {
            if(ToppingSpoon(_loc2_.spoons[_loc4_]).whichTopping == param1)
            {
               _loc3_ = _loc2_.spoons[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function addSpoon(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:FryScreen = this;
         var _loc5_:ToppingSpoon = new ToppingSpoon(_loc4_.gameObj,param1,_loc4_.clip.topholder,param2,param3);
         _loc4_.spoons.push(_loc5_);
      }
      
      public function deleteSpoon(param1:String) : void
      {
         var _loc2_:FryScreen = this;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.spoons.length)
         {
            if(ToppingSpoon(_loc2_.spoons[_loc3_]).whichTopping == param1)
            {
               _loc2_.spoons.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function setNewTopping(param1:String) : void
      {
         var _loc2_:FryScreen = this;
         _loc2_.selectedTopping = param1;
         _loc2_.toppingData = _loc2_.gameObj.toppingData.getToppingItemData(param1,false);
         _loc2_.toppingCapacity = _loc2_.toppingData.capacity;
         _loc2_.toppingRemaining = _loc2_.toppingCapacity;
         _loc2_.shouldDeselect = false;
      }
      
      public function handlePreviousTopping(param1:String) : void
      {
         var _loc2_:ToppingSpoon = null;
         var _loc3_:ToppingShaker = null;
         var _loc4_:FryScreen = this;
         if(_loc4_.selectedTopping != "none")
         {
            _loc2_ = _loc4_.getSpoon(_loc4_.selectedTopping);
            if(_loc2_ != null)
            {
               _loc2_.returnSpoon();
            }
            _loc3_ = _loc4_.getSauceBottle(_loc4_.selectedTopping);
            if(_loc3_ != null)
            {
               _loc3_.putAwayBottle();
            }
         }
      }
      
      public function deselectToppings(param1:String = "all") : void
      {
         var _loc2_:FryScreen = this;
         if(param1 == "all" || _loc2_.selectedTopping == param1)
         {
            _loc2_.handlePreviousTopping("none");
            _loc2_.selectedTopping = "none";
         }
         _loc2_.shouldStartPouring = false;
         if(_loc2_.currentOrder)
         {
            if(_loc2_.currentOrder.isPouring())
            {
               _loc2_.currentOrder.stopPouring();
            }
         }
      }
      
      public function playPouringSound(param1:String) : void
      {
         var whichSound:String = param1;
         var screen:FryScreen = this;
         screen.stopPouringSound();
         try
         {
            screen.pouringSound = screen.gameObj.var_129.playSound(whichSound,true);
         }
         catch(err:Error)
         {
            class_7.method_1("Error playing Pouring Sound");
         }
      }
      
      public function stopPouringSound() : void
      {
         var screen:FryScreen = this;
         try
         {
            if(screen.pouringSound)
            {
               screen.pouringSound.stop();
            }
         }
         catch(err:Error)
         {
            class_7.method_1("Error stopping pouring sound...");
         }
         screen.pouringSound = null;
      }
      
      public function stopSounds() : void
      {
         var _loc1_:FryScreen = this;
         if(_loc1_.grillSound)
         {
            _loc1_.grillSound.stop();
            _loc1_.grillSound = null;
         }
         if(_loc1_.alarmSound)
         {
            _loc1_.alarmSound.stop();
            _loc1_.alarmSound = null;
         }
         if(_loc1_.boostSound)
         {
            _loc1_.boostSound.stop();
            _loc1_.boostSound = null;
         }
         if(_loc1_.pouringSound)
         {
            _loc1_.pouringSound.stop();
            _loc1_.pouringSound = null;
         }
      }
      
      public function isPlayingPouringSound() : Boolean
      {
         var _loc1_:FryScreen = this;
         var _loc2_:Boolean = false;
         if(_loc1_.pouringSound)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function restoreSpoonInBin(param1:String, param2:Boolean = true) : void
      {
         var _loc5_:ToppingSpoon = null;
         var _loc3_:MovieClip = null;
         var _loc4_:FryScreen = this;
         if(param2)
         {
            _loc3_ = _loc4_.getBin(param1);
            if(_loc3_ != null)
            {
               _loc3_.gotoAndPlay("rollout");
            }
         }
         _loc5_ = _loc4_.getSpoon(param1);
         if(_loc5_ != null)
         {
            _loc5_.destroy();
            _loc4_.deleteSpoon(param1);
         }
         _loc5_ = null;
      }
   }
}


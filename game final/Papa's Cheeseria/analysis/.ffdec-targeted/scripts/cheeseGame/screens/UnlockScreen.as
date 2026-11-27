package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.managers.CustomerManager;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class UnlockScreen
   {
      
      public var gameObj:class_5;
      
      public var lineupTypes:Array;
      
      public var lineupDetails:Array;
      
      public var clip:MovieClip;
      
      public var subclip:MovieClip = null;
      
      public var currentLineupIndex:Number = -1;
      
      public var moneyFrame:Number = 40;
      
      public var worker:Worker;
      
      public var customerClip:MovieClip = null;
      
      public var toppingClip:MovieClip = null;
      
      public var shouldShowNewHire:Boolean = false;
      
      public function UnlockScreen(param1:class_5, param2:Boolean = false)
      {
         this.lineupTypes = [];
         this.lineupDetails = [];
         super();
         var _loc3_:UnlockScreen = this;
         _loc3_.gameObj = param1;
         _loc3_.decideLineup(param2);
         _loc3_.setupScreen();
      }
      
      public function decideLineup(param1:Boolean = false) : void
      {
         var _loc5_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:UnlockScreen = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         if(_loc4_.didCreateWaiter == false && _loc4_.currentDay >= GameData.DAY_TO_HIRE)
         {
            _loc3_.shouldShowNewHire = true;
            return;
         }
         if(_loc3_.gameObj.var_128.currentDay == GameData.DAY_TO_HIRE || param1)
         {
            _loc3_.lineupTypes.push("hire");
            _loc3_.lineupDetails.push(_loc3_.gameObj.var_128.waiterName);
         }
         if(_loc4_.isPayday())
         {
            _loc3_.lineupTypes.push("payday");
            _loc3_.lineupDetails.push("");
         }
         if(_loc4_.getMonth() != _loc4_.lastMonthSeen)
         {
            if(_loc4_.getMonth() == 3)
            {
               _loc3_.lineupTypes.push("season");
               _loc3_.lineupDetails.push("spring");
            }
            else if(_loc4_.getMonth() == 6)
            {
               _loc3_.lineupTypes.push("season");
               _loc3_.lineupDetails.push("summer");
            }
            else if(_loc4_.getMonth() == 9)
            {
               _loc3_.lineupTypes.push("season");
               _loc3_.lineupDetails.push("fall");
            }
            else if(_loc4_.getMonth() == 12)
            {
               _loc3_.lineupTypes.push("season");
               _loc3_.lineupDetails.push("winter");
            }
            if(_loc4_.getMonth() != GameData.STARTER_MONTH || _loc4_.isNewYear())
            {
               _loc3_.lineupTypes.push("holiday");
               _loc3_.lineupDetails.push(_loc4_.getMonth());
            }
            _loc4_.lastMonthSeen = _loc4_.getMonth();
         }
         if(_loc3_.gameObj.var_134.showNewCustomer)
         {
            _loc3_.lineupTypes.push("customer");
            _loc3_.lineupDetails.push(_loc3_.gameObj.var_134.showNewCustomerNum);
         }
         _loc5_ = _loc4_.getAllToppingsToReveal();
         if(_loc5_.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               _loc3_.lineupTypes.push("topping");
               _loc3_.lineupDetails.push(_loc5_[_loc2_]);
               _loc2_++;
            }
         }
         if(_loc3_.lineupTypes.length > 0)
         {
            _loc3_.lineupTypes.unshift("fadein");
            _loc3_.lineupDetails.unshift("");
            _loc3_.lineupTypes.push("fadeout");
            _loc3_.lineupDetails.push("");
         }
         class_7.method_1("Unlocks: " + _loc3_.lineupTypes.toString());
      }
      
      public function setupScreen() : void
      {
         var _loc1_:UnlockScreen = this;
         if(_loc1_.lineupTypes.length > 0)
         {
            _loc1_.gameObj.var_129.switchMusic("none");
            _loc1_.clip = new MovieClip();
            _loc1_.setupNewUnlock();
         }
         else
         {
            _loc1_.clip = new MovieClip();
            _loc1_.clip.graphics.beginFill(0,1);
            _loc1_.clip.graphics.drawRect(-400,-400,1440,1280);
            _loc1_.clip.graphics.endFill();
         }
         _loc1_.gameObj.var_155.addChild(_loc1_.clip);
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
      }
      
      public function updateScreen(param1:Event = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:UnlockScreen = this;
         if(_loc3_.lineupTypes.length == 0)
         {
            if(_loc3_.shouldShowNewHire)
            {
               class_7.method_1("Show the NEW HIRE screen before doing anything!");
               _loc3_.showNewHireScreen();
            }
            else
            {
               class_7.method_1("No unlocks.");
               _loc3_.finishUnlocks();
            }
         }
         else
         {
            _loc2_ = _loc3_.lineupTypes[_loc3_.currentLineupIndex];
            if(_loc2_ == "payday")
            {
               if(_loc3_.worker)
               {
                  _loc3_.worker.animateModel();
               }
               if(_loc3_.subclip.currentFrame == _loc3_.moneyFrame)
               {
                  _loc3_.gameObj.var_129.playSound("multicoin.wav");
                  _loc3_.subclip.starburst.gotoAndPlay(2);
               }
            }
            else if(_loc2_ == "hire")
            {
               if(_loc3_.worker)
               {
                  _loc3_.worker.animateModel();
               }
            }
            if(Boolean(_loc3_.subclip) && _loc3_.subclip.currentFrame == _loc3_.subclip.totalFrames)
            {
               if(_loc3_.currentLineupIndex + 1 < _loc3_.lineupTypes.length)
               {
                  class_7.method_1(_loc3_.currentLineupIndex + 1 + " < " + _loc3_.lineupTypes.length + " -- Do the next unlock.");
                  _loc3_.destroyCurrentUnlock();
                  _loc3_.setupNewUnlock();
               }
               else
               {
                  class_7.method_1("Finished with the unlock lineup.");
                  _loc3_.finishUnlocks();
               }
            }
         }
      }
      
      public function setupNewUnlock() : void
      {
         var _loc1_:UnlockScreen = this;
         ++_loc1_.currentLineupIndex;
         var _loc2_:String = _loc1_.lineupTypes[_loc1_.currentLineupIndex];
         var _loc3_:* = _loc1_.lineupDetails[_loc1_.currentLineupIndex];
         if(_loc2_ == "fadein")
         {
            _loc1_.subclip = new unlockfadein_screen();
         }
         else if(_loc2_ == "fadeout")
         {
            _loc1_.subclip = new unlockfadeout_screen();
         }
         else if(_loc2_ == "payday")
         {
            _loc1_.subclip = new payday_screen();
            _loc1_.setupPayDay();
         }
         else if(_loc2_ == "hire")
         {
            _loc1_.subclip = new newhire_screen();
            _loc1_.setupNewHire();
         }
         else if(_loc2_ == "topping")
         {
            _loc1_.subclip = new newtopping_screen();
            _loc1_.setupTopping();
         }
         else if(_loc2_ == "customer")
         {
            _loc1_.subclip = new newcustomer_screen();
            _loc1_.setupCustomer();
         }
         else if(_loc2_ == "holiday")
         {
            _loc1_.subclip = new newholiday_screen();
            _loc1_.subclip.labelMC.gotoAndStop(_loc3_);
            _loc1_.gameObj.var_129.playMusicClip("music_newcustomer");
            _loc1_.gameObj.var_142.recordUnlockHoliday(Number(_loc3_));
         }
         else if(_loc2_ == "season")
         {
            _loc1_.subclip = new newseason_screen();
            _loc1_.subclip.labelMC.gotoAndStop(_loc3_);
            _loc1_.gameObj.var_129.playMusicClip("music_newseason");
            _loc1_.gameObj.var_142.recordUnlockSeason(String(_loc3_));
         }
         _loc1_.clip.addChildAt(_loc1_.subclip,0);
      }
      
      public function destroyCurrentUnlock() : void
      {
         var _loc1_:UnlockScreen = this;
         var _loc2_:String = _loc1_.lineupTypes[_loc1_.currentLineupIndex];
         if(_loc2_ == "payday" || _loc2_ == "hire")
         {
            if(_loc1_.worker)
            {
               _loc1_.worker.destroy();
               _loc1_.worker = null;
            }
         }
         else if(_loc2_ == "customer")
         {
            _loc1_.destroyCustomer();
         }
         else if(_loc2_ == "topping")
         {
            if(_loc1_.toppingClip)
            {
               _loc1_.toppingClip.parent.removeChild(_loc1_.toppingClip);
               _loc1_.toppingClip = null;
            }
         }
         _loc1_.clip.removeChild(_loc1_.subclip);
         _loc1_.subclip = null;
      }
      
      public function finishUnlocks() : void
      {
         var _loc1_:UnlockScreen = this;
         _loc1_.gameObj.method_153();
         _loc1_.gameObj.method_183();
      }
      
      public function showNewHireScreen() : void
      {
         var _loc1_:UnlockScreen = this;
         _loc1_.gameObj.showNewHireScreen();
         _loc1_.gameObj.method_183();
      }
      
      public function setupPayDay() : void
      {
         var _loc1_:UnlockScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.gameObj.var_129.playMusicClip("endofday.wav");
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.subclip.circleMC,_loc1_.gameObj.workerData,130,80,1,false,false);
         _loc1_.worker.playAnimation("payday");
         var _loc3_:String = _loc2_.getWeeklyWage(true);
         _loc1_.subclip.starburst.burst.money.text = _loc3_;
         _loc2_.totalTips += _loc2_.getWeeklyWage();
         _loc1_.gameObj.var_142.recordPayDay();
      }
      
      public function setupNewHire() : void
      {
         var _loc1_:UnlockScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.gameObj.var_129.playMusicClip("customer_overjoyed.wav");
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.subclip.circleMC,_loc1_.gameObj.var_151,138,75,0.85,false,false);
         _loc1_.worker.playAnimation("levelup");
         _loc1_.subclip.circleMC.customername.text = _loc1_.lineupDetails[_loc1_.currentLineupIndex];
      }
      
      public function setupTopping() : void
      {
         var _loc1_:UnlockScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:String = _loc1_.lineupDetails[_loc1_.currentLineupIndex];
         var _loc4_:Number = _loc2_.toppingIndexes.indexOf(_loc3_);
         _loc1_.gameObj.var_142.recordUnlockTopping();
         _loc1_.subclip.circleMC.customername.text = _loc2_.toppingNames[_loc4_];
         _loc1_.toppingClip = new newtopping_topping();
         _loc1_.toppingClip.gotoAndStop(_loc3_);
         _loc1_.subclip.circleMC.topping.inside.addChild(_loc1_.toppingClip);
         _loc1_.toppingClip.cacheAsBitmap = true;
         _loc2_.rememberRevealedTopping(_loc3_);
         _loc1_.gameObj.var_129.playMusicClip("music_newtopping");
      }
      
      public function setupCustomer() : void
      {
         var _loc1_:UnlockScreen = this;
         var _loc2_:CustomerData = _loc1_.gameObj.var_130;
         var _loc3_:CustomerManager = _loc1_.gameObj.var_134;
         _loc1_.buildCustomer(_loc3_.showNewCustomerNum);
         _loc1_.subclip.circleMC.customername.text = _loc2_.getCustomerName(_loc3_.showNewCustomerNum);
         _loc1_.gameObj.var_129.playMusicClip("music_newholiday");
         _loc1_.gameObj.var_142.recordUnlockCustomer(_loc2_.getCustomerName(_loc3_.showNewCustomerNum));
      }
      
      public function destroy() : void
      {
         var _loc1_:UnlockScreen = this;
         if(_loc1_.worker)
         {
            _loc1_.worker.destroy();
            _loc1_.worker = null;
         }
         try
         {
            _loc1_.destroyCurrentUnlock();
         }
         catch(err:Error)
         {
         }
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.gameObj.var_155.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function buildCustomer(param1:Number) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Class = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Class = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:Class = null;
         var _loc16_:MovieClip = null;
         var _loc17_:MovieClip = null;
         var _loc18_:MovieClip = null;
         var _loc19_:MovieClip = null;
         var _loc20_:MovieClip = null;
         var _loc21_:Class = null;
         var _loc22_:MovieClip = null;
         var _loc23_:MovieClip = null;
         var _loc24_:Class = null;
         var _loc25_:MovieClip = null;
         var _loc26_:Number = NaN;
         var _loc2_:Class = null;
         var _loc3_:Class = null;
         var _loc4_:UnlockScreen = this;
         _loc4_.customerClip = new customerMC();
         var _loc5_:String = _loc4_.gameObj.var_130.getCustomerClipName(param1);
         _loc7_ = getDefinitionByName("customer_" + _loc5_ + "_body") as Class;
         _loc6_ = new _loc7_();
         _loc6_.name = "clip";
         _loc4_.customerClip.body.addChild(_loc6_);
         _loc9_ = getDefinitionByName("customer_" + _loc5_ + "_head") as Class;
         _loc8_ = new _loc9_();
         _loc8_.name = "clip";
         _loc4_.customerClip.head.addChild(_loc8_);
         _loc10_ = _loc4_.gameObj.var_130.getCustomerPart(_loc5_,"eyes",_loc4_.gameObj.var_128.getHolidayMonth());
         _loc10_.name = "clip";
         _loc4_.customerClip.eyes.addChild(_loc10_);
         _loc11_ = _loc4_.gameObj.var_130.getCustomerPart(_loc5_,"mouth",_loc4_.gameObj.var_128.getHolidayMonth());
         _loc11_.name = "clip";
         _loc4_.customerClip.mouth.addChild(_loc11_);
         _loc13_ = getDefinitionByName("customer_" + _loc5_ + "_neck") as Class;
         _loc12_ = new _loc13_();
         _loc12_.name = "clip";
         _loc4_.customerClip.neck.addChild(_loc12_);
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         try
         {
            _loc2_ = getDefinitionByName("customer_" + _loc5_ + "_hair") as Class;
            _loc14_ = new _loc2_();
            _loc14_.name = "clip";
            _loc4_.customerClip.hair.addChild(_loc14_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc3_ = getDefinitionByName("customer_" + _loc5_ + "_back_hair") as Class;
            _loc15_ = new _loc3_();
            _loc15_.name = "clip";
            _loc4_.customerClip.back_hair.addChild(_loc15_);
         }
         catch(err:Error)
         {
         }
         _loc16_ = _loc4_.gameObj.var_130.getCustomerPart(_loc5_,"foot",_loc4_.gameObj.var_128.getHolidayMonth());
         _loc16_.name = "clip";
         _loc4_.customerClip.front_shoe.addChild(_loc16_);
         _loc17_ = _loc4_.gameObj.var_130.getCustomerPart(_loc5_,"foot",_loc4_.gameObj.var_128.getHolidayMonth());
         _loc17_.name = "clip";
         _loc4_.customerClip.back_shoe.addChild(_loc17_);
         _loc18_ = _loc4_.gameObj.var_130.getCustomerPart(_loc5_,"hand",_loc4_.gameObj.var_128.getHolidayMonth());
         _loc18_.name = "clip";
         _loc4_.customerClip.fronthand.addChild(_loc18_);
         _loc19_ = _loc4_.gameObj.var_130.getCustomerPart(_loc5_,"hand2",_loc4_.gameObj.var_128.getHolidayMonth());
         _loc19_.name = "clip";
         _loc4_.customerClip.backhand.addChild(_loc19_);
         _loc21_ = getDefinitionByName("customer_" + _loc5_ + "_upperarm") as Class;
         _loc20_ = new _loc21_();
         _loc20_.name = "clip";
         _loc4_.customerClip.front_upperarm.addChild(_loc20_);
         _loc22_ = new _loc21_();
         _loc22_.name = "clip";
         _loc4_.customerClip.back_upperarm.addChild(_loc22_);
         _loc24_ = getDefinitionByName("customer_" + _loc5_ + "_forearm") as Class;
         _loc23_ = new _loc24_();
         _loc23_.name = "clip";
         _loc4_.customerClip.front_forearm.addChild(_loc23_);
         _loc25_ = new _loc24_();
         _loc25_.name = "clip";
         _loc4_.customerClip.back_forearm.addChild(_loc25_);
         _loc26_ = _loc4_.gameObj.var_130.getCustomerHolidayOutfitMonth(param1);
         if(_loc26_ > 0 && _loc4_.gameObj.var_128.getMonth() == _loc26_)
         {
            _loc6_.gotoAndStop(2);
            _loc20_.gotoAndStop(2);
            _loc22_.gotoAndStop(2);
            _loc23_.gotoAndStop(2);
            _loc25_.gotoAndStop(2);
            _loc8_.gotoAndStop(2);
            _loc12_.gotoAndStop(2);
            if(_loc14_)
            {
               _loc14_.gotoAndStop(2);
            }
            if(_loc15_)
            {
               _loc15_.gotoAndStop(2);
            }
         }
         else
         {
            _loc6_.gotoAndStop(1);
            _loc20_.gotoAndStop(1);
            _loc22_.gotoAndStop(1);
            _loc23_.gotoAndStop(1);
            _loc25_.gotoAndStop(1);
            _loc8_.gotoAndStop(1);
            _loc12_.gotoAndStop(1);
            if(_loc14_)
            {
               _loc14_.gotoAndStop(1);
            }
            if(_loc15_)
            {
               _loc15_.gotoAndStop(1);
            }
         }
         _loc4_.customerClip.gotoAndPlay("overjoyed1");
         _loc4_.customerClip.scaleX = 0.8;
         _loc4_.customerClip.scaleY = 0.8;
         _loc4_.customerClip.x = 141;
         _loc4_.customerClip.y = 75;
         _loc4_.subclip.circleMC.addChild(_loc4_.customerClip);
      }
      
      public function destroyCustomer() : void
      {
         var screen:UnlockScreen = this;
         if(screen.customerClip)
         {
            try
            {
               screen.customerClip.stop();
               screen.customerClip.body.removeChildAt(0);
               screen.customerClip.head.removeChildAt(0);
               screen.customerClip.eyes.removeChildAt(0);
               screen.customerClip.mouth.removeChildAt(0);
               screen.customerClip.neck.removeChildAt(0);
               screen.customerClip.front_shoe.removeChildAt(0);
               screen.customerClip.back_shoe.removeChildAt(0);
               screen.customerClip.fronthand.removeChildAt(0);
               screen.customerClip.backhand.removeChildAt(0);
               screen.customerClip.front_upperarm.removeChildAt(0);
               screen.customerClip.back_upperarm.removeChildAt(0);
               screen.customerClip.front_forearm.removeChildAt(0);
               screen.customerClip.back_forearm.removeChildAt(0);
            }
            catch(err:Error)
            {
               class_7.error("Error removing parts of customer");
            }
            try
            {
               screen.customerClip.hair.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
            try
            {
               screen.customerClip.back_hair.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
            screen.subclip.circleMC.removeChild(screen.customerClip);
            screen.customerClip = null;
         }
      }
   }
}


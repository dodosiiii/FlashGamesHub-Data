package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.managers.CustomerManager;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class StartDayScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var worker:Worker;
      
      public var isWaitingForTalkerResponse:Number = 0;
      
      public var backdropBitmap:Bitmap = null;
      
      public var shiftIsDown:Boolean = false;
      
      public var usedModels:Array = [];
      
      public var usedAnimations:Array = [];
      
      public var avoidIDs:Array = [];
      
      public var gondola:MovieClip = null;
      
      public var useWhichPrize:Number = 1;
      
      public var didUseGondola:Boolean = false;
      
      public var specialLogo:BitmapData = null;
      
      public var specialLogoBitmap:Bitmap = null;
      
      public function StartDayScreen(param1:class_5)
      {
         super();
         var _loc2_:StartDayScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:StartDayScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.clip = new startDayMC();
         _loc1_.gameObj.var_155.addChild(_loc1_.clip);
         _loc1_.clip.dayMC.clip.day_text.text = String(_loc2_.getDay());
         _loc1_.clip.dayMC.clip.day_shadow.text = String(_loc2_.getDay());
         _loc1_.clip.dayMC.nopapaclip.day_text.text = String(_loc2_.getDay());
         _loc1_.clip.dayMC.nopapaclip.day_shadow.text = String(_loc2_.getDay());
         _loc1_.clip.dayMC.nopapaclip.return_txt.text = "";
         var _loc3_:Number = _loc2_.getDaysUntilPapa();
         _loc1_.clip.dayMC.clip.visible = false;
         _loc1_.clip.dayMC.nopapaclip.visible = true;
         _loc1_.useWhichPrize = Math.ceil(Math.random() * 7);
         _loc1_.clip.play();
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,this.updateScreen);
         _loc1_.gameObj.var_129.switchMusic("none");
         _loc1_.gameObj.var_129.playMusicClip("startofday.wav");
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip.workerholder,_loc1_.gameObj.workerData,0,0,0.22);
         _loc1_.worker.playAnimation("startday");
         _loc1_.initBackdrop();
         _loc1_.setupCustomers();
         _loc1_.gameObj.stage.frameRate = 30;
         _loc1_.gameObj.stage.focus = _loc1_.gameObj.stage;
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:StartDayScreen = this;
         _loc6_.worker.animateModel();
         if(_loc6_.clip.currentFrame == _loc6_.clip.totalFrames)
         {
            _loc6_.clip.removeEventListener(Event.ENTER_FRAME,this.updateScreen);
            if(_loc6_.shiftIsDown)
            {
               _loc6_.gameObj.method_153();
            }
            else
            {
               _loc6_.gameObj.method_239();
               _loc6_.gameObj.method_242();
            }
         }
         else
         {
            if(_loc6_.clip.currentFrame == 66)
            {
               _loc6_.clip.customerfirst.gotoAndPlay("stand");
            }
            else if(_loc6_.clip.currentFrame == 72)
            {
               _loc5_ = Math.ceil(Math.random() * 4);
               _loc6_.clip.customerfirst.gotoAndPlay("overjoyed" + _loc5_);
            }
            if(_loc6_.usedModels.indexOf("customermeet") > -1 && _loc6_.usedModels.indexOf("customercorner") > -1)
            {
               if(_loc6_.clip.currentFrame == 76)
               {
                  _loc6_.clip.customermeet.gotoAndPlay("stand1_1");
               }
               if(_loc6_.clip.currentFrame == 82)
               {
                  _loc2_ = Math.random();
                  if(_loc2_ < 0.3)
                  {
                     _loc6_.clip.customermeet.gotoAndPlay("takeorder");
                  }
                  else if(_loc2_ < 0.5)
                  {
                     _loc6_.clip.customermeet.gotoAndPlay("worried1");
                  }
                  else if(_loc2_ < 0.8)
                  {
                     _loc6_.clip.customermeet.gotoAndPlay("happy5");
                  }
               }
               else if(_loc6_.clip.currentFrame == 94)
               {
                  _loc2_ = Math.random();
                  if(_loc2_ < 0.3)
                  {
                     _loc6_.clip.customercorner.gotoAndPlay("worried1");
                  }
                  else if(_loc2_ < 0.5)
                  {
                     _loc6_.clip.customercorner.gotoAndPlay("happy5");
                  }
                  else if(_loc2_ < 0.7)
                  {
                     _loc6_.clip.customercorner.gotoAndPlay("takeorder");
                  }
               }
            }
         }
      }
      
      public function keyListener(param1:KeyboardEvent) : void
      {
         var _loc2_:StartDayScreen = this;
         if(param1.keyCode == 32)
         {
            _loc2_.shiftIsDown = true;
         }
         else
         {
            _loc2_.shiftIsDown = false;
         }
      }
      
      public function cb() : void
      {
         var §~~unused§:*;
         var _loc2_:int;
         var _loc1_:StartDayScreen = this;
         if(_loc1_.specialLogoBitmap)
         {
            if(_loc1_.specialLogoBitmap.parent)
            {
               _loc1_.specialLogoBitmap.parent.removeChild(_loc1_.specialLogoBitmap);
            }
            _loc1_.specialLogoBitmap.bitmapData = null;
            _loc1_.specialLogoBitmap = null;
         }
         if(_loc1_.specialLogo)
         {
            _loc1_.specialLogo.dispose();
            _loc1_.specialLogo = null;
         }
         _loc1_.worker.destroy();
         _loc1_.worker = null;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.usedModels.length)
         {
            _loc1_.destroyCustomerModel(_loc1_.clip[_loc1_.usedModels[_loc2_]]);
            _loc2_++;
         }
         if(_loc1_.didUseGondola == true)
         {
            _loc1_.destroyCustomerModel(_loc1_.clip.gondola.passenger);
            _loc1_.destroyCustomerModel(_loc1_.clip.gondola);
         }
         if(_loc1_.backdropBitmap != null)
         {
            _loc1_.backdropBitmap.bitmapData.dispose();
            try
            {
               _loc1_.clip.insideholder.removeChild(_loc1_.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            _loc1_.backdropBitmap = null;
         }
         _loc1_.gameObj.var_155.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function destroy() : void
      {
         this.cb();
      }
      
      public function setupCustomers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:String = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:String = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:StartDayScreen = this;
         var _loc10_:UserData = _loc9_.gameObj.var_128;
         var _loc11_:CustomerData = _loc9_.gameObj.var_130;
         var _loc12_:CustomerManager = _loc9_.gameObj.var_134;
         var _loc13_:Number = Math.ceil(Math.random() * 4);
         var _loc14_:Array = ["Brody","Perri","Austin","Yui","Papa Louie"];
         var _loc15_:Array = ["Santa"];
         _loc1_ = 0;
         while(_loc1_ < _loc14_.length)
         {
            _loc2_ = _loc11_.getCustomerIndex(_loc14_[_loc1_]);
            if(!(_loc2_ < _loc10_.customersUnlocked.length && _loc10_.customersUnlocked[_loc2_] == 1))
            {
               _loc9_.avoidIDs.push(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc15_.length)
         {
            _loc3_ = _loc11_.getCustomerIndex(_loc15_[_loc1_]);
            _loc9_.avoidIDs.push(_loc3_);
            _loc1_++;
         }
         var _loc16_:Number = Number(_loc12_.customerLineup[0]);
         var _loc17_:String = _loc11_.getCustomerClipName(_loc16_);
         _loc9_.buildCustomerModel(_loc9_.clip.customerfirst,_loc17_);
         _loc9_.avoidIDs.push(_loc16_);
         _loc9_.usedModels.push("customerfirst");
         _loc9_.usedAnimations.push("walk");
         if(_loc9_.gameObj.var_128.getMonth() == GameData.MONTH_AUGUST)
         {
            _loc4_ = _loc11_.getCustomerIndex("Deano");
            if(_loc9_.avoidIDs.indexOf(_loc4_) > -1)
            {
               _loc4_ = _loc11_.getCustomerIndex("Nick");
            }
            _loc5_ = _loc11_.getCustomerClipName(_loc4_);
            _loc9_.buildCustomerModel(_loc9_.clip.gondola,_loc5_);
            _loc9_.avoidIDs.push(_loc4_);
            _loc6_ = -1;
            while(_loc6_ == -1 || _loc9_.avoidIDs.indexOf(_loc6_) > -1)
            {
               _loc6_ = Math.ceil(Math.random() * (_loc9_.gameObj.var_130.getCustomerTotal() - 1));
            }
            _loc9_.avoidIDs.push(_loc6_);
            _loc7_ = _loc9_.gameObj.var_130.getCustomerClipName(_loc6_);
            _loc9_.buildCustomerModel(_loc9_.clip.gondola.passenger,_loc7_);
            _loc8_ = Math.random();
            if(_loc8_ > 0.75)
            {
               _loc9_.clip.gondola.passenger.gotoAndPlay("cheer19");
            }
            else if(_loc8_ > 0.5)
            {
               _loc9_.clip.gondola.passenger.gotoAndPlay("cheer3");
            }
            else if(_loc8_ > 0.25)
            {
               _loc9_.clip.gondola.passenger.gotoAndPlay("cheer1");
            }
            else
            {
               _loc9_.clip.gondola.passenger.gotoAndPlay("cheer5");
            }
            _loc9_.didUseGondola = true;
         }
         if(_loc13_ == 1)
         {
            _loc9_.setupCustomerModel("customerunderporch",true,"walk");
            _loc9_.setupCustomerModel("customerfg",true,"walk");
            _loc9_.setupCustomerModel("customerwalk1",true,"walktalking");
            _loc9_.setupCustomerModel("customerwalk2",true,"walk");
            _loc9_.setupCustomerModel("customerbakery1",true,"takeorder");
            _loc9_.setupCustomerModel("customerbakery2",true,"standphone1_3");
            _loc9_.setupCustomerModel("customerwalkbakery",false);
            _loc9_.setupCustomerModel("rooftop1",true,"stand1_1");
            _loc9_.setupCustomerModel("rooftop2",true,"chewgum2");
            _loc9_.setupCustomerModel("rooftop3",true,"stand1_1");
            _loc9_.setupCustomerModel("rooftop4",true,"takeorder");
            _loc9_.setupCustomerModel("rooftop5",true,"look");
            _loc9_.setupCustomerModel("rooftop7",false);
            _loc9_.setupCustomerModel("rooftop6",true,"drinkcoffee1");
            _loc9_.setupCustomerModel("customerdoorway",true,"readpaper1");
            _loc9_.setupCustomerModel("customercorner",false);
            _loc9_.setupCustomerModel("customermeet",false);
            _loc9_.setupCustomerModel("roofgroup1",false);
            _loc9_.setupCustomerModel("roofgroup2",false);
            _loc9_.setupCustomerModel("roofgroup3",false);
            _loc9_.setupCustomerModel("customerpost1",false);
            _loc9_.setupCustomerModel("customerpost2",false);
         }
         else if(_loc13_ == 2)
         {
            _loc9_.setupCustomerModel("customerunderporch",false);
            _loc9_.setupCustomerModel("customerfg",true,"walk");
            _loc9_.setupCustomerModel("customerwalk1",false);
            _loc9_.setupCustomerModel("customerwalk2",false);
            _loc9_.setupCustomerModel("customerbakery1",true,"drinkcoffee2");
            _loc9_.setupCustomerModel("customerbakery2",false);
            _loc9_.setupCustomerModel("customerwalkbakery",true,"walk");
            _loc9_.setupCustomerModel("rooftop1",false);
            _loc9_.setupCustomerModel("rooftop2",false);
            _loc9_.setupCustomerModel("rooftop3",true,"drinkcoffee3");
            _loc9_.setupCustomerModel("rooftop4",false);
            _loc9_.setupCustomerModel("rooftop5",true,"look");
            _loc9_.setupCustomerModel("rooftop7",true,"overjoyed5");
            _loc9_.setupCustomerModel("rooftop6",true,"standphone2_1");
            _loc9_.setupCustomerModel("customerdoorway",false);
            _loc9_.setupCustomerModel("customercorner",true,"stand1_1");
            _loc9_.setupCustomerModel("customermeet",true,"walk");
            _loc9_.setupCustomerModel("roofgroup1",true,"dance1_1");
            _loc9_.setupCustomerModel("roofgroup2",true,"dance1_3");
            _loc9_.setupCustomerModel("roofgroup3",true,"dance1_2");
            _loc9_.setupCustomerModel("customerpost1",true,"readpaper1");
            _loc9_.setupCustomerModel("customerpost2",true,"drinkcoffee3");
         }
         else if(_loc13_ == 3)
         {
            _loc9_.setupCustomerModel("customerunderporch",false);
            _loc9_.setupCustomerModel("customerfg",false);
            _loc9_.setupCustomerModel("customerwalk1",true,"walk");
            _loc9_.setupCustomerModel("customerwalk2",false);
            _loc9_.setupCustomerModel("customerbakery1",false);
            _loc9_.setupCustomerModel("customerbakery2",true,"readpaper2");
            _loc9_.setupCustomerModel("customerwalkbakery",true,"walk");
            _loc9_.setupCustomerModel("rooftop1",false);
            _loc9_.setupCustomerModel("rooftop2",false);
            _loc9_.setupCustomerModel("rooftop3",true,"chewgum2");
            _loc9_.setupCustomerModel("rooftop4",false);
            _loc9_.setupCustomerModel("rooftop5",false);
            _loc9_.setupCustomerModel("rooftop7",true,"happy3");
            _loc9_.setupCustomerModel("rooftop6",true,"pissed2");
            _loc9_.setupCustomerModel("customerdoorway",false);
            _loc9_.setupCustomerModel("customercorner",true,"standphone1_3");
            _loc9_.setupCustomerModel("customermeet",false);
            _loc9_.setupCustomerModel("roofgroup1",true,"dance2_1");
            _loc9_.setupCustomerModel("roofgroup2",true,"overjoyed2");
            _loc9_.setupCustomerModel("roofgroup3",true,"dance3_2");
            _loc9_.setupCustomerModel("customerpost1",false);
            _loc9_.setupCustomerModel("customerpost2",true,"readpaper2");
         }
         else if(_loc13_ == 4)
         {
            _loc9_.setupCustomerModel("customerunderporch",true,"walk");
            _loc9_.setupCustomerModel("customerfg",false);
            _loc9_.setupCustomerModel("customerwalk1",false);
            _loc9_.setupCustomerModel("customerwalk2",true,"walk");
            _loc9_.setupCustomerModel("customerbakery1",true,"takeorder");
            _loc9_.setupCustomerModel("customerbakery2",true,"decent1");
            _loc9_.setupCustomerModel("customerwalkbakery",true,"walk");
            _loc9_.setupCustomerModel("rooftop1",true,"happy5");
            _loc9_.setupCustomerModel("rooftop2",false);
            _loc9_.setupCustomerModel("rooftop3",false);
            _loc9_.setupCustomerModel("rooftop4",true,"overjoyed4");
            _loc9_.setupCustomerModel("rooftop5",true,"decent2");
            _loc9_.setupCustomerModel("rooftop7",true,"takeorder");
            _loc9_.setupCustomerModel("rooftop6",true,"happy5");
            _loc9_.setupCustomerModel("customerdoorway",false);
            _loc9_.setupCustomerModel("customercorner",false);
            _loc9_.setupCustomerModel("customermeet",false);
            _loc9_.setupCustomerModel("roofgroup1",true,"happy4");
            _loc9_.setupCustomerModel("roofgroup2",false);
            _loc9_.setupCustomerModel("roofgroup3",true,"takeorder");
            _loc9_.setupCustomerModel("customerpost1",true,"standphone2_1");
            _loc9_.setupCustomerModel("customerpost2",false);
         }
         else if(_loc13_ != 5)
         {
            if(_loc13_ != 6)
            {
               if(_loc13_ != 7)
               {
                  if(_loc13_ == 8)
                  {
                  }
               }
            }
         }
         class_7.method_1("---- Which Animation Mode: " + _loc13_);
      }
      
      public function setupCustomerModel(param1:String, param2:Boolean, param3:String = "stand1_1") : void
      {
         var id:Number = Number(NaN);
         var clipname:String = null;
         var balloonMC:MovieClip = null;
         var holdwhich:Number = Number(NaN);
         var modelname:String = param1;
         var shouldUse:Boolean = param2;
         var startingAnimation:String = param3;
         var ob:StartDayScreen = this;
         if(shouldUse)
         {
            id = -1;
            while(id == -1 || ob.avoidIDs.indexOf(id) > -1)
            {
               id = Math.ceil(Math.random() * (ob.gameObj.var_130.getCustomerTotal() - 1));
            }
            clipname = ob.gameObj.var_130.getCustomerClipName(id);
            ob.buildCustomerModel(ob.clip[modelname],clipname);
            ob.clip[modelname].gotoAndPlay(startingAnimation);
            try
            {
               if(startingAnimation.indexOf("paper") > -1)
               {
                  ob.clip[modelname].book.gotoAndStop(1);
               }
               else if(startingAnimation.indexOf("coffee") > -1)
               {
                  ob.clip[modelname].mug.gotoAndStop(Math.ceil(Math.random() * 3) + 2);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error setting paper/mug for model.");
            }
            try
            {
               if(startingAnimation == "walkholding" || startingAnimation == "walkprize")
               {
                  balloonMC = new handextra_balloon();
                  holdwhich = Math.ceil(Math.random() * balloonMC.totalFrames);
                  if(startingAnimation == "walkprize")
                  {
                     holdwhich = 7 + Math.ceil(Math.random() * (balloonMC.totalFrames - 7));
                  }
                  balloonMC.gotoAndStop(holdwhich);
                  if(holdwhich >= 8)
                  {
                     ob.clip[modelname].handextra.addChild(balloonMC);
                     balloonMC.prize.gotoAndStop(ob.useWhichPrize);
                  }
                  else
                  {
                     ob.clip[modelname].handextratop.addChild(balloonMC);
                  }
               }
            }
            catch(err:Error)
            {
               class_7.error("Error adding stuff to handextratop: " + err.message);
            }
            ob.usedModels.push(modelname);
            ob.usedAnimations.push(startingAnimation);
            ob.avoidIDs.push(id);
         }
         else
         {
            ob.clip[modelname].visible = false;
            ob.clip[modelname].stop();
            ob.clip.removeChild(ob.clip[modelname]);
         }
      }
      
      public function buildCustomerModel(param1:MovieClip, param2:String) : void
      {
         var §~~unused§:*;
         var _loc14_:MovieClip;
         var _loc15_:MovieClip;
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
         var _loc3_:Class = null;
         var _loc4_:Class = null;
         var _loc5_:StartDayScreen = this;
         (_loc6_ = new (_loc7_ = getDefinitionByName("customer_" + param2 + "_body") as Class)()).name = "clip";
         param1.body.addChild(_loc6_);
         (_loc8_ = new (_loc9_ = getDefinitionByName("customer_" + param2 + "_head") as Class)()).name = "clip";
         param1.head.addChild(_loc8_);
         (_loc10_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"eyes",_loc5_.gameObj.var_128.getHolidayMonth())).name = "clip";
         param1.eyes.addChild(_loc10_);
         (_loc11_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"mouth",_loc5_.gameObj.var_128.getHolidayMonth())).name = "clip";
         param1.mouth.addChild(_loc11_);
         (_loc12_ = new (_loc13_ = getDefinitionByName("customer_" + param2 + "_neck") as Class)()).name = "clip";
         param1.neck.addChild(_loc12_);
         _loc14_ = null;
         _loc15_ = null;
         try
         {
            (_loc14_ = new (_loc3_ = getDefinitionByName("customer_" + param2 + "_hair") as Class)()).name = "clip";
            param1.hair.addChild(_loc14_);
         }
         catch(err:Error)
         {
         }
         try
         {
            (_loc15_ = new (_loc4_ = getDefinitionByName("customer_" + param2 + "_back_hair") as Class)()).name = "clip";
            param1.back_hair.addChild(_loc15_);
         }
         catch(err:Error)
         {
         }
         (_loc16_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"foot",_loc5_.gameObj.var_128.getHolidayMonth())).name = "clip";
         param1.front_shoe.addChild(_loc16_);
         (_loc17_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"foot",_loc5_.gameObj.var_128.getHolidayMonth())).name = "clip";
         param1.back_shoe.addChild(_loc17_);
         (_loc18_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"hand",_loc5_.gameObj.var_128.getHolidayMonth())).name = "clip";
         param1.fronthand.addChild(_loc18_);
         (_loc19_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"hand2",_loc5_.gameObj.var_128.getHolidayMonth())).name = "clip";
         param1.backhand.addChild(_loc19_);
         (_loc20_ = new (_loc21_ = getDefinitionByName("customer_" + param2 + "_upperarm") as Class)()).name = "clip";
         param1.front_upperarm.addChild(_loc20_);
         (_loc22_ = new _loc21_()).name = "clip";
         param1.back_upperarm.addChild(_loc22_);
         (_loc23_ = new (_loc24_ = getDefinitionByName("customer_" + param2 + "_forearm") as Class)()).name = "clip";
         param1.front_forearm.addChild(_loc23_);
         (_loc25_ = new _loc24_()).name = "clip";
         param1.back_forearm.addChild(_loc25_);
         if((_loc26_ = _loc5_.gameObj.var_130.getCustomerHolidayOutfitMonth(_loc5_.gameObj.var_130.getCustomerIndex(param2))) > 0 && _loc5_.gameObj.var_128.getMonth() == _loc26_)
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
      }
      
      public function destroyCustomerModel(param1:MovieClip) : void
      {
         var whichClip:MovieClip = param1;
         whichClip.stop();
         try
         {
            whichClip.body.removeChildAt(0);
            whichClip.head.removeChildAt(0);
            whichClip.eyes.removeChildAt(0);
            whichClip.mouth.removeChildAt(0);
            whichClip.neck.removeChildAt(0);
            whichClip.front_shoe.removeChildAt(0);
            whichClip.back_shoe.removeChildAt(0);
            whichClip.fronthand.removeChildAt(0);
            whichClip.backhand.removeChildAt(0);
            whichClip.front_upperarm.removeChildAt(0);
            whichClip.back_upperarm.removeChildAt(0);
            whichClip.front_forearm.removeChildAt(0);
            whichClip.back_forearm.removeChildAt(0);
         }
         catch(err:Error)
         {
            class_7.error("Error removing parts of customer");
         }
         try
         {
            whichClip.hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            whichClip.back_hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            whichClip.handextra.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            whichClip.handextratop.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
      }
      
      private function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc6_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:StartDayScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Bitmap = null;
         var _loc5_:MovieClip = new startdayBackdropMC();
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc5_.holder.wallparts["wall" + _loc1_].gotoAndStop(_loc3_.lobbyWallpaper);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc5_.holder.floorparts["floor" + _loc1_].gotoAndStop(_loc3_.lobbyFlooring);
            _loc1_++;
         }
         _loc5_.holder.trim.transform.colorTransform = _loc2_.createColorTransform(_loc3_.lobbyTrim);
         _loc5_.holder.wallparts.mask = _loc5_.holder.wallmask;
         _loc5_.holder.floorparts.mask = _loc5_.holder.floormask;
         _loc6_ = new BitmapData(150,172,true,0);
         _loc6_.draw(_loc5_,null,null,null,new Rectangle(0,0,150,172));
         _loc4_ = new Bitmap(_loc6_);
         _loc5_ = null;
         return _loc4_;
      }
      
      private function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
      }
      
      public function initBackdrop() : void
      {
         var _loc1_:StartDayScreen = this;
         var _loc2_:Number = _loc1_.gameObj.var_128.getMonth();
         var _loc3_:Number = _loc1_.gameObj.var_128.getMonth() * 2 - 1;
         if(_loc1_.gameObj.var_128.getMonth() == GameData.STARTER_MONTH && _loc1_.gameObj.var_128.isNewYear() == false)
         {
            _loc3_ = 25;
         }
         var _loc4_:Array = ["fg","lampposts","cheeseria","tradingpost","tradingpostbg","lamppostsbg","bg"];
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_.clip[_loc4_[_loc5_]].gotoAndStop(_loc3_);
            _loc1_.clip[_loc4_[_loc5_]].cacheAsBitmap = true;
            _loc1_.clip[_loc4_[_loc5_]].mouseEnabled = false;
            _loc1_.clip[_loc4_[_loc5_]].mouseChildren = false;
            _loc5_++;
         }
         _loc1_.clip.bg.opaqueBackground = 16777215;
         if(_loc2_ != GameData.MONTH_SEPTEMBER)
         {
            _loc1_.clip.removeChild(_loc1_.clip.chickens);
         }
         if(!(_loc2_ == GameData.MONTH_JUNE || _loc2_ == GameData.MONTH_JULY))
         {
            _loc1_.clip.removeChild(_loc1_.clip.tumbleweed);
         }
         if(_loc2_ != GameData.MONTH_AUGUST)
         {
            _loc1_.clip.removeChild(_loc1_.clip.gondola);
         }
         if(_loc1_.gameObj.var_128.hasBonus("specialsign") && _loc1_.gameObj.var_128.showSpecialSign === 1 && _loc1_.gameObj.var_128.currentSpecial != -1)
         {
            _loc1_.clip.specialsign.visible = true;
            _loc1_.specialLogo = _loc1_.gameObj.var_133.getSpecialLogo(_loc1_.gameObj.var_128.currentSpecial);
            _loc1_.specialLogoBitmap = new Bitmap(_loc1_.specialLogo,"auto",true);
            _loc1_.clip.specialsign.holder.addChild(_loc1_.specialLogoBitmap);
         }
         else
         {
            _loc1_.clip.specialsign.visible = false;
         }
      }
   }
}


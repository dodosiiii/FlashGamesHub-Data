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
   
   public class FinishDayScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var worker:Worker;
      
      public var isWaitingForTalkerResponse:Number = 0;
      
      public var backdropBitmap:Bitmap = null;
      
      public function FinishDayScreen(param1:class_5)
      {
         super();
         var _loc2_:FinishDayScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:FinishDayScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.clip = new finishDayMC();
         _loc1_.gameObj.var_155.addChild(_loc1_.clip);
         _loc1_.clip.play();
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,this.updateScreen);
         _loc1_.gameObj.var_129.switchMusic("none");
         _loc1_.gameObj.var_129.playMusicClip("endofday.wav");
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip.workerholder,_loc1_.gameObj.workerData,0,0,0.22);
         _loc1_.worker.playAnimation("startday");
         _loc1_.initBackdrop();
         _loc1_.setupCustomers();
         _loc1_.gameObj.stage.frameRate = 30;
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:FinishDayScreen = this;
         _loc2_.worker.animateModel();
         if(_loc2_.clip.currentFrame == _loc2_.clip.totalFrames)
         {
            _loc2_.clip.removeEventListener(Event.ENTER_FRAME,this.updateScreen);
            _loc2_.gameObj.var_205 = true;
            _loc2_.gameObj.method_277();
            _loc2_.gameObj.method_212();
         }
         else if(_loc2_.clip.currentFrame == 52)
         {
            _loc2_.worker.playAnimation("score_ok");
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:FinishDayScreen = this;
         _loc1_.worker.destroy();
         _loc1_.worker = null;
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
      
      private function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc6_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:FinishDayScreen = this;
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
         var _loc1_:FinishDayScreen = this;
         var _loc2_:Number = _loc1_.gameObj.var_128.getMonth() * 2 - 0;
         if(_loc1_.gameObj.var_128.getMonth() == GameData.STARTER_MONTH && _loc1_.gameObj.var_128.isNewYear() == false)
         {
            _loc2_ = 26;
         }
         var _loc3_:Array = ["fg","lampposts","cheeseria","tradingpost","tradingpostbg","lamppostsbg","bg"];
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_.clip[_loc3_[_loc4_]].gotoAndStop(_loc2_);
            _loc1_.clip[_loc3_[_loc4_]].cacheAsBitmap = true;
            _loc1_.clip[_loc3_[_loc4_]].mouseEnabled = false;
            _loc1_.clip[_loc3_[_loc4_]].mouseChildren = false;
            _loc4_++;
         }
         _loc1_.clip.bg.opaqueBackground = 16777215;
      }
      
      public function setupCustomers() : void
      {
         var _loc1_:FinishDayScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:CustomerData = _loc1_.gameObj.var_130;
         var _loc4_:CustomerManager = _loc1_.gameObj.var_134;
      }
      
      public function setupCustomerModel(param1:MovieClip, param2:String) : void
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
         var _loc21_:MovieClip = null;
         var _loc22_:Class = null;
         var _loc23_:MovieClip = null;
         var _loc24_:MovieClip = null;
         var _loc25_:Class = null;
         var _loc26_:MovieClip = null;
         var _loc27_:Number = NaN;
         var _loc3_:Class = null;
         var _loc4_:Class = null;
         var _loc5_:FinishDayScreen = this;
         _loc7_ = getDefinitionByName("customer_" + param2 + "_body") as Class;
         _loc6_ = new _loc7_();
         _loc6_.name = "clip";
         param1.body.addChild(_loc6_);
         _loc9_ = getDefinitionByName("customer_" + param2 + "_head") as Class;
         _loc8_ = new _loc9_();
         _loc8_.name = "clip";
         param1.head.addChild(_loc8_);
         _loc10_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"eyes",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc10_.name = "clip";
         param1.eyes.addChild(_loc10_);
         _loc11_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"mouth",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc11_.name = "clip";
         param1.mouth.addChild(_loc11_);
         _loc13_ = getDefinitionByName("customer_" + param2 + "_neck") as Class;
         _loc12_ = new _loc13_();
         _loc12_.name = "clip";
         param1.neck.addChild(_loc12_);
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         try
         {
            _loc3_ = getDefinitionByName("customer_" + param2 + "_hair") as Class;
            _loc14_ = new _loc3_();
            _loc14_.name = "clip";
            param1.hair.addChild(_loc14_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc4_ = getDefinitionByName("customer_" + param2 + "_back_hair") as Class;
            _loc15_ = new _loc4_();
            _loc15_.name = "clip";
            param1.back_hair.addChild(_loc15_);
         }
         catch(err:Error)
         {
         }
         _loc16_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"foot",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc16_.name = "clip";
         param1.front_shoe.addChild(_loc16_);
         _loc17_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"foot",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc17_.name = "clip";
         param1.back_shoe.addChild(_loc17_);
         _loc18_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"hand",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc18_.name = "clip";
         param1.fronthand.addChild(_loc18_);
         _loc19_ = _loc5_.gameObj.var_130.getCustomerPart(param2,"hand2",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc19_.name = "clip";
         param1.backhand.addChild(_loc19_);
         var _loc20_:MovieClip = new leaving_boxMC();
         param1.backhand.addChild(_loc20_);
         _loc22_ = getDefinitionByName("customer_" + param2 + "_upperarm") as Class;
         _loc21_ = new _loc22_();
         _loc21_.name = "clip";
         param1.front_upperarm.addChild(_loc21_);
         _loc23_ = new _loc22_();
         _loc23_.name = "clip";
         param1.back_upperarm.addChild(_loc23_);
         _loc25_ = getDefinitionByName("customer_" + param2 + "_forearm") as Class;
         _loc24_ = new _loc25_();
         _loc24_.name = "clip";
         param1.front_forearm.addChild(_loc24_);
         _loc26_ = new _loc25_();
         _loc26_.name = "clip";
         param1.back_forearm.addChild(_loc26_);
         _loc27_ = _loc5_.gameObj.var_130.getCustomerHolidayOutfitMonth(_loc5_.gameObj.var_130.getCustomerIndex(param2));
         if(_loc27_ > 0 && _loc5_.gameObj.var_128.getMonth() == _loc27_)
         {
            _loc6_.gotoAndStop(2);
            _loc21_.gotoAndStop(2);
            _loc23_.gotoAndStop(2);
            _loc24_.gotoAndStop(2);
            _loc26_.gotoAndStop(2);
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
            _loc21_.gotoAndStop(1);
            _loc23_.gotoAndStop(1);
            _loc24_.gotoAndStop(1);
            _loc26_.gotoAndStop(1);
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
            whichClip.backhand.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
      }
   }
}


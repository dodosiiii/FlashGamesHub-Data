package cheeseGame.models
{
   import cheeseGame.screens.FryScreen;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.filters.*;
   import package_2.*;
   import package_4.class_5;
   
   public class ToppingSpoon
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var whichTopping:String;
      
      public var emptyingClipRange:Number = 25;
      
      public var isReturning:Boolean = false;
      
      public var isStarting:Boolean = false;
      
      public var isPouring:Boolean = false;
      
      public var targetX:Number = 0;
      
      public var targetY:Number = 0;
      
      public var maxY:Number = 170;
      
      public var returnSpeed:Number = 4;
      
      public var moveSpeed:Number = 1.33333;
      
      public var binPaddingX:Number = 34;
      
      public var binPaddingY:Number = 14;
      
      public var meatBinPaddingX:Number = 0;
      
      public var meatBinPaddingY:Number = 0;
      
      public var pourOffset:Number = 0;
      
      public var pourOffsetMax:Number = 60;
      
      public var pourOffsetSpeed:Number = 10;
      
      public var risingOffset:Number = 0;
      
      public var risingOffsetMax:Number = 35;
      
      public var risingOffsetSpeed:Number = 6;
      
      public var shadow:MovieClip;
      
      public var shouldShowPutAway:Boolean = false;
      
      public function ToppingSpoon(param1:class_5, param2:String, param3:MovieClip, param4:Number, param5:Number)
      {
         var _loc6_:ToppingSpoon = null;
         super();
         _loc6_ = this;
         _loc6_.gameObj = param1;
         _loc6_.whichTopping = param2;
         _loc6_.container = param3;
         _loc6_.targetX = param4 + _loc6_.binPaddingX;
         _loc6_.targetY = param5 + _loc6_.binPaddingY;
         _loc6_.setupSpoon();
      }
      
      public function setupSpoon() : void
      {
         var _loc1_:GlowFilter = null;
         var _loc2_:ToppingSpoon = this;
         _loc2_.clip = new spoonMC();
         _loc2_.container.addChild(_loc2_.clip);
         _loc2_.clip.x = _loc2_.targetX;
         _loc2_.clip.y = _loc2_.targetY;
         _loc2_.clip.mouseEnabled = false;
         _loc2_.clip.mouseChildren = false;
         _loc2_.clip.holder.mouseEnabled = false;
         _loc2_.clip.holder.inside.mouseEnabled = false;
         _loc2_.clip.holder.inside.mouseChildren = false;
         _loc2_.clip.tabEnabled = false;
         _loc2_.clip.icon.gotoAndStop("start");
         _loc2_.clip.holder.inside.gotoAndStop(_loc2_.whichTopping);
         _loc2_.clip.holder.mask = _loc2_.clip.masker;
         _loc2_.clip.masker.visible = false;
         _loc2_.clip.timer.inside.mask = _loc2_.clip.timer.masker;
         _loc2_.clip.timer_txt.mouseEnabled = false;
         _loc2_.clip.timer_txt.text = "";
         if(_loc2_.gameObj.training)
         {
            _loc1_ = new GlowFilter(0,1,3,3,1000);
            _loc2_.clip.timer_txt.filters = [_loc1_];
            _loc2_.clip.timer_txt.visible = true;
         }
         else
         {
            _loc2_.clip.timer_txt.visible = false;
         }
         _loc2_.isStarting = true;
         _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.animateSpoon);
         _loc2_.shadow = new bottle_cursor();
         _loc2_.shadow.x = _loc2_.clip.x;
         _loc2_.shadow.y = _loc2_.clip.y + _loc2_.risingOffsetMax;
         _loc2_.shadow.mouseEnabled = false;
         _loc2_.shadow.mouseChildren = false;
         _loc2_.shadow.visible = false;
         _loc2_.container.addChild(_loc2_.shadow);
      }
      
      public function animateSpoon(param1:Event = null) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:ToppingSpoon = this;
         if(_loc8_.isReturning)
         {
            _loc8_.shadow.visible = false;
            _loc2_ = _loc8_.targetX - _loc8_.clip.x;
            _loc3_ = _loc8_.targetY - _loc8_.clip.y;
            _loc8_.clip.x += _loc2_ / _loc8_.returnSpeed;
            _loc8_.clip.y += _loc3_ / _loc8_.returnSpeed;
            if(Math.abs(_loc2_) <= 5 && Math.abs(_loc3_) <= 5)
            {
               _loc8_.gameObj.var_131.restoreSpoonInBin(_loc8_.whichTopping);
            }
         }
         else
         {
            _loc8_.shadow.visible = true;
            _loc8_.shadow.x = _loc8_.gameObj.mouseX;
            _loc8_.shadow.y = _loc8_.gameObj.mouseY;
            _loc4_ = _loc8_.moveSpeed;
            _loc8_.clip.x = _loc8_.gameObj.mouseX;
            _loc8_.clip.y = _loc8_.gameObj.mouseY;
            _loc8_.risingOffset += (_loc8_.risingOffsetMax - _loc8_.risingOffset) / 4;
            _loc8_.clip.y -= _loc8_.risingOffset;
            if(_loc8_.isPouring)
            {
               if(_loc8_.pourOffset < _loc8_.pourOffsetMax)
               {
                  _loc8_.pourOffset += (_loc8_.pourOffsetMax - _loc8_.pourOffset) / 2;
                  if(Math.abs(_loc8_.pourOffsetMax - _loc8_.pourOffset) <= 1)
                  {
                     _loc8_.pourOffset = _loc8_.pourOffsetMax;
                  }
               }
               _loc8_.clip.y -= _loc8_.pourOffset;
               if(_loc8_.clip.icon.currentLabel == "up")
               {
                  try
                  {
                     _loc5_ = _loc8_.gameObj.var_131.currentOrder.clip.x + _loc8_.gameObj.var_131.currentOrder.fries.clip.x - (_loc8_.clip.x - 45);
                     _loc6_ = _loc8_.gameObj.var_131.currentOrder.clip.y + _loc8_.gameObj.var_131.currentOrder.fries.clip.y - _loc8_.clip.y;
                     _loc7_ = Math.atan2(_loc6_,_loc5_);
                     _loc7_ = _loc7_ - Math.PI / 2;
                     _loc7_ = _loc7_ + Math.PI;
                     _loc8_.clip.icon.pointer.rotation = _loc7_ * (180 / Math.PI);
                  }
                  catch(err:Error)
                  {
                  }
               }
            }
            else
            {
               if(_loc8_.pourOffset > 0)
               {
                  _loc8_.pourOffset /= 2;
                  if(Math.abs(this.pourOffset) <= 1)
                  {
                     _loc8_.pourOffset = 0;
                  }
               }
               _loc8_.clip.y -= _loc8_.pourOffset;
            }
            _loc8_.updateTimerClock();
         }
         if(_loc8_.gameObj.mouseX < 170)
         {
            _loc8_.shouldShowPutAway = true;
         }
         if(_loc8_.shadow != null)
         {
            if(_loc8_.gameObj.mouseX < 170 && !_loc8_.isPouring && _loc8_.shouldShowPutAway)
            {
               _loc8_.shadow.gotoAndStop(3);
            }
            else if(_loc8_.isCursorWithinFries())
            {
               _loc8_.shadow.gotoAndStop(1);
            }
            else
            {
               _loc8_.shadow.gotoAndStop(2);
            }
         }
      }
      
      public function startPouring() : void
      {
         var _loc1_:ToppingSpoon = this;
         class_7.method_1("Spoon: Start Pouring!");
         _loc1_.isPouring = true;
      }
      
      public function stopPouring(param1:Number = 1) : void
      {
         var _loc2_:ToppingSpoon = this;
         class_7.method_1("Spoon: Stop Pouring");
         _loc2_.isPouring = false;
         _loc2_.clip.holder.inside.y = _loc2_.emptyingClipRange - param1 * _loc2_.emptyingClipRange;
         _loc2_.clip.gotoAndPlay("release");
         _loc2_.clip.icon.gotoAndStop("start");
      }
      
      public function setIcon(param1:String) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:ToppingSpoon = this;
         if(_loc3_.clip.icon.currentLabel != param1)
         {
            _loc3_.clip.icon.gotoAndStop(param1);
            if(param1 == "none")
            {
               if(_loc3_.clip.currentLabel != "pour" && _loc3_.clip.currentLabel != "pouring")
               {
                  _loc3_.clip.gotoAndPlay("pour");
                  if(_loc3_.gameObj.training)
                  {
                     _loc3_.clip.timer_txt.visible = true;
                  }
               }
            }
            else if(_loc3_.clip.currentLabel != "up" && _loc3_.clip.currentLabel != "release")
            {
               _loc2_ = _loc3_.gameObj.var_131.toppingRemaining / _loc3_.gameObj.var_131.toppingCapacity;
               _loc3_.clip.holder.inside.y = _loc3_.emptyingClipRange - _loc2_ * _loc3_.emptyingClipRange;
               _loc3_.clip.gotoAndPlay("release");
               _loc3_.clip.timer_txt.visible = false;
            }
         }
      }
      
      public function returnSpoon() : void
      {
         var _loc1_:ToppingSpoon = this;
         var _loc2_:FryScreen = _loc1_.gameObj.var_131;
         var _loc3_:MovieClip = _loc2_.getBin(_loc1_.whichTopping);
         _loc1_.targetX = _loc3_.x + _loc1_.binPaddingX;
         _loc1_.targetY = _loc3_.y + _loc1_.binPaddingY;
         _loc1_.isReturning = true;
      }
      
      public function refillSpoon() : void
      {
         var _loc1_:ToppingSpoon = this;
         var _loc2_:FryScreen = _loc1_.gameObj.var_131;
         var _loc3_:MovieClip = _loc2_.getBin(_loc1_.whichTopping);
         _loc1_.clip.x = _loc3_.x + _loc1_.binPaddingX;
         _loc1_.clip.y = _loc3_.y + _loc1_.binPaddingY;
         _loc1_.clip.holder.inside.y = 0;
         _loc1_.isStarting = true;
      }
      
      public function destroy() : void
      {
         var _loc1_:ToppingSpoon = this;
         if(_loc1_.shadow)
         {
            if(_loc1_.shadow.parent)
            {
               _loc1_.shadow.parent.removeChild(_loc1_.shadow);
            }
            _loc1_.shadow = null;
         }
         if(_loc1_.container.contains(_loc1_.clip))
         {
            _loc1_.container.removeChild(_loc1_.clip);
         }
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.animateSpoon);
         _loc1_.clip = null;
      }
      
      public function updateTimerClock() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:MovieClip = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:ToppingSpoon = this;
         if(_loc11_.isPouring)
         {
            _loc1_ = (_loc11_.gameObj.var_131.toppingCapacity - _loc11_.gameObj.var_131.toppingRemaining) / _loc11_.gameObj.var_131.toppingCapacity;
            if(_loc1_ > 1)
            {
               _loc1_ = 1;
            }
            _loc2_ = _loc1_ * (2 * Math.PI);
            _loc3_ = _loc11_.clip.timer.inside;
            _loc4_ = 0 + 46 / 2;
            _loc5_ = 0 + 46 / 2;
            _loc6_ = 46 / 2;
            _loc3_.graphics.clear();
            _loc3_.graphics.lineStyle(1,0,0);
            _loc3_.graphics.beginFill(16777215,0.5);
            _loc3_.graphics.moveTo(_loc4_,0);
            _loc3_.graphics.lineTo(_loc4_,_loc5_);
            _loc7_ = _loc1_ * (2 * Math.PI) - Math.PI / 2;
            _loc8_ = _loc6_ * Math.cos(_loc7_) + _loc4_;
            _loc9_ = _loc6_ * Math.sin(_loc7_) + _loc5_;
            _loc11_.drawArc(_loc4_,_loc5_,_loc6_,0,_loc1_,20,_loc3_);
            _loc3_.graphics.lineTo(_loc4_,_loc5_);
            _loc3_.graphics.endFill();
            if(_loc11_.gameObj.training)
            {
               _loc10_ = Math.ceil(_loc11_.gameObj.var_131.toppingRemaining / _loc11_.gameObj.var_131.toppingCapacity * 5);
               _loc11_.clip.timer_txt.text = _loc10_;
            }
            else
            {
               _loc11_.clip.timer_txt.text = "";
            }
         }
         else
         {
            _loc11_.clip.timer.inside.graphics.clear();
            _loc11_.clip.timer_txt.text = "";
         }
      }
      
      private function drawArc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:MovieClip) : void
      {
         var _loc8_:Number = Number(NaN);
         param4 -= 0.25;
         var _loc9_:Number = 2 * Math.PI;
         var _loc10_:Number = param5 / param6;
         var _loc11_:Number = param1 + Math.cos(param4 * _loc9_) * param3;
         var _loc12_:Number = param2 + Math.sin(param4 * _loc9_) * param3;
         param7.graphics.moveTo(_loc11_,_loc12_);
         var _loc13_:int = 1;
         while(_loc13_ <= param6)
         {
            _loc8_ = param4 + _loc13_ * _loc10_;
            _loc11_ = param1 + Math.cos(_loc8_ * _loc9_) * param3;
            _loc12_ = param2 + Math.sin(_loc8_ * _loc9_) * param3;
            param7.graphics.lineTo(_loc11_,_loc12_);
            _loc13_++;
         }
      }
      
      public function isCursorWithinFries() : Boolean
      {
         var checkx:Number = Number(NaN);
         var checky:Number = Number(NaN);
         var ob:ToppingSpoon = this;
         var screen:FryScreen = ob.gameObj.var_131;
         var returnBool:Boolean = false;
         try
         {
            if(Boolean(screen.currentOrder) && Boolean(screen.currentOrder.fries))
            {
               checkx = ob.shadow.x - screen.currentOrder.clip.x - screen.currentOrder.fries.clip.x - screen.currentOrder.fries.fryClip.x;
               checky = ob.shadow.y - screen.currentOrder.clip.y - screen.currentOrder.fries.clip.y - screen.currentOrder.fries.fryClip.x;
               if(screen.currentOrder.fries.fryTopping.isInsideFries(checkx,checky,false,true))
               {
                  returnBool = true;
               }
            }
         }
         catch(err:Error)
         {
            class_7.error("Error checking fry cursor: " + err.message);
         }
         return returnBool;
      }
   }
}


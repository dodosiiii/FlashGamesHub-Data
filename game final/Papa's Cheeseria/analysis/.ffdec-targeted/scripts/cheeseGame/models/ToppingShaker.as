package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.screens.FryScreen;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.filters.*;
   import flash.ui.*;
   import package_2.*;
   import package_4.class_5;
   
   public class ToppingShaker
   {
      
      public var gameObj:class_5;
      
      public var backContainer:MovieClip;
      
      public var topContainer:MovieClip;
      
      public var clip:MovieClip;
      
      public var shadow:MovieClip;
      
      public var type:String = "none";
      
      public var fromWhichSide:String = "left";
      
      public var isDragging:Boolean = false;
      
      public var isMoving:Boolean = false;
      
      public var tweenSpeed:Number = 2;
      
      public var returningToSpot:Boolean = false;
      
      public var droppingToSquirt:Boolean = false;
      
      public var raisingFromSquirt:Boolean = false;
      
      public var bottomPutAwayBounds:Number = 380;
      
      public var leftPutAwayBounds:Number = 85;
      
      public var rightPutAwayBounds:Number = 405;
      
      public var spotX:Number = 0;
      
      public var spotY:Number = 208;
      
      public var shakerSpotY:Number = 126;
      
      public var hidingX:Number = 0;
      
      public var hidingY:Number = 208;
      
      public var targetX:Number = 0;
      
      public var targetY:Number = 0;
      
      public var lastX:Number = 0;
      
      public var lastY:Number = 0;
      
      public var stackingBufferY:Number = 20;
      
      public var squirtDropHeight:Number = 20;
      
      public var boundsLeft:Number = 120;
      
      public var boundsRight:Number = 368;
      
      public var rotationSpeed:Number = 10;
      
      public var isRotating:Boolean = false;
      
      public var isShaker:Boolean = false;
      
      public var isPouring:Boolean = false;
      
      public var shakingOffset:Number = 0;
      
      public var shakingOffsetMax:Number = 10;
      
      public var shakingOffsetSpeed:Number = 2;
      
      public var shakingDirection:Number = 1;
      
      public var pourOffset:Number = 0;
      
      public var pourOffsetMax:Number = 60;
      
      public var pourOffsetSpeed:Number = 10;
      
      public var risingOffset:Number = 0;
      
      public var risingOffsetMax:Number = 35;
      
      public var risingOffsetSpeed:Number = 6;
      
      public var grabScale:Number = 1;
      
      public var grabScaleSpeed:Number = 0.05;
      
      public var shouldShowPutAway:Boolean = false;
      
      public function ToppingShaker(param1:class_5, param2:String, param3:MovieClip, param4:MovieClip, param5:Number, param6:Number)
      {
         var _loc7_:ToppingShaker = null;
         super();
         _loc7_ = this;
         _loc7_.gameObj = param1;
         _loc7_.type = param2;
         _loc7_.backContainer = param3;
         _loc7_.topContainer = param4;
         if(FoodData.isShaker(param2))
         {
            _loc7_.isShaker = true;
            _loc7_.risingOffsetMax = 28;
         }
         else
         {
            _loc7_.risingOffsetMax = 48;
         }
         _loc7_.risingOffsetMax += 20;
         _loc7_.spotX = param5;
         _loc7_.spotY = param6;
         _loc7_.hidingX = param5;
         _loc7_.hidingY = param6;
         _loc7_.setupBottle();
      }
      
      public function setupBottle() : void
      {
         var _loc1_:GlowFilter = null;
         var _loc2_:ToppingShaker = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(_loc2_.isShaker)
         {
            _loc2_.clip = class_12.method_103("fryshaker_" + _loc2_.type,true,true);
         }
         else
         {
            _loc2_.clip = class_12.method_103("frysauce_" + _loc2_.type,true,true);
         }
         _loc2_.backContainer.addChild(_loc2_.clip);
         _loc2_.clip.x = _loc2_.spotX;
         _loc2_.clip.y = _loc2_.spotY;
         _loc2_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.selectBottle);
         _loc2_.clip.addEventListener(MouseEvent.ROLL_OVER,_loc2_.rolloverBottle);
         _loc2_.clip.addEventListener(MouseEvent.ROLL_OUT,_loc2_.rolloutBottle);
         _loc2_.clip.icon.gotoAndStop("start");
         _loc2_.clip.mouseEnabled = true;
         _loc2_.clip.buttonMode = true;
         _loc2_.clip.useHandCursor = true;
         _loc2_.isDragging = false;
         _loc2_.isMoving = false;
         if(!_loc3_.hasTopping(_loc2_.type))
         {
            _loc2_.clip.visible = false;
         }
         _loc2_.clip.timer_txt.mouseEnabled = false;
         _loc2_.clip.timer_txt.text = "";
         _loc2_.clip.timer_txt.visible = false;
         if(_loc2_.gameObj.training)
         {
            _loc1_ = new GlowFilter(0,1,3,3,1000);
            _loc2_.clip.timer_txt.filters = [_loc1_];
         }
         _loc2_.shadow = new bottle_cursor();
         _loc2_.shadow.x = _loc2_.clip.x;
         _loc2_.shadow.y = _loc2_.clip.y + _loc2_.risingOffsetMax;
         _loc2_.shadow.mouseEnabled = false;
         _loc2_.shadow.mouseChildren = false;
         _loc2_.shadow.visible = false;
         _loc2_.topContainer.addChild(_loc2_.shadow);
      }
      
      public function selectBottle(param1:MouseEvent = null) : void
      {
         var _loc2_:ToppingShaker = this;
         if(!_loc2_.isMoving && !_loc2_.isDragging && _loc2_.gameObj.var_131.currentOrder != null && _loc2_.gameObj.var_131.currentOrder.isLeavingFry == false && _loc2_.gameObj.var_131.currentOrder.isDoneTopping == false && _loc2_.gameObj.var_131.currentOrder.isPouring() == false && _loc2_.gameObj.var_131.selectedTopping == "none")
         {
            if(_loc2_.gameObj.training == false)
            {
               _loc2_.risingOffset = 0;
               _loc2_.pourOffset = 0;
               _loc2_.gameObj.var_131.handlePreviousTopping(_loc2_.type);
               _loc2_.gameObj.var_131.setNewTopping(_loc2_.type);
               _loc2_.gameObj.var_131.isSelectingBottle = true;
               _loc2_.lastX = _loc2_.clip.x;
               _loc2_.lastY = _loc2_.clip.y;
               _loc2_.isDragging = true;
               _loc2_.shouldShowPutAway = false;
               _loc2_.topContainer.addChild(_loc2_.clip);
               if(!_loc2_.clip.hasEventListener(Event.ENTER_FRAME))
               {
                  _loc2_.clip.addEventListener(Event.ENTER_FRAME,this.animateBottle);
               }
               if(_loc2_.gameObj.hud.whichContextTraining == "season")
               {
                  _loc2_.gameObj.hud.removeContextTraining();
               }
               _loc2_.gameObj.var_129.playSound("grabtopping.wav");
               Mouse.hide();
            }
         }
         else if(_loc2_.isDragging)
         {
         }
      }
      
      public function putAwayBottle() : void
      {
         var _loc1_:ToppingShaker = this;
         class_7.method_1("Put away bottle.");
         _loc1_.isDragging = false;
         _loc1_.isMoving = true;
         _loc1_.targetX = _loc1_.spotX;
         _loc1_.targetY = _loc1_.spotY;
         _loc1_.returningToSpot = true;
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,this.animateBottle);
         }
         _loc1_.clip.gotoAndStop(1);
         _loc1_.clip.icon.gotoAndStop("start");
         try
         {
            _loc1_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc1_.releaseBottle);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc1_.gameObj.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBottle);
         }
         catch(err:Error)
         {
         }
         Mouse.show();
      }
      
      public function clickBottle(param1:MouseEvent = null) : void
      {
         var _loc2_:ToppingShaker = this;
         _loc2_.clip.gotoAndStop(2);
      }
      
      public function releaseBottle(param1:MouseEvent = null) : void
      {
      }
      
      public function setIcon(param1:String) : void
      {
         var _loc2_:ToppingShaker = this;
         if(_loc2_.clip.icon.currentLabel != param1)
         {
            _loc2_.clip.icon.gotoAndStop(param1);
            if(param1 == "none" || param1 == "start")
            {
               _loc2_.clip.gotoAndStop(2);
               if(_loc2_.gameObj.training)
               {
                  _loc2_.clip.timer_txt.visible = true;
               }
            }
            else
            {
               _loc2_.clip.gotoAndStop(1);
               _loc2_.clip.timer_txt.visible = false;
            }
         }
      }
      
      public function stopPouring() : void
      {
         var _loc1_:ToppingShaker = this;
         _loc1_.isPouring = false;
         _loc1_.clip.gotoAndStop(1);
         _loc1_.clip.icon.gotoAndStop("start");
         _loc1_.clip.timer_txt.text = "";
      }
      
      public function startPouring() : void
      {
         var _loc1_:ToppingShaker = this;
         _loc1_.isPouring = true;
      }
      
      public function dragBottle(param1:Event = null) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:ToppingShaker = this;
         _loc5_.clip.x = _loc5_.gameObj.mouseX;
         _loc5_.clip.y = _loc5_.gameObj.mouseY;
         if(_loc5_.clip.scaleX < _loc5_.grabScale)
         {
            _loc5_.clip.scaleX += _loc5_.grabScaleSpeed;
            _loc5_.clip.scaleY = _loc5_.clip.scaleX;
         }
         _loc5_.risingOffset += (_loc5_.risingOffsetMax - _loc5_.risingOffset) / 4;
         if(Math.abs(_loc5_.risingOffsetMax - _loc5_.risingOffset) <= 1)
         {
            _loc5_.risingOffset = _loc5_.risingOffsetMax;
         }
         else if(_loc5_.isPouring)
         {
            _loc5_.risingOffset = _loc5_.risingOffsetMax;
         }
         _loc5_.clip.y -= _loc5_.risingOffset;
         if(_loc5_.isShaker && _loc5_.isPouring)
         {
            if(_loc5_.clip.icon.currentLabel == "up")
            {
               try
               {
                  _loc2_ = _loc5_.gameObj.var_131.currentOrder.clip.x + _loc5_.gameObj.var_131.currentOrder.fries.clip.x - (_loc5_.clip.x + 45);
                  _loc3_ = _loc5_.gameObj.var_131.currentOrder.clip.y + _loc5_.gameObj.var_131.currentOrder.fries.clip.y - _loc5_.clip.y;
                  _loc4_ = Math.atan2(_loc3_,_loc2_);
                  _loc4_ = _loc4_ - Math.PI / 2;
                  _loc5_.clip.icon.pointer.rotation = _loc4_ * (180 / Math.PI);
               }
               catch(err:Error)
               {
               }
               if(_loc5_.pourOffset > 0)
               {
                  _loc5_.pourOffset /= 2;
                  if(Math.abs(this.pourOffset) <= 1)
                  {
                     _loc5_.pourOffset = 0;
                  }
               }
            }
            else
            {
               _loc5_.shakingOffset += _loc5_.shakingOffsetSpeed * _loc5_.shakingDirection;
               if(_loc5_.shakingOffset >= _loc5_.shakingOffsetMax)
               {
                  _loc5_.shakingOffset = _loc5_.shakingOffsetMax;
                  _loc5_.shakingDirection = -1;
               }
               else if(_loc5_.shakingOffset <= 0)
               {
                  _loc5_.shakingOffset = 0;
                  _loc5_.shakingDirection = 1;
               }
               _loc5_.clip.y += _loc5_.shakingOffset;
               if(_loc5_.pourOffset < _loc5_.pourOffsetMax)
               {
                  _loc5_.pourOffset += (_loc5_.pourOffsetMax - _loc5_.pourOffset) / 2;
                  if(Math.abs(_loc5_.pourOffsetMax - _loc5_.pourOffset) <= 1)
                  {
                     _loc5_.pourOffset = _loc5_.pourOffsetMax;
                  }
               }
            }
            _loc5_.clip.y -= _loc5_.pourOffset;
            _loc5_.shadow.visible = true;
            _loc5_.shadow.x = _loc5_.gameObj.mouseX;
            _loc5_.shadow.y = _loc5_.gameObj.mouseY;
         }
         else if(_loc5_.isShaker == false && _loc5_.isPouring)
         {
            if(_loc5_.clip.icon.currentLabel == "up")
            {
               try
               {
                  _loc2_ = _loc5_.gameObj.var_131.currentOrder.clip.x + _loc5_.gameObj.var_131.currentOrder.fries.clip.x - (_loc5_.clip.x - 45);
                  _loc3_ = _loc5_.gameObj.var_131.currentOrder.clip.y + _loc5_.gameObj.var_131.currentOrder.fries.clip.y - _loc5_.clip.y;
                  _loc4_ = Math.atan2(_loc3_,_loc2_);
                  _loc4_ = _loc4_ - Math.PI / 2;
                  _loc4_ = _loc4_ + Math.PI;
                  _loc5_.clip.icon.pointer.rotation = _loc4_ * (180 / Math.PI);
               }
               catch(err:Error)
               {
               }
               if(_loc5_.pourOffset > 0)
               {
                  _loc5_.pourOffset /= 2;
                  if(Math.abs(this.pourOffset) <= 1)
                  {
                     _loc5_.pourOffset = 0;
                  }
               }
            }
            else if(_loc5_.pourOffset < _loc5_.pourOffsetMax)
            {
               _loc5_.pourOffset += (_loc5_.pourOffsetMax - _loc5_.pourOffset) / 2;
               if(Math.abs(_loc5_.pourOffsetMax - _loc5_.pourOffset) <= 1)
               {
                  _loc5_.pourOffset = _loc5_.pourOffsetMax;
               }
            }
            _loc5_.clip.y -= _loc5_.pourOffset;
            _loc5_.shadow.visible = true;
            _loc5_.shadow.x = _loc5_.gameObj.mouseX;
            _loc5_.shadow.y = _loc5_.gameObj.mouseY;
         }
         else if(_loc5_.isDragging)
         {
            _loc5_.shadow.visible = true;
            _loc5_.shadow.x = _loc5_.gameObj.mouseX;
            _loc5_.shadow.y = _loc5_.gameObj.mouseY;
         }
         else
         {
            _loc5_.shadow.visible = false;
         }
         if(_loc5_.gameObj.mouseX < 170)
         {
            _loc5_.shouldShowPutAway = true;
         }
         if(_loc5_.gameObj.mouseX < 170 && !_loc5_.isPouring && _loc5_.shouldShowPutAway)
         {
            _loc5_.shadow.gotoAndStop(3);
         }
         else if(_loc5_.isCursorWithinFries())
         {
            _loc5_.shadow.gotoAndStop(1);
         }
         else
         {
            _loc5_.shadow.gotoAndStop(2);
         }
      }
      
      public function tweenBottle(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:ToppingShaker = this;
         if(!_loc4_.gameObj.var_169)
         {
            _loc2_ = _loc4_.targetX - _loc4_.clip.x;
            _loc3_ = _loc4_.targetY - _loc4_.clip.y;
            _loc4_.clip.x += _loc2_ / _loc4_.tweenSpeed;
            _loc4_.clip.y += _loc3_ / _loc4_.tweenSpeed;
            if(_loc4_.clip.scaleX > 1)
            {
               _loc4_.clip.scaleX -= _loc4_.grabScaleSpeed;
               _loc4_.clip.scaleY = _loc4_.clip.scaleX;
            }
            if(Math.abs(_loc2_) <= 1 && Math.abs(_loc3_) <= 1)
            {
               _loc4_.clip.x = _loc4_.targetX;
               _loc4_.clip.y = _loc4_.targetY;
               _loc4_.isMoving = false;
               _loc4_.clip.timer_txt.text = "";
               if(_loc4_.returningToSpot)
               {
                  _loc4_.returningToSpot = false;
                  if(!_loc4_.backContainer.contains(_loc4_.clip))
                  {
                     _loc4_.backContainer.addChild(_loc4_.clip);
                  }
               }
               else if(_loc4_.droppingToSquirt)
               {
                  _loc4_.droppingToSquirt = false;
                  _loc4_.raisingFromSquirt = true;
                  _loc4_.targetY = _loc4_.clip.y - _loc4_.squirtDropHeight;
                  _loc4_.isMoving = true;
               }
               else if(_loc4_.raisingFromSquirt)
               {
                  _loc4_.raisingFromSquirt = false;
                  _loc4_.targetX = _loc4_.spotX;
                  _loc4_.targetY = _loc4_.spotY;
                  _loc4_.isMoving = true;
               }
            }
            _loc4_.shadow.x = _loc4_.clip.x;
            _loc4_.shadow.y = _loc4_.clip.y + _loc4_.risingOffsetMax;
         }
      }
      
      public function animateBottle(param1:Event) : void
      {
         var _loc2_:ToppingShaker = this;
         if(_loc2_.isDragging)
         {
            _loc2_.dragBottle(param1);
            _loc2_.rotateBottle();
            _loc2_.updateTimerClock();
         }
         else if(_loc2_.isMoving)
         {
            _loc2_.tweenBottle(param1);
            _loc2_.rotateBottle();
            _loc2_.shadow.visible = false;
         }
         else if(_loc2_.isRotating)
         {
            _loc2_.rotateBottle();
         }
         else
         {
            _loc2_.clip.scaleX = 1;
            _loc2_.clip.scaleY = 1;
            _loc2_.shadow.visible = false;
            _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.animateBottle);
         }
      }
      
      public function rotateBottle() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:ToppingShaker = this;
         if(_loc2_.isDragging && !_loc2_.isShaker && (_loc2_.isPouring || _loc2_.gameObj.mouseX > 170) || _loc2_.isPouring && _loc2_.isShaker && _loc2_.clip.icon.currentLabel != "point" && _loc2_.clip.icon.currentLabel != "up" && _loc2_.clip.icon.currentLabel != "putaway")
         {
            if(_loc2_.clip.rotation < 180)
            {
               _loc1_ = 180 - _loc2_.clip.rotation;
               _loc2_.clip.rotation += _loc1_ / _loc2_.tweenSpeed;
               if(_loc1_ <= 1)
               {
                  _loc2_.clip.rotation = 180;
                  _loc2_.isRotating = false;
               }
               else
               {
                  _loc2_.isRotating = true;
               }
            }
            else
            {
               _loc2_.isRotating = false;
            }
         }
         else if(_loc2_.clip.rotation > 0)
         {
            _loc1_ = _loc2_.clip.rotation;
            _loc2_.clip.rotation -= _loc1_ / _loc2_.tweenSpeed;
            if(_loc1_ <= 1)
            {
               _loc2_.clip.rotation = 0;
               _loc2_.isRotating = false;
            }
            else
            {
               _loc2_.isRotating = true;
            }
         }
         else
         {
            _loc2_.isRotating = false;
         }
      }
      
      public function destroy() : void
      {
         var ob:ToppingShaker = this;
         if(ob.shadow)
         {
            if(ob.shadow.parent)
            {
               ob.shadow.parent.removeChild(ob.shadow);
            }
            ob.shadow = null;
         }
         if(ob.clip.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            ob.clip.removeEventListener(MouseEvent.MOUSE_DOWN,this.selectBottle);
         }
         try
         {
            ob.gameObj.removeEventListener(MouseEvent.MOUSE_UP,ob.releaseBottle);
         }
         catch(err:Error)
         {
         }
         ob.clip.removeEventListener(MouseEvent.ROLL_OVER,ob.rolloverBottle);
         ob.clip.removeEventListener(MouseEvent.ROLL_OUT,ob.rolloutBottle);
         if(ob.clip.hasEventListener(Event.ENTER_FRAME))
         {
            ob.clip.removeEventListener(Event.ENTER_FRAME,this.animateBottle);
         }
         try
         {
            ob.clip.parent.removeChild(ob.clip);
         }
         catch(err:Error)
         {
            class_7.error("Error removing saucebottle clip.");
         }
         ob.clip = null;
      }
      
      public function hideBottle() : void
      {
         var _loc1_:ToppingShaker = this;
         _loc1_.isMoving = true;
         _loc1_.targetX = _loc1_.hidingX;
         _loc1_.targetY = _loc1_.hidingY;
         _loc1_.returningToSpot = true;
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,this.animateBottle);
         }
      }
      
      public function showBottle() : void
      {
         var _loc1_:ToppingShaker = this;
         _loc1_.isMoving = true;
         _loc1_.targetX = _loc1_.spotX;
         _loc1_.targetY = _loc1_.spotY;
         _loc1_.returningToSpot = true;
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,this.animateBottle);
         }
      }
      
      public function rolloverBottle(param1:MouseEvent = null) : void
      {
         var _loc2_:ToppingShaker = this;
         if(!_loc2_.isMoving && !_loc2_.isDragging && (_loc2_.gameObj.var_131.currentOrder == null || !_loc2_.gameObj.var_131.currentOrder.isPouring() && !_loc2_.gameObj.var_131.currentOrder.isDoneTopping) && !_loc2_.gameObj.var_131.isSelectingBottle)
         {
            _loc2_.clip.y = _loc2_.spotY - 2;
         }
      }
      
      public function rolloutBottle(param1:MouseEvent = null) : void
      {
         var _loc2_:ToppingShaker = this;
         if(!_loc2_.isMoving && !_loc2_.isDragging)
         {
            _loc2_.clip.y = _loc2_.spotY;
         }
      }
      
      public function updateTimerClock() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:ToppingShaker = this;
         if(_loc2_.gameObj.training)
         {
            _loc1_ = Math.ceil(_loc2_.gameObj.var_131.toppingRemaining / _loc2_.gameObj.var_131.toppingCapacity * 5);
            _loc2_.clip.timer_txt.text = _loc1_;
            if(!_loc2_.isPouring)
            {
               _loc2_.clip.timer_txt.text = "";
            }
         }
         else
         {
            _loc2_.clip.timer_txt.text = "";
         }
      }
      
      public function isCursorWithinFries() : Boolean
      {
         var checkx:Number = Number(NaN);
         var checky:Number = Number(NaN);
         var ob:ToppingShaker = this;
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


package cheeseGame.models
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class FryerBasket
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var fryType:String = null;
      
      public var grillX:Number = 0;
      
      public var grillY:Number = 0;
      
      public var isDragging:Boolean = false;
      
      public var isReturning:Boolean = false;
      
      public var dragDist:Number = 14;
      
      public var dragStartX:Number = 0;
      
      public var dragStartY:Number = 0;
      
      public var isDraggingMoving:Boolean = false;
      
      public var isRaisedUp:Boolean = false;
      
      public var isRollingOver:Boolean = false;
      
      public var isCooking:Boolean = false;
      
      public var isDumping:Boolean = false;
      
      public var isThrowingAway:Boolean = false;
      
      public var cookTime:Number = 0;
      
      public var spriteSheet:BitmapData;
      
      public var frySprite:BitmapData;
      
      public var fryBitmap:Bitmap;
      
      public var frySpriteWidth:Number = 113;
      
      public var frySpriteHeight:Number = 106;
      
      public var fryCookLevels:Number = 9;
      
      public var currentFryFrame:Number = 1;
      
      public var meatSpritePadX:Number = 3;
      
      public var meatScale:Number = 0.4;
      
      public var basketBoundsStartX:Number = 188;
      
      public var basketBoundsSpacingX:Number = 145;
      
      public var basketBoundsStartY:Number = 59;
      
      public var basketBoundsSpacingY:Number = 0;
      
      public var pourTargetX:Number = 182;
      
      public var pourTargetY:Number = 339;
      
      public var throwawayTargetX:Number = 30;
      
      public var throwawayTargetY:Number = 234;
      
      public var hasAlarm:Boolean = false;
      
      public var alarmIsSounding:Boolean = false;
      
      public var tweenSpeed:Number = 2;
      
      public var timerBounds:Number = 58;
      
      public var maxMeterTime:Number = 3600;
      
      public var downFrame:Number = 1;
      
      public var rolloverFrame:Number = 5;
      
      public var dragFrame:Number = 8;
      
      public var sidewaysFrame:Number = 15;
      
      public var pourFrame:Number = 16;
      
      public var dumpFrame:Number = 27;
      
      public var timeAllowRollover:Number = 20;
      
      public var isFilling:Boolean = false;
      
      public var fillTimer:Number = 0;
      
      public var fillTimerAdd:Number = 20;
      
      public var fillTimerMax:Number = 40;
      
      public function FryerBasket(param1:class_5, param2:MovieClip, param3:Number, param4:Number)
      {
         var _loc5_:FryerBasket = null;
         super();
         _loc5_ = this;
         _loc5_.gameObj = param1;
         _loc5_.clip = param2;
         _loc5_.grillX = param3;
         _loc5_.grillY = param4;
         _loc5_.setupBasket();
      }
      
      public function setupBasket() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.clip.buttonMode = true;
         _loc1_.clip.useHandCursor = true;
         _loc1_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBasket);
         _loc1_.clip.handle1.gotoAndStop(2);
         _loc1_.clip.handle2.gotoAndStop(2);
         _loc1_.clip.handle_3.gotoAndStop(2);
         _loc1_.clip.handle_4.gotoAndStop(2);
         _loc1_.clip.handle_5.gotoAndStop(2);
         _loc1_.clip.handle_6.gotoAndStop(2);
         _loc1_.clip.handle_7.gotoAndStop(2);
         _loc1_.clip.frymeter.greenbar.mask = _loc1_.clip.frymeter.masker;
         _loc1_.clip.frymeter.greenbar.y = _loc1_.timerBounds;
         _loc1_.clip.frymeter.whitebar.visible = false;
         _loc1_.clip.counter.bells.stop();
         _loc1_.clip.counter.bells.visible = false;
         _loc1_.clip.counter.num_txt.text = "";
         _loc1_.clip.gotoAndStop(_loc1_.rolloverFrame);
         _loc1_.clip.oil.gotoAndStop("static");
         _loc1_.clip.oil.boostboil.stop();
         _loc1_.clip.oil.boostboil.visible = false;
         _loc1_.maxMeterTime = FoodData.getFryMaxCookTime();
      }
      
      public function enableAlarm() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.clip.counter.bells.visible = true;
         _loc1_.hasAlarm = true;
      }
      
      public function startAlarmBells() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.clip.counter.bells.gotoAndPlay(2);
      }
      
      public function stopAlarmBells() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.clip.counter.bells.gotoAndStop(1);
      }
      
      public function addFries(param1:String) : void
      {
         var _loc2_:FryerBasket = this;
         _loc2_.fryType = param1;
         _loc2_.cookTime = 0;
         _loc2_.createFryGraphic();
         var _loc3_:Number = 1;
         if(_loc2_.fryType == FoodData.FRIES_CRINKLE)
         {
            _loc3_ = 6;
         }
         else if(_loc2_.fryType == FoodData.FRIES_CURLY)
         {
            _loc3_ = 1;
         }
         else if(_loc2_.fryType == FoodData.FRIES_REGULAR)
         {
            _loc3_ = 4;
         }
         else if(_loc2_.fryType == FoodData.FRIES_WAFFLE)
         {
            _loc3_ = 2;
         }
         else if(_loc2_.fryType == FoodData.FRIES_SWEETPOTATO)
         {
            _loc3_ = 5;
         }
         _loc2_.clip.handle1.gotoAndStop(_loc3_);
         _loc2_.clip.handle2.gotoAndStop(_loc3_);
         _loc2_.clip.handle_3.gotoAndStop(_loc3_);
         _loc2_.clip.handle_4.gotoAndStop(_loc3_);
         _loc2_.clip.handle_5.gotoAndStop(_loc3_);
         _loc2_.clip.handle_6.gotoAndStop(_loc3_);
         _loc2_.clip.handle_7.gotoAndStop(_loc3_);
         _loc2_.clip.counter.num_txt.text = "";
         _loc2_.clip.frymeter.whitebar.visible = true;
         _loc2_.clip.frymeter.greenbar.gotoAndStop(1);
         _loc2_.clip.frymeter.whitebar.y = _loc2_.timerBounds - FoodData.getFryTargetCookTime() / _loc2_.maxMeterTime * _loc2_.timerBounds;
         _loc2_.clip.frylid.visible = false;
         _loc2_.isRaisedUp = false;
         _loc2_.gameObj.var_129.playSound("dumpwings.wav");
      }
      
      public function lowerBasketIntoOil() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.isCooking = true;
         _loc1_.clip.oil.gotoAndPlay("rise");
         if(_loc1_.gameObj.var_131.isActive)
         {
            _loc1_.gameObj.var_129.playSound("fryer_dropoil.wav");
         }
         else
         {
            _loc1_.gameObj.var_129.playSound("fryer_dropoil.wav",false,0.4);
         }
         if(_loc1_.gameObj.var_128.currentDay >= 2 && _loc1_.gameObj.var_128.hasTrained("pausefries") == false && _loc1_.grillX == 0 && _loc1_.gameObj.hud.currentStation == "fry")
         {
            _loc1_.gameObj.hud.showContextTraining("pausefries");
         }
         else if(!_loc1_.gameObj.var_128.hasTrained("boost") && _loc1_.gameObj.var_128.hasBonus("fryboost" + _loc1_.grillX) && _loc1_.gameObj.hud.currentStation == "fry")
         {
            _loc1_.gameObj.hud.showContextTraining("boost");
         }
      }
      
      public function createFryGraphic() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Matrix = null;
         var _loc3_:FryerBasket = this;
         var _loc4_:Number = Number(getTimer());
         if(_loc3_.spriteSheet)
         {
            _loc3_.spriteSheet.fillRect(_loc3_.spriteSheet.rect,0);
         }
         else
         {
            _loc3_.spriteSheet = new BitmapData(_loc3_.frySpriteWidth * _loc3_.fryCookLevels,_loc3_.frySpriteHeight,true,0);
         }
         if(_loc3_.frySprite)
         {
            _loc3_.frySprite.fillRect(_loc3_.frySprite.rect,0);
         }
         else
         {
            _loc3_.frySprite = new BitmapData(_loc3_.frySpriteWidth,_loc3_.frySpriteHeight,true,0);
            _loc3_.fryBitmap = new Bitmap(_loc3_.frySprite);
            _loc3_.fryBitmap.scaleX = 0.85;
            _loc3_.fryBitmap.scaleY = 0.85;
            _loc3_.clip.meatholder.addChild(_loc3_.fryBitmap);
         }
         var _loc5_:MovieClip = class_12.method_103(_loc3_.fryType + "_basket",false,false);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.fryCookLevels)
         {
            _loc5_.gotoAndStop(_loc1_ + 1);
            _loc2_ = new Matrix();
            _loc2_.scale(1.18,1.18);
            _loc2_.translate(_loc1_ * _loc3_.frySpriteWidth,0);
            _loc3_.spriteSheet.draw(_loc5_,_loc2_);
            _loc1_++;
         }
         _loc3_.frySprite.copyPixels(_loc3_.spriteSheet,new Rectangle(0,0,_loc3_.frySpriteWidth,_loc3_.frySpriteHeight),new Point(0,0));
         _loc3_.currentFryFrame = 1;
         _loc5_ = null;
         var _loc6_:Number = getTimer() - _loc4_;
         class_7.method_1("Create Sprite Duration: " + _loc6_ + " ms.  Sprite Sheet W/H: " + _loc3_.spriteSheet.width + ", " + _loc3_.spriteSheet.height);
      }
      
      public function updateFryGraphic() : void
      {
         var _loc1_:FryerBasket = this;
         var _loc2_:Number = _loc1_.cookTime / FoodData.getFryMaxCookTime();
         var _loc3_:Number = Math.min(_loc1_.fryCookLevels,Math.floor(_loc2_ * (_loc1_.fryCookLevels - 1)) + 1);
         if(_loc1_.currentFryFrame != _loc3_)
         {
            _loc1_.frySprite.copyPixels(_loc1_.spriteSheet,new Rectangle((_loc3_ - 1) * _loc1_.frySpriteWidth,0,_loc1_.frySpriteWidth,_loc1_.frySpriteHeight),new Point(0,0));
            _loc1_.currentFryFrame = _loc3_;
         }
         if(_loc3_ == Math.ceil(_loc1_.fryCookLevels / 2) && _loc1_.hasAlarm && !_loc1_.alarmIsSounding)
         {
            _loc1_.gameObj.var_131.soundAlarm(_loc1_.grillX,_loc1_.grillY);
            _loc1_.startAlarmBells();
            _loc1_.alarmIsSounding = true;
         }
         else if(_loc3_ == Math.ceil(_loc1_.fryCookLevels / 2) && _loc1_.gameObj.method_111(20))
         {
            _loc1_.gameObj.method_104(20);
         }
      }
      
      public function updateMeter() : void
      {
         var _loc1_:FryerBasket = this;
         var _loc2_:Number = _loc1_.cookTime / _loc1_.maxMeterTime;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         _loc1_.clip.frymeter.greenbar.y = _loc1_.timerBounds - _loc2_ * _loc1_.timerBounds;
         if(_loc1_.clip.frymeter.greenbar.currentFrame != 1)
         {
            _loc1_.clip.frymeter.greenbar.gotoAndStop(1);
         }
      }
      
      public function startCooking() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.isCooking = true;
      }
      
      public function isFree() : Boolean
      {
         var _loc1_:FryerBasket = this;
         var _loc2_:Boolean = true;
         if(_loc1_.fryType == FoodData.FRIES_CRINKLE || _loc1_.fryType == FoodData.FRIES_CURLY || _loc1_.fryType == FoodData.FRIES_REGULAR || _loc1_.fryType == FoodData.FRIES_SWEETPOTATO || _loc1_.fryType == FoodData.FRIES_WAFFLE)
         {
            _loc2_ = false;
         }
         else if(_loc1_.isDragging || _loc1_.isReturning)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function getFryType() : String
      {
         var _loc1_:FryerBasket = this;
         return _loc1_.fryType;
      }
      
      public function destroy() : void
      {
         var _loc1_:FryerBasket = this;
         if(_loc1_.fryBitmap)
         {
            _loc1_.fryBitmap.bitmapData = null;
            _loc1_.clip.meatholder.removeChild(_loc1_.fryBitmap);
            _loc1_.fryBitmap = null;
         }
         if(_loc1_.frySprite)
         {
            _loc1_.frySprite.dispose();
            _loc1_.frySprite = null;
         }
         if(_loc1_.spriteSheet)
         {
            _loc1_.spriteSheet.dispose();
            _loc1_.spriteSheet = null;
         }
         _loc1_.setupLid(false);
         _loc1_.clip.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBasket);
         _loc1_.clip = null;
      }
      
      public function clickBasket(param1:MouseEvent) : void
      {
         var _loc2_:FryerBasket = this;
         if(!_loc2_.gameObj.training || _loc2_.gameObj.method_111(21))
         {
            if(!_loc2_.isDumping && !_loc2_.isDragging && !_loc2_.isReturning && !_loc2_.isFree() && !_loc2_.isFilling)
            {
               _loc2_.gameObj.var_131.clip.topholder.addChild(_loc2_.clip);
               _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseBasket);
               _loc2_.isDragging = true;
               _loc2_.isDraggingMoving = false;
               _loc2_.dragStartX = _loc2_.gameObj.var_131.clip.mouseX;
               _loc2_.dragStartY = _loc2_.gameObj.var_131.clip.mouseY;
               _loc2_.isCooking = false;
               _loc2_.isRollingOver = false;
               _loc2_.isReturning = false;
               if(!_loc2_.isRaisedUp)
               {
                  _loc2_.clip.oil.gotoAndPlay("fall");
               }
               _loc2_.clip.oil.boostboil.stop();
               _loc2_.clip.oil.boostboil.visible = false;
               if(_loc2_.alarmIsSounding)
               {
                  _loc2_.alarmIsSounding = false;
                  _loc2_.gameObj.var_131.stopAlarm(_loc2_.grillX,_loc2_.grillY);
                  _loc2_.stopAlarmBells();
               }
               _loc2_.gameObj.var_129.playSound("fryer_pickup.wav");
            }
         }
         else if(_loc2_.gameObj.training && _loc2_.gameObj.method_111(20) && !_loc2_.isFilling)
         {
            _loc2_.gameObj.hud.showTrainingWarning("waitfries");
         }
      }
      
      public function releaseBasket(param1:MouseEvent) : void
      {
         var _loc2_:FryerBasket = this;
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseBasket);
         _loc2_.gameObj.var_131.isDraggingBasket = false;
         _loc2_.clip.stopDrag();
         _loc2_.isDragging = false;
         if(!_loc2_.isDraggingMoving)
         {
            if(_loc2_.isRaisedUp)
            {
               _loc2_.isCooking = true;
               _loc2_.isRaisedUp = false;
               _loc2_.clip.oil.gotoAndPlay("rise");
               _loc2_.gameObj.var_129.playSound("fryer_dropoil.wav",false,0.8);
               if(_loc2_.gameObj.var_131.clip.basketholder.contains(_loc2_.clip) == false)
               {
                  _loc2_.gameObj.var_131.clip.basketholder.addChild(_loc2_.clip);
               }
               if(_loc2_.gameObj.hud.whichContextTraining == "dropfries")
               {
                  _loc2_.gameObj.var_128.setTrained("dropfries");
                  _loc2_.gameObj.hud.removeContextTraining();
               }
            }
            else
            {
               _loc2_.isCooking = false;
               _loc2_.isRaisedUp = true;
               if(_loc2_.gameObj.hud.whichContextTraining == "pausefries")
               {
                  _loc2_.gameObj.var_128.setTrained("pausefries");
                  _loc2_.gameObj.hud.removeContextTraining();
                  _loc2_.gameObj.hud.showContextTraining("dropfries");
               }
            }
         }
         else if(_loc2_.gameObj.var_131.currentOrder != null && _loc2_.gameObj.var_131.currentOrder.fries == null && _loc2_.clip.x >= 98 && _loc2_.clip.x <= 328 && _loc2_.clip.y >= 160 && _loc2_.clip.y <= 330)
         {
            _loc2_.isDumping = true;
            _loc2_.gameObj.var_131.isPouringFries = true;
            _loc2_.clip.gotoAndPlay(_loc2_.pourFrame);
            _loc2_.gameObj.var_129.playSound("dumpwings.wav");
         }
         else if(_loc2_.clip.x <= 80 && _loc2_.clip.y > 98 && _loc2_.clip.y < 238 && _loc2_.fryType != null)
         {
            if(!_loc2_.gameObj.training)
            {
               _loc2_.isThrowingAway = true;
               _loc2_.gameObj.var_131.isThrowingAwayFries = true;
               _loc2_.clip.gotoAndPlay(_loc2_.pourFrame);
               _loc2_.gameObj.var_129.playSound("dumpwings.wav");
            }
            else
            {
               _loc2_.gameObj.hud.showTrainingWarning("garbage");
               _loc2_.isReturning = true;
            }
         }
         else
         {
            class_7.method_1("Nothing. X/Y: " + _loc2_.clip.x + ", " + _loc2_.clip.y);
            _loc2_.isReturning = true;
         }
         _loc2_.isDraggingMoving = false;
      }
      
      public function resetBasket() : void
      {
         var _loc1_:FryerBasket = this;
         _loc1_.fryType = null;
         _loc1_.clip.counter.num_txt.text = "";
         _loc1_.clip.frymeter.greenbar.y = _loc1_.timerBounds;
         _loc1_.clip.frymeter.greenbar.gotoAndStop(2);
         if(_loc1_.frySprite != null)
         {
            _loc1_.frySprite.fillRect(_loc1_.frySprite.rect,0);
         }
         _loc1_.clip.handle1.gotoAndStop(2);
         _loc1_.clip.handle2.gotoAndStop(2);
         _loc1_.clip.handle_3.gotoAndStop(2);
         _loc1_.clip.handle_4.gotoAndStop(2);
         _loc1_.clip.handle_5.gotoAndStop(2);
         _loc1_.clip.handle_6.gotoAndStop(2);
         _loc1_.clip.handle_7.gotoAndStop(2);
         _loc1_.clip.frymeter.whitebar.visible = false;
         _loc1_.isCooking = false;
         _loc1_.isDumping = false;
         _loc1_.isDragging = false;
         _loc1_.isThrowingAway = false;
         _loc1_.isRollingOver = false;
         _loc1_.isReturning = true;
         _loc1_.clip.frylid.visible = true;
      }
      
      public function updateBasket() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:FryerBasket = this;
         if(_loc12_.isRollingOver && _loc12_.isCooking && _loc12_.clip.currentFrame < _loc12_.rolloverFrame)
         {
            _loc12_.clip.nextFrame();
         }
         else if(_loc12_.isRollingOver && _loc12_.isCooking && _loc12_.clip.currentFrame > _loc12_.rolloverFrame)
         {
            _loc12_.clip.prevFrame();
         }
         else if(!_loc12_.isCooking && _loc12_.isFree() && !_loc12_.isReturning && !_loc12_.isDragging && _loc12_.clip.currentFrame > _loc12_.rolloverFrame)
         {
            _loc12_.clip.prevFrame();
         }
         else if(_loc12_.isFilling)
         {
            ++_loc12_.fillTimer;
            if(_loc12_.fillTimer == _loc12_.fillTimerAdd)
            {
               _loc12_.addFries(_loc12_.fryType);
            }
            else if(_loc12_.fillTimer >= _loc12_.fillTimerMax)
            {
               _loc12_.isFilling = false;
               _loc12_.fillTimer = 0;
               _loc12_.lowerBasketIntoOil();
            }
         }
         else if(!_loc12_.isRollingOver && !_loc12_.isRaisedUp && _loc12_.isCooking && !_loc12_.isDragging && !_loc12_.isReturning && !_loc12_.isDumping && !_loc12_.isThrowingAway && _loc12_.clip.currentFrame > _loc12_.downFrame)
         {
            if(_loc12_.clip.currentFrame > _loc12_.dragFrame)
            {
               _loc12_.clip.gotoAndStop(_loc12_.dragFrame);
            }
            else
            {
               _loc12_.clip.prevFrame();
            }
         }
         else if(_loc12_.isDragging)
         {
            if(_loc12_.isDraggingMoving == false)
            {
               _loc1_ = _loc12_.gameObj.var_131.clip.mouseX - _loc12_.dragStartX;
               _loc2_ = _loc12_.gameObj.var_131.clip.mouseY - _loc12_.dragStartY;
               _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
               if(_loc3_ >= _loc12_.dragDist)
               {
                  _loc12_.isDraggingMoving = true;
                  _loc12_.gameObj.var_131.isDraggingBasket = true;
                  _loc12_.clip.startDrag();
               }
            }
            if(_loc12_.clip.currentFrame < _loc12_.rolloverFrame && !_loc12_.isDraggingMoving)
            {
               _loc12_.clip.nextFrame();
            }
            else if(_loc12_.clip.currentFrame < _loc12_.sidewaysFrame && _loc12_.isDraggingMoving == true)
            {
               _loc12_.clip.nextFrame();
            }
            if(_loc12_.gameObj.mouseX < 0 || _loc12_.gameObj.mouseX > 640 || _loc12_.gameObj.mouseY < 0 || _loc12_.gameObj.mouseY > 480)
            {
               _loc12_.releaseBasket(null);
            }
         }
         else if(_loc12_.isReturning)
         {
            _loc4_ = _loc12_.basketBoundsStartX + _loc12_.grillX * _loc12_.basketBoundsSpacingX;
            _loc5_ = _loc12_.basketBoundsStartY + _loc12_.grillY * _loc12_.basketBoundsSpacingY;
            _loc6_ = _loc4_ - _loc12_.clip.x;
            _loc7_ = _loc5_ - _loc12_.clip.y;
            _loc12_.clip.x += _loc6_ / _loc12_.tweenSpeed;
            _loc12_.clip.y += _loc7_ / _loc12_.tweenSpeed;
            if(_loc12_.clip.currentFrame > _loc12_.dragFrame)
            {
               _loc12_.clip.prevFrame();
            }
            else if(_loc12_.clip.currentFrame < _loc12_.dragFrame)
            {
               _loc12_.clip.gotoAndStop(_loc12_.dragFrame);
            }
            if(Math.abs(_loc6_) <= 1 && Math.abs(_loc7_) <= 1 && _loc12_.clip.currentFrame == _loc12_.dragFrame)
            {
               _loc12_.clip.x = _loc4_;
               _loc12_.clip.y = _loc5_;
               _loc12_.gameObj.var_131.clip.basketholder.addChild(_loc12_.clip);
               _loc12_.isReturning = false;
               _loc12_.gameObj.var_129.playSound("fryer_return.wav");
               if(!_loc12_.isFree() && !_loc12_.isRaisedUp)
               {
                  _loc12_.isCooking = true;
                  _loc12_.clip.oil.gotoAndPlay("rise");
                  _loc12_.gameObj.var_129.playSound("fryer_dropoil.wav");
               }
            }
         }
         else if(_loc12_.isDumping)
         {
            _loc8_ = _loc12_.pourTargetX - _loc12_.clip.x;
            _loc9_ = _loc12_.pourTargetY - _loc12_.clip.y;
            _loc12_.clip.x += _loc8_ / _loc12_.tweenSpeed;
            _loc12_.clip.y += _loc9_ / _loc12_.tweenSpeed;
            if(Math.abs(_loc8_) <= 1 && Math.abs(_loc9_) <= 1)
            {
               _loc12_.clip.x = _loc12_.pourTargetX;
               _loc12_.clip.y = _loc12_.pourTargetY;
            }
            if(_loc12_.clip.currentFrame == _loc12_.clip.totalFrames)
            {
               _loc12_.resetBasket();
               _loc12_.gameObj.var_131.isPouringFries = false;
            }
            else if(_loc12_.clip.currentFrame == _loc12_.dumpFrame)
            {
               if(Boolean(_loc12_.gameObj.var_131.currentOrder) && _loc12_.gameObj.var_131.currentOrder.fries == null)
               {
                  _loc12_.gameObj.var_131.currentOrder.addFries(_loc12_.fryType,_loc12_.cookTime,_loc12_.currentFryFrame);
               }
            }
         }
         else if(_loc12_.isThrowingAway)
         {
            _loc10_ = _loc12_.throwawayTargetX - _loc12_.clip.x;
            _loc11_ = _loc12_.throwawayTargetY - _loc12_.clip.y;
            _loc12_.clip.x += _loc10_ / _loc12_.tweenSpeed;
            _loc12_.clip.y += _loc11_ / _loc12_.tweenSpeed;
            if(Math.abs(_loc10_) <= 1 && Math.abs(_loc11_) <= 1)
            {
               _loc12_.clip.x = _loc12_.throwawayTargetX;
               _loc12_.clip.y = _loc12_.throwawayTargetY;
            }
            if(_loc12_.clip.currentFrame == _loc12_.clip.totalFrames)
            {
               _loc12_.resetBasket();
               _loc12_.gameObj.var_131.isThrowingAwayFries = false;
            }
            else if(_loc12_.clip.currentFrame == _loc12_.dumpFrame)
            {
               _loc12_.gameObj.var_131.throwAwayFries(_loc12_.fryType,_loc12_.currentFryFrame);
            }
         }
         else if(_loc12_.isRaisedUp && _loc12_.clip.currentFrame < _loc12_.rolloverFrame)
         {
            _loc12_.clip.nextFrame();
         }
         else if(_loc12_.isRaisedUp && _loc12_.clip.currentFrame > _loc12_.rolloverFrame)
         {
            _loc12_.clip.prevFrame();
         }
         if(_loc12_.isCooking && !_loc12_.isRollingOver && !_loc12_.isRaisedUp && !_loc12_.isDragging)
         {
            ++_loc12_.cookTime;
            if(_loc12_.gameObj.var_128.currentDay == 1)
            {
               _loc12_.cookTime += 2;
            }
            if(_loc12_.gameObj.var_131.isBoosting && _loc12_.gameObj.var_131.boostingWhich == _loc12_.grillX)
            {
               ++_loc12_.cookTime;
               _loc12_.clip.frymeter.bg.gotoAndStop(2);
               _loc12_.clip.oil.boostboil.play();
               _loc12_.clip.oil.boostboil.visible = true;
            }
            else if(_loc12_.clip.frymeter.bg.currentFrame != 1)
            {
               _loc12_.clip.frymeter.bg.gotoAndStop(1);
               _loc12_.clip.oil.boostboil.stop();
               _loc12_.clip.oil.boostboil.visible = false;
            }
            _loc12_.updateFryGraphic();
            _loc12_.updateMeter();
         }
         else if(_loc12_.clip.frymeter.greenbar.currentFrame != 2)
         {
            _loc12_.clip.frymeter.greenbar.gotoAndStop(2);
            _loc12_.clip.frymeter.bg.gotoAndStop(1);
         }
      }
      
      public function initUpgrades() : void
      {
         var _loc1_:FryerBasket = this;
         if(_loc1_.gameObj.var_128.hasBonus("fryalarm" + _loc1_.grillX))
         {
            _loc1_.enableAlarm();
         }
         _loc1_.setupLid();
      }
      
      public function setupLid(param1:Boolean = true) : void
      {
         var _loc2_:FryerBasket = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(param1)
         {
            if(_loc3_.hasTopping(FoodData.FRIES_REGULAR))
            {
               _loc2_.clip.frylid.fry_regular_chooser.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
               _loc2_.clip.frylid.gotoAndStop(2);
            }
            else
            {
               _loc2_.clip.frylid.fry_regular_chooser.visible = false;
               _loc2_.clip.frylid.fry_regular_chooser.mouseEnabled = false;
            }
            if(_loc3_.hasTopping(FoodData.FRIES_CURLY))
            {
               _loc2_.clip.frylid.fry_curly_chooser.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
               _loc2_.clip.frylid.gotoAndStop(2);
            }
            else
            {
               _loc2_.clip.frylid.fry_curly_chooser.visible = false;
               _loc2_.clip.frylid.fry_curly_chooser.mouseEnabled = false;
            }
            if(_loc3_.hasTopping(FoodData.FRIES_WAFFLE))
            {
               _loc2_.clip.frylid.fry_waffle_chooser.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
               _loc2_.clip.frylid.gotoAndStop(3);
            }
            else
            {
               _loc2_.clip.frylid.fry_waffle_chooser.visible = false;
               _loc2_.clip.frylid.fry_waffle_chooser.mouseEnabled = false;
            }
            if(_loc3_.hasTopping(FoodData.FRIES_SWEETPOTATO))
            {
               _loc2_.clip.frylid.fry_sweetpotatowedges_chooser.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
               _loc2_.clip.frylid.gotoAndStop(4);
            }
            else
            {
               _loc2_.clip.frylid.fry_sweetpotatowedges_chooser.visible = false;
               _loc2_.clip.frylid.fry_sweetpotatowedges_chooser.mouseEnabled = false;
            }
            if(_loc3_.hasTopping(FoodData.FRIES_CRINKLE))
            {
               _loc2_.clip.frylid.fry_crinkle_chooser.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
               _loc2_.clip.frylid.gotoAndStop(5);
            }
            else
            {
               _loc2_.clip.frylid.fry_crinkle_chooser.visible = false;
               _loc2_.clip.frylid.fry_crinkle_chooser.mouseEnabled = false;
            }
         }
         else
         {
            _loc2_.clip.frylid.fry_regular_chooser.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
            _loc2_.clip.frylid.fry_curly_chooser.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
            _loc2_.clip.frylid.fry_waffle_chooser.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
            _loc2_.clip.frylid.fry_sweetpotatowedges_chooser.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
            _loc2_.clip.frylid.fry_crinkle_chooser.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickChooseFryType);
         }
      }
      
      public function clickChooseFryType(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:FryerBasket = this;
         if(_loc3_.fryType == null && !_loc3_.isDragging && !_loc3_.isReturning && !_loc3_.isDumping && !_loc3_.isThrowingAway && !_loc3_.isCooking)
         {
            _loc2_ = String(param1.currentTarget.name).split("_chooser")[0];
            if(!_loc3_.gameObj.training || _loc3_.grillX == 0 && _loc3_.gameObj.method_111(19) && _loc2_ == FoodData.FRIES_REGULAR)
            {
               _loc3_.fryType = _loc2_;
               _loc3_.gameObj.var_131.clip["hopper" + _loc3_.grillX].gotoAndPlay(2);
               _loc3_.isFilling = true;
               _loc3_.fillTimer = 0;
               _loc3_.gameObj.method_104(19);
               if(_loc2_ == FoodData.FRIES_CURLY && _loc3_.gameObj.hud.whichContextTraining == "curlyfries")
               {
                  _loc3_.gameObj.var_128.setTrained("curlyfries");
                  _loc3_.gameObj.hud.removeContextTraining();
               }
               _loc3_.gameObj.var_129.playSound("press_machine_button.wav");
               _loc3_.gameObj.var_129.playSound("trayslide.wav");
            }
         }
      }
   }
}


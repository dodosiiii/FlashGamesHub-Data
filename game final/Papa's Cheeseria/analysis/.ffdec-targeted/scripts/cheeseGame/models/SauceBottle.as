package cheeseGame.models
{
   import flash.display.MovieClip;
   import flash.events.*;
   import package_2.*;
   import package_4.class_5;
   
   public class SauceBottle
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var type:String;
      
      public var shelfX:Number = 0;
      
      public var shelfY:Number = 0;
      
      public var isDragging:Boolean = false;
      
      public var isReturning:Boolean = false;
      
      public var isSquirting:Boolean = false;
      
      public var squirtStartY:Number = 0;
      
      public var squirtTargetY:Number = 0;
      
      public var boundsLeft:Number = 180;
      
      public var boundsRight:Number = 290;
      
      public var boundsTop:Number = 0;
      
      public var boundsBottom:Number = 306;
      
      public var tweenSpeed:Number = 2;
      
      public var rotationSpeed:Number = 1.33333;
      
      public var isRotating:Boolean = false;
      
      public var timeToSquirt:Number = 10;
      
      public var squirtTimer:Number = 0;
      
      public var container:MovieClip;
      
      public function SauceBottle(param1:class_5, param2:String, param3:MovieClip, param4:Number, param5:Number)
      {
         super();
         this.gameObj = param1;
         this.container = param3;
         this.type = param2;
         this.shelfX = param4;
         this.shelfY = param5;
         this.setupBottle();
      }
      
      public function setupBottle() : void
      {
         var _loc1_:SauceBottle = this;
         _loc1_.clip = class_12.method_103("sauce_" + _loc1_.type);
         _loc1_.clip.x = _loc1_.shelfX;
         _loc1_.clip.y = _loc1_.shelfY;
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.clip.buttonMode = true;
         _loc1_.clip.useHandCursor = true;
         _loc1_.clip.gotoAndStop(1);
         _loc1_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBottle);
         _loc1_.clip.addEventListener(MouseEvent.ROLL_OVER,_loc1_.rolloverBottle);
         _loc1_.clip.addEventListener(MouseEvent.ROLL_OUT,_loc1_.rolloutBottle);
      }
      
      public function canClick() : Boolean
      {
         var _loc1_:SauceBottle = this;
         if(_loc1_.gameObj.var_139.currentOrder != null && _loc1_.gameObj.var_139.currentOrder.canAddToppings && !_loc1_.isDragging && !_loc1_.isReturning && !_loc1_.isSquirting)
         {
            return true;
         }
         return false;
      }
      
      public function clickBottle(param1:MouseEvent) : void
      {
         var _loc2_:SauceBottle = this;
         if(_loc2_.canClick())
         {
            if(!_loc2_.clip.hasEventListener(Event.ENTER_FRAME))
            {
               _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.updateBottle);
            }
            _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseBottle);
            _loc2_.gameObj.stage.addEventListener(Event.MOUSE_LEAVE,_loc2_.releaseBottle);
            _loc2_.isDragging = true;
            _loc2_.gameObj.var_129.playSound("grabtopping.wav");
         }
      }
      
      public function releaseBottle(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:SauceBottle = this;
         _loc3_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc3_.releaseBottle);
         _loc3_.gameObj.stage.removeEventListener(Event.MOUSE_LEAVE,_loc3_.releaseBottle);
         _loc3_.isDragging = false;
         if(_loc3_.clip.x >= _loc3_.boundsLeft && _loc3_.clip.x <= _loc3_.boundsRight && _loc3_.clip.y >= _loc3_.boundsTop && _loc3_.clip.y <= _loc3_.boundsBottom)
         {
            _loc2_ = _loc3_.gameObj.var_139.currentOrder.tryToAddSauce(_loc3_.type,_loc3_.clip.x,_loc3_.clip.y);
            if(_loc2_ == true)
            {
               _loc3_.squirtTimer = 0;
               _loc3_.isSquirting = true;
               _loc3_.squirtStartY = _loc3_.clip.y;
               _loc3_.squirtTargetY = _loc3_.clip.y + 20;
            }
            else
            {
               class_7.method_1("Hmmm didn\'t work, UNKNOWN REASON -- X/Y: " + _loc3_.clip.x + ", " + _loc3_.clip.y + ".  Bounds L/R: " + _loc3_.boundsLeft + ", " + _loc3_.boundsRight + ".  T/B: " + _loc3_.boundsTop + ", " + _loc3_.boundsBottom);
               _loc3_.isReturning = true;
            }
         }
         else
         {
            class_7.method_1("Hmmm didn\'t work, out of bounds -- X/Y: " + _loc3_.clip.x + ", " + _loc3_.clip.y + ".  Bounds L/R: " + _loc3_.boundsLeft + ", " + _loc3_.boundsRight + ".  T/B: " + _loc3_.boundsTop + ", " + _loc3_.boundsBottom);
            _loc3_.isReturning = true;
         }
      }
      
      public function rolloverBottle(param1:MouseEvent) : void
      {
         var _loc2_:SauceBottle = this;
         if(_loc2_.canClick())
         {
            _loc2_.clip.y = _loc2_.shelfY - 2;
         }
      }
      
      public function rolloutBottle(param1:MouseEvent) : void
      {
         var _loc2_:SauceBottle = this;
         if(_loc2_.canClick())
         {
            _loc2_.clip.y = _loc2_.shelfY;
         }
      }
      
      public function updateBottle(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:SauceBottle = this;
         _loc4_.rotateBottle();
         if(_loc4_.isDragging)
         {
            _loc4_.clip.x = _loc4_.gameObj.var_139.clip.mouseX;
            _loc4_.clip.y = _loc4_.gameObj.var_139.clip.mouseY;
         }
         if(!(_loc4_.isDragging && _loc4_.clip.x >= _loc4_.boundsLeft && _loc4_.clip.x <= _loc4_.boundsRight && _loc4_.clip.y >= _loc4_.boundsTop && _loc4_.clip.y <= _loc4_.boundsBottom))
         {
            if(!_loc4_.isDragging)
            {
               if(_loc4_.isSquirting)
               {
                  _loc4_.clip.gotoAndStop(2);
                  if(_loc4_.squirtTimer >= _loc4_.timeToSquirt / 2)
                  {
                     _loc4_.squirtTargetY = _loc4_.squirtStartY;
                  }
                  _loc4_.clip.y += (_loc4_.squirtTargetY - _loc4_.clip.y) / 3;
                  ++_loc4_.squirtTimer;
                  if(_loc4_.squirtTimer >= _loc4_.timeToSquirt)
                  {
                     _loc4_.clip.gotoAndStop(1);
                     _loc4_.isSquirting = false;
                     _loc4_.isReturning = true;
                  }
               }
               else if(_loc4_.isReturning)
               {
                  _loc2_ = _loc4_.shelfX - _loc4_.clip.x;
                  _loc3_ = _loc4_.shelfY - _loc4_.clip.y;
                  _loc4_.clip.x += _loc2_ / _loc4_.tweenSpeed;
                  _loc4_.clip.y += _loc3_ / _loc4_.tweenSpeed;
                  if(Math.abs(_loc2_) <= 1 && Math.abs(_loc3_) <= 1 && !_loc4_.isRotating)
                  {
                     _loc4_.clip.x = _loc4_.shelfX;
                     _loc4_.clip.y = _loc4_.shelfY;
                     _loc4_.clip.rotation = 0;
                     _loc4_.isReturning = false;
                     _loc4_.clip.removeEventListener(Event.ENTER_FRAME,_loc4_.updateBottle);
                  }
               }
            }
         }
      }
      
      public function rotateBottle() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:SauceBottle = this;
         if(_loc2_.isDragging || _loc2_.isSquirting)
         {
            if(_loc2_.clip.rotation < 180)
            {
               _loc1_ = 180 - _loc2_.clip.rotation;
               _loc2_.clip.rotation += _loc1_ / _loc2_.rotationSpeed;
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
         var _loc1_:SauceBottle = this;
         _loc1_.clip.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBottle);
         _loc1_.clip.removeEventListener(MouseEvent.ROLL_OVER,_loc1_.rolloverBottle);
         _loc1_.clip.removeEventListener(MouseEvent.ROLL_OUT,_loc1_.rolloutBottle);
         try
         {
            _loc1_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc1_.releaseBottle);
            _loc1_.gameObj.stage.removeEventListener(Event.MOUSE_LEAVE,_loc1_.releaseBottle);
         }
         catch(err:Error)
         {
         }
         if(_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateBottle);
         }
         try
         {
            _loc1_.clip.parent.removeChild(_loc1_.clip);
         }
         catch(err:Error)
         {
         }
         _loc1_.container = null;
         _loc1_.clip = null;
      }
   }
}


package cheeseGame.screens
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Rectangle;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class PrizePopup
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var prizeSKU:String = null;
      
      public var targetX:Number = 320;
      
      public var targetY:Number = 180;
      
      public var startY:Number = -140;
      
      public var returnSpeed:Number = 0;
      
      public var returnSpeedAccel:Number = 2;
      
      public var isReturning:Boolean = false;
      
      public var isDown:Boolean = false;
      
      public var waitTimer:Number = 0;
      
      public var waitTimerMax:Number = 60;
      
      public function PrizePopup(param1:class_5, param2:MovieClip, param3:String)
      {
         super();
         this.gameObj = param1;
         this.prizeSKU = param3;
         this.setupScreen(param2);
      }
      
      public function setupScreen(param1:MovieClip) : void
      {
         var _loc2_:ClothingItem = null;
         var _loc3_:PrizePopup = this;
         _loc3_.clip = new prize_popup();
         _loc3_.clip.x = _loc3_.targetX;
         _loc3_.clip.y = _loc3_.startY;
         param1.addChild(_loc3_.clip);
         var _loc4_:FurniData = _loc3_.gameObj.var_133.getFurniFromTag(this.prizeSKU);
         if(_loc4_ != null)
         {
            _loc3_.clip.thumb.addChild(_loc3_.createFurniThumbnail(_loc4_));
            _loc3_.clip.title_txt.text = _loc4_.title;
            _loc3_.gameObj.var_128.earnMinigameFurniture(this.prizeSKU,-1,true);
         }
         else
         {
            _loc3_.clip.thumb.addChild(_loc3_.gameObj.var_135.generateClothingThumb(this.prizeSKU,_loc3_.gameObj.workerData.gender,50,50,100,100));
            _loc2_ = _loc3_.gameObj.var_135.getItemFromSKU(this.prizeSKU);
            _loc3_.clip.title_txt.text = _loc2_.title;
            _loc3_.gameObj.var_128.earnMinigameClothing(this.prizeSKU,-1,true);
            _loc2_ = null;
         }
         _loc4_ = null;
         _loc3_.clip.addEventListener(Event.ENTER_FRAME,_loc3_.updateScreen);
         _loc3_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickScreen);
         _loc3_.gameObj.var_129.playSound("getstar.wav");
      }
      
      public function createFurniThumbnail(param1:FurniData) : MovieClip
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:MovieClip = null;
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Rectangle = null;
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:MovieClip = null;
         if(param1.type == FurniData.TYPE_FLOORING)
         {
            _loc2_ = Number(String(param1.tag).split("floor")[1]);
            _loc20_ = new MovieClip();
            _loc3_ = new flooring_chunk();
            _loc3_.gotoAndStop(_loc2_);
            _loc4_ = new flooring_chunk();
            _loc4_.gotoAndStop(_loc2_);
            _loc4_.x = _loc3_.width;
            _loc20_.addChild(_loc3_);
            _loc20_.addChild(_loc4_);
            _loc20_.scaleX = 0.47;
            _loc20_.scaleY = 0.47;
         }
         else if(param1.type == FurniData.TYPE_WALLPAPER)
         {
            _loc5_ = Number(String(param1.tag).split("wall")[1]);
            _loc20_ = new MovieClip();
            _loc6_ = new wallpaper_holder();
            _loc6_.gotoAndStop(_loc5_);
            _loc7_ = new wallpaper_holder();
            _loc7_.gotoAndStop(_loc5_);
            _loc7_.x = _loc6_.width;
            _loc20_.addChild(_loc6_);
            _loc20_.addChild(_loc7_);
            _loc8_ = new MovieClip();
            _loc8_.graphics.beginFill(0,1);
            _loc8_.graphics.drawRect(0,0,_loc6_.width,245);
            _loc8_.graphics.endFill();
            _loc20_.addChild(_loc8_);
            _loc9_ = new MovieClip();
            _loc9_.graphics.beginFill(0,1);
            _loc9_.graphics.drawRect(0,0,_loc7_.width,245);
            _loc9_.graphics.endFill();
            _loc9_.x = _loc7_.x;
            _loc20_.addChild(_loc9_);
            _loc6_.mask = _loc8_;
            _loc7_.mask = _loc9_;
            _loc20_.scaleX = 0.43;
            _loc20_.scaleY = 0.43;
         }
         else
         {
            _loc10_ = getDefinitionByName(param1.tag) as Class;
            _loc11_ = new _loc10_();
            if(_loc11_.totalFrames > 1)
            {
               _loc11_.gotoAndStop(2);
            }
            _loc12_ = _loc11_.height;
            _loc13_ = _loc11_.height / _loc11_.width;
            _loc14_ = _loc11_.width / _loc11_.height;
            if(_loc11_.height > 100 || _loc11_.width > 100)
            {
               if(_loc11_.height > _loc11_.width)
               {
                  _loc11_.height = 100;
                  _loc11_.width = _loc11_.height * _loc14_;
               }
               else
               {
                  _loc11_.width = 100;
                  _loc11_.height = _loc11_.width * _loc13_;
               }
            }
            _loc15_ = (100 - _loc11_.width) / 2;
            _loc16_ = (100 - _loc11_.height) / 2;
            _loc17_ = _loc11_.getBounds(_loc11_);
            _loc18_ = _loc17_.y + _loc17_.height;
            _loc19_ = _loc18_ * (_loc11_.height / _loc12_);
            if(param1.type == FurniData.TYPE_FURNI)
            {
               _loc11_.x = _loc15_;
               _loc11_.y = 100 - _loc16_;
               _loc11_.y -= _loc19_;
            }
            else if(param1.type == FurniData.TYPE_POSTER)
            {
               _loc11_.x = _loc15_;
               _loc11_.y = _loc16_;
            }
            _loc20_ = _loc11_;
         }
         return _loc20_;
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:PrizePopup = this;
         if(!_loc3_.isDown)
         {
            _loc2_ = _loc3_.targetY - _loc3_.clip.y;
            _loc3_.clip.y += _loc2_ / 4;
            if(Math.abs(_loc2_) <= 1)
            {
               _loc3_.clip.y = _loc3_.targetY;
               _loc3_.isDown = true;
            }
         }
         else if(_loc3_.isReturning)
         {
            _loc3_.returnSpeed += _loc3_.returnSpeedAccel;
            _loc3_.clip.y -= _loc3_.returnSpeed;
            if(_loc3_.clip.y <= _loc3_.startY)
            {
               _loc3_.gameObj.method_254();
               return;
            }
         }
         else
         {
            ++_loc3_.waitTimer;
            if(_loc3_.waitTimer >= _loc3_.waitTimerMax)
            {
               _loc3_.isReturning = true;
            }
         }
      }
      
      public function clickScreen(param1:MouseEvent) : void
      {
         var _loc2_:PrizePopup = this;
         if(!_loc2_.isReturning)
         {
            _loc2_.waitTimer = _loc2_.waitTimerMax;
            _loc2_.isReturning = true;
            _loc2_.clip.mouseEnabled = false;
            _loc2_.clip.mouseChildren = false;
         }
      }
      
      public function destroy() : void
      {
         var screen:PrizePopup = this;
         screen.clip.removeEventListener(Event.ENTER_FRAME,screen.updateScreen);
         screen.clip.removeEventListener(MouseEvent.MOUSE_DOWN,screen.clickScreen);
         try
         {
            if(screen.clip.thumb.numChildren > 0)
            {
               screen.clip.thumb.removeChildAt(0);
            }
         }
         catch(err:Error)
         {
            class_7.error("Error removing thumb.");
         }
         if(screen.clip)
         {
            if(screen.clip.parent)
            {
               screen.clip.parent.removeChild(screen.clip);
            }
         }
      }
   }
}


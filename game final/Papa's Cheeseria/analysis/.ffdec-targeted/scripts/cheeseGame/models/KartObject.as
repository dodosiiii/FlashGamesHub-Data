package cheeseGame.models
{
   import cheeseGame.screens.MiniGameKart;
   import flash.display.MovieClip;
   
   public class KartObject
   {
      
      public static const TYPE_CONE:String = "cone";
      
      public static const TYPE_OILSLICK:String = "oilslick";
      
      public static const TYPE_BOOSTPAD:String = "boostpad";
      
      public static const TYPE_COIN:String = "coin";
      
      public static const TYPE_STARTLINE:String = "startline";
      
      public static const TYPE_FINISHLINE:String = "finishline";
      
      public static const TYPE_FINISHBANNER:String = "finishbanner";
      
      public var minigame:MiniGameKart;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var x:Number;
      
      public var y:Number;
      
      public var speedX:Number = 0;
      
      public var speedY:Number = 0;
      
      public var type:String;
      
      public var id:Number;
      
      public var objectWidth:Number = 18;
      
      public var objectHeight:Number = 6;
      
      public var isTumbling:Boolean = false;
      
      public var jumpSpeed:Number = 0;
      
      public var tumbleStartY:Number = 0;
      
      public var isFlat:Boolean = false;
      
      public var isLine:Boolean = false;
      
      public var kartsPassed:Number = 0;
      
      public var lastSoundPlayed:Number = 0;
      
      public function KartObject(param1:MiniGameKart, param2:MovieClip, param3:String, param4:Number, param5:Number, param6:Number)
      {
         super();
         this.minigame = param1;
         this.container = param2;
         this.x = param5;
         this.y = param6;
         this.type = param3;
         this.id = param4;
         this.setupObject();
      }
      
      public function setupObject() : void
      {
         var _loc1_:KartObject = this;
         if(_loc1_.type == KartObject.TYPE_CONE)
         {
            _loc1_.clip = new minigame_kart_cone();
            _loc1_.isFlat = false;
            _loc1_.objectWidth = 18;
            _loc1_.objectHeight = 6;
         }
         else if(_loc1_.type == KartObject.TYPE_OILSLICK)
         {
            _loc1_.clip = new minigame_kart_oilslick();
            _loc1_.isFlat = true;
            _loc1_.objectWidth = 30;
            _loc1_.objectHeight = 8;
         }
         else if(_loc1_.type == KartObject.TYPE_BOOSTPAD)
         {
            _loc1_.clip = new minigame_kart_boostpad();
            _loc1_.isFlat = true;
            _loc1_.objectWidth = 30;
            _loc1_.objectHeight = 12;
         }
         else if(_loc1_.type == KartObject.TYPE_COIN)
         {
            _loc1_.clip = new minigame_kart_coin();
            _loc1_.isFlat = false;
            _loc1_.objectWidth = 8;
            _loc1_.objectHeight = 4;
         }
         else if(_loc1_.type == KartObject.TYPE_STARTLINE)
         {
            _loc1_.clip = new kart_start_bg();
            _loc1_.isFlat = true;
            _loc1_.objectWidth = 2;
            _loc1_.objectHeight = 2;
            _loc1_.isLine = true;
         }
         else if(_loc1_.type == KartObject.TYPE_FINISHLINE)
         {
            _loc1_.clip = new kart_finish_bg();
            _loc1_.isFlat = true;
            _loc1_.objectWidth = 2;
            _loc1_.objectHeight = 2;
            _loc1_.isLine = true;
         }
         else if(_loc1_.type == KartObject.TYPE_FINISHBANNER)
         {
            _loc1_.clip = new kart_finish_fg();
            _loc1_.isFlat = false;
            _loc1_.objectWidth = 2;
            _loc1_.objectHeight = 2;
            _loc1_.isLine = true;
         }
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.clip.x = _loc1_.minigame.kartStartX + _loc1_.x - _loc1_.minigame.kart.nextX;
         _loc1_.clip.y = _loc1_.y;
      }
      
      public function updateObject() : void
      {
         var _loc3_:KartObject = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         _loc3_ = this;
         _loc3_.x += _loc3_.speedX;
         _loc3_.y += _loc3_.speedY;
         if(_loc3_.type == KartObject.TYPE_CONE)
         {
            _loc3_.speedX *= 0.9;
            _loc3_.speedY *= 0.9;
            if(Math.abs(_loc3_.speedX) < 0.01)
            {
               _loc3_.speedX = 0;
            }
            if(Math.abs(_loc3_.speedY) < 0.01)
            {
               _loc3_.speedY = 0;
            }
         }
         if(_loc3_.minigame.isFinishing)
         {
            _loc1_ = _loc3_.minigame.finishDecaySpeed;
            _loc3_.clip.x += _loc3_.speedX - _loc1_;
         }
         else
         {
            _loc3_.clip.x = _loc3_.minigame.kartStartX + _loc3_.x - _loc3_.minigame.kart.nextX;
         }
         if(!_loc3_.isTumbling)
         {
            _loc3_.clip.y = _loc3_.y;
         }
         if(_loc3_.isLine == false)
         {
            _loc2_ = (_loc3_.y - _loc3_.minigame.kartMinY) / (_loc3_.minigame.kartMaxY - _loc3_.minigame.kartMinY);
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            else if(_loc2_ > 1)
            {
               _loc2_ = 1;
            }
            _loc3_.clip.scaleX = 0.8 + _loc2_ * 0.2;
            _loc3_.clip.scaleY = _loc3_.clip.scaleX;
            if(_loc3_.isTumbling || _loc3_.y < _loc3_.minigame.kartMinY - 15 || _loc3_.y > _loc3_.minigame.kartMaxY + 15)
            {
               if(!_loc3_.isTumbling)
               {
                  _loc3_.isTumbling = true;
                  _loc3_.jumpSpeed = -16;
                  _loc3_.tumbleStartY = _loc3_.y;
                  _loc3_.speedX = 0;
                  _loc3_.speedY = 0;
               }
               else
               {
                  _loc3_.jumpSpeed += 2;
                  _loc3_.clip.y += _loc3_.jumpSpeed;
                  _loc3_.clip.rotation += 6;
                  if(_loc3_.clip.y > _loc3_.tumbleStartY)
                  {
                     _loc3_.minigame.removeObject(_loc3_.id);
                     return;
                  }
               }
            }
         }
         if(_loc3_.clip.x < -50)
         {
            if(_loc3_.type == KartObject.TYPE_BOOSTPAD || _loc3_.type == KartObject.TYPE_COIN)
            {
               _loc3_.clip.visible = false;
            }
            else
            {
               _loc3_.minigame.removeObject(_loc3_.id);
            }
         }
      }
      
      public function hitObject(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc13_:KartObject = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         _loc13_ = this;
         if(_loc13_.type == KartObject.TYPE_CONE)
         {
            _loc5_ = param3 - param1;
            _loc6_ = param4 - param2;
            _loc7_ = Math.atan2(_loc6_,_loc5_);
            _loc8_ = _loc5_ / Math.cos(_loc7_);
            _loc9_ = _loc13_.x - param3;
            _loc10_ = _loc13_.y - param4;
            _loc11_ = Math.atan2(_loc10_,_loc9_);
            _loc12_ = _loc8_ * 1.5;
            _loc13_.speedX = Math.cos(_loc11_) * _loc12_;
            _loc13_.speedY = Math.sin(_loc11_) * _loc12_;
         }
         else if(_loc13_.type == KartObject.TYPE_FINISHLINE)
         {
            ++_loc13_.kartsPassed;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:KartObject = this;
         if(Boolean(_loc1_.clip) && Boolean(_loc1_.clip.parent))
         {
            _loc1_.clip.parent.removeChild(_loc1_.clip);
         }
         _loc1_.clip = null;
      }
   }
}


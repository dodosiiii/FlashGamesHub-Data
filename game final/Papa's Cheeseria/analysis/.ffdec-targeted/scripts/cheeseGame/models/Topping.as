package cheeseGame.models
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import package_2.*;
   import package_4.class_5;
   
   public class Topping
   {
      
      public var gameObj:class_5;
      
      public var sandwich:Sandwich = null;
      
      public var clip:MovieClip = null;
      
      public var type:String = null;
      
      public var toppingData:ToppingItem = null;
      
      public var isClumps:Boolean = false;
      
      public var isSauce:Boolean = false;
      
      public var isSolid:Boolean = false;
      
      public var isDragging:Boolean = true;
      
      public var isDropping:Boolean = false;
      
      public var isLanded:Boolean = false;
      
      public var isReturning:Boolean = false;
      
      public var clumps:Vector.<MovieClip> = null;
      
      public var clumpData:Vector.<Object> = null;
      
      public var placedX:Number = 0;
      
      public var dragOffsetY:Number = 30;
      
      public var radius:Number = 50;
      
      public var spiralDir:Number = 1;
      
      public var splatClip:MovieClip = null;
      
      public var dripClip:MovieClip = null;
      
      public var isDripping:Boolean = false;
      
      public var dripTargetY:Number = 0;
      
      public var dripSpeed:Number = 4;
      
      public var dripSpeedChange:Number = 4;
      
      public var dripSpeedMax:Number = 24;
      
      public var sauceOffsetY:Number = 25;
      
      public var percentSplat:Number = 0;
      
      public var sauceTargetScaleX:Number = 1;
      
      public var sauceTargetScaleY:Number = 1;
      
      public var sauceFlipMultiplier:Number = 1;
      
      public var solidDragScale:Number = 1;
      
      public var solidReturnScale:Number = 0.67;
      
      public var returnTargetX:Number = 0;
      
      public var returnTargetY:Number = 0;
      
      public var returnSpeed:Number = 10;
      
      public var returnSpeedChange:Number = 2;
      
      public var returnSpeedMax:Number = 50;
      
      public var solidHasLanded:Boolean = false;
      
      public var solidFallSpeed:Number = 4;
      
      public var solidFallSpeedChange:Number = 2;
      
      public var solidFallSpeedMax:Number = 50;
      
      public var leftEdge:Number = 0;
      
      public var numParts:Number = 4;
      
      public var partYoffset:Number = -80;
      
      public var partXoffset:Number = -58;
      
      public var partWidth:Number = 29;
      
      public var maxAngle:Number = 70;
      
      public var maxDiffAngle:Number = 25;
      
      public var heightValues:Array = null;
      
      public var nodesX:Array;
      
      public var nodesY:Array;
      
      public var fallingNodesX:Array;
      
      public var fallingNodesY:Array;
      
      public var playedLandingSound:Boolean = false;
      
      public function Topping(param1:class_5, param2:String, param3:Number = 1)
      {
         var _loc4_:Topping = null;
         this.nodesX = [];
         this.nodesY = [];
         this.fallingNodesX = [];
         this.fallingNodesY = [];
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.type = param2;
         _loc4_.spiralDir = param3;
         _loc4_.setupTopping();
      }
      
      public function setupTopping() : void
      {
         var _loc1_:Topping = this;
         _loc1_.toppingData = _loc1_.gameObj.toppingData.getToppingItemData(_loc1_.type,true);
         if(FoodData.isSauce(_loc1_.type))
         {
            _loc1_.isClumps = false;
            _loc1_.isSauce = true;
            _loc1_.isSolid = false;
            _loc1_.setupSauce();
         }
         else if(FoodData.isSliceTopping(_loc1_.type))
         {
            _loc1_.isClumps = false;
            _loc1_.isSauce = false;
            _loc1_.isSolid = true;
            _loc1_.setupSolid();
         }
         else
         {
            _loc1_.isClumps = true;
            _loc1_.isSauce = false;
            _loc1_.isSolid = false;
            _loc1_.setupClumps();
         }
         if(!_loc1_.isSauce)
         {
            _loc1_.gameObj.var_129.playSound("grabtopping.wav");
         }
      }
      
      public function setupSolid() : void
      {
         var _loc1_:Topping = this;
         _loc1_.numParts = _loc1_.toppingData.capacity;
         _loc1_.partWidth = _loc1_.toppingData.collisionPaddingX;
         _loc1_.partXoffset = _loc1_.toppingData.collisionPaddingY;
         _loc1_.partYoffset = _loc1_.toppingData.nudgeAmount;
         _loc1_.maxDiffAngle = _loc1_.toppingData.dropRate;
         _loc1_.maxAngle = _loc1_.toppingData.maxSpeed;
         var _loc2_:int = 0;
         while(_loc2_ <= _loc1_.numParts)
         {
            _loc1_.nodesX.push(_loc2_ * _loc1_.partWidth);
            _loc1_.nodesY.push(0);
            _loc1_.fallingNodesX.push(_loc2_ * _loc1_.partWidth);
            _loc1_.fallingNodesY.push(0);
            _loc2_++;
         }
         _loc1_.radius = Math.round(_loc1_.partWidth * _loc1_.numParts / 2);
         _loc1_.dragOffsetY = 40;
         _loc1_.clip = class_12.method_103("topping_" + _loc1_.type + "_slice",false,false);
         _loc1_.clip.scaleX = _loc1_.solidReturnScale;
         _loc1_.clip.scaleY = _loc1_.solidReturnScale;
         _loc1_.clip.x = _loc1_.gameObj.var_139.clip.mouseX;
         _loc1_.clip.y = _loc1_.gameObj.var_139.clip.mouseY + _loc1_.dragOffsetY * _loc1_.solidReturnScale;
         _loc1_.gameObj.var_139.clip.dragholder.addChild(_loc1_.clip);
      }
      
      public function setupSauce() : void
      {
         var _loc1_:Topping = this;
         _loc1_.dripClip = class_12.method_103("sauce_" + _loc1_.type + "_drip",false,false);
         _loc1_.dripClip.x = _loc1_.gameObj.var_139.clip.mouseX;
         _loc1_.dripClip.y = _loc1_.gameObj.var_139.clip.mouseY + 40;
         _loc1_.clip = new MovieClip();
         _loc1_.splatClip = class_12.method_103("sauce_" + _loc1_.type + "_splat",false,false);
         _loc1_.clip.addChild(_loc1_.splatClip);
      }
      
      public function setupClumps() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:MovieClip = null;
         var _loc9_:Topping = this;
         _loc9_.clip = new MovieClip();
         _loc9_.clip.x = _loc9_.gameObj.var_139.clip.mouseX;
         _loc9_.clip.y = _loc9_.gameObj.var_139.clip.mouseY + _loc9_.dragOffsetY;
         _loc9_.gameObj.var_139.clip.dragholder.addChild(_loc9_.clip);
         var _loc10_:Number = _loc9_.toppingData.capacity;
         var _loc11_:Number = _loc9_.toppingData.collisionPaddingX;
         var _loc12_:Number = _loc9_.toppingData.collisionPaddingY;
         var _loc13_:Number = _loc9_.toppingData.rotationMin;
         var _loc14_:Number = _loc9_.toppingData.rotationMax;
         _loc9_.clumps = new Vector.<MovieClip>();
         var _loc15_:Number = Math.PI * (3 - Math.sqrt(5));
         var _loc16_:Array = [-15,17,-32,0,35,-19,16];
         var _loc17_:Array = [-20,-19,-5,3,-2,17,19];
         _loc1_ = 0;
         while(_loc1_ < _loc10_)
         {
            _loc2_ = _loc1_ * _loc15_;
            _loc3_ = Math.sqrt(_loc1_) / Math.sqrt(_loc10_);
            _loc3_ = _loc3_ * _loc9_.spiralDir;
            _loc4_ = Math.round(_loc3_ * Math.cos(_loc2_) * this.radius);
            _loc5_ = Math.round(_loc3_ * Math.sin(_loc2_) * this.radius * 0.5);
            if(_loc9_.type == FoodData.TOPPING_MEATBALLS)
            {
               _loc4_ = _loc16_[_loc1_] + Math.round(4 - Math.random() * 8);
               _loc5_ = Number(_loc17_[_loc1_]);
            }
            _loc6_ = _loc4_ / 16;
            _loc7_ = _loc5_ / 16;
            _loc5_ -= Math.round(this.radius * 0.5);
            _loc7_ -= Math.round(this.radius * 0.5);
            _loc8_ = class_12.method_103("topping_" + _loc9_.type + "_pieces",false,false);
            _loc8_.gotoAndStop(Math.ceil(Math.random() * _loc8_.totalFrames));
            _loc8_.rotation = _loc13_ + Math.round(Math.random() * (_loc14_ - _loc13_));
            _loc8_.x = _loc6_;
            _loc8_.y = _loc7_;
            _loc8_.targetX = _loc4_;
            _loc8_.targetY = _loc5_;
            _loc8_.relativeX = _loc4_;
            _loc8_.relativeY = _loc5_;
            _loc8_.tweenSpeed = 3 + Math.round(Math.random() * 2);
            _loc8_.cacheAsBitmap = true;
            _loc9_.clip.addChild(_loc8_);
            _loc9_.clumps.push(_loc8_);
            _loc1_++;
         }
      }
      
      public function updateTopping() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:int = 0;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Boolean = false;
         var _loc6_:Topping = this;
         if(_loc6_.isDragging)
         {
            _loc6_.clip.x = _loc6_.gameObj.var_139.clip.mouseX;
            if(_loc6_.isSolid)
            {
               _loc6_.clip.scaleX += (_loc6_.solidDragScale - _loc6_.clip.scaleX) / 2;
               _loc6_.clip.scaleY = _loc6_.clip.scaleX;
               if(Math.abs(_loc6_.solidDragScale - _loc6_.clip.scaleX) <= 0.02)
               {
                  _loc6_.clip.scaleX = _loc6_.solidDragScale;
                  _loc6_.clip.scaleY = _loc6_.solidDragScale;
               }
               _loc6_.clip.y = _loc6_.gameObj.var_139.clip.mouseY + _loc6_.dragOffsetY * _loc6_.clip.scaleX;
            }
            else
            {
               _loc6_.clip.y = _loc6_.gameObj.var_139.clip.mouseY + _loc6_.dragOffsetY;
            }
         }
         else if(_loc6_.isReturning)
         {
            if(_loc6_.isSolid)
            {
               _loc6_.clip.scaleX += (_loc6_.solidReturnScale - _loc6_.clip.scaleX) / 2;
               _loc6_.clip.scaleY = _loc6_.clip.scaleX;
               if(Math.abs(_loc6_.solidReturnScale - _loc6_.clip.scaleX) <= 0.02)
               {
                  _loc6_.clip.scaleX = _loc6_.solidReturnScale;
                  _loc6_.clip.scaleY = _loc6_.clip.scaleX;
               }
               if(_loc6_.returnSpeed < _loc6_.returnSpeedMax)
               {
                  _loc6_.returnSpeed += _loc6_.returnSpeedChange;
                  if(_loc6_.returnSpeed > _loc6_.returnSpeedMax)
                  {
                     _loc6_.returnSpeed = _loc6_.returnSpeedMax;
                  }
               }
               _loc6_.gameObj.var_139.tweenToTarget(_loc6_.clip,_loc6_.returnTargetX,_loc6_.returnTargetY,_loc6_.returnSpeed,true);
               if(Math.abs(_loc6_.returnTargetX - _loc6_.clip.x) <= 1 && Math.abs(_loc6_.returnTargetY - _loc6_.clip.y) <= 1)
               {
                  _loc6_.gameObj.var_139.removeFromReturningToppings(_loc6_);
               }
            }
         }
         else if(_loc6_.isDropping)
         {
            if(_loc6_.isSolid)
            {
               _loc6_.updateFallingSolid();
            }
         }
         if(_loc6_.isClumps && _loc6_.clumps != null)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc6_.clumps.length)
            {
               if(_loc6_.clumps[_loc2_].x != _loc6_.clumps[_loc2_].targetX || _loc6_.clumps[_loc2_].y != _loc6_.clumps[_loc2_].targetY || _loc6_.clumps[_loc2_].isOutside === true && _loc6_.clumps[_loc2_].pastThreshhold !== true)
               {
                  _loc3_ = _loc6_.clumps[_loc2_].targetY - _loc6_.clumps[_loc2_].y;
                  _loc4_ = _loc6_.clumps[_loc2_].targetX - _loc6_.clumps[_loc2_].x;
                  if(_loc6_.isReturning || _loc6_.isDropping)
                  {
                     if(_loc6_.clumps[_loc2_].speed < _loc6_.clumps[_loc2_].speedmax)
                     {
                        _loc6_.clumps[_loc2_].speed += _loc6_.clumps[_loc2_].speedchange;
                        if(_loc6_.clumps[_loc2_].speed > _loc6_.clumps[_loc2_].speedmax)
                        {
                           _loc6_.clumps[_loc2_].speed = _loc6_.clumps[_loc2_].speedmax;
                        }
                     }
                     _loc5_ = true;
                     if(_loc6_.clumps[_loc2_].isOutside === true && _loc6_.clumps[_loc2_].pastThreshhold !== true)
                     {
                        _loc5_ = false;
                     }
                     _loc6_.gameObj.var_139.tweenToTarget(_loc6_.clumps[_loc2_],_loc6_.clumps[_loc2_].targetX,_loc6_.clumps[_loc2_].targetY,_loc6_.clumps[_loc2_].speed,_loc5_);
                     if(_loc6_.clumps[_loc2_].preventCheck === true)
                     {
                        _loc6_.clumps[_loc2_].preventCheck = false;
                     }
                     if(_loc6_.isDropping && _loc6_.clumps[_loc2_].isOutside === true && _loc6_.clumps[_loc2_].pastThreshhold !== true && _loc6_.clumps[_loc2_].y >= _loc6_.clumps[_loc2_].targetY)
                     {
                        _loc6_.loseClump(_loc6_.clumps[_loc2_],_loc2_);
                        _loc3_ = _loc6_.clumps[_loc2_].targetY - _loc6_.clumps[_loc2_].y;
                        _loc4_ = _loc6_.clumps[_loc2_].targetX - _loc6_.clumps[_loc2_].x;
                     }
                  }
                  else
                  {
                     _loc6_.clumps[_loc2_].x += _loc4_ / _loc6_.clumps[_loc2_].tweenSpeed;
                     _loc6_.clumps[_loc2_].y += _loc3_ / _loc6_.clumps[_loc2_].tweenSpeed;
                  }
                  if(Math.abs(_loc3_) <= 1 && Math.abs(_loc4_) <= 1 && _loc6_.clumps[_loc2_].preventCheck !== true || _loc6_.clumps[_loc2_].x == _loc6_.clumps[_loc2_].targetX && _loc6_.clumps[_loc2_].y == _loc6_.clumps[_loc2_].targetY)
                  {
                     if(!(_loc6_.isDropping && _loc6_.clumps[_loc2_].isOutside === true && _loc6_.clumps[_loc2_].pastThreshhold !== true))
                     {
                        _loc6_.clumps[_loc2_].x = _loc6_.clumps[_loc2_].targetX;
                        _loc6_.clumps[_loc2_].y = _loc6_.clumps[_loc2_].targetY;
                        _loc1_++;
                        if(_loc6_.clumps[_loc2_].pastThreshhold === true)
                        {
                        }
                        if(!_loc6_.playedLandingSound && _loc6_.isDropping && _loc1_ >= _loc6_.clumps.length / 2)
                        {
                           _loc6_.gameObj.var_129.playSound("droptopping.wav");
                           _loc6_.playedLandingSound = true;
                        }
                        if(_loc6_.isReturning)
                        {
                           _loc6_.clumps[_loc2_].visible = false;
                        }
                     }
                  }
               }
               else
               {
                  _loc1_++;
               }
               _loc2_++;
            }
            if(_loc1_ == _loc6_.clumps.length)
            {
               if(_loc6_.isReturning)
               {
                  _loc6_.gameObj.var_139.removeFromReturningToppings(_loc6_);
               }
               else if(_loc6_.isDropping)
               {
                  _loc6_.isDropping = false;
                  _loc6_.clip.cacheAsBitmap = true;
               }
            }
         }
         else if(_loc6_.isDripping)
         {
            if(Boolean(_loc6_.gameObj.var_139) && Boolean(_loc6_.dripClip))
            {
               if(_loc6_.dripSpeed < _loc6_.dripSpeedMax)
               {
                  _loc6_.dripSpeed += _loc6_.dripSpeedChange;
                  if(_loc6_.dripSpeed > _loc6_.dripSpeedMax)
                  {
                     _loc6_.dripSpeed = _loc6_.dripSpeedMax;
                  }
               }
               _loc6_.gameObj.var_139.tweenToTarget(_loc6_.dripClip,_loc6_.dripClip.x,_loc6_.dripTargetY - _loc6_.sauceOffsetY,_loc6_.dripSpeed);
               if(Math.abs(_loc6_.dripTargetY - _loc6_.sauceOffsetY - _loc6_.dripClip.y) <= 1)
               {
                  _loc6_.dripClip.y = _loc6_.dripTargetY - _loc6_.sauceOffsetY;
                  _loc6_.dripClip.scaleY += (0 - _loc6_.dripClip.scaleY) / 2;
                  _loc6_.splatClip.scaleX += (_loc6_.sauceTargetScaleX - _loc6_.splatClip.scaleX) / 2;
                  _loc6_.splatClip.scaleY += (_loc6_.sauceTargetScaleY - _loc6_.splatClip.scaleY) / 2;
                  if(!_loc6_.playedLandingSound)
                  {
                     _loc6_.gameObj.var_129.playSound("dropsauce.wav");
                     _loc6_.playedLandingSound = true;
                  }
                  if(Math.abs(0 - _loc6_.dripClip.scaleY) <= 0.02)
                  {
                     _loc6_.dripClip.parent.removeChild(_loc6_.dripClip);
                     _loc6_.dripClip = null;
                     _loc6_.isDripping = false;
                     _loc6_.splatClip.scaleX = _loc6_.sauceTargetScaleX;
                     _loc6_.splatClip.scaleY = _loc6_.sauceTargetScaleY;
                     _loc6_.clip.cacheAsBitmap = true;
                  }
               }
            }
            else
            {
               _loc6_.isDripping = false;
               if(Boolean(_loc6_.dripClip) && Boolean(_loc6_.dripClip.parent))
               {
                  _loc6_.dripClip.parent.removeChild(_loc6_.dripClip);
               }
               _loc6_.dripClip = null;
            }
         }
      }
      
      public function returnToBin() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:int = 0;
         var _loc4_:Topping = this;
         var _loc5_:MovieClip = _loc4_.gameObj.var_139.getBinClip(_loc4_.type);
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.x + 38;
            _loc7_ = _loc5_.y + 23;
         }
         if(_loc4_.isClumps && _loc4_.clumps != null && _loc4_.clumps.length > 0)
         {
            _loc1_ = _loc4_.clip.x;
            _loc2_ = _loc4_.clip.y;
            _loc4_.clip.x = 0;
            _loc4_.clip.y = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc4_.clumps.length)
            {
               _loc4_.clumps[_loc3_].x += _loc1_;
               _loc4_.clumps[_loc3_].y += _loc2_;
               _loc4_.clumps[_loc3_].targetX = _loc6_;
               _loc4_.clumps[_loc3_].targetY = _loc7_;
               _loc4_.clumps[_loc3_].speed = 8 + Math.round(Math.random() * 5);
               _loc4_.clumps[_loc3_].speedmax = 50;
               _loc4_.clumps[_loc3_].speedchange = 2 + Math.round(Math.random() * 5);
               _loc3_++;
            }
         }
         else if(!_loc4_.isClumps)
         {
            _loc4_.returnTargetX = _loc6_;
            _loc4_.returnTargetY = _loc7_;
         }
         _loc4_.isDragging = false;
         _loc4_.isReturning = true;
      }
      
      public function prepareToAdd(param1:Sandwich, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc4_:Topping = null;
         _loc4_ = this;
         _loc4_.sandwich = param1;
         if(_loc4_.isClumps && _loc4_.clumps != null && _loc4_.clumps.length > 0)
         {
            _loc4_.addClumps(param1,param2,param3);
         }
         else if(_loc4_.isSauce)
         {
            _loc4_.addSauce(param1,param2,param3);
         }
         else if(!_loc4_.isClumps)
         {
            _loc4_.addSolid(param1,param2,param3);
         }
         _loc4_.isDragging = false;
         _loc4_.isDropping = true;
      }
      
      public function addClumps(param1:Sandwich, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc12_:Topping = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Boolean = false;
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         _loc12_ = this;
         var _loc13_:Number = _loc12_.clip.y;
         var _loc14_:Number = _loc12_.clip.x;
         if(param2 == -1)
         {
            _loc12_.sandwich.toppingClip.addChild(_loc12_.clip);
            _loc12_.clip.x = _loc14_ - _loc12_.sandwich.clip.x;
            _loc12_.placedX = _loc12_.clip.x;
         }
         else
         {
            _loc12_.sandwich.toppingClip.setChildIndex(_loc12_.clip,param2);
            _loc12_.clip.x *= -1;
         }
         _loc12_.clip.y = _loc12_.sandwich.getToppingTargetY(param2);
         var _loc15_:Number = _loc13_ - (_loc12_.sandwich.clip.y + _loc12_.clip.y);
         var _loc16_:int = 0;
         while(_loc16_ < _loc12_.clumps.length)
         {
            if(param2 != -1 && _loc12_.clumps[_loc16_].isOutside === true)
            {
               if(param3)
               {
                  _loc12_.clumps[_loc16_].alpha = 0.2;
               }
               else
               {
                  _loc12_.clumps[_loc16_].alpha = 1;
               }
            }
            else
            {
               _loc12_.clumps[_loc16_].alpha = 1;
               _loc12_.clumps[_loc16_].x = _loc12_.clumps[_loc16_].targetX;
               _loc12_.clumps[_loc16_].y = _loc12_.clumps[_loc16_].targetY;
               if(param2 != -1)
               {
                  _loc12_.clumps[_loc16_].x = _loc12_.clumps[_loc16_].relativeX;
                  _loc12_.clumps[_loc16_].y = _loc12_.clumps[_loc16_].relativeY;
                  if(param3)
                  {
                     _loc12_.clumps[_loc16_].x *= -1;
                  }
                  _loc12_.clumps[_loc16_].targetX = _loc12_.clumps[_loc16_].x;
                  _loc12_.clumps[_loc16_].targetY = _loc12_.clumps[_loc16_].y;
               }
               _loc4_ = _loc12_.clumps[_loc16_].y;
               _loc5_ = _loc12_.clumps[_loc16_].x + _loc12_.clip.x;
               _loc6_ = _loc12_.clumps[_loc16_].targetY - _loc12_.sandwich.breadHeight;
               _loc7_ = _loc12_.sandwich.isWithinBreadBounds(_loc5_,_loc6_);
               if((_loc7_) || param2 != -1)
               {
                  _loc12_.clumps[_loc16_].isOutside = false;
                  _loc9_ = _loc12_.sandwich.getHeightOffsetAtPoint(_loc5_,_loc6_);
                  _loc10_ = 0 - (_loc12_.clip.y + (_loc12_.sandwich.breadHeight + _loc12_.sandwich.cheeseHeight));
                  _loc11_ = _loc10_ - _loc9_;
                  _loc12_.clumps[_loc16_].targetY += _loc11_;
               }
               else
               {
                  _loc12_.clumps[_loc16_].isOutside = true;
                  _loc12_.clumps[_loc16_].yThreshhold = _loc12_.clumps[_loc16_].targetY;
               }
               _loc12_.clumps[_loc16_].y += _loc15_;
               _loc8_ = 1 - _loc16_ / _loc12_.clumps.length;
               _loc12_.clumps[_loc16_].speed = 5 + Math.ceil(_loc8_ * 8);
               _loc12_.clumps[_loc16_].speedchange = 3;
               if(_loc12_.clumps[_loc16_].targetY < _loc12_.clumps[_loc16_].y && _loc12_.clumps[_loc16_].isOutside !== true)
               {
                  _loc12_.clumps[_loc16_].speed += 8;
               }
               else if(_loc12_.clumps[_loc16_].targetY < _loc12_.clumps[_loc16_].y && _loc12_.clumps[_loc16_].isOutside === true)
               {
                  _loc12_.clumps[_loc16_].targetY = _loc12_.clumps[_loc16_].y;
                  _loc12_.clumps[_loc16_].yThreshhold = _loc12_.clumps[_loc16_].y;
               }
               if(param2 != -1)
               {
                  _loc12_.clumps[_loc16_].y = _loc12_.clumps[_loc16_].targetY;
                  _loc12_.clumps[_loc16_].yThreshhold = _loc12_.clumps[_loc16_].y;
               }
            }
            _loc16_++;
         }
         _loc12_.sandwich.addToppingToMap(_loc12_);
      }
      
      public function addSauce(param1:Sandwich, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc11_:Array = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Topping = this;
         var _loc7_:Matrix = new Matrix();
         var _loc8_:Matrix = new Matrix();
         if(param2 == -1)
         {
            _loc4_ = _loc6_.dripClip.y;
            _loc5_ = _loc6_.dripClip.x;
            _loc6_.sandwich.toppingClip.addChild(_loc6_.clip);
            _loc6_.clip.x = _loc5_ - _loc6_.sandwich.clip.x;
            _loc6_.placedX = _loc6_.clip.x;
            _loc6_.sandwich.toppingClip.addChild(_loc6_.dripClip);
            _loc6_.dripClip.x = _loc6_.clip.x;
            _loc6_.dripClip.y = _loc4_ - _loc6_.sandwich.clip.y;
            if(_loc6_.sandwich.numSaucesAdded % 2 == 1)
            {
               _loc6_.sauceFlipMultiplier = -1;
            }
            _loc6_.isDripping = true;
         }
         else
         {
            _loc6_.sandwich.toppingClip.setChildIndex(_loc6_.clip,param2);
            _loc6_.clip.x *= -1;
         }
         var _loc9_:Array = _loc6_.getSauceData(_loc6_.clip.x);
         var _loc10_:Number = Math.round(42 * _loc9_[1]);
         _loc11_ = _loc6_.sandwich.getSkewData(_loc9_[2],_loc10_,true);
         var _loc12_:Number = Number(_loc11_[1]);
         _loc6_.dripTargetY = _loc12_;
         _loc8_.b = Math.tan(_loc9_[0] / 180 * Math.PI);
         _loc8_.tx = 0;
         _loc8_.ty = 0 - _loc6_.sauceOffsetY + _loc9_[3];
         _loc6_.splatClip.transform.matrix = _loc8_;
         _loc6_.splatClip.scaleX = _loc9_[1] * _loc6_.sauceFlipMultiplier;
         _loc6_.splatClip.scaleY = 1;
         _loc6_.sauceTargetScaleX = _loc9_[1] * _loc6_.sauceFlipMultiplier;
         _loc6_.sauceTargetScaleY = 1;
         if(param2 != -1)
         {
            _loc6_.splatClip.scaleX = _loc6_.sauceTargetScaleX;
            _loc6_.splatClip.scaleY = _loc6_.sauceTargetScaleY;
         }
         else
         {
            _loc6_.splatClip.scaleX = 0;
            _loc6_.splatClip.scaleY = 0;
         }
         _loc7_.b = Math.tan(_loc11_[0] / 180 * Math.PI);
         _loc7_.tx = _loc9_[2];
         _loc7_.ty = _loc12_;
         _loc6_.clip.transform.matrix = _loc7_;
         _loc6_.clip.scaleX = _loc6_.sandwich.getScaleXForSkew(_loc11_[0]);
         _loc6_.clip.scaleY = _loc6_.sandwich.getScaleYForSkew(_loc11_[0]);
         _loc7_ = null;
      }
      
      public function addSolid(param1:Sandwich, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc26_:Topping = null;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:MovieClip = null;
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:Number = Number(NaN);
         var _loc21_:Number = Number(NaN);
         var _loc22_:Number = Number(NaN);
         var _loc23_:Number = Number(NaN);
         var _loc24_:Number = Number(NaN);
         var _loc25_:Matrix = null;
         _loc26_ = this;
         _loc26_.clip.scaleX = _loc26_.solidDragScale;
         _loc26_.clip.scaleY = _loc26_.clip.scaleX;
         _loc26_.heightValues = _loc26_.sandwich.getHeightArray();
         var _loc27_:Number = _loc26_.clip.y;
         var _loc28_:Number = _loc26_.clip.x;
         if(param2 == -1)
         {
            _loc26_.sandwich.toppingClip.addChild(_loc26_.clip);
            _loc26_.clip.x = _loc28_ - _loc26_.sandwich.clip.x;
            _loc26_.placedX = _loc26_.clip.x;
         }
         else
         {
            _loc26_.sandwich.toppingClip.setChildIndex(_loc26_.clip,param2);
            _loc26_.clip.x *= -1;
         }
         _loc26_.clip.y = 0;
         var _loc29_:Number = _loc27_ - (_loc26_.sandwich.clip.y + _loc26_.clip.y);
         _loc26_.leftEdge = Math.round(_loc26_.clip.x + this.partXoffset + _loc26_.sandwich.shadowOffsetX);
         var _loc30_:Number = -1;
         var _loc31_:Number = -999;
         _loc4_ = 0;
         while(_loc4_ < this.nodesX.length)
         {
            _loc14_ = this.leftEdge + _loc4_ * this.partWidth;
            if(_loc14_ >= 0 && _loc14_ < _loc26_.heightValues.length)
            {
               _loc15_ = Number(_loc26_.heightValues[_loc14_]);
               if(_loc15_ > _loc31_)
               {
                  _loc30_ = _loc4_;
                  _loc31_ = _loc15_;
               }
               else if(_loc15_ == _loc31_ && _loc4_ <= this.nodesX.length / 2)
               {
                  _loc30_ = _loc4_;
                  _loc31_ = _loc15_;
               }
            }
            _loc4_++;
         }
         _loc26_.nodesX[_loc30_] = this.leftEdge + _loc30_ * this.partWidth;
         _loc26_.nodesY[_loc30_] = _loc31_;
         var _loc32_:Number = 0 - this.maxAngle;
         if(_loc30_ > 0)
         {
            _loc10_ = Number(_loc26_.nodesX[_loc30_]);
            _loc11_ = Number(_loc26_.nodesY[_loc30_]);
            _loc12_ = 0;
            _loc4_ = int(_loc30_ - 1);
            while(_loc4_ >= 0)
            {
               _loc13_ = Math.min(this.maxAngle,_loc12_ + this.maxDiffAngle);
               _loc5_ = _loc32_;
               while(_loc5_ < _loc13_)
               {
                  _loc6_ = Number(class_26.degreesToRads(_loc5_ + 90));
                  _loc8_ = _loc10_ - Math.sin(_loc6_) * this.partWidth;
                  _loc9_ = _loc11_ + Math.cos(_loc6_) * this.partWidth;
                  _loc7_ = Math.round(_loc8_);
                  if(_loc5_ == _loc13_ - 1 || _loc7_ >= 0 && _loc7_ < _loc26_.heightValues.length && (_loc26_.heightValues[_loc7_] >= _loc9_ || _loc5_ == _loc13_ - 1))
                  {
                     _loc26_.nodesX[_loc4_] = _loc8_;
                     _loc26_.nodesY[_loc4_] = _loc9_;
                     _loc10_ = _loc8_;
                     _loc11_ = _loc9_;
                     _loc12_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
               _loc4_--;
            }
         }
         if(_loc30_ < this.nodesX.length - 1)
         {
            _loc10_ = Number(_loc26_.nodesX[_loc30_]);
            _loc11_ = Number(_loc26_.nodesY[_loc30_]);
            _loc12_ = 0;
            _loc4_ = int(_loc30_ + 1);
            while(_loc4_ < this.nodesX.length)
            {
               _loc13_ = Math.min(this.maxAngle,_loc12_ + this.maxDiffAngle);
               _loc5_ = _loc32_;
               while(_loc5_ < _loc13_)
               {
                  _loc6_ = Number(class_26.degreesToRads(_loc5_ + 90));
                  _loc8_ = _loc10_ + Math.sin(_loc6_) * this.partWidth;
                  _loc9_ = _loc11_ + Math.cos(_loc6_) * this.partWidth;
                  _loc7_ = Math.round(_loc8_);
                  if(_loc5_ == _loc13_ - 1 || _loc7_ >= 0 && _loc7_ < _loc26_.heightValues.length && (_loc26_.heightValues[_loc7_] >= _loc9_ || _loc5_ == _loc13_ - 1))
                  {
                     _loc26_.nodesX[_loc4_] = _loc8_;
                     _loc26_.nodesY[_loc4_] = _loc9_;
                     _loc10_ = _loc8_;
                     _loc11_ = _loc9_;
                     _loc12_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc26_.nodesX.length)
         {
            _loc26_.fallingNodesY[_loc4_] = 0 - _loc29_ - _loc26_.sandwich.breadHeight;
            _loc26_.fallingNodesX[_loc4_] = this.leftEdge + _loc4_ * _loc26_.partWidth;
            if(param2 != -1)
            {
               _loc26_.fallingNodesX[_loc4_] = _loc26_.nodesX[_loc4_];
               _loc26_.fallingNodesY[_loc4_] = _loc26_.nodesY[_loc4_];
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc26_.numParts)
         {
            _loc16_ = _loc26_.clip["piece" + (_loc4_ + 1)];
            _loc17_ = Number(_loc26_.fallingNodesX[_loc4_]);
            _loc18_ = Number(_loc26_.fallingNodesY[_loc4_]);
            _loc19_ = Number(_loc26_.fallingNodesX[_loc4_ + 1]);
            _loc20_ = Number(_loc26_.fallingNodesY[_loc4_ + 1]);
            _loc21_ = Math.atan2(_loc20_ - _loc18_,_loc19_ - _loc17_);
            _loc22_ = class_26.radsToDegrees(_loc21_) * -1;
            _loc23_ = _loc17_ - this.leftEdge + this.partXoffset;
            _loc24_ = 0 - _loc18_ + this.partYoffset - _loc26_.sandwich.breadHeight;
            _loc25_ = new Matrix();
            _loc25_.b = Math.tan(_loc22_ / 180 * Math.PI);
            _loc25_.tx = _loc23_;
            _loc25_.ty = _loc24_;
            _loc16_.transform.matrix = _loc25_;
            _loc16_.scaleX = 1;
            _loc16_.scaleY = 1;
            _loc4_++;
         }
         _loc26_.sandwich.addToppingToMap(_loc26_);
      }
      
      public function updateFallingSolid() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:MovieClip = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Matrix = null;
         var _loc16_:Topping = this;
         var _loc17_:Number = 0;
         if(_loc16_.solidHasLanded)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc16_.fallingNodesX.length)
            {
               _loc2_ = _loc16_.nodesX[_loc1_] - _loc16_.fallingNodesX[_loc1_];
               _loc3_ = _loc16_.nodesY[_loc1_] - _loc16_.fallingNodesY[_loc1_];
               _loc16_.fallingNodesX[_loc1_] += _loc2_ / 2;
               _loc16_.fallingNodesY[_loc1_] += _loc3_ / 2;
               if(Math.abs(_loc2_) <= 1 && Math.abs(_loc3_) <= 1)
               {
                  _loc16_.fallingNodesX[_loc1_] = _loc16_.nodesX[_loc1_];
                  _loc16_.fallingNodesY[_loc1_] = _loc16_.nodesY[_loc1_];
                  _loc17_++;
               }
               _loc1_++;
            }
         }
         else
         {
            if(_loc16_.solidFallSpeed < _loc16_.solidFallSpeedMax)
            {
               _loc16_.solidFallSpeed += _loc16_.solidFallSpeedChange;
               if(_loc16_.solidFallSpeed > _loc16_.solidFallSpeedMax)
               {
                  _loc16_.solidFallSpeed = _loc16_.solidFallSpeedMax;
               }
            }
            _loc1_ = 0;
            while(_loc1_ < _loc16_.fallingNodesX.length)
            {
               _loc16_.fallingNodesY[_loc1_] -= _loc16_.solidFallSpeed;
               if(_loc16_.fallingNodesY[_loc1_] < _loc16_.nodesY[_loc1_])
               {
                  _loc16_.fallingNodesY[_loc1_] = _loc16_.nodesY[_loc1_];
                  _loc16_.solidHasLanded = true;
                  if(!_loc16_.playedLandingSound)
                  {
                     _loc16_.gameObj.var_129.playSound("droptopping.wav");
                     _loc16_.playedLandingSound = true;
                  }
               }
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < _loc16_.numParts)
         {
            _loc4_ = _loc16_.clip["piece" + (_loc1_ + 1)];
            _loc5_ = Number(_loc16_.fallingNodesX[_loc1_]);
            _loc6_ = Number(_loc16_.fallingNodesY[_loc1_]);
            _loc7_ = Number(_loc16_.fallingNodesX[_loc1_ + 1]);
            _loc8_ = Number(_loc16_.fallingNodesY[_loc1_ + 1]);
            _loc9_ = Math.atan2(_loc8_ - _loc6_,_loc7_ - _loc5_);
            _loc10_ = class_26.radsToDegrees(_loc9_) * -1;
            _loc11_ = Math.sqrt((_loc7_ - _loc5_) * (_loc7_ - _loc5_) + (_loc8_ - _loc6_) * (_loc8_ - _loc6_));
            _loc12_ = _loc11_ / _loc16_.partWidth + 0.02;
            _loc13_ = _loc5_ - _loc16_.leftEdge + this.partXoffset;
            _loc14_ = 0 - _loc6_ + this.partYoffset - _loc16_.sandwich.breadHeight;
            _loc15_ = new Matrix();
            _loc15_.b = Math.tan(_loc10_ / 180 * Math.PI);
            _loc15_.tx = _loc13_;
            _loc15_.ty = _loc14_;
            _loc4_.transform.matrix = _loc15_;
            _loc4_.scaleX = Math.max(1,_loc12_);
            _loc4_.scaleY = 1;
            _loc1_++;
         }
         if(_loc17_ == _loc16_.nodesX.length)
         {
            _loc16_.isDropping = false;
            _loc16_.clip.cacheAsBitmap = true;
         }
      }
      
      public function loseClump(param1:MovieClip, param2:Number) : void
      {
         var _loc3_:Topping = this;
         var _loc4_:Number = Number(param1.targetY);
         if(param1.targetY < 0 - _loc3_.dragOffsetY)
         {
            _loc3_.sandwich.fallenBottomClip.addChild(param1);
         }
         else
         {
            _loc3_.sandwich.fallenTopClip.addChild(param1);
         }
         param1.x += _loc3_.clip.x;
         param1.y += _loc3_.clip.y;
         param1.targetX = param1.x;
         param1.targetY = _loc4_ - 3;
         param1.preventCheck = true;
         param1.pastThreshhold = true;
      }
      
      public function flipTopping(param1:Boolean, param2:Number) : void
      {
         var _loc3_:Topping = this;
         _loc3_.prepareToAdd(_loc3_.sandwich,param2,param1);
      }
      
      public function destroy() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Topping = this;
         _loc2_.sandwich = null;
         _loc2_.toppingData = null;
         _loc2_.heightValues = null;
         _loc2_.nodesX = null;
         _loc2_.nodesY = null;
         _loc2_.fallingNodesX = null;
         _loc2_.fallingNodesY = null;
         if(_loc2_.clumpData != null && _loc2_.clumpData.length > 0)
         {
            _loc1_ = int(_loc2_.clumpData.length - 1);
            while(_loc1_ >= 0)
            {
               _loc2_.clumpData[_loc1_] = null;
               _loc2_.clumpData.splice(_loc1_,1);
               _loc1_--;
            }
         }
         _loc2_.clumpData = null;
         if(_loc2_.clumps != null && _loc2_.clumps.length > 0)
         {
            _loc1_ = int(_loc2_.clumps.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc2_.clumps[_loc1_].parent)
               {
                  _loc2_.clumps[_loc1_].parent.removeChild(_loc2_.clumps[_loc1_]);
               }
               _loc2_.clumps[_loc1_] = null;
               _loc2_.clumps.splice(_loc1_,1);
               _loc1_--;
            }
         }
         _loc2_.clumps = null;
         if(_loc2_.dripClip)
         {
            if(_loc2_.dripClip.parent)
            {
               _loc2_.dripClip.parent.removeChild(_loc2_.dripClip);
            }
            _loc2_.dripClip = null;
         }
         if(_loc2_.splatClip)
         {
            if(_loc2_.splatClip.parent)
            {
               _loc2_.splatClip.parent.removeChild(_loc2_.splatClip);
            }
            _loc2_.splatClip = null;
         }
         if(_loc2_.clip)
         {
            if(_loc2_.clip.parent)
            {
               _loc2_.clip.parent.removeChild(_loc2_.clip);
            }
            _loc2_.clip = null;
         }
      }
      
      public function getSauceData(param1:Number) : Array
      {
         if(param1 > 24)
         {
            param1 = 24;
         }
         else if(param1 < 24 * -1)
         {
            param1 = 24 * -1;
         }
         var _loc2_:Number = param1 / 24;
         var _loc3_:Number = 1 - Math.abs(_loc2_ * 0.3);
         return [_loc2_ * 10,_loc3_,param1,Math.abs(_loc2_ * 4)];
      }
      
      public function cleanupAfterBuild() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Object = null;
         var _loc3_:Topping = this;
         if(_loc3_.isSauce)
         {
            if(_loc3_.dripClip)
            {
               if(_loc3_.dripClip.parent)
               {
                  _loc3_.dripClip.parent.removeChild(_loc3_.dripClip);
               }
               _loc3_.dripClip = null;
            }
            if(_loc3_.splatClip)
            {
               if(_loc3_.splatClip.parent)
               {
                  _loc3_.splatClip.parent.removeChild(_loc3_.splatClip);
               }
               _loc3_.splatClip = null;
            }
         }
         else if(!_loc3_.isSolid)
         {
            if(_loc3_.isClumps)
            {
               _loc3_.clumpData = new Vector.<Object>();
               _loc1_ = 0;
               while(_loc1_ < _loc3_.clumps.length)
               {
                  _loc2_ = new Object();
                  _loc2_.relativeX = _loc3_.clumps[_loc1_].relativeX;
                  _loc2_.relativeY = _loc3_.clumps[_loc1_].relativeY;
                  _loc2_.targetX = _loc3_.clumps[_loc1_].targetX;
                  _loc2_.targetY = _loc3_.clumps[_loc1_].targetY;
                  _loc2_.isOutside = _loc3_.clumps[_loc1_].isOutside;
                  _loc3_.clumpData.push(_loc2_);
                  _loc1_++;
               }
               _loc1_ = int(_loc3_.clumps.length - 1);
               while(_loc1_ >= 0)
               {
                  if(_loc3_.clumps[_loc1_].parent)
                  {
                     _loc3_.clumps[_loc1_].parent.removeChild(_loc3_.clumps[_loc1_]);
                  }
                  _loc3_.clumps[_loc1_] = null;
                  _loc3_.clumps.splice(_loc1_,1);
                  _loc1_--;
               }
               _loc3_.clumps = null;
            }
         }
         if(_loc3_.clip)
         {
            if(_loc3_.clip.parent)
            {
               _loc3_.clip.parent.removeChild(_loc3_.clip);
            }
            _loc3_.clip = null;
         }
      }
   }
}


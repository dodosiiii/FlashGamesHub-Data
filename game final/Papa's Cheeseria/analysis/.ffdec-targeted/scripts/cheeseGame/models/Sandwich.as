package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.screens.GrillScreen;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class Sandwich
   {
      
      public var gameObj:class_5;
      
      public var foodOrder:FoodOrder;
      
      public var clip:MovieClip = null;
      
      public var container:MovieClip = null;
      
      public var isFlippedVersion:Boolean = false;
      
      public var shadowBitmap:BitmapData = null;
      
      public var shadowOffsetX:Number = 0;
      
      public var shadowOffsetY:Number = 0;
      
      public var maskBitmap:BitmapData = null;
      
      public var blankShadowBitmap:BitmapData = null;
      
      public var breadType:String = null;
      
      public var cheeseType1:String = null;
      
      public var cheeseType2:String = null;
      
      public var breadHeight:Number = 0;
      
      public var cheeseHeight:Number = 5;
      
      public var cheese1OffsetX:Number = 0;
      
      public var cheese2OffsetX:Number = 0;
      
      public var breadSkewAmount:Number = 0;
      
      public var cheeseSkewAmount:Number = 0;
      
      public var topSkewDropOffset:Number = 0;
      
      public var topCheeseSkewDropOffset:Number = 0;
      
      public var waxpaperClip1:MovieClip = null;
      
      public var waxpaperClip2:MovieClip = null;
      
      public var breadClip1:MovieClip = null;
      
      public var breadClip2:MovieClip = null;
      
      public var cheeseClip1:MovieClip = null;
      
      public var cheeseClip2:MovieClip = null;
      
      public var toppingClip:MovieClip = null;
      
      public var fallenTopClip:MovieClip = null;
      
      public var fallenBottomClip:MovieClip = null;
      
      public var cheeseCutClip:MovieClip = null;
      
      public var sliceClip:MovieClip = null;
      
      public var breadStartX:Number = 0;
      
      public var breadStartY:Number = 0;
      
      public var clipTargetX:Number = 245;
      
      public var clipTargetY:Number = 366;
      
      public var bread1CheesingTargetX:Number = -65;
      
      public var bread1CheesingTargetY:Number = 54;
      
      public var bread2CheesingTargetX:Number = 113;
      
      public var bread2CheesingTargetY:Number = 54;
      
      public var bread1BuildTargetX:Number = 0;
      
      public var bread1BuildTargetY:Number = 0;
      
      public var bread2BuildTargetX:Number = 319;
      
      public var bread2BuildTargetY:Number = 44;
      
      public var bread2TopTargetX:Number;
      
      public var bread2TopTargetY:Number;
      
      public var bread2TopTargetYStartSkew:Number;
      
      public var bread2TopTargetSkew:Number;
      
      public var cheese2TopTargetX:Number;
      
      public var cheese2TopTargetY:Number;
      
      public var cheese2TopTargetYStartSkew:Number;
      
      public var cheese2TopTargetSkew:Number;
      
      public var waxpaper1StartX:Number = 640;
      
      public var waxpaper2StartX:Number = 980;
      
      public var maxCheeseAllowedOffX:Number = 30;
      
      public var maxToppingAllowedOffX:Number = 70;
      
      public var flipSkews:Array;
      
      public var flipScalesY:Array;
      
      public var flipScalesX:Array;
      
      public var dropBreadSpeed:Number = 4;
      
      public var dropCheeseSpeed:Number = 10;
      
      public var dropSpeedChange:Number = 2;
      
      public var currentFlipFrame:Number = 0;
      
      public var flipDirection:Number = 1;
      
      public var numSaucesAdded:Number = 0;
      
      public var trashTargetX:Number = 800;
      
      public var trashSpeed:Number = 40;
      
      public var grillWaitOffscreenY:Number = 600;
      
      public var grillScale:Number = 0.75;
      
      public var flipMaxDist:Number = 5;
      
      public var isShowingGrease:Boolean = false;
      
      public var flipHeightOffset:Number = -100;
      
      public var flipRotateDegreesPerFrame:Number = 30;
      
      public var flipRotateOffsetPerFrame:Number = -3;
      
      public var flipScaleTop:Number = 0.65;
      
      public var flipLandScaleX:Number = 0.8;
      
      public var flipLandScaleY:Number = 0.65;
      
      public var flipLandOffsetY:Number = 3;
      
      public var flipIsRotating:Boolean = false;
      
      public var isFlipFalling:Boolean = false;
      
      public var isFlipSquashing:Boolean = false;
      
      public var isFlipFinishSquashing:Boolean = false;
      
      public var isFlipRotating:Boolean = false;
      
      public var flipUseRotation:Number = 0;
      
      public var flipFallSpeedStart:Number = 8;
      
      public var flipFallSpeed:Number = 8;
      
      public var flipFallSpeedChange:Number = 4;
      
      public var toppings:Vector.<Topping> = null;
      
      public var topBitmap:Bitmap = null;
      
      public var bottomBitmap:Bitmap = null;
      
      public var previousBottomBitmap:Bitmap = null;
      
      public var topBitmapData:BitmapData = null;
      
      public var bottomBitmapData:BitmapData = null;
      
      public var previousBottomBitmapData:BitmapData = null;
      
      public var topNormalSheet:BitmapData = null;
      
      public var bottomNormalSheet:BitmapData = null;
      
      public var topFlippedSheet:BitmapData = null;
      
      public var bottomFlippedSheet:BitmapData = null;
      
      public var bitmapHolder:MovieClip = null;
      
      public var spriteWidth:Number = 0;
      
      public var spriteHeight:Number = 0;
      
      public var flipSpriteWidth:Number = 0;
      
      public var flipSpriteHeight:Number = 0;
      
      public var numFrames:Number = 12;
      
      public var topFrame:Number = 0;
      
      public var bottomFrame:Number = 0;
      
      public var targetTopFrame:Number = 0;
      
      public var targetBottomFrame:Number = 0;
      
      public var isBitmapFlipped:Boolean = false;
      
      public var bitmapXNormal:Number = 0;
      
      public var bitmapXFlipped:Number = 0;
      
      public var canAddToppings:Boolean = false;
      
      public var canAddCheese:Boolean = false;
      
      public var topBreadIsAdded:Boolean = false;
      
      public var spritesCreated:Boolean = false;
      
      public var isOnBuild:Boolean = true;
      
      public var isOnGrill:Boolean = false;
      
      public var isOnFry:Boolean = false;
      
      public var isAddingBread:Boolean = true;
      
      public var isAddingCheese:Boolean = false;
      
      public var isPreparingForTopping:Boolean = false;
      
      public var isDraggingTopBread:Boolean = false;
      
      public var isReturningTopBread:Boolean = false;
      
      public var isAddingTopBread:Boolean = false;
      
      public var isMovingFromBuild:Boolean = false;
      
      public var isTrashingBuild:Boolean = false;
      
      public var isMovingToGrillTray:Boolean = false;
      
      public var isTrashingGrill:Boolean = false;
      
      public var isLeavingGrill:Boolean = false;
      
      public var isGrabbing:Boolean = false;
      
      public var isGrabbingMoving:Boolean = false;
      
      public var grabX:Number = 0;
      
      public var grabY:Number = 0;
      
      public var isReturningToTray:Boolean = false;
      
      public var isReturningToCook:Boolean = false;
      
      public var isCooking:Boolean = false;
      
      public var isFlipping:Boolean = false;
      
      public var isCut:Boolean = false;
      
      public var isCutting:Boolean = false;
      
      public var cutSpacing:Number = 10;
      
      public var cutLocationX:Number = 0;
      
      public var cutLeftTargetX:Number = 0;
      
      public var cutRightTargetX:Number = 0;
      
      public var cutTimer:Number = 0;
      
      public var cutTimerSplit:Number = 5;
      
      public var cutTimerLeave:Number = 12;
      
      public var topTime:Number = 0;
      
      public var bottomTime:Number = 0;
      
      public var dragOffsetY:Number = 30;
      
      public var whichGrillSpot:Number = -1;
      
      public var isTimerActivated:Boolean = false;
      
      public var timerType:String = "none";
      
      public function Sandwich(param1:class_5, param2:String, param3:Number, param4:Number)
      {
         this.flipSkews = [0,22.5,45,-45,-22.5,0];
         this.flipScalesY = [1,1.2,1.4,1.4,1.2,1];
         this.flipScalesX = [1,0.9,0.8,0.8,0.9,1];
         super();
         var _loc5_:Sandwich = this;
         class_7.method_1("NEW SANDWICH");
         _loc5_.gameObj = param1;
         _loc5_.breadType = param2;
         _loc5_.breadStartX = param3;
         _loc5_.breadStartY = param4;
         _loc5_.breadHeight = _loc5_.gameObj.toppingData.getBreadHeight(_loc5_.breadType);
         _loc5_.setupSandwich();
      }
      
      public function setupSandwich() : void
      {
         var _loc4_:Matrix = null;
         var _loc1_:Sandwich = this;
         _loc1_.clip = new MovieClip();
         _loc1_.clip.x = _loc1_.clipTargetX;
         _loc1_.clip.y = _loc1_.clipTargetY;
         _loc1_.gameObj.var_139.clip.holder.addChild(_loc1_.clip);
         _loc1_.waxpaperClip1 = new build_bread_waxpaper();
         _loc1_.waxpaperClip2 = new build_bread_waxpaper();
         _loc1_.waxpaperClip1.y = _loc1_.bread1CheesingTargetY;
         _loc1_.waxpaperClip1.x = _loc1_.waxpaper1StartX;
         _loc1_.waxpaperClip2.y = _loc1_.bread2CheesingTargetY;
         _loc1_.waxpaperClip2.x = _loc1_.waxpaper2StartX;
         _loc1_.waxpaperClip2.scaleX = -1;
         _loc1_.clip.addChild(_loc1_.waxpaperClip1);
         _loc1_.clip.addChild(_loc1_.waxpaperClip2);
         _loc1_.fallenBottomClip = new MovieClip();
         _loc1_.clip.addChild(_loc1_.fallenBottomClip);
         _loc1_.breadClip1 = class_12.method_103("clip_" + _loc1_.breadType,false,false);
         _loc1_.breadClip2 = class_12.method_103("clip_" + _loc1_.breadType,false,false);
         _loc1_.breadClip1.gotoAndStop(1);
         _loc1_.breadClip2.gotoAndStop(1);
         _loc1_.breadClip1.x = _loc1_.breadStartX - _loc1_.clipTargetX;
         _loc1_.breadClip1.y = _loc1_.breadStartY - _loc1_.clipTargetY;
         _loc1_.breadClip2.x = _loc1_.breadStartX - _loc1_.clipTargetX;
         _loc1_.breadClip2.y = _loc1_.breadStartY - _loc1_.clipTargetY - _loc1_.breadHeight;
         _loc1_.clip.addChild(_loc1_.breadClip1);
         _loc1_.clip.addChild(_loc1_.breadClip2);
         var _loc2_:MovieClip = class_12.method_103("shadow_" + _loc1_.breadType,false,false);
         var _loc3_:Rectangle = _loc2_.getRect(_loc2_);
         this.shadowOffsetX = Math.round(0 - _loc3_.x);
         this.shadowOffsetY = Math.round(0 - _loc3_.y);
         _loc1_.shadowBitmap = new BitmapData(Math.round(_loc2_.width),Math.round(_loc2_.height),true,4294901760);
         _loc4_ = new Matrix();
         _loc4_.tx = this.shadowOffsetX;
         _loc4_.ty = this.shadowOffsetY;
         _loc1_.shadowBitmap.draw(_loc2_,_loc4_,null,null,null,true);
         _loc2_ = null;
         _loc3_ = null;
         _loc4_ = null;
      }
      
      public function cleanupAllMovieClips() : void
      {
         var _loc1_:Sandwich = this;
         if(_loc1_.breadClip1 != null)
         {
            if(_loc1_.breadClip1.parent)
            {
               _loc1_.breadClip1.parent.removeChild(_loc1_.breadClip1);
            }
         }
         if(_loc1_.breadClip2 != null)
         {
            if(_loc1_.breadClip2.parent)
            {
               _loc1_.breadClip2.parent.removeChild(_loc1_.breadClip2);
            }
         }
         if(_loc1_.cheeseClip1 != null)
         {
            if(_loc1_.cheeseClip1.parent)
            {
               _loc1_.cheeseClip1.parent.removeChild(_loc1_.cheeseClip1);
            }
         }
         if(_loc1_.cheeseClip2 != null)
         {
            if(_loc1_.cheeseClip2.parent)
            {
               _loc1_.cheeseClip2.parent.removeChild(_loc1_.cheeseClip2);
            }
         }
         if(_loc1_.toppingClip != null)
         {
            if(_loc1_.toppingClip.parent)
            {
               _loc1_.toppingClip.parent.removeChild(_loc1_.toppingClip);
            }
         }
         if(_loc1_.shadowBitmap != null)
         {
            _loc1_.shadowBitmap.dispose();
            _loc1_.shadowBitmap = null;
         }
         if(_loc1_.maskBitmap != null)
         {
            _loc1_.maskBitmap.dispose();
            _loc1_.maskBitmap = null;
         }
         if(_loc1_.blankShadowBitmap != null)
         {
            _loc1_.blankShadowBitmap.dispose();
            _loc1_.blankShadowBitmap = null;
         }
         if(_loc1_.breadClip2)
         {
            _loc1_.breadClip2.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickTopBread);
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.toppings.length)
         {
            if(_loc1_.toppings[_loc2_] != null)
            {
               _loc1_.toppings[_loc2_].cleanupAfterBuild();
            }
            _loc2_++;
         }
         _loc1_.breadClip1 = null;
         _loc1_.breadClip2 = null;
         _loc1_.cheeseClip1 = null;
         _loc1_.cheeseClip2 = null;
         _loc1_.toppingClip = null;
         _loc1_.waxpaperClip1 = null;
         _loc1_.waxpaperClip2 = null;
         _loc1_.fallenBottomClip = null;
         _loc1_.fallenTopClip = null;
      }
      
      public function cleanupSprites() : void
      {
         var _loc1_:Sandwich = this;
         if(_loc1_.topBitmap)
         {
            if(_loc1_.topBitmap.parent)
            {
               _loc1_.topBitmap.parent.removeChild(_loc1_.topBitmap);
            }
            _loc1_.topBitmap.bitmapData = null;
            _loc1_.topBitmap = null;
         }
         if(_loc1_.bottomBitmap)
         {
            if(_loc1_.bottomBitmap.parent)
            {
               _loc1_.bottomBitmap.parent.removeChild(_loc1_.bottomBitmap);
            }
            _loc1_.bottomBitmap.bitmapData = null;
            _loc1_.bottomBitmap = null;
         }
         if(_loc1_.previousBottomBitmap)
         {
            if(_loc1_.previousBottomBitmap.parent)
            {
               _loc1_.previousBottomBitmap.parent.removeChild(_loc1_.previousBottomBitmap);
            }
            _loc1_.previousBottomBitmap.bitmapData = null;
            _loc1_.previousBottomBitmap = null;
         }
         if(_loc1_.topBitmapData != null)
         {
            _loc1_.topBitmapData.dispose();
            _loc1_.topBitmapData = null;
         }
         if(_loc1_.bottomBitmapData != null)
         {
            _loc1_.bottomBitmapData.dispose();
            _loc1_.bottomBitmapData = null;
         }
         if(_loc1_.previousBottomBitmapData != null)
         {
            _loc1_.previousBottomBitmapData.dispose();
            _loc1_.previousBottomBitmapData = null;
         }
         if(_loc1_.topNormalSheet != null)
         {
            _loc1_.topNormalSheet.dispose();
            _loc1_.topNormalSheet = null;
         }
         if(_loc1_.topFlippedSheet != null)
         {
            _loc1_.topFlippedSheet.dispose();
            _loc1_.topFlippedSheet = null;
         }
         if(_loc1_.bottomNormalSheet != null)
         {
            _loc1_.bottomNormalSheet.dispose();
            _loc1_.bottomNormalSheet = null;
         }
         if(_loc1_.bottomFlippedSheet != null)
         {
            _loc1_.bottomFlippedSheet.dispose();
            _loc1_.bottomFlippedSheet = null;
         }
         if(_loc1_.bitmapHolder != null)
         {
            if(_loc1_.bitmapHolder.parent)
            {
               _loc1_.bitmapHolder.parent.removeChild(_loc1_.bitmapHolder);
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Sandwich = this;
         class_7.method_1("DESTROY SANDWICH");
         _loc2_.cleanupSprites();
         if(_loc2_.waxpaperClip1 != null)
         {
            if(_loc2_.waxpaperClip1.parent)
            {
               _loc2_.waxpaperClip1.parent.removeChild(_loc2_.waxpaperClip1);
            }
         }
         if(_loc2_.waxpaperClip2 != null)
         {
            if(_loc2_.waxpaperClip2.parent)
            {
               _loc2_.waxpaperClip2.parent.removeChild(_loc2_.waxpaperClip2);
            }
         }
         if(_loc2_.breadClip1 != null)
         {
            if(_loc2_.breadClip1.parent)
            {
               _loc2_.breadClip1.parent.removeChild(_loc2_.breadClip1);
            }
         }
         if(_loc2_.breadClip2 != null)
         {
            if(_loc2_.breadClip2.parent)
            {
               _loc2_.breadClip2.parent.removeChild(_loc2_.breadClip2);
            }
         }
         if(_loc2_.cheeseClip1 != null)
         {
            if(_loc2_.cheeseClip1.parent)
            {
               _loc2_.cheeseClip1.parent.removeChild(_loc2_.cheeseClip1);
            }
         }
         if(_loc2_.cheeseClip2 != null)
         {
            if(_loc2_.cheeseClip2.parent)
            {
               _loc2_.cheeseClip2.parent.removeChild(_loc2_.cheeseClip2);
            }
         }
         if(_loc2_.toppingClip != null)
         {
            if(_loc2_.toppingClip.parent)
            {
               _loc2_.toppingClip.parent.removeChild(_loc2_.toppingClip);
            }
         }
         if(_loc2_.cheeseCutClip != null)
         {
            if(_loc2_.cheeseCutClip.parent)
            {
               _loc2_.cheeseCutClip.parent.removeChild(_loc2_.cheeseCutClip);
            }
         }
         if(_loc2_.sliceClip != null)
         {
            if(_loc2_.sliceClip.parent)
            {
               _loc2_.sliceClip.parent.removeChild(_loc2_.sliceClip);
            }
         }
         if(_loc2_.toppings != null && _loc2_.toppings.length > 0)
         {
            _loc1_ = int(_loc2_.toppings.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc2_.toppings[_loc1_] != null)
               {
                  _loc2_.toppings[_loc1_].destroy();
                  _loc2_.toppings[_loc1_] = null;
               }
               _loc2_.toppings.splice(_loc1_,1);
               _loc1_--;
            }
         }
         _loc2_.toppings = null;
         if(_loc2_.fallenTopClip != null)
         {
            if(_loc2_.fallenTopClip.parent)
            {
               _loc2_.fallenTopClip.parent.removeChild(_loc2_.fallenTopClip);
            }
         }
         if(_loc2_.fallenBottomClip != null)
         {
            if(_loc2_.fallenBottomClip.parent)
            {
               _loc2_.fallenBottomClip.parent.removeChild(_loc2_.fallenBottomClip);
            }
         }
         if(_loc2_.shadowBitmap != null)
         {
            _loc2_.shadowBitmap.dispose();
            _loc2_.shadowBitmap = null;
         }
         if(_loc2_.maskBitmap != null)
         {
            _loc2_.maskBitmap.dispose();
            _loc2_.maskBitmap = null;
         }
         if(_loc2_.blankShadowBitmap != null)
         {
            _loc2_.blankShadowBitmap.dispose();
            _loc2_.blankShadowBitmap = null;
         }
         _loc2_.clip.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.grabSandwich);
         if(_loc2_.breadClip2)
         {
            _loc2_.breadClip2.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickTopBread);
         }
         _loc2_.waxpaperClip1 = null;
         _loc2_.waxpaperClip2 = null;
         _loc2_.fallenBottomClip = null;
         _loc2_.fallenTopClip = null;
         _loc2_.breadClip1 = null;
         _loc2_.breadClip2 = null;
         _loc2_.cheeseClip1 = null;
         _loc2_.cheeseClip2 = null;
         _loc2_.toppingClip = null;
         _loc2_.cheeseCutClip = null;
         _loc2_.sliceClip = null;
         if(_loc2_.clip != null)
         {
            if(_loc2_.clip.parent)
            {
               _loc2_.clip.parent.removeChild(_loc2_.clip);
            }
         }
         _loc2_.clip = null;
      }
      
      public function updateSandwich() : void
      {
         var _loc1_:Sandwich = this;
         if(_loc1_.isOnBuild)
         {
            _loc1_.updateSandwichOnBuild();
         }
         else if(_loc1_.isOnGrill)
         {
            _loc1_.updateSandwichOnGrill();
         }
      }
      
      public function updateSandwichOnBuild() : void
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
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:int = 0;
         var _loc19_:Sandwich = this;
         if(_loc19_.isAddingBread || _loc19_.isPreparingForTopping && !_loc19_.isAddingCheese)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 0;
            if(_loc19_.isAddingBread)
            {
               _loc1_ = _loc19_.bread1CheesingTargetX;
               _loc2_ = _loc19_.bread1CheesingTargetY;
               _loc3_ = _loc19_.bread2CheesingTargetX;
               _loc4_ = _loc19_.bread2CheesingTargetY;
            }
            else if(_loc19_.isPreparingForTopping)
            {
               _loc1_ = _loc19_.bread1BuildTargetX;
               _loc2_ = _loc19_.bread1BuildTargetY;
               _loc3_ = _loc19_.bread2BuildTargetX;
               _loc4_ = _loc19_.bread2BuildTargetY;
            }
            _loc5_ = _loc1_ - _loc19_.breadClip1.x;
            _loc6_ = _loc2_ - _loc19_.breadClip1.y;
            _loc7_ = _loc3_ - _loc19_.breadClip2.x;
            _loc8_ = _loc4_ - _loc19_.breadClip2.y;
            _loc9_ = 3;
            _loc19_.breadClip1.x += _loc5_ / _loc9_;
            _loc19_.breadClip1.y += _loc6_ / _loc9_;
            _loc19_.breadClip2.x += _loc7_ / _loc9_;
            _loc19_.breadClip2.y += _loc8_ / _loc9_;
            _loc10_ = _loc1_ - _loc19_.waxpaperClip1.x;
            _loc11_ = _loc2_ - _loc19_.waxpaperClip1.y;
            _loc12_ = _loc3_ - _loc19_.waxpaperClip2.x;
            _loc13_ = _loc4_ - _loc19_.waxpaperClip2.y;
            _loc19_.waxpaperClip1.x += _loc10_ / _loc9_;
            _loc19_.waxpaperClip1.y += _loc11_ / _loc9_;
            _loc19_.waxpaperClip2.x += _loc12_ / _loc9_;
            _loc19_.waxpaperClip2.y += _loc13_ / _loc9_;
            if(Math.abs(_loc5_) <= 1 && Math.abs(_loc6_) <= 1 && Math.abs(_loc7_) <= 1 && Math.abs(_loc8_) <= 1)
            {
               _loc19_.breadClip1.x = _loc1_;
               _loc19_.breadClip1.y = _loc2_;
               _loc19_.breadClip2.x = _loc3_;
               _loc19_.breadClip2.y = _loc4_;
               _loc19_.waxpaperClip1.x = _loc1_;
               _loc19_.waxpaperClip1.y = _loc2_;
               _loc19_.waxpaperClip2.x = _loc3_;
               _loc19_.waxpaperClip2.y = _loc4_;
               if(_loc19_.isAddingBread)
               {
                  _loc19_.isAddingBread = false;
                  _loc19_.canAddCheese = true;
               }
               else if(_loc19_.isPreparingForTopping)
               {
                  _loc19_.isPreparingForTopping = false;
                  _loc19_.canAddToppings = true;
                  class_7.method_1("(Done preparing)");
               }
            }
            if(_loc19_.cheeseClip1 != null)
            {
               _loc19_.cheeseClip1.x = _loc19_.breadClip1.x + _loc19_.cheese1OffsetX;
               _loc19_.cheeseClip1.y = _loc19_.breadClip1.y - _loc19_.breadHeight;
            }
            if(_loc19_.cheeseClip2 != null)
            {
               _loc19_.cheeseClip2.x = _loc19_.breadClip2.x + _loc19_.cheese2OffsetX;
               _loc19_.cheeseClip2.y = _loc19_.breadClip2.y - _loc19_.breadHeight;
            }
         }
         else if(_loc19_.isAddingCheese)
         {
            if(_loc19_.cheeseClip1 != null)
            {
               _loc19_.cheeseClip1.x = _loc19_.breadClip1.x + _loc19_.cheese1OffsetX;
               _loc14_ = _loc19_.breadClip1.y - _loc19_.breadHeight;
               _loc15_ = _loc14_ - _loc19_.cheeseClip1.y;
               _loc19_.cheeseClip1.y += _loc15_ / 2;
               if(Math.abs(_loc15_) <= 2)
               {
                  _loc19_.cheeseClip1.y = _loc14_;
               }
            }
            if(_loc19_.cheeseClip2 != null)
            {
               _loc19_.cheeseClip2.x = _loc19_.breadClip2.x + _loc19_.cheese2OffsetX;
               _loc16_ = _loc19_.breadClip2.y - _loc19_.breadHeight;
               _loc17_ = _loc16_ - _loc19_.cheeseClip2.y;
               _loc19_.cheeseClip2.y += _loc17_ / 2;
               if(Math.abs(_loc17_) <= 2)
               {
                  _loc19_.cheeseClip2.y = _loc16_;
               }
            }
            if(_loc19_.cheeseClip1 != null && _loc19_.cheeseClip2 != null && _loc19_.cheeseClip1.y == _loc19_.breadClip1.y - _loc19_.breadHeight && _loc19_.cheeseClip2.y == _loc19_.breadClip2.y - _loc19_.breadHeight)
            {
               class_7.method_1("Cheeses are done being added!");
               _loc19_.isAddingCheese = false;
            }
         }
         if(_loc19_.toppings != null && _loc19_.toppings.length > 0)
         {
            _loc18_ = 0;
            while(_loc18_ < _loc19_.toppings.length)
            {
               if(_loc19_.toppings[_loc18_] != null)
               {
                  _loc19_.toppings[_loc18_].updateTopping();
               }
               _loc18_++;
            }
         }
         if(_loc19_.isTrashingBuild)
         {
            _loc19_.trashSpeed += 10;
            _loc19_.clip.x += _loc19_.trashSpeed;
            if(_loc19_.clip.x > _loc19_.trashTargetX)
            {
               _loc19_.isOnBuild = false;
               _loc19_.isTrashingBuild = false;
               _loc19_.gameObj.var_139.removeFromLeavingSandwiches(_loc19_,true);
               return;
            }
         }
         else if(_loc19_.isMovingFromBuild)
         {
            _loc19_.trashSpeed += 10;
            _loc19_.clip.x += _loc19_.trashSpeed;
            if(_loc19_.clip.x > _loc19_.trashTargetX)
            {
               _loc19_.isOnBuild = false;
               _loc19_.gameObj.var_136.addToWaitingSandwiches(_loc19_);
               _loc19_.gameObj.var_139.removeFromLeavingSandwiches(_loc19_);
               _loc19_.gameObj.hud.startTransition("cook");
            }
         }
         if(_loc19_.isDraggingTopBread || _loc19_.isReturningTopBread || _loc19_.isAddingTopBread)
         {
            _loc19_.updateMovingTopBread();
         }
      }
      
      public function updateMovingTopBread() : void
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
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Sandwich = this;
         var _loc16_:Matrix = new Matrix();
         var _loc17_:Matrix = new Matrix();
         var _loc18_:Boolean = false;
         if(_loc15_.isDraggingTopBread)
         {
            _loc15_.currentFlipFrame += _loc15_.flipDirection;
            if(_loc15_.currentFlipFrame >= _loc15_.flipSkews.length)
            {
               _loc15_.currentFlipFrame = _loc15_.flipSkews.length - 1;
            }
            if(_loc15_.currentFlipFrame >= 3)
            {
               _loc18_ = true;
               if(_loc15_.currentFlipFrame == 3)
               {
                  _loc15_.clip.setChildIndex(_loc15_.breadClip2,_loc15_.clip.numChildren - 1);
               }
            }
            if(_loc15_.currentFlipFrame < _loc15_.flipSkews.length && _loc15_.currentFlipFrame >= 0)
            {
               _loc1_ = Number(_loc15_.flipSkews[_loc15_.currentFlipFrame]);
               _loc2_ = Number(_loc15_.flipScalesY[_loc15_.currentFlipFrame]);
               _loc3_ = Number(_loc15_.flipScalesX[_loc15_.currentFlipFrame]);
            }
            else
            {
               _loc1_ = 0;
               _loc2_ = 1;
               _loc3_ = 1;
            }
            _loc16_.b = Math.tan(_loc1_ / 180 * Math.PI);
            _loc4_ = _loc15_.gameObj.var_139.clip.mouseX - _loc15_.clip.x;
            _loc5_ = _loc15_.gameObj.var_139.clip.mouseY - _loc15_.clip.y + 30;
            _loc16_.tx = _loc4_;
            _loc16_.ty = _loc5_;
            _loc15_.breadClip2.transform.matrix = _loc16_;
            _loc15_.breadClip2.scaleX = _loc3_;
            _loc15_.breadClip2.scaleY = _loc2_;
            _loc17_.b = _loc16_.b;
            if(_loc18_)
            {
               _loc17_.tx = _loc15_.breadClip2.x - _loc15_.cheese2OffsetX;
               _loc17_.ty = _loc15_.breadClip2.y + 1;
            }
            else
            {
               _loc17_.tx = _loc15_.breadClip2.x + _loc15_.cheese2OffsetX;
               _loc17_.ty = _loc15_.breadClip2.y - _loc15_.breadHeight;
            }
            _loc15_.cheeseClip2.transform.matrix = _loc17_;
            _loc15_.cheeseClip2.scaleX = _loc3_;
            _loc15_.cheeseClip2.scaleY = _loc2_;
         }
         else if(_loc15_.isReturningTopBread)
         {
            _loc4_ = _loc15_.bread2BuildTargetX;
            _loc5_ = _loc15_.bread2BuildTargetY;
            _loc6_ = _loc4_ - _loc15_.breadClip2.x;
            _loc7_ = _loc5_ - _loc15_.breadClip2.y;
            _loc15_.currentFlipFrame += _loc15_.flipDirection;
            if(_loc15_.currentFlipFrame < 0)
            {
               _loc15_.currentFlipFrame = 0;
            }
            if(_loc15_.currentFlipFrame >= 3)
            {
               _loc18_ = true;
            }
            if(_loc15_.currentFlipFrame == 2)
            {
               _loc15_.clip.setChildIndex(_loc15_.cheeseClip2,_loc15_.clip.numChildren - 1);
            }
            if(_loc15_.currentFlipFrame < _loc15_.flipSkews.length && _loc15_.currentFlipFrame >= 0)
            {
               _loc1_ = Number(_loc15_.flipSkews[_loc15_.currentFlipFrame]);
               _loc2_ = Number(_loc15_.flipScalesY[_loc15_.currentFlipFrame]);
               _loc3_ = Number(_loc15_.flipScalesX[_loc15_.currentFlipFrame]);
            }
            else
            {
               _loc1_ = 0;
               _loc2_ = 1;
               _loc3_ = 1;
            }
            _loc16_.b = Math.tan(_loc1_ / 180 * Math.PI);
            _loc16_.tx = _loc15_.breadClip2.x + _loc6_ / 4;
            _loc16_.ty = _loc15_.breadClip2.y + _loc7_ / 4;
            _loc15_.breadClip2.transform.matrix = _loc16_;
            _loc15_.breadClip2.scaleX = _loc3_;
            _loc15_.breadClip2.scaleY = _loc2_;
            _loc17_.b = _loc16_.b;
            if(_loc18_)
            {
               _loc17_.tx = _loc15_.breadClip2.x - _loc15_.cheese2OffsetX;
               _loc17_.ty = _loc15_.breadClip2.y + 1;
            }
            else
            {
               _loc17_.tx = _loc15_.breadClip2.x + _loc15_.cheese2OffsetX;
               _loc17_.ty = _loc15_.breadClip2.y - _loc15_.breadHeight;
            }
            _loc15_.cheeseClip2.transform.matrix = _loc17_;
            _loc15_.cheeseClip2.scaleX = _loc3_;
            _loc15_.cheeseClip2.scaleY = _loc2_;
            if(Math.abs(_loc6_) <= 1 && Math.abs(_loc7_) <= 1)
            {
               class_7.method_1("Returning top bread, close enough!");
               _loc15_.breadClip2.x = _loc15_.bread2BuildTargetX;
               _loc15_.breadClip2.y = _loc15_.bread2BuildTargetY;
               _loc15_.cheeseClip2.x = _loc15_.breadClip2.x + _loc15_.cheese2OffsetX;
               _loc15_.cheeseClip2.y = _loc15_.breadClip2.y - _loc15_.breadHeight;
               _loc15_.breadClip2.scaleX = 1;
               _loc15_.cheeseClip2.scaleX = 1;
               _loc15_.breadClip2.scaleY = 1;
               _loc15_.cheeseClip2.scaleY = 1;
               _loc15_.isReturningTopBread = false;
            }
         }
         else if(_loc15_.isAddingTopBread)
         {
            _loc18_ = true;
            _loc9_ = 999;
            _loc10_ = 999;
            _loc10_ = _loc15_.bread2TopTargetSkew - _loc15_.breadSkewAmount;
            _loc15_.breadSkewAmount += _loc10_ / 3;
            _loc16_.b = Math.tan(_loc15_.breadSkewAmount / 180 * Math.PI);
            _loc16_.tx = _loc15_.breadClip2.x;
            _loc16_.ty = _loc15_.breadClip2.y;
            _loc15_.breadClip2.transform.matrix = _loc16_;
            _loc15_.breadClip2.scaleX = _loc15_.getScaleXForSkew(_loc15_.breadSkewAmount);
            _loc15_.breadClip2.scaleY = _loc15_.getScaleYForSkew(_loc15_.breadSkewAmount);
            _loc9_ = _loc15_.cheese2TopTargetSkew - _loc15_.cheeseSkewAmount;
            _loc15_.cheeseSkewAmount += _loc9_ / 3;
            _loc17_.b = Math.tan(_loc15_.cheeseSkewAmount / 180 * Math.PI);
            _loc17_.tx = _loc15_.cheeseClip2.x;
            _loc17_.ty = _loc15_.cheeseClip2.y;
            _loc15_.cheeseClip2.transform.matrix = _loc17_;
            _loc15_.cheeseClip2.scaleX = _loc15_.getScaleXForSkew(_loc15_.cheeseSkewAmount);
            _loc15_.cheeseClip2.scaleY = _loc15_.getScaleYForSkew(_loc15_.cheeseSkewAmount);
            _loc15_.gameObj.var_139.tweenToTarget(_loc15_.breadClip2,_loc15_.bread2TopTargetX,_loc15_.bread2TopTargetY,_loc15_.dropBreadSpeed,true);
            _loc15_.gameObj.var_139.tweenToTarget(_loc15_.cheeseClip2,_loc15_.cheese2TopTargetX,_loc15_.cheese2TopTargetY,_loc15_.dropCheeseSpeed,true);
            _loc11_ = _loc15_.cheese2TopTargetX - _loc15_.cheeseClip2.x;
            _loc12_ = _loc15_.cheese2TopTargetY - _loc15_.cheeseClip2.y;
            _loc13_ = _loc15_.bread2TopTargetX - _loc15_.breadClip2.x;
            _loc14_ = _loc15_.bread2TopTargetY - _loc15_.breadClip2.y;
            if(Math.abs(_loc13_) <= 1 && Math.abs(_loc14_) <= 1)
            {
               _loc15_.breadClip2.x = _loc15_.bread2TopTargetX;
               _loc15_.breadClip2.y = _loc15_.bread2TopTargetY;
            }
            if(Math.abs(_loc11_) <= 1 && Math.abs(_loc12_) <= 1)
            {
               _loc15_.cheeseClip2.x = _loc15_.cheese2TopTargetX;
               _loc15_.cheeseClip2.y = _loc15_.cheese2TopTargetY;
            }
            if(Math.abs(_loc13_) <= 1 && Math.abs(_loc14_) <= 1 && Math.abs(_loc11_) <= 1 && Math.abs(_loc12_) <= 1 && Math.abs(_loc9_) <= 0.5 && Math.abs(_loc10_) <= 0.5)
            {
               class_7.method_1("Bread and cheese done landing and skewing!");
               _loc15_.isAddingTopBread = false;
               _loc15_.gameObj.var_129.playSound("droptopping.wav");
               _loc15_.gameObj.var_129.playSound("trayslide.wav");
               _loc15_.isMovingFromBuild = true;
               _loc15_.gameObj.var_139.addToLeavingSandwiches(_loc15_);
               _loc15_.gameObj.var_139.removeCurrentOrder(false);
            }
            _loc15_.dropBreadSpeed += _loc15_.dropSpeedChange;
            _loc15_.dropCheeseSpeed += _loc15_.dropSpeedChange;
         }
      }
      
      public function updateSandwichOnGrill() : void
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
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Sandwich = this;
         if(_loc14_.isFlipping)
         {
            if(_loc14_.isFlipFalling)
            {
               _loc3_ = _loc14_.clipTargetY;
               _loc5_ = _loc14_.grillScale;
               _loc14_.flipFallSpeed += _loc14_.flipFallSpeedChange;
               _loc14_.clip.y += _loc14_.flipFallSpeed;
               if(_loc14_.clip.y > _loc3_)
               {
                  _loc14_.clip.y = _loc3_;
               }
               _loc14_.clip.scaleY += (_loc5_ - _loc14_.clip.scaleY) / 2;
               if(Math.abs(_loc3_ - _loc14_.clip.y) <= 1)
               {
                  _loc14_.clip.y = _loc3_;
                  _loc14_.clip.scaleY = _loc5_;
                  _loc14_.isFlipFalling = false;
                  _loc14_.isFlipSquashing = true;
                  _loc14_.gameObj.var_129.playSound("landburger.wav");
               }
            }
            else if(_loc14_.isFlipSquashing)
            {
               _loc3_ = _loc14_.clipTargetY + _loc14_.flipLandOffsetY;
               _loc4_ = _loc14_.flipLandScaleX;
               _loc5_ = _loc14_.flipLandScaleY;
               _loc14_.clip.y += (_loc3_ - _loc14_.clip.y) / 2;
               _loc14_.clip.scaleX += (_loc4_ - _loc14_.clip.scaleX) / 2;
               _loc14_.clip.scaleY += (_loc5_ - _loc14_.clip.scaleY) / 2;
               if(Math.abs(_loc3_ - _loc14_.clip.y) <= 1)
               {
                  _loc14_.clip.y = _loc3_;
                  _loc14_.clip.scaleX = _loc4_;
                  _loc14_.clip.scaleY = _loc5_;
                  _loc14_.isFlipSquashing = false;
                  _loc14_.isFlipFinishSquashing = true;
               }
            }
            else if(_loc14_.isFlipFinishSquashing)
            {
               _loc3_ = _loc14_.clipTargetY;
               _loc4_ = _loc14_.grillScale;
               _loc5_ = _loc14_.grillScale;
               _loc14_.clip.y += (_loc3_ - _loc14_.clip.y) / 2;
               _loc14_.clip.scaleX += (_loc4_ - _loc14_.clip.scaleX) / 2;
               _loc14_.clip.scaleY += (_loc5_ - _loc14_.clip.scaleY) / 2;
               if(Math.abs(_loc3_ - _loc14_.clip.y) <= 1)
               {
                  _loc14_.clip.y = _loc3_;
                  _loc14_.clip.scaleX = _loc4_;
                  _loc14_.clip.scaleY = _loc5_;
                  _loc14_.isFlipSquashing = false;
                  _loc14_.isFlipFinishSquashing = false;
                  _loc14_.isFlipping = false;
                  class_7.method_1("DONE FLIPPING");
                  if(!_loc14_.isShowingGrease)
                  {
                     _loc14_.gameObj.var_136.addGrease(_loc14_.whichGrillSpot,_loc14_.bottomFrame);
                     _loc14_.isShowingGrease = true;
                  }
               }
            }
            else if(_loc14_.isFlipRotating)
            {
               _loc14_.flipUseRotation += _loc14_.flipRotateDegreesPerFrame;
               if(_loc14_.flipUseRotation > 0)
               {
                  _loc14_.clip.y += _loc14_.flipRotateOffsetPerFrame;
               }
               else
               {
                  _loc14_.clip.y -= _loc14_.flipRotateOffsetPerFrame;
               }
               _loc14_.bitmapHolder.rotation = _loc14_.flipUseRotation;
               if(_loc14_.flipUseRotation == 90)
               {
                  class_7.method_1("REALLY FLIP IT");
                  _loc7_ = _loc14_.targetTopFrame;
                  _loc8_ = _loc14_.targetBottomFrame;
                  _loc9_ = _loc14_.topTime;
                  _loc10_ = _loc14_.bottomTime;
                  _loc14_.targetTopFrame = _loc8_;
                  _loc14_.targetBottomFrame = _loc7_;
                  _loc14_.topFrame = -1;
                  _loc14_.bottomFrame = -1;
                  _loc14_.topTime = _loc10_;
                  _loc14_.bottomTime = _loc9_;
                  _loc14_.isBitmapFlipped = !_loc14_.isBitmapFlipped;
                  _loc14_.updateSandwichGraphic(true);
                  _loc14_.flipUseRotation = -90;
                  _loc14_.bitmapHolder.rotation = _loc14_.flipUseRotation;
                  if(_loc14_.isBitmapFlipped)
                  {
                     _loc14_.topBitmap.x = _loc14_.bitmapXFlipped;
                     _loc14_.bottomBitmap.x = _loc14_.bitmapXFlipped;
                     _loc14_.previousBottomBitmap.x = _loc14_.bottomBitmap.x;
                     _loc14_.topBitmap.y = 0 - _loc14_.flipSpriteHeight / 2;
                     _loc14_.bottomBitmap.y = _loc14_.topBitmap.y;
                     _loc14_.previousBottomBitmap.y = _loc14_.topBitmap.y;
                     _loc14_.bitmapHolder.y = (0 - this.flipSpriteHeight) / 2;
                  }
                  else
                  {
                     _loc14_.topBitmap.x = _loc14_.bitmapXNormal;
                     _loc14_.bottomBitmap.x = _loc14_.bitmapXNormal;
                     _loc14_.previousBottomBitmap.x = _loc14_.bottomBitmap.x;
                     _loc14_.topBitmap.y = 0 - _loc14_.spriteHeight / 2;
                     _loc14_.bottomBitmap.y = _loc14_.topBitmap.y;
                     _loc14_.previousBottomBitmap.y = _loc14_.topBitmap.y;
                     _loc14_.bitmapHolder.y = (0 - this.spriteHeight) / 2;
                  }
                  _loc14_.gameObj.var_129.playSound("trayslide.wav");
               }
               else if(_loc14_.flipUseRotation == 0)
               {
                  _loc14_.isFlipRotating = false;
                  _loc14_.isFlipFalling = true;
               }
            }
            else
            {
               _loc3_ = _loc14_.clipTargetY + _loc14_.flipHeightOffset;
               _loc5_ = _loc14_.flipScaleTop;
               _loc14_.clip.y += (_loc3_ - _loc14_.clip.y) / 2;
               _loc14_.clip.scaleY += (_loc5_ - _loc14_.clip.scaleY) / 2;
               if(Math.abs(_loc3_ - _loc14_.clip.y) <= 1)
               {
                  _loc14_.clip.y = _loc3_;
                  _loc14_.clip.scaleY = _loc5_;
                  _loc14_.isFlipRotating = true;
               }
            }
         }
         else if(_loc14_.isMovingToGrillTray)
         {
            _loc1_ = _loc14_.clipTargetX - _loc14_.clip.x;
            _loc2_ = _loc14_.clipTargetY - _loc14_.clip.y;
            _loc14_.clip.x += _loc1_ / 2;
            _loc14_.clip.y += _loc2_ / 2;
            if(Math.abs(_loc1_) <= 1 && Math.abs(_loc2_) <= 1)
            {
               _loc14_.clip.x = _loc14_.clipTargetX;
               _loc14_.clip.y = _loc14_.clipTargetY;
               _loc14_.isMovingToGrillTray = false;
               class_7.method_1("Done moving on grill tray!");
            }
         }
         else if(_loc14_.isGrabbing)
         {
            _loc11_ = _loc14_.gameObj.var_136.clip.mouseX;
            _loc12_ = _loc14_.gameObj.var_136.clip.mouseY + _loc14_.dragOffsetY;
            _loc13_ = Math.sqrt((_loc11_ - _loc14_.grabX) * (_loc11_ - _loc14_.grabX) + (_loc12_ - _loc14_.grabY) * (_loc12_ - _loc14_.grabY));
            if(_loc13_ > _loc14_.flipMaxDist || !_loc14_.isCooking || _loc14_.isGrabbingMoving)
            {
               _loc14_.isGrabbingMoving = true;
               _loc14_.clip.x = _loc11_;
               _loc14_.clip.y = _loc12_;
               if(_loc14_.gameObj.training)
               {
                  _loc14_.gameObj.method_104(16);
               }
            }
         }
         else if(_loc14_.isTrashingGrill)
         {
            _loc14_.trashSpeed += 3;
            _loc14_.clip.y += _loc14_.trashSpeed;
            if(_loc14_.clip.y >= _loc14_.clipTargetY)
            {
               class_7.method_1("Done grill trashing!");
               _loc14_.isOnGrill = false;
               _loc14_.isTrashingGrill = false;
               _loc14_.gameObj.var_136.removeFromLeavingSandwiches(_loc14_,true);
               return;
            }
         }
         else if(_loc14_.isCutting)
         {
            ++_loc14_.cutTimer;
            if(_loc14_.cutTimer >= _loc14_.cutTimerSplit)
            {
               _loc14_.topBitmap.x += (_loc14_.cutLeftTargetX - _loc14_.topBitmap.x) / 4;
               _loc14_.bottomBitmap.x += (_loc14_.cutRightTargetX - _loc14_.bottomBitmap.x) / 4;
               _loc14_.cheeseCutClip.scaleX += (1 - _loc14_.cheeseCutClip.scaleX) / 4;
               if(_loc14_.cutTimer >= _loc14_.cutTimerLeave)
               {
                  _loc14_.topBitmap.x = _loc14_.cutLeftTargetX;
                  _loc14_.bottomBitmap.x = _loc14_.cutRightTargetX;
                  _loc14_.cheeseCutClip.scaleX = 1;
                  if(_loc14_.sliceClip)
                  {
                     _loc14_.clip.removeChild(_loc14_.sliceClip);
                     _loc14_.sliceClip = null;
                  }
                  _loc14_.clipTargetX = _loc14_.gameObj.var_136.cutOffscreenX;
                  _loc14_.isCutting = false;
                  _loc14_.isLeavingGrill = true;
                  _loc14_.trashSpeed = 20;
                  _loc14_.gameObj.var_129.playSound("trayslide.wav");
                  _loc14_.gameObj.var_131.addToWaitingSandwiches(_loc14_);
               }
            }
         }
         else if(_loc14_.isLeavingGrill)
         {
            _loc14_.trashSpeed += 3;
            _loc14_.clip.x += _loc14_.trashSpeed;
            if(_loc14_.clip.x >= _loc14_.clipTargetX)
            {
               class_7.method_1("Done leaving grill");
               _loc14_.isOnGrill = false;
               _loc14_.isLeavingGrill = false;
               _loc14_.gameObj.var_136.removeFromLeavingSandwiches(_loc14_);
               return;
            }
         }
         else
         {
            _loc1_ = _loc14_.clipTargetX - _loc14_.clip.x;
            _loc2_ = _loc14_.clipTargetY - _loc14_.clip.y;
            _loc14_.clip.x += _loc1_ / 2;
            _loc14_.clip.y += _loc2_ / 2;
            if(Math.abs(_loc1_) <= 1 && Math.abs(_loc2_) <= 1)
            {
               _loc14_.clip.x = _loc14_.clipTargetX;
               _loc14_.clip.y = _loc14_.clipTargetY;
            }
         }
      }
      
      public function prepareForTopping() : void
      {
         var _loc1_:Sandwich = this;
         _loc1_.isPreparingForTopping = true;
         _loc1_.addCheeseToMap(1);
         _loc1_.createMaskMap(1);
         _loc1_.fallenTopClip = new MovieClip();
         _loc1_.clip.addChild(_loc1_.fallenTopClip);
         _loc1_.toppingClip = new MovieClip();
         _loc1_.toppingClip.x = _loc1_.bread1BuildTargetX;
         _loc1_.toppingClip.y = _loc1_.bread1BuildTargetY;
         _loc1_.clip.addChild(_loc1_.toppingClip);
         _loc1_.toppings = new Vector.<Topping>();
         _loc1_.breadClip2.mouseEnabled = true;
         _loc1_.breadClip2.buttonMode = true;
         _loc1_.breadClip2.useHandCursor = true;
         _loc1_.breadClip2.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickTopBread);
         _loc1_.cheeseClip2.mouseEnabled = false;
         _loc1_.cheeseClip2.mouseChildren = false;
      }
      
      public function sendToBuildTrash() : void
      {
         var _loc1_:Sandwich = this;
         _loc1_.isTrashingBuild = true;
      }
      
      public function sendToGrillTrash() : void
      {
         var _loc1_:Sandwich = this;
         class_7.method_1("Send to grill trash");
         _loc1_.isTrashingGrill = true;
         if(_loc1_.container != _loc1_.gameObj.var_136.clip.trashholder)
         {
            _loc1_.container = _loc1_.gameObj.var_136.clip.trashholder;
            _loc1_.container.addChild(_loc1_.clip);
         }
         _loc1_.isFlipping = false;
         _loc1_.isCooking = false;
         _loc1_.whichGrillSpot = -1;
         _loc1_.clip.mouseEnabled = false;
         _loc1_.clip.mouseChildren = false;
         _loc1_.clipTargetX = 77;
         _loc1_.clip.x = 77;
         if(_loc1_.clip.y > 413)
         {
            _loc1_.clip.y = 413;
         }
         _loc1_.clipTargetY = 650;
         _loc1_.trashSpeed = 20;
      }
      
      public function hasBothCheeses() : Boolean
      {
         var _loc1_:Sandwich = this;
         if(_loc1_.cheeseType1 != null && _loc1_.cheeseType2 != null)
         {
            return true;
         }
         return false;
      }
      
      public function tryToAddCheese(param1:MovieClip, param2:String) : Boolean
      {
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Sandwich = this;
         var _loc12_:Boolean = false;
         if(_loc11_.canAddCheese && param1.y > 350)
         {
            _loc3_ = param1.x - _loc11_.clip.x;
            _loc4_ = param1.y - _loc11_.clip.y;
            _loc5_ = _loc11_.breadClip1.x - _loc3_;
            _loc6_ = _loc11_.breadClip1.y - _loc4_;
            _loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
            _loc8_ = _loc11_.breadClip2.x - _loc3_;
            _loc9_ = _loc11_.breadClip2.y - _loc4_;
            _loc10_ = Math.sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_);
            if(Math.abs(_loc5_) <= _loc11_.maxCheeseAllowedOffX * 2 && _loc4_ <= _loc11_.breadClip1.y + 20 && _loc11_.cheeseType1 == null && (!_loc11_.gameObj.training || _loc11_.gameObj.method_111(6)))
            {
               if(Math.abs(_loc5_) > _loc11_.maxCheeseAllowedOffX)
               {
                  if(_loc3_ < _loc11_.breadClip1.x)
                  {
                     _loc3_ = _loc11_.breadClip1.x - _loc11_.maxCheeseAllowedOffX;
                  }
                  else
                  {
                     _loc3_ = _loc11_.breadClip1.x + _loc11_.maxCheeseAllowedOffX;
                  }
               }
               _loc11_.cheeseClip1 = class_12.method_103("clip_" + param2 + "_bottom",false,false);
               _loc11_.cheeseClip1.gotoAndStop(1);
               _loc11_.cheeseClip1.scaleX = 1;
               _loc11_.cheeseClip1.scaleY = 1;
               _loc11_.cheeseClip1.x = _loc3_;
               _loc11_.cheeseClip1.y = _loc4_;
               _loc11_.cheeseType1 = param2;
               _loc11_.cheese1OffsetX = _loc3_ - _loc11_.breadClip1.x;
               _loc11_.clip.addChild(_loc11_.cheeseClip1);
               _loc12_ = true;
               _loc11_.isAddingCheese = true;
               _loc11_.gameObj.var_129.playSound("droptopping.wav");
               _loc11_.gameObj.method_104(6);
            }
            else if(Math.abs(_loc8_) <= _loc11_.maxCheeseAllowedOffX * 2 && _loc4_ <= _loc11_.breadClip2.y + 20 && _loc11_.cheeseType2 == null && (!_loc11_.gameObj.training || _loc11_.gameObj.method_111(7)))
            {
               if(Math.abs(_loc8_) > _loc11_.maxCheeseAllowedOffX)
               {
                  if(_loc3_ < _loc11_.breadClip2.x)
                  {
                     _loc3_ = _loc11_.breadClip2.x - _loc11_.maxCheeseAllowedOffX;
                  }
                  else
                  {
                     _loc3_ = _loc11_.breadClip2.x + _loc11_.maxCheeseAllowedOffX;
                  }
               }
               _loc11_.cheeseClip2 = class_12.method_103("clip_" + param2 + "_top",false,false);
               _loc11_.cheeseClip2.gotoAndStop(1);
               _loc11_.cheeseClip2.scaleX = 1;
               _loc11_.cheeseClip2.scaleY = 1;
               _loc11_.cheeseClip2.x = _loc3_;
               _loc11_.cheeseClip2.y = _loc4_;
               _loc11_.cheeseType2 = param2;
               _loc11_.cheese2OffsetX = _loc3_ - _loc11_.breadClip2.x;
               _loc11_.clip.addChild(_loc11_.cheeseClip2);
               _loc12_ = true;
               _loc11_.isAddingCheese = true;
               _loc11_.gameObj.var_129.playSound("droptopping.wav");
               _loc11_.gameObj.method_104(7);
            }
            if(_loc11_.cheeseType1 != null && _loc11_.cheeseType2 != null)
            {
               _loc11_.canAddCheese = false;
            }
         }
         return _loc12_;
      }
      
      public function tryToAddTopping(param1:Topping) : Boolean
      {
         var _loc2_:Sandwich = this;
         var _loc3_:Boolean = false;
         if(_loc2_.canAddToppings && param1.clip.y > 215 && param1.clip.y <= Math.min(_loc2_.clip.y,_loc2_.clip.y + _loc2_.getToppingDropTargetY(_loc2_.clip.x) + 15) && param1.clip.x > _loc2_.clip.x - _loc2_.maxToppingAllowedOffX && param1.clip.x < _loc2_.clip.x + _loc2_.maxToppingAllowedOffX)
         {
            param1.prepareToAdd(_loc2_);
            _loc2_.toppings.push(param1);
            _loc3_ = true;
            if(param1.type == FoodData.TOPPING_TURKEY)
            {
               _loc2_.gameObj.method_104(8);
            }
            else if(param1.type == FoodData.TOPPING_TOMATO)
            {
               _loc2_.gameObj.method_104(9);
            }
         }
         return _loc3_;
      }
      
      public function tryToAddSauce(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Topping = null;
         var _loc5_:Sandwich = this;
         var _loc6_:Boolean = false;
         if(_loc5_.canAddToppings)
         {
            _loc4_ = new Topping(_loc5_.gameObj,param1);
            _loc4_.prepareToAdd(_loc5_);
            _loc5_.toppings.push(_loc4_);
            ++_loc5_.numSaucesAdded;
            _loc6_ = true;
            if(_loc4_.type == FoodData.SAUCE_MUSTARD)
            {
               _loc5_.gameObj.method_104(10);
            }
         }
         return _loc6_;
      }
      
      public function tryToAddTopBread(param1:Boolean = false) : void
      {
         var _loc2_:Matrix = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Array = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Array = null;
         var _loc7_:Sandwich = this;
         if(param1 || _loc7_.canAddToppings && _loc7_.breadClip2.y <= _loc7_.breadClip1.y - 10 && _loc7_.breadClip2.x > _loc7_.breadClip1.x - _loc7_.maxToppingAllowedOffX && _loc7_.breadClip2.x < _loc7_.breadClip1.x + _loc7_.maxToppingAllowedOffX)
         {
            _loc2_ = new Matrix();
            _loc2_.tx = _loc7_.breadClip2.x;
            _loc2_.ty = _loc7_.breadClip2.y;
            _loc7_.breadClip2.transform.matrix = _loc2_;
            _loc2_.tx = _loc7_.breadClip2.x - _loc7_.cheese2OffsetX;
            _loc2_.ty = _loc7_.breadClip2.y + 1;
            _loc7_.cheeseClip2.transform.matrix = _loc2_;
            _loc7_.cheeseClip2.scaleX = 1;
            _loc7_.cheeseClip2.scaleY = 1;
            _loc7_.breadClip2.scaleX = 1;
            _loc7_.breadClip2.scaleY = 1;
            _loc7_.clip.setChildIndex(_loc7_.breadClip2,_loc7_.clip.numChildren - 1);
            _loc3_ = _loc7_.breadClip1.x - _loc7_.cheeseClip2.x;
            if(!param1)
            {
               if(_loc3_ > 2)
               {
                  _loc7_.topCheeseSkewDropOffset = Math.min(1,_loc3_ / 30) * (8 * -1);
               }
               else if(_loc3_ < 2 * -1)
               {
                  _loc7_.topCheeseSkewDropOffset = Math.min(1,Math.abs(_loc3_) / 30) * 8;
               }
            }
            _loc7_.cheese2TopTargetX = _loc7_.breadClip1.x - _loc7_.cheese2OffsetX;
            _loc4_ = _loc7_.getSkewData(_loc7_.cheese2TopTargetX);
            _loc7_.cheeseClip2.x += (_loc7_.cheese2TopTargetX - _loc7_.cheeseClip2.x) / 2;
            _loc7_.cheese2TopTargetY = _loc4_[1];
            _loc7_.cheese2TopTargetYStartSkew = _loc4_[2];
            _loc7_.cheese2TopTargetSkew = _loc4_[0];
            if(_loc7_.isFlippedVersion == false && Math.abs(_loc4_[0]) <= 2 && Math.abs(_loc7_.topCheeseSkewDropOffset) > Math.abs(_loc4_[0]))
            {
               _loc7_.cheese2TopTargetSkew = _loc7_.topCheeseSkewDropOffset;
               _loc7_.cheese2TopTargetY += Math.round(Math.abs(_loc7_.topCheeseSkewDropOffset) / 2);
            }
            _loc5_ = _loc7_.breadClip1.x - _loc7_.breadClip2.x;
            if(!param1)
            {
               if(_loc5_ > 2)
               {
                  _loc7_.topSkewDropOffset = Math.min(1,_loc5_ / 30) * (8 * -1);
               }
               else if(_loc5_ < 2 * -1)
               {
                  _loc7_.topSkewDropOffset = Math.min(1,Math.abs(_loc5_) / 30) * 8;
               }
            }
            _loc7_.bread2TopTargetX = _loc7_.breadClip1.x;
            _loc6_ = _loc7_.getSkewData(_loc7_.bread2TopTargetX);
            _loc7_.breadClip2.x += (_loc7_.bread2TopTargetX - _loc7_.breadClip2.x) / 2;
            _loc7_.bread2TopTargetY = _loc6_[1] - _loc7_.cheeseHeight;
            _loc7_.bread2TopTargetYStartSkew = _loc6_[2] - _loc7_.cheeseHeight;
            _loc7_.bread2TopTargetSkew = _loc6_[0];
            if(_loc7_.isFlippedVersion == false && Math.abs(_loc6_[0]) <= 2 && Math.abs(_loc7_.topSkewDropOffset) > Math.abs(_loc6_[0]))
            {
               _loc7_.bread2TopTargetSkew = _loc7_.topSkewDropOffset;
               _loc7_.bread2TopTargetY += Math.round(Math.abs(_loc7_.topSkewDropOffset) / 2);
            }
            _loc7_.isDraggingTopBread = false;
            _loc7_.isReturningTopBread = false;
            _loc7_.isAddingTopBread = true;
            _loc7_.breadClip2.mouseEnabled = false;
            _loc7_.breadClip2.mouseChildren = false;
            _loc7_.canAddToppings = false;
            _loc7_.topBreadIsAdded = true;
            if(!param1)
            {
               _loc7_.gameObj.hud.disableStationButtons();
            }
            if(param1)
            {
               _loc2_ = new Matrix();
               _loc7_.breadSkewAmount = _loc7_.bread2TopTargetSkew;
               _loc2_.b = Math.tan(_loc7_.breadSkewAmount / 180 * Math.PI);
               _loc2_.tx = _loc7_.breadClip2.x;
               _loc2_.ty = _loc7_.bread2TopTargetY;
               _loc7_.breadClip2.transform.matrix = _loc2_;
               _loc7_.breadClip2.scaleX = _loc7_.getScaleXForSkew(_loc7_.breadSkewAmount);
               _loc7_.breadClip2.scaleY = _loc7_.getScaleYForSkew(_loc7_.breadSkewAmount);
               _loc7_.cheeseSkewAmount = _loc7_.cheese2TopTargetSkew;
               _loc2_.b = Math.tan(_loc7_.cheeseSkewAmount / 180 * Math.PI);
               _loc2_.tx = _loc7_.cheeseClip2.x;
               _loc2_.ty = _loc7_.cheese2TopTargetY;
               _loc7_.cheeseClip2.transform.matrix = _loc2_;
               _loc7_.cheeseClip2.scaleX = _loc7_.getScaleXForSkew(_loc7_.cheeseSkewAmount);
               _loc7_.cheeseClip2.scaleY = _loc7_.getScaleYForSkew(_loc7_.cheeseSkewAmount);
            }
         }
         else
         {
            class_7.method_1("Try to add top bread, not within bounds. Return.");
            _loc7_.flipDirection = -1;
            _loc7_.isDraggingTopBread = false;
            _loc7_.isReturningTopBread = true;
         }
      }
      
      public function getToppingDropTargetY(param1:Number) : Number
      {
         var _loc2_:Sandwich = this;
         param1 -= _loc2_.clip.x;
         return Number(0 - _loc2_.breadHeight - _loc2_.cheeseHeight - _loc2_.getHeightOffsetAtPoint(param1,-20));
      }
      
      public function getToppingTargetY(param1:Number = -1) : Number
      {
         var _loc2_:Sandwich = this;
         var _loc3_:Number = 0 - _loc2_.breadHeight;
         _loc3_ -= _loc2_.cheeseHeight;
         if(param1 > -1)
         {
            _loc3_ -= _loc2_.getHeightOffsetAtPoint(_loc2_.shadowOffsetX,_loc2_.shadowOffsetY);
         }
         else if(_loc2_.toppings != null && _loc2_.toppings.length > 0)
         {
            _loc3_ -= _loc2_.getHeightOffsetAtPoint(_loc2_.shadowOffsetX,_loc2_.shadowOffsetY);
         }
         return _loc3_;
      }
      
      public function isWithinBreadBounds(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:Sandwich = this;
         var _loc5_:Boolean = false;
         var _loc6_:Number = param1 + _loc4_.shadowOffsetX;
         var _loc7_:Number = param2 + _loc4_.shadowOffsetY;
         if(_loc6_ >= 0 && _loc6_ < _loc4_.shadowBitmap.width && _loc7_ >= 0 && _loc7_ < _loc4_.shadowBitmap.height)
         {
            _loc3_ = _loc4_.shadowBitmap.getPixel(_loc6_,_loc7_);
            if(_loc3_ !== 16711680)
            {
               _loc5_ = true;
            }
         }
         if(_loc5_ == false)
         {
            class_7.method_1("PARTICLE NOT WITHIN BOUNDS (" + param1 + ", " + param2 + " --> " + _loc6_ + ", " + _loc7_ + ").  W/H: " + _loc4_.shadowBitmap.width + ", " + _loc4_.shadowBitmap.height);
         }
         return _loc5_;
      }
      
      public function getHeightOffsetAtPoint(param1:Number, param2:Number) : Number
      {
         var _loc3_:uint = 0;
         var _loc4_:Sandwich = this;
         var _loc5_:Number = 0;
         var _loc6_:Number = param1 + _loc4_.shadowOffsetX;
         var _loc7_:Number = param2 + _loc4_.shadowOffsetY;
         if(_loc6_ >= 0 && _loc6_ < _loc4_.shadowBitmap.width && _loc7_ >= 0 && _loc7_ < _loc4_.shadowBitmap.height)
         {
            _loc3_ = _loc4_.shadowBitmap.getPixel(_loc6_,_loc7_);
            _loc5_ = _loc3_ & 0xFF;
            _loc5_ = Math.round(_loc5_ / 5) * 5;
         }
         else
         {
            class_7.method_1("PARTICLE OOB! (" + param1 + ", " + param2 + " --> " + _loc6_ + ", " + _loc7_ + ")");
         }
         return Math.ceil(_loc5_);
      }
      
      public function getHeightArray() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Sandwich = this;
         var _loc3_:Array = [];
         var _loc4_:Vector.<uint> = _loc2_.shadowBitmap.getVector(new Rectangle(0,Math.round(_loc2_.shadowBitmap.height / 2),_loc2_.shadowBitmap.width,1));
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_ = Math.round((_loc4_[_loc5_] & 0xFF) / 5) * 5;
            if(_loc4_[_loc5_] == 16711680 || _loc4_[_loc5_] == 4294901760)
            {
               _loc1_ = 0 - _loc2_.breadHeight;
            }
            _loc3_.push(_loc1_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getSkewData(param1:Number, param2:Number = 40, param3:Boolean = false) : Array
      {
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:Sandwich = this;
         var _loc7_:Array = [];
         var _loc8_:Number = Number(getTimer());
         var _loc9_:Number = param1 - param2 + _loc6_.shadowOffsetX;
         var _loc10_:Number = param1 + param2 + _loc6_.shadowOffsetX;
         var _loc11_:Number = _loc9_;
         var _loc12_:Number = Math.round(_loc6_.shadowBitmap.height / 2);
         var _loc13_:Vector.<uint> = _loc6_.shadowBitmap.getVector(new Rectangle(_loc11_,_loc12_,param2 * 2,1));
         var _loc14_:Vector.<int> = new Vector.<int>();
         _loc4_ = 0;
         while(_loc4_ < _loc13_.length)
         {
            _loc5_ = Math.round((_loc13_[_loc4_] & 0xFF) / 5) * 5;
            _loc14_.push(_loc5_);
            _loc4_++;
         }
         if(_loc9_ < 0)
         {
            _loc4_ = int(_loc9_);
            while(_loc4_ < 0)
            {
               _loc14_.unshift(0 - _loc6_.breadHeight);
               _loc4_++;
            }
         }
         if(_loc10_ >= _loc6_.shadowBitmap.width)
         {
            _loc4_ = int(_loc10_);
            while(_loc4_ >= _loc6_.shadowBitmap.width)
            {
               _loc14_.push(0 - _loc6_.breadHeight);
               _loc4_--;
            }
         }
         var _loc15_:Number = 0;
         var _loc16_:Number = 0;
         var _loc17_:Number = 0;
         var _loc18_:Number = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc14_.length)
         {
            if(_loc14_[_loc4_] > _loc15_)
            {
               _loc15_ = _loc14_[_loc4_];
            }
            _loc18_ += _loc14_[_loc4_];
            if(_loc4_ < _loc14_.length / 2)
            {
               _loc16_ += _loc14_[_loc4_];
            }
            else
            {
               _loc17_ += _loc14_[_loc4_];
            }
            _loc4_++;
         }
         var _loc19_:Number = _loc16_ / param2;
         var _loc20_:Number = _loc17_ / param2;
         _loc22_ = Math.atan2(_loc20_ - _loc19_,param2 * 2);
         _loc21_ = _loc22_ * (180 / Math.PI) * -1;
         if(_loc21_ > 15)
         {
            _loc21_ = 15;
         }
         else if(_loc21_ < 15 * -1)
         {
            _loc21_ = 15 * -1;
         }
         var _loc23_:Number = Math.abs(Math.tan(_loc22_) * (param2 * 2));
         _loc7_[0] = _loc21_;
         _loc7_[1] = 0 - _loc6_.breadHeight - _loc6_.cheeseHeight - _loc15_ + _loc23_ / 2;
         _loc7_[2] = 0 - _loc6_.breadHeight - _loc6_.cheeseHeight - _loc15_;
         if(param3)
         {
            _loc7_[1] = 0 - _loc6_.breadHeight - _loc6_.cheeseHeight - _loc18_ / _loc14_.length - _loc23_ / 2;
            _loc7_[2] = _loc7_[1];
         }
         return _loc7_;
      }
      
      public function addCheeseToMap(param1:Number) : void
      {
         var _loc6_:Matrix = null;
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Sandwich = this;
         if(param1 == 1)
         {
            _loc2_ = class_12.method_103("clip_" + _loc4_.cheeseType1 + "_bottom",false,false);
            _loc3_ = _loc4_.cheese1OffsetX;
         }
         else
         {
            _loc2_ = class_12.method_103("clip_" + _loc4_.cheeseType2 + "_top",false,false);
            _loc3_ = _loc4_.cheese2OffsetX;
         }
         var _loc5_:ColorTransform = new ColorTransform(0,0,0,1,0,0,0,0);
         _loc6_ = new Matrix();
         _loc6_.tx = _loc3_ + _loc4_.shadowOffsetX;
         _loc6_.ty = _loc4_.shadowOffsetY - _loc4_.breadHeight;
         _loc4_.shadowBitmap.draw(_loc2_,_loc6_,_loc5_,null,null,true);
         _loc6_ = null;
         _loc5_ = null;
         _loc2_ = null;
      }
      
      public function addToppingToMap(param1:Topping) : void
      {
         var _loc2_:Sandwich = this;
         var _loc3_:Number = _loc2_.shadowOffsetX + (param1.clip.x - param1.radius - 0);
         var _loc4_:Number = _loc2_.shadowOffsetX + (param1.clip.x + param1.radius + 0);
         var _loc5_:Rectangle = new Rectangle(_loc3_,0,_loc4_ - _loc3_,_loc2_.maskBitmap.height);
         var _loc6_:Point = new Point(_loc3_,0);
         _loc2_.shadowBitmap.copyPixels(_loc2_.maskBitmap,_loc5_,_loc6_,null,null,true);
         if(param1.isClumps)
         {
            _loc2_.shadowBitmap.copyPixels(_loc2_.maskBitmap,_loc5_,_loc6_,null,null,true);
         }
      }
      
      public function createMaskMap(param1:Number) : void
      {
         var _loc7_:Matrix = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Sandwich = this;
         var _loc6_:MovieClip = new MovieClip();
         if(param1 == 1)
         {
            _loc2_ = class_12.method_103("shadow_" + _loc5_.breadType,false,false);
            _loc3_ = class_12.method_103("clip_" + _loc5_.cheeseType1 + "_bottom",false,false);
            _loc4_ = _loc5_.cheese1OffsetX;
         }
         else
         {
            _loc2_ = class_12.method_103("shadow_" + _loc5_.breadType,false,false);
            _loc3_ = class_12.method_103("clip_" + _loc5_.cheeseType2 + "_bottom",false,false);
            _loc4_ = _loc5_.cheese2OffsetX;
         }
         _loc6_.addChild(_loc2_);
         _loc6_.addChild(_loc3_);
         _loc3_.x = _loc4_;
         _loc3_.y -= _loc5_.breadHeight;
         _loc5_.maskBitmap = new BitmapData(_loc5_.shadowBitmap.width,_loc5_.shadowBitmap.height,true,0);
         _loc7_ = new Matrix();
         _loc7_.tx = this.shadowOffsetX;
         _loc7_.ty = this.shadowOffsetY;
         var _loc8_:ColorTransform = new ColorTransform(1,1,1,0,255,255,255,5);
         _loc5_.maskBitmap.draw(_loc6_,_loc7_,null,null,null,true);
         _loc5_.maskBitmap.colorTransform(_loc5_.maskBitmap.rect,_loc8_);
         _loc5_.blankShadowBitmap = _loc5_.shadowBitmap.clone();
         _loc6_.removeChild(_loc2_);
         _loc6_.removeChild(_loc3_);
         _loc2_ = null;
         _loc3_ = null;
         _loc6_ = null;
         _loc7_ = null;
         _loc8_ = null;
      }
      
      public function clickTopBread(param1:MouseEvent) : void
      {
         var _loc2_:Sandwich = this;
         _loc2_.currentFlipFrame = 0;
         _loc2_.flipDirection = 1;
         _loc2_.isDraggingTopBread = true;
         _loc2_.isReturningTopBread = false;
         _loc2_.clip.setChildIndex(_loc2_.breadClip2,_loc2_.clip.numChildren - 1);
         _loc2_.clip.setChildIndex(_loc2_.cheeseClip2,_loc2_.clip.numChildren - 1);
         _loc2_.gameObj.var_129.playSound("grabtopping.wav");
      }
      
      public function getScaleXForSkew(param1:Number) : Number
      {
         return 1 + 0.001 * Math.abs(param1);
      }
      
      public function getScaleYForSkew(param1:Number) : Number
      {
         return 1;
      }
      
      public function flipModel() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:MovieClip = null;
         var _loc7_:Rectangle = null;
         var _loc8_:Matrix = null;
         var _loc9_:int = 0;
         var _loc10_:Number = Number(NaN);
         var _loc11_:Sandwich = this;
         if(!_loc11_.spritesCreated)
         {
            _loc1_ = Number(getTimer());
            _loc11_.isFlippedVersion = !_loc11_.isFlippedVersion;
            _loc2_ = _loc11_.cheeseType1;
            _loc3_ = _loc11_.cheeseType2;
            if(_loc11_.isFlippedVersion)
            {
               _loc2_ = _loc11_.cheeseType2;
               _loc3_ = _loc11_.cheeseType1;
            }
            _loc4_ = _loc11_.cheese1OffsetX;
            _loc5_ = _loc11_.cheese2OffsetX;
            _loc11_.cheese1OffsetX = _loc5_;
            _loc11_.cheese2OffsetX = _loc4_;
            if(_loc11_.cheeseClip1.parent)
            {
               _loc11_.cheeseClip1.parent.removeChild(_loc11_.cheeseClip1);
            }
            _loc11_.cheeseClip1 = null;
            _loc11_.cheeseClip1 = class_12.method_103("clip_" + _loc2_ + "_bottom",false,false);
            _loc11_.cheeseClip1.gotoAndStop(1);
            _loc11_.clip.addChildAt(_loc11_.cheeseClip1,_loc11_.clip.getChildIndex(_loc11_.breadClip1) + 1);
            if(_loc11_.cheeseClip2.parent)
            {
               _loc11_.cheeseClip2.parent.removeChild(_loc11_.cheeseClip2);
            }
            _loc11_.cheeseClip2 = null;
            _loc11_.cheeseClip2 = class_12.method_103("clip_" + _loc3_ + "_top",false,false);
            _loc11_.cheeseClip2.gotoAndStop(2);
            _loc11_.clip.addChild(_loc11_.cheeseClip2);
            _loc11_.cheeseClip1.transform.matrix = new Matrix();
            _loc11_.cheeseClip1.y = 0 - _loc11_.breadHeight;
            _loc11_.cheeseClip1.x = _loc11_.breadClip1.x + _loc11_.cheese1OffsetX;
            _loc6_ = class_12.method_103("shadow_" + _loc11_.breadType,false,false);
            _loc7_ = _loc6_.getRect(_loc6_);
            this.shadowOffsetX = Math.round(0 - _loc7_.x);
            this.shadowOffsetY = Math.round(0 - _loc7_.y);
            _loc8_ = new Matrix();
            _loc8_.tx = this.shadowOffsetX;
            _loc8_.ty = this.shadowOffsetY;
            _loc11_.shadowBitmap.fillRect(_loc11_.shadowBitmap.rect,4294901760);
            _loc11_.shadowBitmap.draw(_loc6_,_loc8_,null,null,null,true);
            _loc11_.addCheeseToMap(1);
            _loc11_.createMaskMap(1);
            _loc9_ = 0;
            while(_loc9_ < _loc11_.toppings.length)
            {
               _loc10_ = _loc9_;
               if(_loc11_.isFlippedVersion)
               {
                  _loc10_ = _loc11_.toppings.length - 1 - _loc9_;
               }
               if(_loc11_.toppings.length > _loc10_ && _loc11_.toppings[_loc10_] != null)
               {
                  _loc11_.toppings[_loc10_].flipTopping(_loc11_.isFlippedVersion,_loc9_);
               }
               _loc9_++;
            }
            _loc11_.tryToAddTopBread(true);
            _loc11_.clip.setChildIndex(_loc11_.cheeseClip2,_loc11_.clip.numChildren - 1);
            _loc11_.clip.setChildIndex(_loc11_.breadClip2,_loc11_.clip.numChildren - 1);
         }
      }
      
      public function createSprites() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Rectangle = null;
         var _loc4_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Matrix = null;
         var _loc7_:Rectangle = null;
         var _loc8_:Sandwich = this;
         if(!_loc8_.spritesCreated)
         {
            _loc2_ = Number(getTimer());
            _loc8_.clip.removeChild(_loc8_.waxpaperClip1);
            _loc8_.clip.removeChild(_loc8_.waxpaperClip2);
            _loc8_.clip.removeChild(_loc8_.fallenTopClip);
            _loc8_.clip.removeChild(_loc8_.fallenBottomClip);
            _loc3_ = new Rectangle();
            _loc4_ = new Point(0,0);
            _loc5_ = new Rectangle();
            _loc6_ = new Matrix();
            _loc7_ = _loc8_.clip.getBounds(_loc8_.clip);
            _loc6_.tx = 0 - Math.ceil(_loc7_.x);
            _loc6_.ty = 0 - Math.ceil(_loc7_.y);
            _loc8_.spriteWidth = Math.ceil(_loc7_.width);
            _loc8_.spriteHeight = Math.ceil(_loc7_.height);
            _loc8_.bitmapXNormal = Math.ceil(_loc7_.x);
            _loc3_.x = 0;
            _loc3_.y = 0;
            _loc3_.width = _loc8_.spriteWidth;
            _loc3_.height = _loc8_.spriteHeight;
            class_7.method_1("Sprite Width/Height:" + _loc8_.spriteWidth + ", " + _loc8_.spriteHeight + ".  Bounds X:" + _loc7_.x);
            _loc8_.topNormalSheet = new BitmapData(_loc8_.spriteWidth * _loc8_.numFrames,_loc8_.spriteHeight,true,0);
            _loc8_.bottomNormalSheet = new BitmapData(_loc8_.spriteWidth * _loc8_.numFrames,_loc8_.spriteHeight,true,0);
            _loc8_.setupClipForTopSprite();
            _loc1_ = 0;
            while(_loc1_ < _loc8_.numFrames)
            {
               _loc8_.breadClip2.gotoAndStop(_loc1_ + 1);
               _loc8_.cheeseClip2.gotoAndStop(_loc1_ + 1);
               _loc6_.tx = Math.ceil(0 - _loc7_.x) + _loc1_ * _loc8_.spriteWidth;
               _loc3_.x = _loc1_ * _loc8_.spriteWidth;
               _loc8_.topNormalSheet.draw(_loc8_.clip,_loc6_,null,null,_loc3_,true);
               _loc1_++;
            }
            _loc8_.setupClipForBottomSprite();
            _loc1_ = 0;
            while(_loc1_ < _loc8_.numFrames)
            {
               _loc8_.breadClip1.gotoAndStop(_loc1_ + 1);
               _loc8_.cheeseClip1.gotoAndStop(_loc1_ + 1);
               _loc6_.tx = Math.ceil(0 - _loc7_.x) + _loc1_ * _loc8_.spriteWidth;
               _loc3_.x = _loc1_ * _loc8_.spriteWidth;
               _loc8_.bottomNormalSheet.draw(_loc8_.clip,_loc6_,null,null,_loc3_,true);
               _loc1_++;
            }
            _loc8_.flipModel();
            _loc7_ = _loc8_.clip.getBounds(_loc8_.clip);
            _loc6_.tx = 0 - Math.ceil(_loc7_.x);
            _loc6_.ty = 0 - Math.ceil(_loc7_.y);
            _loc8_.flipSpriteWidth = Math.ceil(_loc7_.width);
            _loc8_.flipSpriteHeight = Math.ceil(_loc7_.height);
            _loc8_.bitmapXFlipped = Math.ceil(_loc7_.x);
            _loc3_.x = 0;
            _loc3_.y = 0;
            _loc3_.width = _loc8_.flipSpriteWidth;
            _loc3_.height = _loc8_.flipSpriteHeight;
            _loc8_.topFlippedSheet = new BitmapData(_loc8_.flipSpriteWidth * _loc8_.numFrames,_loc8_.flipSpriteHeight,true,0);
            _loc8_.bottomFlippedSheet = new BitmapData(_loc8_.flipSpriteWidth * _loc8_.numFrames,_loc8_.flipSpriteHeight,true,0);
            _loc8_.setupClipForTopSprite();
            _loc1_ = 0;
            while(_loc1_ < _loc8_.numFrames)
            {
               _loc8_.breadClip2.gotoAndStop(_loc1_ + 1);
               _loc8_.cheeseClip2.gotoAndStop(_loc1_ + 1);
               _loc6_.tx = Math.ceil(0 - _loc7_.x) + _loc1_ * _loc8_.flipSpriteWidth;
               _loc3_.x = _loc1_ * _loc8_.flipSpriteWidth;
               _loc8_.topFlippedSheet.draw(_loc8_.clip,_loc6_,null,null,_loc3_,true);
               _loc1_++;
            }
            _loc8_.setupClipForBottomSprite();
            _loc1_ = 0;
            while(_loc1_ < _loc8_.numFrames)
            {
               _loc8_.breadClip1.gotoAndStop(_loc1_ + 1);
               _loc8_.cheeseClip1.gotoAndStop(_loc1_ + 1);
               _loc6_.tx = Math.ceil(0 - _loc7_.x) + _loc1_ * _loc8_.flipSpriteWidth;
               _loc3_.x = _loc1_ * _loc8_.flipSpriteWidth;
               _loc8_.bottomFlippedSheet.draw(_loc8_.clip,_loc6_,null,null,_loc3_,true);
               _loc1_++;
            }
            if(_loc8_.spriteWidth != _loc8_.flipSpriteWidth || _loc8_.spriteHeight != _loc8_.flipSpriteHeight)
            {
               class_7.method_1(" ------ Sprites are not the same width/height!  Normal = " + _loc8_.spriteWidth + " x " + _loc8_.spriteHeight + ".  Flipped = " + _loc8_.flipSpriteWidth + " x " + _loc8_.flipSpriteHeight);
            }
            _loc8_.topBitmapData = new BitmapData(Math.max(_loc8_.flipSpriteWidth,_loc8_.spriteWidth),Math.max(_loc8_.flipSpriteHeight,_loc8_.spriteHeight),true,0);
            _loc8_.bottomBitmapData = new BitmapData(_loc8_.topBitmapData.width,_loc8_.topBitmapData.height,true,0);
            _loc8_.previousBottomBitmapData = new BitmapData(_loc8_.topBitmapData.width,_loc8_.topBitmapData.height,true,0);
            _loc8_.topBitmap = new Bitmap(_loc8_.topBitmapData,"auto",true);
            _loc8_.bottomBitmap = new Bitmap(_loc8_.bottomBitmapData,"auto",true);
            _loc8_.previousBottomBitmap = new Bitmap(_loc8_.previousBottomBitmapData,"auto",true);
            _loc4_.x = 0;
            _loc4_.y = 0;
            _loc5_.x = 0;
            _loc5_.y = 0;
            _loc5_.width = _loc8_.spriteWidth;
            _loc5_.height = _loc8_.spriteHeight;
            _loc8_.topBitmapData.copyPixels(_loc8_.topNormalSheet,_loc5_,_loc4_,null,null,true);
            _loc8_.bottomBitmapData.copyPixels(_loc8_.bottomNormalSheet,_loc5_,_loc4_,null,null,true);
            _loc8_.bitmapHolder = new MovieClip();
            _loc8_.clip.addChild(_loc8_.bitmapHolder);
            _loc8_.bitmapHolder.x = 0;
            _loc8_.bitmapHolder.y = (0 - this.spriteHeight) / 2;
            _loc8_.bitmapHolder.addChild(_loc8_.previousBottomBitmap);
            _loc8_.bitmapHolder.addChild(_loc8_.bottomBitmap);
            _loc8_.bitmapHolder.addChild(_loc8_.topBitmap);
            _loc8_.topBitmap.x = _loc8_.bitmapXNormal;
            _loc8_.topBitmap.y = 0 - this.spriteHeight / 2;
            _loc8_.bottomBitmap.x = _loc8_.topBitmap.x;
            _loc8_.bottomBitmap.y = _loc8_.topBitmap.y;
            _loc8_.previousBottomBitmap.x = _loc8_.bottomBitmap.x;
            _loc8_.previousBottomBitmap.y = _loc8_.bottomBitmap.y;
            _loc8_.cleanupAllMovieClips();
            class_7.method_1("---------- Create Sprites Duration: " + (getTimer() - _loc2_) + " ms.");
            class_7.method_1("Bitmaps Placed at " + _loc8_.topBitmap.x + ", " + _loc8_.topBitmap.y);
            _loc8_.spritesCreated = true;
         }
      }
      
      private function setupClipForTopSprite() : void
      {
         var _loc1_:Sandwich = this;
         _loc1_.breadClip2.visible = true;
         _loc1_.cheeseClip2.visible = true;
         _loc1_.breadClip1.visible = false;
         _loc1_.cheeseClip1.visible = false;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.toppings.length)
         {
            _loc1_.toppings[_loc2_].clip.visible = false;
            _loc2_++;
         }
      }
      
      private function setupClipForBottomSprite() : void
      {
         var _loc1_:Sandwich = this;
         _loc1_.breadClip2.visible = false;
         _loc1_.cheeseClip2.visible = false;
         _loc1_.breadClip1.visible = true;
         _loc1_.cheeseClip1.visible = true;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.toppings.length)
         {
            _loc1_.toppings[_loc2_].clip.visible = true;
            _loc2_++;
         }
      }
      
      private function resetClipForSprite() : void
      {
         var _loc1_:Sandwich = this;
         _loc1_.breadClip2.visible = true;
         _loc1_.cheeseClip2.visible = true;
         _loc1_.breadClip1.visible = true;
         _loc1_.cheeseClip1.visible = true;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.toppings.length)
         {
            _loc1_.toppings[_loc2_].clip.visible = true;
            _loc2_++;
         }
      }
      
      public function addToGrillTray(param1:Number, param2:Number, param3:MovieClip) : void
      {
         var _loc4_:Sandwich = null;
         _loc4_ = this;
         _loc4_.isOnBuild = false;
         _loc4_.isOnGrill = true;
         _loc4_.isMovingToGrillTray = true;
         _loc4_.clip.scaleX = _loc4_.grillScale;
         _loc4_.clip.scaleY = _loc4_.grillScale;
         _loc4_.clipTargetX = param1;
         _loc4_.clip.x = param1;
         _loc4_.clipTargetY = param2;
         _loc4_.clip.y = _loc4_.grillWaitOffscreenY;
         _loc4_.container = param3;
         _loc4_.container.addChild(_loc4_.clip);
         _loc4_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.grabSandwich);
         _loc4_.clip.mouseEnabled = true;
         _loc4_.clip.mouseChildren = false;
         _loc4_.clip.buttonMode = true;
         _loc4_.clip.useHandCursor = true;
      }
      
      public function cookSandwich(param1:Number) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Sandwich = this;
         if(!_loc3_.isFlipping && !_loc3_.isGrabbing)
         {
            _loc3_.bottomTime += param1;
            _loc2_ = _loc3_.bottomTime / FoodData.getMaxCookTime();
            if(_loc2_ >= 21 / 48)
            {
               _loc3_.targetBottomFrame = 12;
            }
            else if(_loc2_ >= 19 / 48)
            {
               _loc3_.targetBottomFrame = 11;
            }
            else if(_loc2_ >= 17 / 48)
            {
               _loc3_.targetBottomFrame = 10;
            }
            else if(_loc2_ >= 15 / 48)
            {
               _loc3_.targetBottomFrame = 9;
            }
            else if(_loc2_ >= 13 / 48)
            {
               _loc3_.targetBottomFrame = 8;
            }
            else if(_loc2_ >= 11 / 48)
            {
               _loc3_.targetBottomFrame = 7;
            }
            else if(_loc2_ >= 9 / 48)
            {
               _loc3_.targetBottomFrame = 6;
            }
            else if(_loc2_ >= 7 / 48)
            {
               _loc3_.targetBottomFrame = 5;
            }
            else if(_loc2_ >= 5 / 48)
            {
               _loc3_.targetBottomFrame = 4;
            }
            else if(_loc2_ >= 3 / 48)
            {
               _loc3_.targetBottomFrame = 3;
            }
            else if(_loc2_ >= 2 / 48)
            {
               _loc3_.targetBottomFrame = 2;
            }
            else if(_loc2_ >= 1 / 48)
            {
               _loc3_.targetBottomFrame = 1;
            }
            else
            {
               _loc3_.targetBottomFrame = 0;
            }
            if(_loc3_.targetBottomFrame > _loc3_.numFrames - 1)
            {
               _loc3_.targetBottomFrame = _loc3_.numFrames - 1;
            }
            _loc3_.gameObj.var_136.updateMeter(_loc3_.whichGrillSpot,_loc3_.bottomTime + _loc3_.topTime,_loc3_.targetTopFrame,_loc3_.targetBottomFrame,_loc3_.topTime,_loc3_.bottomTime);
            _loc3_.checkSandwichTimer();
         }
         _loc3_.updateSandwichGraphic();
      }
      
      public function updateSandwichGraphic(param1:Boolean = false) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Point = null;
         var _loc4_:Sandwich = this;
         if(!_loc4_.isCut)
         {
            _loc2_ = new Rectangle(0,0,_loc4_.spriteWidth,_loc4_.spriteHeight);
            _loc3_ = new Point(0,0);
            if(_loc4_.topFrame != _loc4_.targetTopFrame || param1)
            {
               class_7.method_1("Update Top -- " + _loc4_.topFrame + " -> " + _loc4_.targetTopFrame);
               _loc4_.topFrame = _loc4_.targetTopFrame;
               _loc4_.topBitmapData.fillRect(_loc4_.topBitmapData.rect,0);
               if(_loc4_.isBitmapFlipped)
               {
                  _loc2_.x = _loc4_.topFrame * _loc4_.flipSpriteWidth;
                  _loc2_.width = _loc4_.flipSpriteWidth;
                  _loc2_.height = _loc4_.flipSpriteHeight;
                  _loc4_.topBitmapData.copyPixels(_loc4_.topFlippedSheet,_loc2_,_loc3_,null,null,true);
               }
               else
               {
                  _loc2_.x = _loc4_.topFrame * _loc4_.spriteWidth;
                  _loc2_.width = _loc4_.spriteWidth;
                  _loc2_.height = _loc4_.spriteHeight;
                  _loc4_.topBitmapData.copyPixels(_loc4_.topNormalSheet,_loc2_,_loc3_,null,null,true);
               }
            }
            if(_loc4_.bottomFrame != _loc4_.targetBottomFrame || param1)
            {
               class_7.method_1("Update Bottom -- " + _loc4_.bottomFrame + " -> " + _loc4_.targetBottomFrame + ". Flipped?: " + _loc4_.isBitmapFlipped);
               _loc4_.bottomFrame = _loc4_.targetBottomFrame;
               if(!param1)
               {
                  _loc4_.previousBottomBitmapData.fillRect(_loc4_.previousBottomBitmapData.rect,0);
                  _loc4_.previousBottomBitmapData.copyPixels(_loc4_.bottomBitmapData,_loc4_.bottomBitmapData.rect,_loc3_,null,null,true);
                  _loc4_.previousBottomBitmap.alpha = 1;
                  _loc4_.bottomBitmap.alpha = 0;
               }
               else
               {
                  _loc4_.bottomBitmap.alpha = 1;
                  _loc4_.previousBottomBitmap.alpha = 0;
               }
               _loc4_.bottomBitmapData.fillRect(_loc4_.bottomBitmapData.rect,0);
               if(_loc4_.isBitmapFlipped)
               {
                  _loc2_.x = _loc4_.bottomFrame * _loc4_.flipSpriteWidth;
                  _loc2_.width = _loc4_.flipSpriteWidth;
                  _loc2_.height = _loc4_.flipSpriteHeight;
                  _loc4_.bottomBitmapData.copyPixels(_loc4_.bottomFlippedSheet,_loc2_,_loc3_,null,null,true);
               }
               else
               {
                  _loc2_.x = _loc4_.bottomFrame * _loc4_.spriteWidth;
                  _loc2_.width = _loc4_.spriteWidth;
                  _loc2_.height = _loc4_.spriteHeight;
                  _loc4_.bottomBitmapData.copyPixels(_loc4_.bottomNormalSheet,_loc2_,_loc3_,null,null,true);
               }
               if(!_loc4_.isFlipping)
               {
                  _loc4_.gameObj.var_136.changeGreaseColor(_loc4_.whichGrillSpot,_loc4_.bottomFrame);
               }
            }
            if(_loc4_.bottomBitmap.alpha < 1)
            {
               _loc4_.bottomBitmap.alpha += 0.05;
               if(_loc4_.bottomBitmap.alpha >= 1)
               {
                  _loc4_.bottomBitmap.alpha = 1;
               }
            }
            else if(_loc4_.previousBottomBitmap.alpha > 0)
            {
               _loc4_.previousBottomBitmap.alpha -= 0.05;
               if(_loc4_.previousBottomBitmap.alpha < 0)
               {
                  _loc4_.previousBottomBitmap.alpha = 0;
               }
            }
         }
      }
      
      public function grabSandwich(param1:MouseEvent) : void
      {
         var _loc2_:Sandwich = this;
         if(_loc2_.isOnGrill)
         {
            if(!_loc2_.isFlipping && !_loc2_.isTrashingGrill && !_loc2_.isLeavingGrill && (!_loc2_.gameObj.training || _loc2_.gameObj.method_111(12,14,16,17)))
            {
               _loc2_.grabX = _loc2_.gameObj.var_136.clip.mouseX;
               _loc2_.grabY = _loc2_.gameObj.var_136.clip.mouseY + _loc2_.dragOffsetY;
               _loc2_.isGrabbing = true;
               _loc2_.isGrabbingMoving = false;
               _loc2_.isMovingToGrillTray = false;
               _loc2_.gameObj.var_129.playSound("grabtopping.wav");
               _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseSandwich);
               _loc2_.gameObj.stage.addEventListener(Event.MOUSE_LEAVE,_loc2_.releaseSandwich);
               if(_loc2_.container != _loc2_.gameObj.var_136.clip.dragholder)
               {
                  _loc2_.container = _loc2_.gameObj.var_136.clip.dragholder;
                  _loc2_.container.addChild(_loc2_.clip);
               }
               else
               {
                  _loc2_.container.setChildIndex(_loc2_.clip,_loc2_.container.numChildren - 1);
               }
               if(_loc2_.gameObj.var_136.timerAlarmsRunning[_loc2_.whichGrillSpot] == true)
               {
                  _loc2_.gameObj.var_136.stopAlarm(_loc2_.whichGrillSpot,true);
               }
               if(_loc2_.isShowingGrease && _loc2_.whichGrillSpot > -1)
               {
                  _loc2_.gameObj.var_136.removeGrease(_loc2_.whichGrillSpot);
                  _loc2_.isShowingGrease = false;
               }
            }
            else if(_loc2_.gameObj.method_111(13,15))
            {
               _loc2_.gameObj.hud.showTrainingWarning("waitmove");
            }
         }
      }
      
      public function releaseSandwich(param1:MouseEvent = null) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Sandwich = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         _loc4_ = Number(NaN);
         _loc5_ = null;
         _loc6_ = this;
         if(_loc6_.isOnGrill)
         {
            _loc6_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc6_.releaseSandwich);
            _loc6_.gameObj.stage.removeEventListener(Event.MOUSE_LEAVE,_loc6_.releaseSandwich);
            _loc6_.isGrabbing = false;
            if(!_loc6_.isGrabbingMoving && _loc6_.isCooking)
            {
               _loc6_.flipSandwichOnGrill();
               _loc6_.gameObj.method_104(14);
            }
            else
            {
               if(_loc6_.clip.x <= 135 && _loc6_.clip.y >= 340 && _loc6_.gameObj.training)
               {
                  _loc6_.gameObj.hud.showTrainingWarning("garbage");
               }
               if(_loc6_.clip.x <= 135 && _loc6_.clip.y >= 340 && !_loc6_.gameObj.training)
               {
                  _loc6_.gameObj.var_129.playSound("trayslide.wav");
                  if(_loc6_.whichGrillSpot != -1)
                  {
                     _loc6_.gameObj.var_136.removeFromCooking(_loc6_);
                     _loc6_.gameObj.var_136.updateMeter(_loc6_.whichGrillSpot,0,0,0,0,0,true);
                  }
                  _loc6_.gameObj.var_136.removeFromTray(_loc6_);
                  _loc6_.gameObj.var_136.addToLeavingSandwiches(_loc6_);
                  _loc6_.sendToGrillTrash();
               }
               else if(_loc6_.clip.x >= 471 && _loc6_.clip.y >= 317 && (_loc6_.bottomTime > 0 || _loc6_.topTime > 0) && (!_loc6_.gameObj.training || _loc6_.gameObj.method_111(16,17)))
               {
                  if(_loc6_.whichGrillSpot != -1)
                  {
                     _loc6_.gameObj.var_136.removeFromCooking(_loc6_);
                     _loc6_.gameObj.var_136.updateMeter(_loc6_.whichGrillSpot,0,0,0,0,0,true);
                  }
                  _loc6_.gameObj.var_136.addToLeavingSandwiches(_loc6_);
                  _loc2_ = _loc6_.gameObj.var_136.cutTargetX;
                  _loc3_ = _loc2_ - _loc6_.clip.x;
                  _loc6_.cutSandwich(_loc3_);
               }
               else
               {
                  _loc4_ = _loc6_.gameObj.var_136.getNearestGrillSpot(_loc6_.clip.x,_loc6_.clip.y);
                  if(_loc6_.clip.y <= 260 && _loc4_ > -1 && _loc6_.gameObj.var_136.isGrillSpotFree(_loc4_))
                  {
                     if(_loc6_.gameObj.training)
                     {
                        _loc4_ = 1;
                     }
                     if(_loc6_.container != _loc6_.gameObj.var_136.clip.holder)
                     {
                        _loc6_.container = _loc6_.gameObj.var_136.clip.holder;
                        _loc6_.container.addChild(_loc6_.clip);
                     }
                     _loc5_ = "none";
                     if(_loc6_.whichGrillSpot != -1)
                     {
                        _loc5_ = _loc6_.gameObj.var_136.getAlarmType(_loc6_.whichGrillSpot);
                        _loc6_.gameObj.var_136.removeFromCooking(_loc6_);
                        _loc6_.gameObj.var_136.updateMeter(_loc6_.whichGrillSpot,0,0,0,0,0,true);
                     }
                     _loc6_.gameObj.var_136.addToCooking(_loc6_,_loc4_);
                     _loc6_.gameObj.var_136.removeFromTray(_loc6_);
                     if(_loc5_ != "none" && _loc5_ != null)
                     {
                        _loc6_.gameObj.var_136.setAlarm(_loc4_,_loc5_);
                     }
                     class_7.method_1("Place at spot " + _loc4_);
                     _loc6_.startCooking(_loc4_);
                     if(!_loc6_.isShowingGrease)
                     {
                        _loc6_.gameObj.var_136.addGrease(_loc6_.whichGrillSpot,_loc6_.bottomFrame);
                        _loc6_.isShowingGrease = true;
                     }
                     _loc6_.gameObj.method_104(12);
                  }
                  else if(_loc6_.whichGrillSpot > -1)
                  {
                     class_7.method_1("Couldn\'t find anything to do, BUT you were cooking before (" + _loc6_.whichGrillSpot + ")");
                     if(_loc6_.container != _loc6_.gameObj.var_136.clip.holder)
                     {
                        _loc6_.container = _loc6_.gameObj.var_136.clip.holder;
                        _loc6_.container.addChild(_loc6_.clip);
                     }
                     else
                     {
                        _loc6_.container.setChildIndex(_loc6_.clip,_loc6_.container.numChildren - 1);
                     }
                     if(!_loc6_.isShowingGrease)
                     {
                        _loc6_.gameObj.var_136.addGrease(_loc6_.whichGrillSpot,_loc6_.bottomFrame);
                        _loc6_.isShowingGrease = true;
                     }
                  }
                  else if(!_loc6_.isCooking)
                  {
                     if(_loc6_.container != _loc6_.gameObj.var_136.clip.holder)
                     {
                        _loc6_.container = _loc6_.gameObj.var_136.clip.holder;
                        _loc6_.container.addChild(_loc6_.clip);
                     }
                     else
                     {
                        _loc6_.container.setChildIndex(_loc6_.clip,_loc6_.container.numChildren - 1);
                     }
                     _loc6_.isMovingToGrillTray = true;
                  }
               }
            }
         }
      }
      
      public function startCooking(param1:Number) : void
      {
         var _loc2_:Sandwich = null;
         var _loc3_:GrillScreen = null;
         _loc2_ = this;
         _loc3_ = _loc2_.gameObj.var_136;
         _loc2_.isCooking = true;
         _loc2_.isMovingToGrillTray = false;
         _loc2_.whichGrillSpot = param1;
         _loc2_.clipTargetX = _loc3_.grillStartX + param1 * _loc3_.grillSpacingX;
         _loc2_.clipTargetY = _loc3_.grillStartY;
         _loc2_.gameObj.var_129.playSound("landburger.wav");
         try
         {
            if(!_loc2_.gameObj.var_128.hasTrained("light") && _loc2_.gameObj.var_147.hangerTicket != null && _loc2_.gameObj.var_147.hangerTicket.orderData.cookType == FoodData.COOK_LIGHT && _loc2_.gameObj.var_147.tickets.length == 1)
            {
               _loc2_.gameObj.hud.showContextTraining("light");
               _loc2_.gameObj.var_128.setTrained("light");
            }
            else if(!_loc2_.gameObj.var_128.hasTrained("welldone") && _loc2_.gameObj.var_147.hangerTicket != null && _loc2_.gameObj.var_147.hangerTicket.orderData.cookType == FoodData.COOK_WELL && _loc2_.gameObj.var_147.tickets.length == 1)
            {
               _loc2_.gameObj.hud.showContextTraining("welldone");
               _loc2_.gameObj.var_128.setTrained("welldone");
            }
            else if(!_loc2_.gameObj.var_128.hasTrained("alarm") && (_loc2_.gameObj.var_128.hasBonus("lightalarm") || _loc2_.gameObj.var_128.hasBonus("mediumalarm") || _loc2_.gameObj.var_128.hasBonus("wellalarm")))
            {
               _loc2_.gameObj.hud.showContextTraining("alarm");
               _loc2_.gameObj.var_128.setTrained("alarm");
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public function flipSandwichOnGrill() : void
      {
         var _loc1_:Sandwich = null;
         _loc1_ = this;
         class_7.method_1("FLIP SANDWICH!");
         _loc1_.flipUseRotation = 0;
         _loc1_.isFlipRotating = false;
         _loc1_.isFlipFalling = false;
         _loc1_.isFlipSquashing = false;
         _loc1_.isFlipFinishSquashing = false;
         _loc1_.flipFallSpeed = _loc1_.flipFallSpeedStart;
         _loc1_.isFlipping = true;
         _loc1_.gameObj.var_136.showFlipShadow(_loc1_.whichGrillSpot);
      }
      
      public function getTotalTime() : Number
      {
         var _loc1_:Sandwich = null;
         _loc1_ = this;
         return _loc1_.topTime + _loc1_.bottomTime;
      }
      
      public function checkSandwichTimer() : void
      {
      }
      
      public function cutSandwich(param1:Number) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Sandwich = null;
         var _loc4_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         _loc2_ = 0;
         _loc3_ = this;
         _loc4_ = new Point(0,0);
         _loc5_ = new Rectangle();
         param1 = Math.round(param1 / _loc3_.grillScale);
         _loc6_ = param1;
         if(_loc3_.isBitmapFlipped)
         {
            _loc6_ -= _loc3_.bitmapXFlipped;
         }
         else
         {
            _loc6_ -= _loc3_.bitmapXNormal;
         }
         class_7.method_1("Cut at " + param1 + ". Cut Bitmap at " + _loc6_);
         if(_loc3_.isBitmapFlipped)
         {
            class_7.method_1("(Sprite Width = " + _loc3_.flipSpriteWidth + ")");
         }
         else
         {
            class_7.method_1("(Sprite Width = " + _loc3_.spriteWidth + ")");
         }
         _loc3_.topBitmapData.fillRect(_loc3_.topBitmapData.rect,0);
         _loc3_.bottomBitmapData.fillRect(_loc3_.bottomBitmapData.rect,0);
         _loc3_.bottomBitmap.alpha = 1;
         _loc3_.previousBottomBitmap.alpha = 0;
         if(_loc3_.isBitmapFlipped)
         {
            _loc5_.x = _loc3_.bottomFrame * _loc3_.flipSpriteWidth;
            _loc5_.width = _loc6_;
            _loc5_.height = _loc3_.flipSpriteHeight;
            _loc3_.topBitmapData.copyPixels(_loc3_.bottomFlippedSheet,_loc5_,_loc4_,null,null,true);
         }
         else
         {
            _loc5_.x = _loc3_.bottomFrame * _loc3_.spriteWidth;
            _loc5_.width = _loc6_;
            _loc5_.height = _loc3_.spriteHeight;
            _loc3_.topBitmapData.copyPixels(_loc3_.bottomNormalSheet,_loc5_,_loc4_,null,null,true);
         }
         if(_loc3_.isBitmapFlipped)
         {
            _loc5_.x = _loc3_.topFrame * _loc3_.flipSpriteWidth;
            _loc5_.width = _loc6_;
            _loc5_.height = _loc3_.flipSpriteHeight;
            _loc3_.topBitmapData.copyPixels(_loc3_.topFlippedSheet,_loc5_,_loc4_,null,null,true);
         }
         else
         {
            _loc5_.x = _loc3_.topFrame * _loc3_.spriteWidth;
            _loc5_.width = _loc6_;
            _loc5_.height = _loc3_.spriteHeight;
            _loc3_.topBitmapData.copyPixels(_loc3_.topNormalSheet,_loc5_,_loc4_,null,null,true);
         }
         _loc4_.x = _loc6_;
         if(_loc3_.isBitmapFlipped)
         {
            _loc5_.x = _loc3_.bottomFrame * _loc3_.flipSpriteWidth + _loc6_;
            _loc5_.width = _loc3_.flipSpriteWidth - _loc6_;
            _loc5_.height = _loc3_.flipSpriteHeight;
            _loc3_.bottomBitmapData.copyPixels(_loc3_.bottomFlippedSheet,_loc5_,_loc4_,null,null,true);
         }
         else
         {
            _loc5_.x = _loc3_.bottomFrame * _loc3_.spriteWidth + _loc6_;
            _loc5_.width = _loc3_.spriteWidth - _loc6_;
            _loc5_.height = _loc3_.spriteHeight;
            _loc3_.bottomBitmapData.copyPixels(_loc3_.bottomNormalSheet,_loc5_,_loc4_,null,null,true);
         }
         if(_loc3_.isBitmapFlipped)
         {
            _loc5_.x = _loc3_.topFrame * _loc3_.flipSpriteWidth + _loc6_;
            _loc5_.width = _loc3_.flipSpriteWidth - _loc6_;
            _loc5_.height = _loc3_.flipSpriteHeight;
            _loc3_.bottomBitmapData.copyPixels(_loc3_.topFlippedSheet,_loc5_,_loc4_,null,null,true);
         }
         else
         {
            _loc5_.x = _loc3_.topFrame * _loc3_.spriteWidth + _loc6_;
            _loc5_.width = _loc3_.spriteWidth - _loc6_;
            _loc5_.height = _loc3_.spriteHeight;
            _loc3_.bottomBitmapData.copyPixels(_loc3_.topNormalSheet,_loc5_,_loc4_,null,null,true);
         }
         _loc3_.cheeseCutClip = class_12.method_103("cut_" + _loc3_.cheeseType1,false,false);
         _loc3_.cheeseCutClip.x = param1;
         _loc3_.clip.addChild(_loc3_.cheeseCutClip);
         _loc7_ = _loc3_.bottomBitmapData.getVector(new Rectangle(_loc6_,0,1,_loc3_.bottomBitmapData.height));
         _loc8_ = -1;
         _loc9_ = -1;
         _loc2_ = 0;
         while(_loc2_ < _loc7_.length)
         {
            if(_loc7_[_loc2_] != 0 && _loc8_ == -1)
            {
               _loc8_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         _loc2_ = int(_loc7_.length - 1);
         while(_loc2_ >= 0)
         {
            if(_loc7_[_loc2_] != 0 && _loc9_ == -1)
            {
               _loc9_ = _loc2_;
               break;
            }
            _loc2_--;
         }
         _loc8_ += 2;
         _loc9_ -= 2;
         class_7.method_1("Cheese Cut Top/Bottom: " + _loc8_ + ", " + _loc9_ + " (Height = " + (_loc9_ - _loc8_) + ")");
         _loc3_.cheeseCutClip.y = _loc3_.bitmapHolder.y + _loc3_.bottomBitmap.y + _loc8_;
         _loc3_.cheeseCutClip.height = _loc9_ - _loc8_;
         _loc3_.cheeseCutClip.scaleX = 0;
         _loc3_.sliceClip = new slice_animation();
         _loc3_.sliceClip.x = _loc3_.cheeseCutClip.x;
         _loc3_.sliceClip.y = _loc3_.cheeseCutClip.y;
         _loc3_.sliceClip.height = _loc3_.cheeseCutClip.height;
         _loc3_.clip.addChild(_loc3_.sliceClip);
         class_7.method_1("Slice at " + _loc3_.sliceClip.x + ", " + _loc3_.sliceClip.y + " W/H: " + _loc3_.sliceClip.width + ", " + _loc3_.sliceClip.height);
         _loc3_.clipTargetX = _loc3_.clip.x;
         _loc3_.clipTargetY = _loc3_.gameObj.var_136.cutTargetY;
         _loc3_.cutRightTargetX = _loc3_.bottomBitmap.x + _loc3_.cutSpacing / 2;
         _loc3_.cutLeftTargetX = _loc3_.topBitmap.x - _loc3_.cutSpacing / 2;
         _loc3_.cutLocationX = param1;
         _loc3_.isCut = true;
         _loc3_.isCutting = true;
         _loc3_.gameObj.var_129.playSound("cut.wav");
         _loc3_.gameObj.method_104(17);
      }
      
      public function addToPlatter(param1:MovieClip) : void
      {
         var _loc2_:Sandwich = null;
         _loc2_ = this;
         _loc2_.gameObj.var_136.removeFromLeavingSandwiches(_loc2_);
         _loc2_.container = param1;
         _loc2_.container.addChild(_loc2_.clip);
         _loc2_.clip.x = 70;
         _loc2_.clip.y = 32;
         _loc2_.clip.scaleX = 1;
         _loc2_.clip.scaleY = 1;
         _loc2_.isOnFry = true;
      }
      
      public function getToppingTypes() : Array
      {
         var _loc1_:Sandwich = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _loc1_ = null;
         _loc2_ = null;
         _loc3_ = 0;
         _loc1_ = this;
         _loc2_ = [];
         _loc3_ = 0;
         while(_loc3_ < _loc1_.toppings.length)
         {
            _loc2_.push(_loc1_.toppings[_loc3_].type);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}


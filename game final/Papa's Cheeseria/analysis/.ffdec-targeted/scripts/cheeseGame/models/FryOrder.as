package cheeseGame.models
{
   import flash.display.*;
   import package_2.*;
   import package_4.class_5;
   
   public class FryOrder
   {
      
      public var gameObj:class_5;
      
      public var foodOrder:FoodOrder;
      
      public var clip:MovieClip;
      
      public var fryClip:MovieClip;
      
      public var fryType:String;
      
      public var cookAmount:Number;
      
      public var targetFrame:Number;
      
      public var placeX:Number = -72;
      
      public var placeY:Number = -20;
      
      public var targetScale:Number = 1;
      
      public var fryTopping:FryTopping = null;
      
      public function FryOrder(param1:class_5, param2:FoodOrder, param3:String, param4:Number, param5:Number)
      {
         super();
         this.gameObj = param1;
         this.foodOrder = param2;
         this.fryType = param3;
         this.cookAmount = param4;
         this.targetFrame = param5;
         this.setupFries();
      }
      
      public function setupFries() : void
      {
         var _loc1_:FryOrder = this;
         _loc1_.clip = new MovieClip();
         _loc1_.clip.x = _loc1_.placeX;
         _loc1_.clip.y = _loc1_.placeY;
         _loc1_.fryClip = class_12.method_103(_loc1_.fryType + "_clump",false,false);
         _loc1_.fryClip.gotoAndStop(_loc1_.targetFrame);
         _loc1_.fryClip.scaleX = 0.75;
         _loc1_.fryClip.scaleY = _loc1_.fryClip.scaleX;
         _loc1_.clip.addChild(_loc1_.fryClip);
         _loc1_.foodOrder.clip.addChild(_loc1_.clip);
         _loc1_.fryTopping = new FryTopping(_loc1_.gameObj,_loc1_);
      }
      
      public function updateFries() : void
      {
         var _loc1_:FryOrder = this;
         if(_loc1_.fryClip.scaleX != _loc1_.targetScale)
         {
            _loc1_.fryClip.scaleX += (_loc1_.targetScale - _loc1_.fryClip.scaleX) / 2;
            _loc1_.fryClip.scaleY = _loc1_.fryClip.scaleX;
            if(Math.abs(_loc1_.targetScale - _loc1_.fryClip.scaleX) <= 0.02)
            {
               _loc1_.fryClip.scaleX = _loc1_.targetScale;
               _loc1_.fryClip.scaleY = _loc1_.targetScale;
               _loc1_.fryClip.cacheAsBitmap = true;
            }
         }
         if(Boolean(_loc1_.fryTopping) && _loc1_.gameObj.hud.currentStation == "fry")
         {
            _loc1_.fryTopping.screenUpdate();
         }
      }
      
      public function prepareForGiveOrder() : void
      {
         var _loc1_:FryOrder = this;
         if(_loc1_.fryTopping)
         {
            _loc1_.fryTopping.clearLooseToppings();
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:FryOrder = this;
         if(_loc1_.fryTopping)
         {
            _loc1_.fryTopping.destroy();
            _loc1_.fryTopping = null;
         }
         if(_loc1_.fryClip)
         {
            if(_loc1_.fryClip.parent)
            {
               _loc1_.fryClip.parent.removeChild(_loc1_.fryClip);
            }
            _loc1_.fryClip = null;
         }
         if(_loc1_.clip)
         {
            if(_loc1_.clip.parent)
            {
               _loc1_.clip.parent.removeChild(_loc1_.clip);
            }
            _loc1_.clip = null;
         }
         _loc1_.foodOrder = null;
         _loc1_.gameObj = null;
      }
   }
}


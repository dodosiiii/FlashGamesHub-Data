package cheeseGame.screens
{
   import flash.display.MovieClip;
   import flash.events.*;
   import package_4.class_5;
   
   public class class_11
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public function class_11(param1:class_5)
      {
         super();
         var _loc2_:class_11 = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:class_11 = this;
         _loc1_.clip = new sponsorLogoMC();
         _loc1_.gameObj.addChild(_loc1_.clip);
         _loc1_.gameObj.stage.frameRate = 45;
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:class_11 = this;
         if(_loc2_.clip.currentFrame == _loc2_.clip.totalFrames)
         {
            _loc2_.gameObj.stage.frameRate = 30;
            _loc2_.gameObj.method_152();
            _loc2_.gameObj.method_217();
         }
      }
      
      public function clickScreen(param1:MouseEvent) : void
      {
         var _loc2_:class_11 = this;
      }
      
      public function destroy() : void
      {
         var _loc1_:class_11 = this;
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.gameObj.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


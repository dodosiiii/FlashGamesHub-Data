package cheeseGame.screens
{
   import flash.display.MovieClip;
   import flash.events.*;
   import package_1.*;
   import package_4.class_5;
   
   public class class_6
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public function class_6(param1:class_5)
      {
         super();
         var _loc2_:class_6 = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:class_6 = this;
         _loc1_.clip = new licenseLogoMC();
         _loc1_.gameObj.addChild(_loc1_.clip);
         _loc1_.gameObj.stage.frameRate = 45;
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.clip.btn.addEventListener(MouseEvent.CLICK,_loc1_.clickScreen);
         if(class_1.method_95() == false)
         {
            _loc1_.clip.btn.visible = false;
         }
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:class_6 = this;
         if(_loc2_.clip.currentFrame == _loc2_.clip.totalFrames)
         {
            _loc2_.gameObj.stage.frameRate = 30;
            if(class_1.method_91())
            {
               _loc2_.gameObj.method_152();
            }
            else
            {
               _loc2_.gameObj.var_132.api.method_106("SplashScreen");
            }
            _loc2_.gameObj.method_222();
         }
      }
      
      public function clickScreen(param1:MouseEvent) : void
      {
         var _loc2_:class_6 = this;
         _loc2_.gameObj.var_132.api.method_107(class_1.method_72());
      }
      
      public function destroy() : void
      {
         var _loc1_:class_6 = this;
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.clip.btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickScreen);
         _loc1_.gameObj.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


package cheeseGame.screens
{
   import flash.display.MovieClip;
   import flash.events.*;
   import package_3.*;
   import package_4.class_5;
   
   public class SplashScreen
   {
      
      public var gameObj:class_5;
      
      public var container:MovieClip;
      
      public var clip:MovieClip;
      
      public var cloudSpeed:Number = 2;
      
      public var cloudWidth:Number = 640;
      
      public var donutsShouldLeave:Boolean = false;
      
      public var donutLeaveSpeed:Number = 10;
      
      public var donutLeaveSpeedAccel:Number = 5;
      
      public function SplashScreen(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         var _loc4_:SplashScreen = null;
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.container = param2;
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:SplashScreen = this;
         _loc1_.clip = new splashScreenMC();
         _loc1_.clip.iris.gotoAndStop(1);
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.container.addEventListener("clickStart",_loc1_.clickStart);
         _loc1_.container.addEventListener("clickCredits",_loc1_.clickCredits);
         _loc1_.container.addEventListener("clickHighScores",_loc1_.clickHighScores);
         _loc1_.clip.fader.mouseEnabled = false;
         _loc1_.gameObj.var_129.switchMusic("title");
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.animateScreen);
      }
      
      public function animateScreen(param1:Event) : void
      {
         var _loc2_:SplashScreen = this;
         if(_loc2_.donutsShouldLeave)
         {
            _loc2_.donutLeaveSpeed += _loc2_.donutLeaveSpeedAccel;
            _loc2_.clip.cheeses.stop();
            _loc2_.clip.fries.stop();
            _loc2_.clip.cheeses.y += _loc2_.donutLeaveSpeed;
            _loc2_.clip.fries.y += _loc2_.donutLeaveSpeed;
         }
         if(_loc2_.clip.iris.currentFrame == _loc2_.clip.iris.totalFrames)
         {
            _loc2_.closeSplashScreen();
         }
      }
      
      public function clickStart(param1:Event) : void
      {
         var _loc2_:SplashScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.method_125();
         _loc2_.clip.iris.gotoAndPlay("irisout");
         _loc2_.gameObj.var_132.api.method_114("SplashScreen");
         _loc2_.donutsShouldLeave = true;
         class_4.method_82();
      }
      
      public function clickHighScores(param1:Event) : void
      {
         var _loc2_:SplashScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc2_.gameObj.var_132.api.method_197())
         {
            _loc2_.gameObj.var_132.method_125();
         }
         else
         {
            _loc2_.gameObj.var_132.method_224();
         }
      }
      
      public function clickCredits(param1:Event) : void
      {
         var _loc2_:SplashScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.method_125();
         class_4.method_82();
         _loc2_.gameObj.var_132.api.method_106("SplashCredits",{"useSection":"credits"});
         _loc2_.gameObj.var_132.api.method_105("SplashScreen");
      }
      
      public function destroy() : void
      {
         var _loc1_:SplashScreen = this;
         class_4.method_82();
         _loc1_.container.removeEventListener("clickStart",_loc1_.clickStart);
         _loc1_.container.removeEventListener("clickCredits",_loc1_.clickCredits);
         _loc1_.container.removeEventListener("clickHighScores",_loc1_.clickHighScores);
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.animateScreen);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function closeSplashScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:SplashScreen = this;
         _loc2_.gameObj.var_132.api.method_106("SlotSelect");
         _loc2_.gameObj.var_132.api.method_105("SplashScreen");
      }
   }
}


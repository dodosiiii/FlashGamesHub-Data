package cheeseGame.events
{
   import flash.events.*;
   import flash.system.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class GameControls
   {
      
      public var gameObj:class_5;
      
      public var gameplayTimer:Number = 0;
      
      public var lastTime:Number = 0;
      
      public var lastFPSWarning:Number = 0;
      
      public var alreadyCheated:Boolean = false;
      
      public var cheatm:Number = 0;
      
      public var debugMode:Number = 1;
      
      public var debugCheckOffset:Number = 6;
      
      public var debugDropDistance:Number = 4;
      
      public function GameControls(param1:class_5)
      {
         super();
         var _loc2_:GameControls = this;
         _loc2_.gameObj = param1;
      }
      
      public function setupGameCycle() : void
      {
         var _loc1_:GameControls = this;
         _loc1_.gameObj.var_138.addEventListener(Event.ENTER_FRAME,_loc1_.gameCycle);
         _loc1_.gameObj.stage.focus = _loc1_.gameObj.stage;
         _loc1_.gameObj.stage.addEventListener(KeyboardEvent.KEY_UP,_loc1_.keyListener);
         _loc1_.alreadyCheated = false;
      }
      
      public function removeGameCycle() : void
      {
         var _loc1_:GameControls = this;
         class_7.error("-------------------------------------------");
         class_7.error("");
         class_7.error("Day " + _loc1_.gameObj.var_128.currentDay + ".  Time = " + class_13.method_226(this.gameplayTimer));
         class_7.error("");
         class_7.error("-------------------------------------------");
         if(_loc1_.gameObj.var_138.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.gameObj.var_138.removeEventListener(Event.ENTER_FRAME,_loc1_.gameCycle);
         }
         _loc1_.gameObj.stage.removeEventListener(KeyboardEvent.KEY_UP,_loc1_.keyListener);
      }
      
      public function resetKeyFocus() : void
      {
         var _loc1_:GameControls = this;
         _loc1_.gameObj.stage.focus = _loc1_.gameObj.stage;
      }
      
      public function keyListener(param1:KeyboardEvent) : void
      {
      }
      
      public function gameCycle(param1:Event) : void
      {
         var _loc2_:GameControls = this;
         var _loc3_:class_5 = _loc2_.gameObj;
         if(!_loc3_.var_169)
         {
            ++_loc2_.gameplayTimer;
            if(_loc3_.hud)
            {
               _loc3_.hud.updateHUD();
            }
            if(!_loc3_.var_205)
            {
               _loc3_.var_134.updateManager();
               _loc3_.var_187.updateScreen();
               _loc3_.var_183.updateScreen();
               _loc3_.var_195.updateScreen();
               _loc3_.var_199.updateScreen();
               _loc3_.var_145.updateScreen();
               _loc3_.var_131.updateScreen();
               _loc3_.var_136.updateScreen();
               _loc3_.var_139.updateScreen();
            }
         }
         var _loc4_:Number = Number(getTimer());
         var _loc5_:Number = Math.round(1000 / (_loc4_ - this.lastTime));
         if(_loc4_ == this.lastTime)
         {
            _loc5_ = 0;
         }
         if(Boolean(_loc3_.hud) && Boolean(_loc3_.hud.clip))
         {
            _loc3_.hud.clip.fps_txt.text = _loc5_ + " fps";
            _loc3_.hud.clip.mem_txt.text = String(Math.round(System.totalMemory / 1024 / 1024)) + " MB";
         }
         _loc2_.lastTime = _loc4_;
      }
      
      public function destroy() : void
      {
         var _loc1_:GameControls = this;
         _loc1_.removeGameCycle();
      }
   }
}


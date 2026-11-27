package
{
   import cheeseGame.screens.class_2;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import package_1.*;
   import package_4.*;
   
   [SWF(width="640", height="480", backgroundColor="#000000", frameRate="30")]
   public dynamic class Preloader extends MovieClip
   {
      
      private var loadingScreen:class_2;
      
      public function Preloader()
      {
         super();
         stop();
         this.addEventListener(Event.ENTER_FRAME,this.initPreloader);
      }
      
      private function initPreloader(param1:Event) : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.initPreloader);
         class_1.init(loaderInfo);
         this.gameModule = new class_5();
         this.addChild(this.gameModule);
         this.gameModule.method_209();
      }
      
      private function ioError(param1:IOErrorEvent) : void
      {
         trace(param1.text);
      }
      
      private function loadingFinished() : void
      {
         gotoAndStop(2);
         this.startup();
      }
      
      private function startup() : void
      {
         var _loc2_:Class = getDefinitionByName("Main") as Class;
         addChild(new _loc2_() as DisplayObject);
         if(this.loadingScreen)
         {
            this.loadingScreen.destroy();
            this.loadingScreen = null;
         }
      }
   }
}


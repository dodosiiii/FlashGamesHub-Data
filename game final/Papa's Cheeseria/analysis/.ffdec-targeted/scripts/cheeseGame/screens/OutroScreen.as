package cheeseGame.screens
{
   import cheeseGame.data.UserData;
   import cheeseGame.models.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_2.*;
   import package_4.class_5;
   
   public class OutroScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var didSkip:Boolean = false;
      
      public var replay:Boolean = false;
      
      public var worker:Worker = null;
      
      public var workerTurnedFlipped:Worker = null;
      
      public var workerFlipped:Worker = null;
      
      public var server:Worker = null;
      
      public var completeFunction:Function = null;
      
      public function OutroScreen(param1:class_5, param2:Boolean = false, param3:Function = null)
      {
         super();
         var _loc4_:OutroScreen = this;
         class_7.method_1("Outro!");
         _loc4_.gameObj = param1;
         _loc4_.replay = param2;
         _loc4_.completeFunction = param3;
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:OutroScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.clip = new outroMC();
         _loc1_.gameObj.var_155.addChild(_loc1_.clip);
         _loc1_.clip.x = 0;
         _loc1_.clip.y = 0;
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.checkFrame);
         _loc1_.clip.gotoAndPlay(1);
         _loc1_.gameObj.var_129.switchMusic("bake");
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.workerData,0,0,1);
         _loc1_.workerFlipped = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.workerData,0,0,1,false,true);
         _loc1_.workerTurnedFlipped = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.workerData,0,0,1,true,true);
         _loc1_.server = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.var_151,0,0,1);
         _loc1_.worker.clip.visible = false;
         _loc1_.server.clip.visible = false;
      }
      
      public function clickSkip(param1:MouseEvent) : void
      {
         var _loc2_:OutroScreen = this;
         _loc2_.didSkip = true;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.gotoAndStop(_loc2_.clip.totalFrames);
      }
      
      public function checkFrame(param1:Event) : void
      {
         var _loc2_:OutroScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(_loc2_.clip.currentFrame == 101)
         {
            _loc2_.clip.frame2.holder.addChild(_loc2_.workerTurnedFlipped.clip);
            _loc2_.workerTurnedFlipped.clip.visible = true;
            _loc2_.workerTurnedFlipped.clip.scaleX = -1.568;
            _loc2_.workerTurnedFlipped.clip.scaleY = 1.568;
            _loc2_.workerTurnedFlipped.clip.x = 717;
            _loc2_.workerTurnedFlipped.clip.y = 67;
            _loc2_.workerTurnedFlipped.clip.gotoAndStop("intro7");
            _loc2_.workerTurnedFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 200)
         {
            _loc2_.clip.frame3.holder.addChild(_loc2_.worker.clip);
            _loc2_.worker.clip.visible = true;
            _loc2_.worker.clip.scaleX = 1.192;
            _loc2_.worker.clip.scaleY = 1.192;
            _loc2_.worker.clip.x = 80;
            _loc2_.worker.clip.y = 80;
            _loc2_.worker.clip.gotoAndStop("outro1");
            _loc2_.worker.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 400)
         {
            _loc2_.clip.frame5.holder.addChild(_loc2_.workerFlipped.clip);
            _loc2_.workerFlipped.clip.visible = true;
            _loc2_.workerFlipped.clip.scaleX = -2.103;
            _loc2_.workerFlipped.clip.scaleY = 2.103;
            _loc2_.workerFlipped.clip.x = 492;
            _loc2_.workerFlipped.clip.y = 27;
            _loc2_.workerFlipped.clip.gotoAndStop("outro2");
            _loc2_.workerFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 500)
         {
            _loc2_.gameObj.var_129.switchMusic("title");
            if(_loc3_.whichCharacter == "custom" && _loc3_.whichWaiter == "custom")
            {
               _loc2_.clip.frame6.worker_txt.text = String(_loc3_.myName).toUpperCase();
               _loc2_.clip.frame6.server_txt.text = String(_loc3_.waiterName).toUpperCase();
            }
            else if(_loc3_.whichCharacter == "custom")
            {
               _loc2_.clip.frame6.worker_txt.text = String(_loc3_.myName).toUpperCase();
               _loc2_.clip.frame6.server_txt.text = "on SAXOPHONE";
               _loc2_.clip.frame6.and_label.visible = false;
            }
            else if(_loc3_.whichWaiter == "custom")
            {
               _loc2_.clip.frame6.worker_txt.text = String(_loc3_.waiterName).toUpperCase();
               _loc2_.clip.frame6.server_txt.text = "on SAXOPHONE";
               _loc2_.clip.frame6.and_label.visible = false;
            }
            else
            {
               _loc2_.clip.frame6.worker_txt.text = "LIVE AT";
               _loc2_.clip.frame6.server_txt.text = "PAPA\'S CHEESERIA";
               _loc2_.clip.frame6.and_label.visible = false;
               _loc2_.clip.frame6.featuring.visible = false;
            }
            _loc2_.clip.frame6.worker_txt.cacheAsBitmap = true;
            _loc2_.clip.frame6.server_txt.cacheAsBitmap = true;
         }
         else if(_loc2_.clip.currentFrame == 600)
         {
            if(_loc3_.whichCharacter == "custom")
            {
               _loc2_.clip.frame7.holder.addChild(_loc2_.worker.clip);
               _loc2_.worker.clip.visible = true;
               _loc2_.worker.clip.scaleX = 1.094;
               _loc2_.worker.clip.scaleY = 1.094;
               _loc2_.worker.clip.x = 58;
               _loc2_.worker.clip.y = 129;
               _loc2_.worker.clip.gotoAndStop("outro3");
               _loc2_.worker.animateModel();
            }
            else if(_loc3_.whichWaiter == "custom")
            {
               _loc2_.clip.frame7.holder.addChild(_loc2_.server.clip);
               _loc2_.server.clip.visible = true;
               _loc2_.server.clip.scaleX = 1.094;
               _loc2_.server.clip.scaleY = 1.094;
               _loc2_.server.clip.x = 58;
               _loc2_.server.clip.y = 129;
               _loc2_.server.clip.gotoAndStop("outro3");
               _loc2_.server.animateModel();
            }
            if(_loc3_.whichCharacter == "custom" && _loc3_.whichWaiter == "custom")
            {
               _loc2_.clip.frame7.backholder.addChild(_loc2_.server.clip);
               _loc2_.server.clip.visible = true;
               _loc2_.server.clip.scaleX = 0.661;
               _loc2_.server.clip.scaleY = 0.661;
               _loc2_.server.clip.x = 376.45;
               _loc2_.server.clip.y = 61.75;
               _loc2_.server.clip.gotoAndStop("outro4");
               _loc2_.server.animateModel();
            }
            else
            {
               _loc2_.clip.frame7.maracas.visible = false;
            }
         }
         if(_loc2_.clip.currentFrame == _loc2_.clip.totalFrames)
         {
            _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.checkFrame);
            if(!this.replay)
            {
               _loc2_.gameObj.method_176(false);
            }
            else
            {
               _loc2_.gameObj.var_129.switchMusic("none");
            }
            try
            {
               if(_loc2_.completeFunction != null)
               {
                  _loc2_.completeFunction();
               }
               _loc2_.completeFunction = null;
            }
            catch(err:Error)
            {
            }
            _loc2_.gameObj.method_216();
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:OutroScreen = this;
         _loc1_.worker.destroy();
         _loc1_.worker = null;
         _loc1_.workerFlipped.destroy();
         _loc1_.workerFlipped = null;
         _loc1_.workerTurnedFlipped.destroy();
         _loc1_.workerTurnedFlipped = null;
         _loc1_.server.destroy();
         _loc1_.server = null;
         try
         {
            _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.checkFrame);
         }
         catch(err:Error)
         {
         }
         _loc1_.gameObj.var_155.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


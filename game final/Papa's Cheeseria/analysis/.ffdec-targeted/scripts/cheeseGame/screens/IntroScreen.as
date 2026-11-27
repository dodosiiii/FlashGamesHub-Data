package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_1.*;
   import package_2.*;
   import package_4.class_5;
   
   public class IntroScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var didSkip:Boolean = false;
      
      public var worker:Worker = null;
      
      public var workerFlipped:Worker = null;
      
      public var workerTurned:Worker = null;
      
      public var workerTurnedFlipped:Worker = null;
      
      public function IntroScreen(param1:class_5)
      {
         super();
         var _loc2_:IntroScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:IntroScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.clip = new introMC();
         _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         _loc1_.clip.x = 0;
         _loc1_.clip.y = 0;
         var _loc3_:WorkerData = new WorkerData(_loc1_.gameObj.workerData.getDataToSave());
         if(_loc2_.whichCharacter == "marty")
         {
            _loc3_.shirt = "tint_tshirt_spade_a";
            _loc3_.pants = "tint_pants_1_g";
            _loc3_.jacket = "tint_tornovershirt_a";
            _loc3_.shoes = "tint_darkshoes1_b";
            _loc3_.acca = "";
            _loc3_.accb = "tint_belt_7_a";
            _loc3_.accd = "tint_sunglasses01_b";
            _loc3_.hat = "";
         }
         else if(_loc2_.whichCharacter == "rita")
         {
            _loc3_.shirt = "tint_vneck_stitch_a";
            _loc3_.pants = "tint_pants_7_a";
            _loc3_.jacket = "tint_scarlettvest_a";
            _loc3_.shoes = "tint_darkshoes1_a";
            _loc3_.acca = "";
            _loc3_.accb = "tint_belt_11_d";
            _loc3_.accc = "tint_shortthermal_a";
            _loc3_.accd = "";
            _loc3_.hat = "tint_hairtie_a";
         }
         else if(_loc3_.gender == WorkerData.GENDER_FEMALE)
         {
            _loc3_.shirt = "tint_vneck_stitch_a";
            _loc3_.pants = "tint_skirt_1alt_a";
            _loc3_.jacket = "";
            _loc3_.shoes = "tint_shoes1_a";
            _loc3_.acca = "";
            _loc3_.accb = "";
            _loc3_.accc = "";
            _loc3_.hat = "";
         }
         else
         {
            _loc3_.shirt = "tint_vneck_stitch_a";
            _loc3_.pants = "tint_pants_10_a";
            _loc3_.jacket = "";
            _loc3_.shoes = "tint_shoes1_a";
            _loc3_.acca = "";
            _loc3_.accb = "";
            _loc3_.accc = "";
            _loc3_.hat = "";
         }
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip,_loc3_,0,0,1);
         _loc1_.workerFlipped = new Worker(_loc1_.gameObj,_loc1_.clip,_loc3_,0,0,1,false,true);
         _loc1_.workerTurned = new Worker(_loc1_.gameObj,_loc1_.clip,_loc3_,0,0,1,true);
         _loc1_.workerTurnedFlipped = new Worker(_loc1_.gameObj,_loc1_.clip,_loc3_,0,0,1,true,true);
         _loc1_.worker.clip.visible = false;
         _loc1_.workerFlipped.clip.visible = false;
         _loc1_.workerTurned.clip.visible = false;
         _loc1_.workerTurnedFlipped.clip.visible = false;
         _loc1_.clip.frame0.title_txt.text = String(_loc2_.myName + "\'s\nMusic Meltdown");
         if(Boolean(class_3.method_60()) && class_1.method_101() == false)
         {
            _loc1_.clip.frame0.title_txt.text = String("Music Meltdown");
         }
         _loc1_.clip.frame0.title_txt.cacheAsBitmap = true;
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.checkFrame);
         _loc1_.clip.gotoAndPlay(1);
         _loc1_.clip.skip_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickSkip);
         _loc1_.gameObj.var_129.switchMusic("other");
      }
      
      public function clickSkip(param1:MouseEvent) : void
      {
         var _loc2_:IntroScreen = this;
         _loc2_.didSkip = true;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.gotoAndStop(_loc2_.clip.totalFrames);
      }
      
      public function checkFrame(param1:Event) : void
      {
         var _loc2_:IntroScreen = this;
         if(_loc2_.clip.currentFrame == 101)
         {
            if(_loc2_.gameObj.var_128.whichCharacter == "custom")
            {
               _loc2_.clip.frame1.flyer.name_txt.text = String(_loc2_.gameObj.var_128.myName).toUpperCase();
            }
            else
            {
               _loc2_.clip.frame1.flyer.featuring.visible = false;
               _loc2_.clip.frame1.flyer.name_txt.text = "SPECIAL SHOW!";
            }
            _loc2_.clip.frame1.flyer.name_txt.cacheAsBitmap = true;
         }
         else if(_loc2_.clip.currentFrame == 362)
         {
            _loc2_.clip.frame2.holder.addChild(_loc2_.worker.clip);
            _loc2_.worker.clip.visible = true;
            _loc2_.worker.clip.scaleX = 1;
            _loc2_.worker.clip.scaleY = 1;
            _loc2_.worker.clip.x = 465;
            _loc2_.worker.clip.y = 90;
            _loc2_.worker.clip.gotoAndStop("intro1");
            _loc2_.worker.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 579)
         {
            _loc2_.clip.frame4.holder.addChild(_loc2_.worker.clip);
            _loc2_.worker.clip.visible = true;
            _loc2_.worker.clip.scaleX = 0.52;
            _loc2_.worker.clip.scaleY = 0.52;
            _loc2_.worker.clip.x = 367;
            _loc2_.worker.clip.y = 281;
            _loc2_.worker.clip.gotoAndStop("intro2");
            _loc2_.worker.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 728)
         {
            _loc2_.clip.frame5.holder.addChild(_loc2_.workerTurnedFlipped.clip);
            _loc2_.workerTurnedFlipped.clip.visible = true;
            _loc2_.workerTurnedFlipped.clip.scaleX = -1.858;
            _loc2_.workerTurnedFlipped.clip.scaleY = 1.858;
            _loc2_.workerTurnedFlipped.clip.x = 670;
            _loc2_.workerTurnedFlipped.clip.y = 43;
            _loc2_.workerTurnedFlipped.clip.gotoAndStop("intro3");
            _loc2_.workerTurnedFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 827)
         {
            _loc2_.clip.frame6.holder.addChild(_loc2_.workerFlipped.clip);
            _loc2_.workerFlipped.clip.visible = true;
            _loc2_.workerFlipped.clip.scaleX = -1.316;
            _loc2_.workerFlipped.clip.scaleY = 1.316;
            _loc2_.workerFlipped.clip.x = 550;
            _loc2_.workerFlipped.clip.y = 107;
            _loc2_.workerFlipped.clip.gotoAndStop("intro4");
            _loc2_.workerFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 932)
         {
            _loc2_.clip.frame7.holder.addChild(_loc2_.workerFlipped.clip);
            _loc2_.workerFlipped.clip.visible = true;
            _loc2_.workerFlipped.clip.scaleX = -2.713;
            _loc2_.workerFlipped.clip.scaleY = 2.713;
            _loc2_.workerFlipped.clip.x = 533;
            _loc2_.workerFlipped.clip.y = 2;
            _loc2_.workerFlipped.clip.gotoAndStop("intro5");
            _loc2_.workerFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 1033)
         {
            _loc2_.clip.frame8.holder.addChild(_loc2_.workerFlipped.clip);
            _loc2_.workerFlipped.clip.visible = true;
            _loc2_.workerFlipped.clip.scaleX = -0.575;
            _loc2_.workerFlipped.clip.scaleY = 0.575;
            _loc2_.workerFlipped.clip.x = 396;
            _loc2_.workerFlipped.clip.y = 197;
            _loc2_.workerFlipped.clip.gotoAndStop("intro6");
            _loc2_.workerFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 1171)
         {
            _loc2_.clip.frame9.holder.addChild(_loc2_.workerTurned.clip);
            _loc2_.workerTurned.clip.visible = true;
            _loc2_.workerTurned.clip.scaleX = 1.858;
            _loc2_.workerTurned.clip.scaleY = 1.858;
            _loc2_.workerTurned.clip.x = -70;
            _loc2_.workerTurned.clip.y = 43;
            _loc2_.workerTurned.clip.gotoAndStop("intro7");
            _loc2_.workerTurned.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 1271)
         {
            _loc2_.clip.frame10.holder.addChild(_loc2_.workerFlipped.clip);
            _loc2_.workerFlipped.clip.visible = true;
            _loc2_.workerFlipped.clip.scaleX = -2.431;
            _loc2_.workerFlipped.clip.scaleY = 2.431;
            _loc2_.workerFlipped.clip.x = 481;
            _loc2_.workerFlipped.clip.y = -25;
            _loc2_.workerFlipped.clip.gotoAndStop("intro8");
            _loc2_.workerFlipped.animateModel();
         }
         else if(_loc2_.clip.currentFrame == 1471)
         {
            _loc2_.clip.frame12.holder.addChild(_loc2_.workerFlipped.clip);
            _loc2_.workerFlipped.clip.visible = true;
            _loc2_.workerFlipped.clip.scaleX = -1.877;
            _loc2_.workerFlipped.clip.scaleY = 1.877;
            _loc2_.workerFlipped.clip.x = 474;
            _loc2_.workerFlipped.clip.y = 44;
            _loc2_.workerFlipped.clip.gotoAndStop("intro9");
            _loc2_.workerFlipped.animateModel();
         }
         if(_loc2_.clip.currentFrame == _loc2_.clip.totalFrames)
         {
            _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.checkFrame);
            _loc2_.gameObj.method_154();
            _loc2_.gameObj.method_271();
         }
         else if(_loc2_.clip.currentFrame == 578)
         {
            _loc2_.gameObj.var_129.switchMusic("build");
         }
         else if(_loc2_.clip.currentFrame == 931)
         {
            _loc2_.gameObj.var_129.switchMusic("bake");
         }
         else if(_loc2_.clip.currentFrame == 1490)
         {
            _loc2_.gameObj.var_129.switchMusic("none");
            _loc2_.gameObj.var_129.playMusicClip("endofday.wav");
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:IntroScreen = this;
         _loc1_.clip.skip_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickSkip);
         _loc1_.worker.destroy();
         _loc1_.workerTurned.destroy();
         _loc1_.workerFlipped.destroy();
         _loc1_.workerTurnedFlipped.destroy();
         _loc1_.worker = null;
         _loc1_.workerTurned = null;
         _loc1_.workerFlipped = null;
         _loc1_.workerTurnedFlipped = null;
         try
         {
            _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.checkFrame);
         }
         catch(err:Error)
         {
         }
         _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


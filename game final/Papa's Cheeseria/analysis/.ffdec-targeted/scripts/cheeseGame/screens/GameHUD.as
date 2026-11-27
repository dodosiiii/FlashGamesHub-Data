package cheeseGame.screens
{
   import cheeseGame.data.UserData;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_4.class_5;
   
   public class GameHUD
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var currentStation:String = "none";
      
      public var duringTransition:Boolean = false;
      
      private var transitionToScreen:String = "none";
      
      private var transitionSpeed:Number = 0.2;
      
      private var switchedTransition:Boolean = false;
      
      public var trainingClip:MovieClip;
      
      public var whichContextTraining:String = "none";
      
      public var timersGoingOff:Number = 0;
      
      public var fryTimersGoingOff:Number = 0;
      
      public function GameHUD(param1:class_5)
      {
         super();
         var _loc2_:GameHUD = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip = new hudMC();
         _loc1_.gameObj.var_155.addChild(_loc1_.clip);
         _loc1_.clip.mouseEnabled = false;
         _loc1_.clip.order_ring.visible = false;
         _loc1_.clip.cook_ring.visible = false;
         _loc1_.clip.build_ring.visible = false;
         _loc1_.clip.fry_ring.visible = false;
         _loc1_.clip.order_ring.mouseEnabled = false;
         _loc1_.clip.cook_ring.mouseEnabled = false;
         _loc1_.clip.build_ring.mouseEnabled = false;
         _loc1_.clip.fry_ring.mouseEnabled = false;
         _loc1_.clip.order_ring.mouseChildren = false;
         _loc1_.clip.cook_ring.mouseChildren = false;
         _loc1_.clip.build_ring.mouseChildren = false;
         _loc1_.clip.fry_ring.mouseChildren = false;
         _loc1_.clip.order_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickOrder);
         _loc1_.clip.cook_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickCook);
         _loc1_.clip.build_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickBuild);
         _loc1_.clip.fry_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickFry);
         _loc1_.clip.mute_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickMute);
         _loc1_.clip.unmute_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickUnmute);
         _loc1_.clip.menu_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickMenu);
         _loc1_.clip.mute_music_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickMuteMusic);
         _loc1_.clip.unmute_music_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickUnmuteMusic);
         _loc1_.clip.special_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickSpecial);
         _loc1_.updateMuteButton();
         _loc1_.clip.pausedBG.visible = false;
         _loc1_.clip.pausedBG.mouseEnabled = true;
         _loc1_.clip.doorchime_alert.visible = false;
         _loc1_.clip.doorchime_alert.stop();
         _loc1_.clip.doorchime_alert.mouseEnabled = false;
         _loc1_.clip.red_timer.visible = false;
         _loc1_.clip.red_timer.mouseEnabled = false;
         _loc1_.clip.yellow_timer.visible = false;
         _loc1_.clip.yellow_timer.mouseEnabled = false;
         _loc1_.clip.blue_timer.visible = false;
         _loc1_.clip.blue_timer.mouseEnabled = false;
         _loc1_.clip.red_timer.stop();
         _loc1_.clip.yellow_timer.stop();
         _loc1_.clip.blue_timer.stop();
         _loc1_.clip.fry_alarm_0.visible = false;
         _loc1_.clip.fry_alarm_0.mouseEnabled = false;
         _loc1_.clip.fry_alarm_0.stop();
         _loc1_.clip.fry_alarm_1.visible = false;
         _loc1_.clip.fry_alarm_1.mouseEnabled = false;
         _loc1_.clip.fry_alarm_1.stop();
         if(_loc1_.gameObj.var_128.currentDay == 1 && _loc1_.gameObj.training)
         {
            _loc1_.trainingClip = new trainingMC();
            _loc1_.clip.addChild(_loc1_.trainingClip);
            _loc1_.trainingClip.mouseEnabled = false;
            _loc1_.trainingClip.mouseChildren = false;
            _loc1_.clip.skiptraining_btn.visible = true;
            _loc1_.clip.skiptraining_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickSkipTraining);
            _loc1_.clip.skip_yes_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickSkipTrainingYes);
            _loc1_.clip.skip_no_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickSkipTrainingNo);
            _loc1_.clip.menu_btn.visible = false;
         }
         else
         {
            _loc1_.clip.skiptraining_btn.visible = false;
         }
         _loc1_.clip.skip_yes_btn.visible = false;
         _loc1_.clip.skip_no_btn.visible = false;
         _loc1_.clip.sureMC.visible = false;
         _loc1_.clip.fps_txt.visible = false;
         _loc1_.clip.mem_txt.visible = false;
         _loc1_.clip.fps_warning.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip.order_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickOrder);
         _loc1_.clip.cook_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickCook);
         _loc1_.clip.build_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickBuild);
         _loc1_.clip.fry_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickFry);
         _loc1_.clip.mute_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickMute);
         _loc1_.clip.unmute_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickUnmute);
         _loc1_.clip.mute_music_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickMuteMusic);
         _loc1_.clip.unmute_music_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickUnmuteMusic);
         _loc1_.clip.menu_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickMenu);
         _loc1_.clip.special_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickSpecial);
         _loc1_.clip.skiptraining_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickSkipTraining);
         _loc1_.clip.skip_yes_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickSkipTrainingYes);
         _loc1_.clip.skip_no_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickSkipTrainingNo);
         if(_loc1_.trainingClip)
         {
            _loc1_.clip.removeChild(_loc1_.trainingClip);
            _loc1_.trainingClip = null;
         }
         _loc1_.gameObj.var_155.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function removeSkipButtons() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip.skiptraining_btn.visible = false;
         _loc1_.clip.skip_yes_btn.visible = false;
         _loc1_.clip.skip_no_btn.visible = false;
         _loc1_.clip.sureMC.visible = false;
         _loc1_.clip.menu_btn.visible = true;
      }
      
      public function clickSkipTraining(param1:MouseEvent) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.skiptraining_btn.visible = false;
         _loc2_.clip.skip_yes_btn.visible = true;
         _loc2_.clip.skip_no_btn.visible = true;
         _loc2_.clip.sureMC.visible = true;
      }
      
      public function clickSkipTrainingYes(param1:MouseEvent) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.removeSkipButtons();
         if(_loc2_.gameObj.training)
         {
            _loc2_.gameObj.var_200 = _loc2_.gameObj.var_305 + 1;
            if(_loc2_.trainingClip)
            {
               _loc2_.trainingClip.gotoAndStop(_loc2_.gameObj.var_200);
            }
            _loc2_.gameObj.var_134.didSkipTraining = true;
            _loc2_.gameObj.var_134.lastSpawnTime = _loc2_.gameObj.controls.gameplayTimer;
            _loc2_.gameObj.method_203();
         }
      }
      
      public function clickSkipTrainingNo(param1:MouseEvent) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.skiptraining_btn.visible = true;
         _loc2_.clip.skip_yes_btn.visible = false;
         _loc2_.clip.skip_no_btn.visible = false;
         _loc2_.clip.sureMC.visible = false;
      }
      
      public function clickSpecial(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc2_.clip.build_btn.visible != false)
         {
            _loc2_.gameObj.method_184();
            if(_loc2_.whichContextTraining == "cheatsheet")
            {
               _loc2_.removeContextTraining();
               _loc2_.gameObj.var_128.setTrained("cheatsheet");
            }
         }
      }
      
      public function clickOrder(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         if(_loc2_.currentStation != "order" && _loc2_.canClickInTraining(param1))
         {
            _loc2_.gameObj.var_145.registerClickForForcing();
            _loc2_.startTransition("order");
         }
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickCook(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         if(_loc2_.currentStation != "cook" && _loc2_.canClickInTraining(param1))
         {
            _loc2_.startTransition("cook");
         }
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickBuild(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         if(_loc2_.currentStation != "build" && _loc2_.canClickInTraining(param1))
         {
            _loc2_.startTransition("build");
         }
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickFry(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         if(_loc2_.currentStation != "fry" && _loc2_.canClickInTraining(param1))
         {
            _loc2_.startTransition("fry");
         }
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function updateMuteButton() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip.mute_btn.visible = !_loc1_.gameObj.var_129.isMute;
         _loc1_.clip.unmute_btn.visible = _loc1_.gameObj.var_129.isMute;
         _loc1_.clip.mute_music_btn.visible = !_loc1_.gameObj.var_129.isMusicMute;
         _loc1_.clip.unmute_music_btn.visible = _loc1_.gameObj.var_129.isMusicMute;
      }
      
      public function clickMute(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.muteSound();
         _loc2_.updateMuteButton();
      }
      
      public function clickUnmute(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.unmuteSound();
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.updateMuteButton();
      }
      
      public function clickMuteMusic(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.muteMusic();
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.updateMuteButton();
      }
      
      public function clickUnmuteMusic(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         _loc2_.gameObj.var_129.unmuteMusic();
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.updateMuteButton();
      }
      
      public function clickMenu(param1:MouseEvent = null) : void
      {
         var _loc2_:GameHUD = this;
         if(_loc2_.canClickInTraining(param1))
         {
            _loc2_.gameObj.var_129.playSound("buttonclick.wav");
            _loc2_.gameObj.method_280();
            _loc2_.gameObj.var_136.quietSoundWhenPaused();
            _loc2_.gameObj.var_131.quietSoundWhenPaused();
            _loc2_.gameObj.var_145.stopFurniMusic();
         }
      }
      
      public function closedMenu() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.gameObj.var_136.resumeSoundAfterPaused();
         _loc1_.gameObj.var_131.resumeSoundAfterPaused();
      }
      
      public function startTransition(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:GameHUD = this;
         if(!_loc3_.duringTransition)
         {
            _loc3_.transitionToScreen = param1;
            _loc3_.duringTransition = true;
            _loc3_.switchedTransition = false;
            _loc3_.clip.transition.visible = true;
            _loc3_.clip.transition.alpha = 0;
            if(param2)
            {
               _loc3_.clip.transition.alpha = 1;
            }
            if(_loc3_.whichContextTraining != "none")
            {
               _loc3_.removeContextTraining();
            }
         }
      }
      
      private function triggerTransition() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip.order_ring.visible = false;
         _loc1_.clip.cook_ring.visible = false;
         _loc1_.clip.build_ring.visible = false;
         _loc1_.clip.fry_ring.visible = false;
         if(_loc1_.currentStation == "build")
         {
            _loc1_.gameObj.var_139.deactivateScreen();
         }
         else if(_loc1_.currentStation == "cook")
         {
            _loc1_.gameObj.var_136.deactivateScreen();
         }
         else if(_loc1_.currentStation == "fry")
         {
            _loc1_.gameObj.var_131.deactivateScreen();
         }
         else if(_loc1_.currentStation == "order")
         {
            _loc1_.gameObj.var_145.deactivateScreen();
         }
         else if(_loc1_.currentStation == "takeOrder")
         {
            _loc1_.gameObj.var_187.deactivateScreen();
         }
         else if(_loc1_.currentStation == "giveOrder")
         {
            _loc1_.gameObj.var_183.deactivateScreen();
         }
         else if(_loc1_.currentStation == "diningGiveOrder")
         {
            _loc1_.gameObj.var_195.deactivateScreen();
         }
         else if(_loc1_.currentStation == "diningTakeOrder")
         {
            _loc1_.gameObj.var_199.deactivateScreen();
         }
         if(_loc1_.transitionToScreen == "order")
         {
            _loc1_.gameObj.var_145.activateScreen();
            _loc1_.clip.order_ring.visible = true;
            _loc1_.gameObj.method_104(3,25);
         }
         else if(_loc1_.transitionToScreen == "cook")
         {
            _loc1_.gameObj.var_136.activateScreen();
            _loc1_.clip.cook_ring.visible = true;
            _loc1_.gameObj.method_104(11);
         }
         else if(_loc1_.transitionToScreen == "fry")
         {
            _loc1_.gameObj.var_131.activateScreen();
            _loc1_.clip.fry_ring.visible = true;
            _loc1_.gameObj.method_104(18);
         }
         else if(_loc1_.transitionToScreen == "build")
         {
            _loc1_.gameObj.var_139.activateScreen();
            _loc1_.clip.build_ring.visible = true;
            _loc1_.gameObj.method_104(4);
         }
         else if(_loc1_.transitionToScreen == "takeOrder")
         {
            _loc1_.gameObj.var_187.activateScreen();
         }
         else if(_loc1_.transitionToScreen == "giveOrder")
         {
            _loc1_.gameObj.var_183.activateScreen();
         }
         else if(_loc1_.transitionToScreen == "diningGiveOrder")
         {
            _loc1_.gameObj.var_195.activateScreen();
         }
         else if(_loc1_.transitionToScreen == "diningTakeOrder")
         {
            _loc1_.gameObj.var_199.activateScreen();
         }
         if(_loc1_.transitionToScreen == "order" && _loc1_.gameObj.var_128.hasRibbon() && !_loc1_.gameObj.var_128.hasTrained("ribbon") && !_loc1_.gameObj.var_145.isWaitingToEnd)
         {
            _loc1_.showContextTraining("ribbon");
            _loc1_.gameObj.var_128.setTrained("ribbon");
         }
         else if(_loc1_.transitionToScreen == "order" && _loc1_.gameObj.var_128.getDay() > 1 && _loc1_.gameObj.var_128.getRank() > 6 && !_loc1_.gameObj.var_128.hasTrained("clothingbonus"))
         {
            _loc1_.showContextTraining("clothingbonus");
            _loc1_.gameObj.var_128.setTrained("clothingbonus");
         }
         if(_loc1_.transitionToScreen == "takeOrder" || _loc1_.transitionToScreen == "giveOrder" || _loc1_.transitionToScreen == "diningGiveOrder" || _loc1_.transitionToScreen == "diningTakeOrder" || _loc1_.gameObj.var_145.isWaitingToEnd)
         {
            _loc1_.clip.build_btn.visible = false;
            _loc1_.clip.cook_btn.visible = false;
            _loc1_.clip.order_btn.visible = false;
            _loc1_.clip.fry_btn.visible = false;
         }
         else
         {
            _loc1_.clip.build_btn.visible = true;
            _loc1_.clip.cook_btn.visible = true;
            _loc1_.clip.order_btn.visible = true;
            _loc1_.clip.fry_btn.visible = true;
         }
         if(_loc1_.transitionToScreen == "ending")
         {
            _loc1_.gameObj.method_230();
         }
         else
         {
            _loc1_.currentStation = _loc1_.transitionToScreen;
            _loc1_.transitionToScreen = "none";
         }
      }
      
      public function disableStationButtons() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip.build_btn.visible = false;
         _loc1_.clip.cook_btn.visible = false;
         _loc1_.clip.order_btn.visible = false;
         _loc1_.clip.fry_btn.visible = false;
      }
      
      public function enableStationButtons() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.clip.build_btn.visible = true;
         _loc1_.clip.cook_btn.visible = true;
         _loc1_.clip.order_btn.visible = true;
         _loc1_.clip.fry_btn.visible = true;
      }
      
      public function updateHUD() : void
      {
         var _loc1_:GameHUD = this;
         if(_loc1_.duringTransition)
         {
            if(!_loc1_.switchedTransition)
            {
               _loc1_.clip.transition.alpha += _loc1_.transitionSpeed;
               if(_loc1_.clip.transition.alpha >= 1)
               {
                  _loc1_.clip.transition.alpha = 1;
                  _loc1_.triggerTransition();
                  _loc1_.switchedTransition = true;
               }
            }
            else
            {
               _loc1_.clip.transition.alpha -= _loc1_.transitionSpeed;
               if(_loc1_.clip.transition.alpha <= 0)
               {
                  _loc1_.clip.transition.alpha = 0;
                  _loc1_.clip.transition.visible = false;
                  _loc1_.duringTransition = false;
               }
            }
         }
      }
      
      public function startHUD() : void
      {
         var _loc1_:GameHUD = this;
         _loc1_.updateMuteButton();
         _loc1_.startTransition("order",true);
         if(_loc1_.gameObj.var_128.currentSpecial > -1)
         {
            _loc1_.clip.special_btn.visible = true;
         }
         else
         {
            _loc1_.clip.special_btn.visible = false;
         }
      }
      
      public function showCustomerAlert(param1:Boolean = false) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:GameHUD = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         if(_loc4_.hasBonus("doorbell"))
         {
            _loc2_ = _loc3_.gameObj.var_134.orderline.length;
            if(_loc2_ > 0)
            {
               if(_loc3_.currentStation != "order" && _loc3_.transitionToScreen != "order")
               {
                  _loc3_.clip.doorchime_alert.visible = true;
                  _loc3_.clip.doorchime_alert.play();
                  _loc3_.clip.doorchime_alert.num_txt.text = String(_loc2_);
               }
               if(param1)
               {
                  _loc3_.gameObj.var_129.playSound("waiter_bell.wav");
               }
               else
               {
                  _loc3_.gameObj.var_129.playSound("doorchime.wav");
               }
            }
         }
      }
      
      public function showTimerAlert(param1:String = "cook") : void
      {
         var _loc2_:GameHUD = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(param1 == "cook" && _loc2_.currentStation != "cook" && _loc2_.transitionToScreen != "cook")
         {
            ++_loc2_.timersGoingOff;
            if(_loc2_.timersGoingOff == 1)
            {
               _loc2_.clip.blue_timer.visible = true;
               _loc2_.clip.blue_timer.play();
            }
            else if(_loc2_.timersGoingOff == 2)
            {
               _loc2_.clip.yellow_timer.visible = true;
               _loc2_.clip.yellow_timer.play();
            }
            else if(_loc2_.timersGoingOff > 2)
            {
               _loc2_.clip.red_timer.visible = true;
               _loc2_.clip.red_timer.play();
            }
         }
         else if(param1 == "fry" && _loc2_.currentStation != "fry" && _loc2_.transitionToScreen != "fry")
         {
            ++_loc2_.fryTimersGoingOff;
            if(_loc2_.fryTimersGoingOff == 1)
            {
               _loc2_.clip.fry_alarm_0.visible = true;
               _loc2_.clip.fry_alarm_0.play();
            }
            else if(_loc2_.fryTimersGoingOff > 1)
            {
               _loc2_.clip.fry_alarm_1.visible = true;
               _loc2_.clip.fry_alarm_1.play();
            }
         }
      }
      
      public function hideTimerAlerts(param1:String = "cook") : void
      {
         var _loc2_:GameHUD = this;
         if(param1 == "cook")
         {
            _loc2_.timersGoingOff = 0;
            _loc2_.clip.blue_timer.visible = false;
            _loc2_.clip.yellow_timer.visible = false;
            _loc2_.clip.red_timer.visible = false;
            _loc2_.clip.blue_timer.stop();
            _loc2_.clip.yellow_timer.stop();
            _loc2_.clip.red_timer.stop();
         }
         else if(param1 == "fry")
         {
            _loc2_.fryTimersGoingOff = 0;
            _loc2_.clip.fry_alarm_0.visible = false;
            _loc2_.clip.fry_alarm_1.visible = false;
            _loc2_.clip.fry_alarm_0.stop();
            _loc2_.clip.fry_alarm_1.stop();
         }
      }
      
      public function canClickInTraining(param1:Event) : Boolean
      {
         var _loc2_:GameHUD = this;
         var _loc3_:class_5 = _loc2_.gameObj;
         var _loc4_:Boolean = false;
         if(_loc3_.training)
         {
            if(param1.currentTarget == _loc2_.clip.build_btn && _loc3_.method_111(4))
            {
               return true;
            }
            if(param1.currentTarget == _loc2_.clip.fry_btn && _loc3_.method_111(18))
            {
               return true;
            }
         }
         else if(_loc3_.var_205)
         {
            _loc4_ = false;
         }
         else
         {
            _loc4_ = true;
         }
         return _loc4_;
      }
      
      public function showContextTraining(param1:String) : void
      {
         var _loc2_:GameHUD = this;
         if(!_loc2_.trainingClip && !_loc2_.gameObj.training)
         {
            _loc2_.trainingClip = new trainingMC();
            _loc2_.clip.addChild(_loc2_.trainingClip);
            _loc2_.trainingClip.mouseEnabled = false;
            _loc2_.trainingClip.mouseChildren = false;
         }
         _loc2_.whichContextTraining = param1;
         _loc2_.trainingClip.gotoAndStop(param1);
      }
      
      public function removeContextTraining() : void
      {
         var _loc1_:GameHUD = this;
         if(!_loc1_.gameObj.training && Boolean(_loc1_.trainingClip))
         {
            _loc1_.clip.removeChild(_loc1_.trainingClip);
            _loc1_.trainingClip = null;
         }
         _loc1_.whichContextTraining = "none";
      }
      
      public function showTrainingWarning(param1:String) : void
      {
         var _loc2_:GameHUD = this;
         if(_loc2_.trainingClip)
         {
            try
            {
               _loc2_.trainingClip.warningMC.gotoAndPlay(param1);
               if(param1 != "hidden")
               {
                  _loc2_.gameObj.var_129.playSound("boing.wav");
               }
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function clickHeatMap(param1:MouseEvent) : void
      {
      }
   }
}


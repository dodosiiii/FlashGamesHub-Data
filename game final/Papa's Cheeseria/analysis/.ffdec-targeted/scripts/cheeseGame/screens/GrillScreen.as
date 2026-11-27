package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import package_2.*;
   import package_4.*;
   
   public class GrillScreen
   {
      
      public var clip:MovieClip;
      
      public var isActive:Boolean = false;
      
      public var gameObj:class_5;
      
      public var cookSpotsTotal:Number = 4;
      
      public var cookingSandwiches:Vector.<Sandwich>;
      
      public var waitingSandwiches:Vector.<Sandwich>;
      
      public var traySandwiches:Vector.<Sandwich>;
      
      public var leavingSandwiches:Vector.<Sandwich>;
      
      public var isBoosting:Boolean = false;
      
      public var boostingWhich:Number = -1;
      
      public var boostSound:SoundChannel;
      
      public var cookSound:SoundChannel = null;
      
      public var cookVolume:Number = 0;
      
      public var alarmsRunning:Number = 0;
      
      public var alarmSound:SoundChannel = null;
      
      public var alarmBaseVolume:Number = 0.5;
      
      public var alarmExtraVolume:Number = 0.2;
      
      public var grillStartX:Number = 69;
      
      public var grillStartY:Number = 202;
      
      public var grillSpacingX:Number = 117;
      
      public var waitingStartX:Number = 257;
      
      public var waitingStartY:Number = 420;
      
      public var waitingSpacingX:Number = 122;
      
      public var waitingSpacingY:Number = 180;
      
      public var cutTargetX:Number = 556;
      
      public var cutTargetY:Number = 414;
      
      public var cutOffscreenX:Number = 800;
      
      public var alarmTargetY:Number = 316;
      
      public var alarmStartY:Number = 366;
      
      public var alarmTargetX:Array;
      
      public var alarmClips:Array;
      
      public var alarmTypes:Array;
      
      public var alarmsDragging:Array;
      
      public var alarmsReturning:Array;
      
      public var timerAlarmTypes:Array;
      
      public var timerAlarmsRunning:Array;
      
      public var timerAlarmsMode:Array;
      
      public const ALARM_LIGHT:String = "lightalarm";
      
      public const ALARM_MEDIUM:String = "mediumalarm";
      
      public const ALARM_WELL:String = "wellalarm";
      
      public function GrillScreen(param1:class_5)
      {
         this.alarmTargetX = [29,77,126];
         this.alarmClips = [];
         this.alarmTypes = ["lightalarm","mediumalarm","wellalarm"];
         this.alarmsDragging = [false,false,false];
         this.alarmsReturning = [false,false,false];
         this.timerAlarmTypes = ["none","none","none","none"];
         this.timerAlarmsRunning = [false,false,false,false];
         this.timerAlarmsMode = ["none","none","none","none"];
         super();
         var _loc2_:GrillScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function restoreSoundAfterAd() : void
      {
         var _loc1_:GrillScreen = this;
         if(_loc1_.cookSound)
         {
            _loc1_.cookSound.stop();
         }
         _loc1_.cookSound = null;
         _loc1_.cookSound = _loc1_.gameObj.var_129.playSound("grillburger.wav",true,0);
      }
      
      public function setupScreen() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:MovieClip = null;
         var _loc4_:GrillScreen = this;
         var _loc5_:UserData = _loc4_.gameObj.var_128;
         _loc4_.clip = new grillScreenMC();
         _loc4_.clip.bg.cacheAsBitmap = true;
         _loc4_.clip.trashfront.cacheAsBitmap = true;
         _loc4_.gameObj.var_129.addEventListener("soundIsMuted",_loc4_.onSoundIsMuted);
         _loc4_.gameObj.var_129.addEventListener("soundIsNotMuted",_loc4_.onSoundIsNotMuted);
         _loc4_.cookingSandwiches = new Vector.<Sandwich>(4,true);
         _loc4_.traySandwiches = new Vector.<Sandwich>(2,true);
         _loc4_.leavingSandwiches = new Vector.<Sandwich>();
         _loc4_.waitingSandwiches = new Vector.<Sandwich>();
         _loc1_ = 0;
         while(_loc1_ < _loc4_.cookSpotsTotal)
         {
            _loc4_.clip["boost" + _loc1_ + "_btn"].addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.pressGrillBoost);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.cookSpotsTotal)
         {
            _loc4_.clip["timer" + _loc1_].mouseEnabled = false;
            _loc4_.clip["timer" + _loc1_].mouseChildren = false;
            _loc4_.clip["timer" + _loc1_].wedge.gotoAndStop(1);
            _loc4_.clip["timer" + _loc1_].top.gotoAndStop(1);
            _loc4_.clip["timer" + _loc1_].bottom.gotoAndStop(1);
            _loc4_.clip["timer" + _loc1_].bar.visible = false;
            _loc4_.clip["timer" + _loc1_].alarm.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.alarmTypes.length)
         {
            _loc3_ = _loc4_.clip[_loc4_.alarmTypes[_loc1_]];
            _loc4_.alarmClips.push(_loc3_);
            _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.grabAlarm);
            _loc4_.clip.alarmholder.addChild(_loc3_);
            _loc1_++;
         }
      }
      
      public function stopSounds() : void
      {
         var _loc1_:GrillScreen = this;
         if(_loc1_.cookSound)
         {
            _loc1_.cookSound.stop();
            _loc1_.cookSound = null;
         }
         if(_loc1_.alarmSound)
         {
            _loc1_.alarmSound.stop();
            _loc1_.alarmSound = null;
         }
         if(_loc1_.boostSound)
         {
            _loc1_.boostSound.stop();
            _loc1_.boostSound = null;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:GrillScreen = this;
         _loc1_ = _loc3_.alarmClips.length - 1;
         while(_loc1_ >= 0)
         {
            _loc3_.alarmClips[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.grabAlarm);
            if(_loc3_.alarmClips[_loc1_].parent)
            {
               _loc3_.alarmClips[_loc1_].parent.removeChild(_loc3_.alarmClips[_loc1_]);
            }
            _loc3_.alarmClips[_loc1_] = null;
            _loc3_.alarmClips.splice(_loc1_,1);
            _loc1_--;
         }
         _loc1_ = _loc3_.cookingSandwiches.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.cookingSandwiches[_loc1_] != null)
            {
               _loc3_.cookingSandwiches[_loc1_].destroy();
               _loc3_.cookingSandwiches[_loc1_] = null;
            }
            _loc1_--;
         }
         _loc1_ = _loc3_.traySandwiches.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.traySandwiches[_loc1_] != null)
            {
               _loc3_.traySandwiches[_loc1_].destroy();
               _loc3_.traySandwiches[_loc1_] = null;
            }
            _loc1_--;
         }
         _loc1_ = _loc3_.leavingSandwiches.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.leavingSandwiches[_loc1_] != null)
            {
               _loc3_.leavingSandwiches[_loc1_].destroy();
               _loc3_.leavingSandwiches[_loc1_] = null;
            }
            _loc3_.leavingSandwiches.splice(_loc1_,1);
            _loc1_--;
         }
         _loc1_ = _loc3_.waitingSandwiches.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.waitingSandwiches[_loc1_] != null)
            {
               _loc3_.waitingSandwiches[_loc1_].destroy();
               _loc3_.waitingSandwiches[_loc1_] = null;
            }
            _loc3_.waitingSandwiches.splice(_loc1_,1);
            _loc1_--;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_.cookSpotsTotal)
         {
            _loc3_.clip["boost" + _loc1_ + "_btn"].removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.pressGrillBoost);
            _loc1_++;
         }
         _loc3_.stopSounds();
         _loc3_.gameObj.var_129.removeEventListener("soundIsMuted",_loc3_.onSoundIsMuted);
         _loc3_.gameObj.var_129.removeEventListener("soundIsNotMuted",_loc3_.onSoundIsNotMuted);
         if(_loc3_.gameObj.var_138.contains(_loc3_.clip))
         {
            _loc3_.gameObj.var_138.removeChild(_loc3_.clip);
         }
         _loc3_.waitingSandwiches = null;
         _loc3_.leavingSandwiches = null;
         _loc3_.cookingSandwiches = null;
         _loc3_.traySandwiches = null;
         _loc3_.alarmClips = null;
         _loc3_.clip = null;
      }
      
      public function activateScreen() : void
      {
         var _loc1_:GrillScreen = this;
         if(!_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         }
         _loc1_.gameObj.hud.hideTimerAlerts();
         _loc1_.gameObj.var_129.switchMusic("bake");
         _loc1_.isActive = true;
         _loc1_.updateSandwichSprites();
         _loc1_.checkForTraySandwiches();
      }
      
      public function deactivateScreen() : void
      {
         var _loc1_:GrillScreen = this;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.isActive = false;
      }
      
      public function updateScreen() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:GrillScreen = this;
         var _loc6_:Number = 1;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.cookingSandwiches.length)
         {
            if(_loc5_.boostingWhich == _loc1_)
            {
               _loc6_ = 2;
            }
            else if(_loc5_.gameObj.var_128.currentDay == 1)
            {
               _loc6_ = 2;
            }
            else
            {
               _loc6_ = 1;
            }
            if(_loc5_.cookingSandwiches[_loc1_] != null)
            {
               _loc5_.cookingSandwiches[_loc1_].cookSandwich(_loc6_);
               _loc5_.cookingSandwiches[_loc1_].updateSandwichOnGrill();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc5_.traySandwiches.length)
         {
            if(_loc5_.traySandwiches[_loc1_] != null)
            {
               _loc5_.traySandwiches[_loc1_].updateSandwichOnGrill();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc5_.leavingSandwiches.length)
         {
            if(_loc5_.leavingSandwiches[_loc1_] != null)
            {
               _loc5_.leavingSandwiches[_loc1_].updateSandwichOnGrill();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc5_.alarmClips.length)
         {
            _loc2_ = _loc5_.alarmClips[_loc1_];
            if(_loc5_.alarmsDragging[_loc1_] == true)
            {
               _loc2_.x = _loc5_.clip.mouseX;
               _loc2_.y = _loc5_.clip.mouseY;
            }
            else if(_loc5_.alarmsReturning[_loc1_] == true)
            {
               _loc3_ = Number(_loc5_.alarmTargetX[_loc1_]);
               _loc4_ = _loc5_.alarmTargetY;
               _loc2_.x += (_loc3_ - _loc2_.x) / 2;
               _loc2_.y += (_loc4_ - _loc2_.y) / 2;
               if(Math.abs(_loc3_ - _loc2_.x) <= 1 && Math.abs(_loc4_ - _loc2_.y) <= 1)
               {
                  _loc2_.x = _loc3_;
                  _loc2_.y = _loc4_;
                  _loc5_.alarmsReturning[_loc1_] = false;
                  if(_loc5_.clip.alarmholder.contains(_loc2_) == false)
                  {
                     _loc5_.clip.alarmholder.addChild(_loc2_);
                  }
               }
            }
            else
            {
               _loc2_.x = _loc5_.alarmTargetX[_loc1_];
               _loc4_ = _loc5_.alarmTargetY;
               if(_loc2_.y != _loc4_)
               {
                  _loc2_.y += (_loc4_ - _loc2_.y) / 2;
                  if(Math.abs(_loc4_ - _loc2_.y) <= 1)
                  {
                     _loc2_.y = _loc5_.alarmTargetY;
                  }
               }
            }
            _loc1_++;
         }
         _loc5_.updateCookingSound();
      }
      
      public function updateCookingSound() : void
      {
         var _loc1_:SoundTransform = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:GrillScreen = this;
         try
         {
            if(_loc5_.cookSound != null)
            {
               _loc1_ = new SoundTransform();
               _loc2_ = _loc5_.cookSound.soundTransform.volume;
               _loc3_ = Math.min(1,_loc5_.getTotalSandwichesCooking()) / 4;
               _loc4_ = _loc5_.cookVolume;
               if(_loc3_ > _loc4_)
               {
                  _loc4_ += 0.01;
               }
               else if(_loc3_ < _loc4_)
               {
                  _loc4_ -= 0.01;
               }
               if(!_loc5_.isActive && _loc5_.getTotalSandwichesCooking() > 0)
               {
                  _loc4_ = 0.15;
               }
               else if(!_loc5_.isActive && _loc5_.getTotalSandwichesCooking() == 0)
               {
                  _loc4_ = 0;
               }
               else
               {
                  _loc5_.cookVolume = _loc4_;
               }
               if(_loc5_.gameObj.var_129.isMute)
               {
                  _loc4_ = 0;
               }
               _loc1_.volume = _loc4_;
               _loc5_.cookSound.soundTransform = _loc1_;
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public function getTotalSandwichesCooking() : Number
      {
         var _loc1_:GrillScreen = this;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.cookingSandwiches.length)
         {
            if(_loc1_.cookingSandwiches[_loc3_] != null)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function quietSoundWhenPaused() : void
      {
         var _loc1_:SoundTransform = null;
         var _loc2_:GrillScreen = this;
         if(_loc2_.cookSound)
         {
            _loc1_ = new SoundTransform();
            _loc1_.volume = 0;
            _loc2_.cookSound.soundTransform = _loc1_;
         }
         _loc2_.updateAlarmSound();
      }
      
      public function resumeSoundAfterPaused() : void
      {
         var _loc1_:GrillScreen = this;
         _loc1_.updateAlarmSound();
      }
      
      public function initStationUpgrades() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GrillScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.cookSpotsTotal)
         {
            if(_loc3_.hasBonus("booster" + _loc1_))
            {
               _loc2_.clip["boost" + _loc1_ + "_btn"].visible = true;
            }
            else
            {
               _loc2_.clip["boost" + _loc1_ + "_btn"].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.alarmTypes.length)
         {
            if(_loc3_.hasBonus(_loc2_.alarmTypes[_loc1_]))
            {
               _loc2_.alarmClips[_loc1_].visible = true;
            }
            else
            {
               _loc2_.alarmClips[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public function soundAlarm(param1:Number, param2:String = "done") : void
      {
         var _loc3_:String = null;
         var _loc4_:GrillScreen = this;
         if(param1 > -1 && param1 < _loc4_.timerAlarmTypes.length)
         {
            _loc3_ = _loc4_.timerAlarmTypes[param1];
            if(_loc3_ != "none" && _loc3_ != null && _loc4_.gameObj.var_128.hasBonus(_loc3_) && _loc4_.timerAlarmsRunning[param1] == false)
            {
               _loc4_.clip["timer" + param1].alarm.bells.gotoAndPlay(2);
               _loc4_.gameObj.hud.showTimerAlert();
               ++_loc4_.alarmsRunning;
               _loc4_.updateAlarmSound();
            }
         }
      }
      
      public function stopAlarm(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:String = null;
         var _loc4_:GrillScreen = this;
         if(param1 > -1 && param1 < _loc4_.timerAlarmTypes.length)
         {
            _loc3_ = _loc4_.timerAlarmTypes[param1];
            try
            {
               if(_loc3_ != "none" && _loc3_ != null && _loc4_.timerAlarmsRunning[param1] == true && _loc4_.gameObj.var_128.hasBonus(_loc3_))
               {
                  _loc4_.clip["timer" + param1].alarm.bells.gotoAndStop(1);
                  --_loc4_.alarmsRunning;
                  _loc4_.updateAlarmSound();
               }
            }
            catch(err:Error)
            {
            }
            if(param2)
            {
               if(_loc4_.timerAlarmsRunning[param1] == true)
               {
                  _loc4_.timerAlarmsRunning[param1] = false;
                  _loc4_.timerAlarmsMode[param1] = "none";
               }
            }
         }
      }
      
      public function updateAlarmSound() : void
      {
         var _loc1_:GrillScreen = this;
         if(_loc1_.alarmSound != null)
         {
            _loc1_.alarmSound.stop();
            _loc1_.alarmSound = null;
         }
         var _loc2_:Number = _loc1_.alarmBaseVolume + (_loc1_.alarmsRunning - 1) * _loc1_.alarmExtraVolume;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         if(_loc1_.gameObj.var_169)
         {
            _loc2_ = 0;
         }
         else if(_loc1_.gameObj.var_129.isMute)
         {
            _loc2_ = 0;
         }
         if(_loc1_.alarmsRunning > 0)
         {
            _loc1_.alarmSound = _loc1_.gameObj.var_129.playSound("timeralarm.wav",true,_loc2_);
         }
      }
      
      public function onSoundIsMuted(param1:Event) : void
      {
         var _loc2_:GrillScreen = this;
         _loc2_.updateAlarmSound();
      }
      
      public function onSoundIsNotMuted(param1:Event) : void
      {
         var _loc2_:GrillScreen = this;
         _loc2_.updateAlarmSound();
      }
      
      public function pressGrillBoost(param1:MouseEvent) : void
      {
         var _loc2_:GrillScreen = this;
         if(!_loc2_.gameObj.training)
         {
            _loc2_.isBoosting = true;
            if(param1.currentTarget.name == "boost0_btn")
            {
               _loc2_.boostingWhich = 0;
            }
            else if(param1.currentTarget.name == "boost1_btn")
            {
               _loc2_.boostingWhich = 1;
            }
            else if(param1.currentTarget.name == "boost2_btn")
            {
               _loc2_.boostingWhich = 2;
            }
            else if(param1.currentTarget.name == "boost3_btn")
            {
               _loc2_.boostingWhich = 3;
            }
            _loc2_.gameObj.var_129.playSound("press_machine_button.wav");
            if(_loc2_.boostSound)
            {
               _loc2_.boostSound.stop();
               _loc2_.boostSound = null;
            }
            _loc2_.boostSound = _loc2_.gameObj.var_129.playSound("boosting.wav",true);
            if(_loc2_.gameObj.hud.whichContextTraining == "boost")
            {
               _loc2_.gameObj.var_128.setTrained("boost");
               _loc2_.gameObj.hud.removeContextTraining();
            }
            _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseGrillBoost);
         }
      }
      
      public function releaseGrillBoost(param1:MouseEvent) : void
      {
         var _loc2_:GrillScreen = this;
         _loc2_.isBoosting = false;
         _loc2_.boostingWhich = -1;
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseGrillBoost);
         _loc2_.gameObj.var_129.playSound("release_button.wav");
         if(_loc2_.boostSound)
         {
            _loc2_.boostSound.stop();
            _loc2_.boostSound = null;
         }
      }
      
      public function cheatChangeMonth(param1:Number) : void
      {
      }
      
      public function updateMeter(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false) : void
      {
         var _loc8_:MovieClip = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:String = null;
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:Number = Number(NaN);
         var _loc21_:GrillScreen = this;
         if(param1 > -1 && param1 < _loc21_.cookSpotsTotal)
         {
            _loc8_ = _loc21_.clip["timer" + param1];
            _loc11_ = Number(FoodData.getMaxCookTime());
            _loc12_ = Math.min(1,param2 / _loc11_);
            _loc8_.hand.rotation = _loc12_ * 360;
            if(param2 <= 0)
            {
               _loc8_.wedge.rotation = 0;
               _loc8_.wedge.gotoAndStop(1);
               _loc8_.progress.gotoAndStop(1);
            }
            else
            {
               if(_loc12_ >= 1)
               {
                  _loc10_ = 359.5;
                  _loc8_.wedge.gotoAndStop(5);
                  _loc8_.progress.gotoAndStop(5);
               }
               else if(_loc12_ >= 0.625)
               {
                  _loc10_ = 270;
                  _loc8_.wedge.gotoAndStop(4);
                  _loc8_.progress.gotoAndStop(4);
               }
               else if(_loc12_ >= 0.375)
               {
                  _loc10_ = 180;
                  _loc8_.wedge.gotoAndStop(3);
                  _loc8_.progress.gotoAndStop(3);
               }
               else if(_loc12_ >= 0.125)
               {
                  _loc10_ = 90;
                  _loc8_.wedge.gotoAndStop(2);
                  _loc8_.progress.gotoAndStop(2);
               }
               else
               {
                  _loc10_ = 0;
                  _loc8_.wedge.gotoAndStop(1);
                  _loc8_.progress.gotoAndStop(1);
               }
               _loc9_ = Number(_loc8_.wedge.rotation);
               while(_loc9_ < 0)
               {
                  _loc9_ += 360;
               }
               _loc13_ = _loc10_ - _loc9_;
               _loc8_.wedge.rotation += _loc13_ / 2;
               if(Math.abs(_loc13_) <= 1)
               {
                  _loc8_.wedge.rotation = _loc10_;
               }
            }
            _loc14_ = Math.min(7,Math.floor(param5 / (0.0625 * _loc11_)));
            _loc15_ = Math.min(7,Math.floor(param6 / (0.0625 * _loc11_)));
            _loc8_.top.gotoAndStop(_loc14_ + 1);
            _loc8_.bottom.gotoAndStop(_loc15_ + 1);
            if(_loc14_ != _loc15_)
            {
               _loc8_.bar.visible = true;
            }
            else
            {
               _loc8_.bar.visible = false;
            }
            if(param7 == true)
            {
               _loc21_.unsetAlarm(param1);
               return;
            }
            _loc16_ = _loc21_.timerAlarmTypes[param1];
            if(_loc16_ != "none" && _loc16_ != null)
            {
               _loc17_ = Number(FoodData.getTargetCookTime(_loc16_));
               _loc18_ = Number(FoodData.getSafeRemoveBuffer());
               _loc19_ = 999;
               if(_loc16_ == "lightalarm")
               {
                  _loc19_ = 1;
               }
               else if(_loc16_ == "mediumalarm")
               {
                  _loc19_ = 3;
               }
               else if(_loc16_ == "wellalarm")
               {
                  _loc19_ = 5;
               }
               if(param2 >= _loc17_ && _loc14_ >= _loc19_ && _loc15_ >= _loc19_)
               {
                  if(_loc21_.timerAlarmsRunning[param1] == false)
                  {
                     class_7.method_1("Sound Alarm " + param1 + ": DONE!");
                     _loc21_.soundAlarm(param1,"done");
                     _loc21_.timerAlarmsRunning[param1] = true;
                     _loc21_.timerAlarmsMode[param1] = "done";
                  }
               }
               else if(_loc15_ >= _loc19_ || _loc14_ >= _loc19_ && _loc15_ > _loc14_)
               {
                  if(_loc21_.timerAlarmsRunning[param1] == false)
                  {
                     class_7.method_1("Sound Alarm " + param1 + ": FLIP!");
                     _loc21_.soundAlarm(param1,"flip");
                     _loc21_.timerAlarmsRunning[param1] = true;
                     _loc21_.timerAlarmsMode[param1] = "flip";
                  }
               }
            }
            if(_loc21_.gameObj.training)
            {
               _loc20_ = Number(FoodData.getTargetCookTime(FoodData.COOK_MEDIUM));
               if(param6 >= _loc20_ / 2)
               {
                  _loc21_.gameObj.method_104(13);
               }
               if(param6 + param5 >= _loc20_)
               {
                  _loc21_.gameObj.method_104(15);
               }
            }
         }
      }
      
      public function addToWaitingSandwiches(param1:Sandwich) : void
      {
         var _loc2_:GrillScreen = this;
         _loc2_.waitingSandwiches.push(param1);
      }
      
      public function removeFromWaitingSandwiches(param1:Sandwich, param2:Boolean = false) : void
      {
         var _loc3_:GrillScreen = this;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.waitingSandwiches.length)
         {
            if(_loc3_.waitingSandwiches[_loc4_] == param1)
            {
               if(param2)
               {
                  _loc3_.waitingSandwiches[_loc4_].destroy();
               }
               _loc3_.waitingSandwiches[_loc4_] = null;
               _loc3_.waitingSandwiches.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function addToLeavingSandwiches(param1:Sandwich) : void
      {
         var _loc2_:GrillScreen = this;
         _loc2_.leavingSandwiches.push(param1);
      }
      
      public function removeFromLeavingSandwiches(param1:Sandwich, param2:Boolean = false) : void
      {
         var _loc3_:GrillScreen = this;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.leavingSandwiches.length)
         {
            if(_loc3_.leavingSandwiches[_loc4_] == param1)
            {
               if(param2)
               {
                  _loc3_.leavingSandwiches[_loc4_].destroy();
               }
               _loc3_.leavingSandwiches[_loc4_] = null;
               _loc3_.leavingSandwiches.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function updateSandwichSprites() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GrillScreen = this;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.waitingSandwiches.length)
         {
            if(_loc2_.waitingSandwiches[_loc1_] != null)
            {
               _loc2_.waitingSandwiches[_loc1_].createSprites();
            }
            _loc1_++;
         }
      }
      
      public function checkForTraySandwiches() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GrillScreen = this;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.traySandwiches.length)
         {
            if(_loc2_.traySandwiches[_loc1_] == null)
            {
               if(_loc2_.waitingSandwiches.length > 0)
               {
                  _loc2_.addToTray(_loc2_.waitingSandwiches[0],_loc1_);
                  _loc2_.waitingSandwiches[0].addToGrillTray(_loc2_.waitingStartX + _loc2_.waitingSpacingX * _loc1_,_loc2_.waitingStartY,_loc2_.clip.holder);
                  _loc2_.removeFromWaitingSandwiches(_loc2_.waitingSandwiches[0]);
               }
            }
            _loc1_++;
         }
      }
      
      public function addToTray(param1:Sandwich, param2:Number) : void
      {
         var _loc3_:GrillScreen = this;
         if(_loc3_.traySandwiches != null && _loc3_.traySandwiches.length > param2 && param2 > -1 && _loc3_.traySandwiches[param2] == null)
         {
            _loc3_.traySandwiches[param2] = param1;
         }
      }
      
      public function removeFromTray(param1:Sandwich) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GrillScreen = this;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.traySandwiches.length)
         {
            if(_loc3_.traySandwiches[_loc2_] == param1)
            {
               _loc3_.traySandwiches[_loc2_] = null;
               break;
            }
            _loc2_++;
         }
         _loc3_.checkForTraySandwiches();
      }
      
      public function isGrillSpotFree(param1:Number) : Boolean
      {
         var _loc2_:GrillScreen = this;
         var _loc3_:Boolean = false;
         if(_loc2_.cookingSandwiches != null && _loc2_.cookingSandwiches.length > param1 && param1 > -1)
         {
            if(_loc2_.cookingSandwiches[param1] == null)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function getNearestGrillSpot(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:GrillScreen = this;
         var _loc6_:Number = -1;
         var _loc7_:Number = 9999999;
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.cookingSandwiches.length)
         {
            _loc3_ = _loc5_.grillStartX + _loc8_ * _loc5_.grillSpacingX;
            _loc4_ = Math.abs(_loc3_ - param1);
            if(_loc4_ < _loc7_)
            {
               _loc6_ = _loc8_;
               _loc7_ = _loc4_;
            }
            _loc8_++;
         }
         return _loc6_;
      }
      
      public function removeFromCooking(param1:Sandwich) : void
      {
         var _loc2_:GrillScreen = this;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.cookingSandwiches.length)
         {
            if(_loc2_.cookingSandwiches[_loc3_] == param1)
            {
               _loc2_.cookingSandwiches[_loc3_] = null;
               break;
            }
            _loc3_++;
         }
      }
      
      public function addToCooking(param1:Sandwich, param2:Number) : void
      {
         var _loc3_:GrillScreen = this;
         if(_loc3_.cookingSandwiches != null && _loc3_.cookingSandwiches.length > param2 && param2 > -1 && _loc3_.cookingSandwiches[param2] == null)
         {
            _loc3_.cookingSandwiches[param2] = param1;
         }
         if(!_loc3_.gameObj.var_128.hasTrained("boost") && _loc3_.gameObj.var_128.hasBonus("booster" + param2))
         {
            _loc3_.gameObj.hud.showContextTraining("boost");
         }
      }
      
      public function addGrease(param1:Number, param2:Number) : void
      {
         var _loc3_:GrillScreen = this;
         _loc3_.clip["grease_" + param1].gotoAndStop(2);
         _loc3_.changeGreaseColor(param1,param2);
      }
      
      public function changeGreaseColor(param1:Number, param2:Number) : void
      {
         var _loc3_:ColorTransform = null;
         var _loc4_:GrillScreen = this;
         var _loc5_:MovieClip = _loc4_.clip["grease_" + param1];
         if(param2 == 0 || param2 == 1)
         {
            _loc3_ = new ColorTransform(1,0.94,0.75);
         }
         else if(param2 == 2 || param2 == 3)
         {
            _loc3_ = new ColorTransform(0.93,0.85,0.69);
         }
         else if(param2 == 4 || param2 == 5)
         {
            _loc3_ = new ColorTransform(0.9,0.8,0.63);
         }
         else if(param2 == 6 || param2 == 7)
         {
            _loc3_ = new ColorTransform(0.85,0.76,0.59);
         }
         else if(param2 == 8 || param2 == 9)
         {
            _loc3_ = new ColorTransform(0.85,0.71,0.53);
         }
         else if(param2 == 10 || param2 == 11)
         {
            _loc3_ = new ColorTransform(0.79,0.68,0.58);
         }
         else if(param2 == 12)
         {
            _loc3_ = new ColorTransform(0.65,0.55,0.5);
         }
         else
         {
            _loc3_ = new ColorTransform(0.46,0.37,0.3);
         }
         _loc5_.transform.colorTransform = _loc3_;
      }
      
      public function removeGrease(param1:Number) : void
      {
         var _loc2_:GrillScreen = this;
         if(_loc2_.clip["grease_" + param1].currentFrame == 2)
         {
            _loc2_.clip["grease_" + param1].gotoAndStop(3);
         }
      }
      
      public function showFlipShadow(param1:Number) : void
      {
         var _loc2_:GrillScreen = this;
         _loc2_.clip["shadow_" + param1].gotoAndPlay(2);
      }
      
      public function grabAlarm(param1:MouseEvent) : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:GrillScreen = this;
         var _loc3_:MovieClip = MovieClip(param1.currentTarget);
         var _loc4_:String = _loc3_.name;
         _loc5_ = _loc2_.alarmClips.indexOf(_loc3_);
         if(_loc5_ > -1)
         {
            if(_loc2_.clip.dragholder.contains(_loc3_) == false)
            {
               _loc2_.clip.dragholder.addChild(_loc3_);
            }
            _loc2_.alarmsDragging[_loc5_] = true;
            _loc2_.alarmsReturning[_loc5_] = false;
            _loc2_.gameObj.var_129.playSound("buttonclick.wav");
            _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseAlarm);
         }
      }
      
      public function releaseAlarm(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:MovieClip = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:GrillScreen = this;
         var _loc12_:Boolean = false;
         _loc11_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc11_.releaseAlarm);
         var _loc13_:Number = -1;
         _loc2_ = 0;
         while(_loc2_ < _loc11_.alarmsDragging.length)
         {
            if(_loc11_.alarmsDragging[_loc2_] == true)
            {
               _loc13_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         if(_loc13_ > -1)
         {
            _loc3_ = _loc11_.alarmClips[_loc13_];
            _loc4_ = _loc11_.alarmTypes[_loc13_];
            _loc5_ = null;
            _loc6_ = -1;
            _loc7_ = 999999;
            _loc2_ = 0;
            while(_loc2_ < _loc11_.cookSpotsTotal)
            {
               _loc8_ = _loc11_.clip["timer" + _loc2_];
               _loc9_ = Math.abs(_loc8_.x - _loc3_.x);
               if(_loc9_ < _loc7_)
               {
                  _loc7_ = _loc9_;
                  _loc5_ = _loc8_;
                  _loc6_ = _loc2_;
               }
               _loc2_++;
            }
            if(_loc5_ != null)
            {
               _loc10_ = Math.abs(_loc5_.y - _loc3_.y);
               if(_loc10_ < 60)
               {
                  _loc11_.setAlarm(_loc6_,_loc4_);
                  _loc11_.gameObj.var_129.playSound("release_button.wav");
                  _loc12_ = true;
               }
            }
            _loc11_.alarmsDragging[_loc13_] = false;
            if(_loc12_ == false)
            {
               _loc11_.gameObj.var_129.playSound("buttonclick.wav");
               _loc11_.alarmsReturning[_loc13_] = true;
            }
            else
            {
               _loc3_.y = _loc11_.alarmStartY;
               if(_loc11_.clip.alarmholder.contains(_loc3_) == false)
               {
                  _loc11_.clip.alarmholder.addChild(_loc3_);
               }
            }
         }
      }
      
      public function setAlarm(param1:Number, param2:String) : void
      {
         var _loc3_:GrillScreen = this;
         if(param1 > -1 && param1 < _loc3_.timerAlarmTypes.length)
         {
            _loc3_.stopAlarm(param1);
            _loc3_.timerAlarmTypes[param1] = param2;
            _loc3_.clip["timer" + param1].alarm.visible = true;
            if(param2 == _loc3_.ALARM_LIGHT)
            {
               _loc3_.clip["timer" + param1].alarm.bg.gotoAndStop(1);
            }
            else if(param2 == _loc3_.ALARM_MEDIUM)
            {
               _loc3_.clip["timer" + param1].alarm.bg.gotoAndStop(2);
            }
            else if(param2 == _loc3_.ALARM_WELL)
            {
               _loc3_.clip["timer" + param1].alarm.bg.gotoAndStop(3);
            }
            if(_loc3_.gameObj.hud.whichContextTraining == "alarm")
            {
               _loc3_.gameObj.hud.removeContextTraining();
            }
         }
      }
      
      public function unsetAlarm(param1:Number) : void
      {
         var _loc2_:GrillScreen = this;
         if(param1 > -1 && param1 < _loc2_.timerAlarmTypes.length)
         {
            _loc2_.stopAlarm(param1);
            _loc2_.timerAlarmTypes[param1] = "none";
            _loc2_.clip["timer" + param1].alarm.visible = false;
            _loc2_.clip["timer" + param1].alarm.bells.stop();
            _loc2_.clip["timer" + param1].alarm.bg.stop();
         }
      }
      
      public function getAlarmType(param1:Number) : String
      {
         var _loc2_:GrillScreen = this;
         if(param1 > -1 && param1 < _loc2_.timerAlarmTypes.length)
         {
            return _loc2_.timerAlarmTypes[param1];
         }
         return "none";
      }
   }
}


package cheeseGame.models
{
   import cheeseGame.screens.MiniGameKart;
   import flash.display.MovieClip;
   import flash.geom.*;
   import flash.media.*;
   import flash.utils.*;
   import package_4.class_5;
   
   public class GoKart
   {
      
      public var minigame:MiniGameKart;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var x:Number;
      
      public var y:Number;
      
      public var nextX:Number;
      
      public var nextY:Number;
      
      public var lastX:Number;
      
      public var lastY:Number;
      
      public var nextSpeed:Number;
      
      public var targetY:Number = 0;
      
      public var accel:Number;
      
      public var speed:Number;
      
      public var startingSpeed:Number;
      
      public var maxSpeed:Number;
      
      public var laneSpeedFactor:Number = 0.6;
      
      public var aiLaneSpeedFactor:Number = 0.3;
      
      public var customerName:String;
      
      public var isPlayer:Boolean = false;
      
      public var customerClip:MovieClip = null;
      
      public var worker:Worker = null;
      
      public var isBoosting:Boolean = false;
      
      public var boostHitID:Number = -1;
      
      public var boostDuration:Number = 40;
      
      public var boostTimer:Number = 0;
      
      public var boostAccel:Number = 1;
      
      public var boostDecay:Number = 0.5;
      
      public var boostAmount:Number = 1.7;
      
      public var isCrashed:Boolean = false;
      
      public var kartHeight:Number = 15;
      
      public var kartWidth:Number = 55;
      
      public var didCollide:Boolean = false;
      
      public var isSkidding:Boolean = false;
      
      public var skidHitID:Number = -1;
      
      public var skidTimer:Number = 0;
      
      public var skidTimerMax:Number = 30;
      
      public var skidAnimFrames:Array;
      
      public var skidAnimFrameIndex:Number = 0;
      
      public var skidTargetYOffset:Number = 0;
      
      public var crossedFinish:Boolean = false;
      
      public var crossTime:Number = 2147483647;
      
      public var smartFactor:Number = 1;
      
      public var smartCollectFactor:Number = 1;
      
      public var aiRangeY:Number = 40;
      
      public var aiRangeX:Number = 250;
      
      public var playerControlled:Boolean = true;
      
      public var aheadOfPlayer:Boolean = false;
      
      public var drivingSound:SoundChannel = null;
      
      public var soundTransform:SoundTransform = null;
      
      public var startFadeUp:Number = 0;
      
      public function GoKart(param1:MiniGameKart, param2:MovieClip, param3:Number, param4:Number, param5:String, param6:Number, param7:Number, param8:Number, param9:Boolean = false, param10:Number = 1, param11:Number = 1)
      {
         this.skidAnimFrames = [1,2,3,4,5,5,5,5,5,4,3,2,1,10,11,12,13,13,13,13,13,12,11,10];
         super();
         this.minigame = param1;
         this.container = param2;
         this.x = param3;
         this.y = param4;
         this.nextX = param3;
         this.nextY = param4;
         this.lastX = param3;
         this.lastY = param4;
         this.targetY = param4;
         this.startingSpeed = param6;
         this.speed = param6;
         this.nextSpeed = param6;
         this.accel = param7;
         this.maxSpeed = param8;
         this.customerName = param5;
         this.isPlayer = param9;
         this.smartFactor = param10;
         this.smartCollectFactor = param11;
         this.setupKart();
      }
      
      public function setupKart() : void
      {
         var _loc1_:GoKart = this;
         if(_loc1_.customerName == "Hank" || _loc1_.customerName == "Marty" || _loc1_.customerName == "Rico" || _loc1_.customerName == "Foodini" || _loc1_.customerName == "Ember" || _loc1_.customerName == "Johnny" || _loc1_.customerName == "Nick")
         {
            _loc1_.clip = new kartBoxyMC();
         }
         else
         {
            _loc1_.clip = new kartMC();
         }
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.clip.x = _loc1_.minigame.kartStartX;
         _loc1_.clip.y = _loc1_.y;
         if(!_loc1_.isPlayer || !_loc1_.playerControlled)
         {
            _loc1_.laneSpeedFactor = _loc1_.aiLaneSpeedFactor;
         }
         _loc1_.clip.gotoAndStop(1);
         _loc1_.setupColor();
         _loc1_.setupDriver();
         _loc1_.updateKartGraphic();
      }
      
      public function setupColor() : void
      {
         var _loc1_:GoKart = this;
         var _loc2_:Number = _loc1_.minigame.karts.length;
         var _loc3_:Number = _loc2_ + 2;
         if(_loc1_.isPlayer)
         {
            _loc3_ = 1;
         }
         if(_loc1_.customerName == "Boomer")
         {
            _loc3_ = 2;
         }
         else if(_loc1_.customerName == "Akari")
         {
            _loc3_ = 3;
         }
         else if(_loc1_.customerName == "Wally")
         {
            _loc3_ = 4;
         }
         else if(_loc1_.customerName == "Hank")
         {
            _loc3_ = 5;
         }
         else if(_loc1_.customerName == "Marty")
         {
            _loc3_ = 6;
         }
         else if(_loc1_.customerName == "Radlynn")
         {
            _loc3_ = 7;
         }
         else if(_loc1_.customerName == "Rico")
         {
            _loc3_ = 8;
         }
         else if(_loc1_.customerName == "SargeFan" || _loc1_.customerName == "Sarge Fan")
         {
            _loc3_ = 9;
         }
         else if(_loc1_.customerName == "Willow")
         {
            _loc3_ = 10;
         }
         else if(_loc1_.customerName == "ProfessorFitz" || _loc1_.customerName == "Professor Fitz")
         {
            _loc3_ = 11;
         }
         else if(_loc1_.customerName == "Foodini")
         {
            _loc3_ = 12;
         }
         else if(_loc1_.customerName == "Xandra")
         {
            _loc3_ = 13;
         }
         else if(_loc1_.customerName == "Ember")
         {
            _loc3_ = 14;
         }
         else if(_loc1_.customerName == "Johnny")
         {
            _loc3_ = 15;
         }
         else if(_loc1_.customerName == "Sasha")
         {
            _loc3_ = 16;
         }
         else if(_loc1_.customerName == "Nick")
         {
            _loc3_ = 17;
         }
         _loc1_.clip.farside.gotoAndStop(_loc3_);
         _loc1_.clip.seat.gotoAndStop(_loc3_);
         _loc1_.clip.trunk.gotoAndStop(_loc3_);
         _loc1_.clip.side.gotoAndStop(_loc3_);
         _loc1_.clip.hood.gotoAndStop(_loc3_);
         _loc1_.clip.dash.gotoAndStop(_loc3_);
         try
         {
            _loc1_.clip.spoiler1.gotoAndStop(_loc3_);
            _loc1_.clip.spoiler2.gotoAndStop(_loc3_);
            _loc1_.clip.spoiler3.gotoAndStop(_loc3_);
         }
         catch(err:Error)
         {
         }
      }
      
      public function setupDriver(param1:Boolean = true) : void
      {
         var _loc2_:GoKart = this;
         if(param1)
         {
            if(_loc2_.isPlayer)
            {
               _loc2_.worker = new Worker(_loc2_.minigame.screen.gameObj,_loc2_.clip.customerholder,_loc2_.minigame.screen.gameObj.workerData,0,0,1,false,false);
               _loc2_.worker.playAnimation("drive");
            }
            else
            {
               _loc2_.buildCustomerModel(_loc2_.customerName);
               _loc2_.clip.customerholder.addChild(_loc2_.customerClip);
               _loc2_.customerClip.gotoAndPlay("drive");
            }
         }
         else
         {
            if(_loc2_.customerClip != null)
            {
               _loc2_.destroyCustomerModel(_loc2_.customerClip);
               if(_loc2_.customerClip != null && Boolean(_loc2_.customerClip.parent))
               {
                  _loc2_.customerClip.parent.removeChild(_loc2_.customerClip);
               }
               _loc2_.customerClip = null;
            }
            if(_loc2_.worker != null)
            {
               _loc2_.worker.destroy();
               _loc2_.worker = null;
            }
         }
      }
      
      public function startDrivingSound(param1:Boolean = false) : void
      {
         var _loc2_:GoKart = this;
         var _loc3_:String = "minigame_kart_drive.wav";
         if(param1)
         {
            _loc3_ = "minigame_kart_drive2.wav";
         }
         if(_loc2_.isPlayer)
         {
            _loc3_ = "minigame_kart_maindrive.wav";
         }
         _loc2_.startFadeUp = 0;
         _loc2_.soundTransform = new SoundTransform(0,-0.4);
         _loc2_.drivingSound = _loc2_.minigame.screen.gameObj.var_129.playSound(_loc3_,true,0,-0.4);
         _loc2_.drivingSound.soundTransform = _loc2_.soundTransform;
      }
      
      public function updateDrivingSound() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:GoKart = this;
         if(_loc9_.drivingSound != null)
         {
            _loc1_ = 320 - _loc9_.clip.x;
            _loc2_ = Math.abs(_loc1_);
            _loc3_ = 0.4;
            _loc4_ = 1;
            if(_loc9_.startFadeUp < 1)
            {
               _loc9_.startFadeUp += 0.05;
            }
            _loc3_ *= _loc9_.startFadeUp;
            if(_loc2_ > 640)
            {
               _loc4_ = 0;
            }
            else if(_loc2_ <= 640)
            {
               _loc8_ = _loc2_ / 640;
               _loc4_ = 1 - _loc8_;
            }
            else
            {
               _loc4_ = 1;
            }
            _loc5_ = _loc4_;
            _loc4_ *= _loc3_;
            _loc6_ = 0;
            _loc7_ = _loc2_ / 320;
            if(_loc1_ > 0)
            {
               _loc6_ = 0 - _loc7_;
            }
            else
            {
               _loc6_ = _loc7_;
            }
            if(_loc6_ < -1)
            {
               _loc6_ = -1;
            }
            else if(_loc6_ > 1)
            {
               _loc6_ = 1;
            }
            if(_loc9_.minigame.screen.gameObj.var_129.isMute)
            {
               _loc4_ = 0;
            }
            _loc9_.soundTransform.volume = _loc4_;
            _loc9_.soundTransform.pan = _loc6_;
            _loc9_.drivingSound.soundTransform = _loc9_.soundTransform;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:GoKart = this;
         _loc1_.setupDriver(false);
         if(_loc1_.drivingSound)
         {
            _loc1_.drivingSound.stop();
            _loc1_.drivingSound = null;
         }
         _loc1_.soundTransform = null;
         if(_loc1_.clip)
         {
            if(_loc1_.clip.parent)
            {
               _loc1_.clip.parent.removeChild(_loc1_.clip);
            }
            _loc1_.clip = null;
         }
         _loc1_.container = null;
      }
      
      public function setNextCoordinates() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:GoKart = this;
         _loc2_.lastX = _loc2_.x;
         _loc2_.lastY = _loc2_.y;
         if(!_loc2_.isCrashed)
         {
            if(_loc2_.isBoosting)
            {
               if(_loc2_.speed < _loc2_.maxSpeed * _loc2_.boostAmount)
               {
                  _loc2_.nextSpeed += _loc2_.boostAccel;
                  if(_loc2_.nextSpeed > _loc2_.maxSpeed * _loc2_.boostAmount)
                  {
                     _loc2_.nextSpeed = _loc2_.maxSpeed * _loc2_.boostAmount;
                  }
               }
               ++_loc2_.boostTimer;
               if(_loc2_.boostTimer >= _loc2_.boostDuration)
               {
                  _loc2_.isBoosting = false;
               }
            }
            else if(_loc2_.isSkidding)
            {
               _loc1_ = 1;
               if(_loc2_.skidTargetYOffset > 1 || _loc2_.skidTargetYOffset < -1)
               {
                  _loc1_ = 1 - Math.abs(_loc2_.skidTargetYOffset / 10);
                  if(_loc1_ < 0)
                  {
                     _loc1_ = 0;
                  }
                  else if(_loc1_ > 1)
                  {
                     _loc1_ = 1;
                  }
                  _loc1_ = _loc1_ / 2 + 0.5;
               }
               if(_loc2_.speed > _loc2_.startingSpeed)
               {
                  _loc2_.nextSpeed -= _loc2_.accel * _loc1_;
                  if(_loc2_.speed < _loc2_.startingSpeed)
                  {
                     _loc2_.speed = _loc2_.startingSpeed;
                  }
               }
            }
            else if(_loc2_.speed < _loc2_.maxSpeed)
            {
               _loc2_.nextSpeed += _loc2_.accel;
               if(_loc2_.nextSpeed > _loc2_.maxSpeed)
               {
                  _loc2_.nextSpeed = _loc2_.maxSpeed;
               }
            }
            else if(_loc2_.speed > _loc2_.maxSpeed)
            {
               _loc2_.nextSpeed -= _loc2_.boostDecay;
               if(_loc2_.nextSpeed < _loc2_.maxSpeed)
               {
                  _loc2_.nextSpeed = _loc2_.maxSpeed;
               }
            }
            if(_loc2_.isSkidding)
            {
               ++_loc2_.skidTimer;
               if(_loc2_.skidTimer >= _loc2_.skidTimerMax)
               {
                  _loc2_.isSkidding = false;
               }
            }
         }
         if(_loc2_.isPlayer && _loc2_.playerControlled)
         {
            if(_loc2_.isSkidding)
            {
               _loc2_.targetY = _loc2_.y + _loc2_.skidTargetYOffset;
               _loc2_.skidTargetYOffset *= 0.97;
            }
            else if(_loc2_.minigame.isFinishing || _loc2_.isCrashed)
            {
               _loc2_.targetY = _loc2_.y;
            }
            else
            {
               _loc2_.targetY = _loc2_.minigame.clip.mouseY;
            }
         }
         else if(_loc2_.isSkidding)
         {
            _loc2_.targetY = _loc2_.y + _loc2_.skidTargetYOffset;
            _loc2_.skidTargetYOffset *= 0.97;
         }
         else
         {
            _loc2_.kartAI();
         }
         _loc2_.nextX = _loc2_.x + _loc2_.nextSpeed;
         if(_loc2_.targetY < _loc2_.minigame.kartMinY)
         {
            _loc2_.targetY = _loc2_.minigame.kartMinY;
         }
         else if(_loc2_.targetY > _loc2_.minigame.kartMaxY)
         {
            _loc2_.targetY = _loc2_.minigame.kartMaxY;
         }
         var _loc3_:Number = _loc2_.targetY - _loc2_.y;
         var _loc4_:Number = _loc3_ / 4;
         if(Math.abs(_loc4_) < 0.1)
         {
            _loc4_ = 0;
         }
         var _loc5_:Number = this.nextSpeed * _loc2_.laneSpeedFactor;
         if(_loc4_ > _loc5_)
         {
            _loc4_ = _loc5_;
         }
         else if(_loc4_ < _loc5_ * -1)
         {
            _loc4_ = _loc5_ * -1;
         }
         _loc2_.nextY = _loc2_.y + _loc4_;
      }
      
      public function playObjectSound(param1:String) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:GoKart = this;
         var _loc4_:Number = 320 - _loc3_.clip.x;
         var _loc5_:Number = Math.abs(_loc4_);
         var _loc6_:Number = 0.5;
         var _loc7_:Number = 1;
         if(_loc3_.isPlayer)
         {
            _loc6_ = 0.7;
         }
         else if(param1 == "grabtopping.wav" || param1 == "singlecoin.wav")
         {
            _loc6_ = 1;
         }
         if(_loc5_ > 640)
         {
            _loc7_ = 0;
         }
         else if(_loc5_ <= 640)
         {
            _loc2_ = _loc5_ / 640;
            _loc7_ = 1 - _loc2_;
         }
         else
         {
            _loc7_ = 1;
         }
         var _loc8_:Number = _loc7_;
         _loc7_ *= _loc6_;
         var _loc9_:Number = 0;
         var _loc10_:Number = _loc5_ / 320;
         if(_loc4_ > 0)
         {
            _loc9_ = 0 - _loc10_;
         }
         else
         {
            _loc9_ = _loc10_;
         }
         if(_loc9_ < -1)
         {
            _loc9_ = -1;
         }
         else if(_loc9_ > 1)
         {
            _loc9_ = 1;
         }
         _loc3_.minigame.screen.gameObj.var_129.playSound(param1,false,_loc7_,_loc9_);
      }
      
      public function checkForHittingObjects() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:GoKart = this;
         var _loc5_:* = int(_loc4_.minigame.objects.length - 1);
         while(_loc5_ >= 0)
         {
            _loc1_ = _loc4_.minigame.objects[_loc5_].x - _loc4_.nextX;
            _loc2_ = _loc4_.minigame.objects[_loc5_].y - _loc4_.nextY;
            if(_loc4_.minigame.objects[_loc5_].type == KartObject.TYPE_CONE && _loc4_.minigame.objects[_loc5_].isTumbling == false && Math.abs(_loc1_) < _loc4_.kartWidth + _loc4_.minigame.objects[_loc5_].objectWidth && Math.abs(_loc2_) < _loc4_.kartHeight + _loc4_.minigame.objects[_loc5_].objectHeight)
            {
               _loc4_.minigame.objects[_loc5_].hitObject(_loc4_.lastX,_loc4_.lastY,_loc4_.nextX,_loc4_.nextY);
               _loc4_.nextSpeed *= 0.8;
               _loc4_.animateDriver("hit");
               if(_loc4_.minigame.currFrame - _loc4_.minigame.objects[_loc5_].lastSoundPlayed > 30)
               {
                  if(Math.random() < 0.5)
                  {
                     _loc4_.playObjectSound("minigame_kart_cone1.wav");
                  }
                  else
                  {
                     _loc4_.playObjectSound("minigame_kart_cone2.wav");
                  }
                  _loc4_.minigame.objects[_loc5_].lastSoundPlayed = _loc4_.minigame.currFrame;
               }
            }
            else if(_loc4_.minigame.objects[_loc5_].type == KartObject.TYPE_OILSLICK && Math.abs(_loc1_) < _loc4_.kartWidth + _loc4_.minigame.objects[_loc5_].objectWidth && Math.abs(_loc2_) < _loc4_.kartHeight + _loc4_.minigame.objects[_loc5_].objectHeight)
            {
               if(!_loc4_.isSkidding || _loc4_.skidHitID != _loc4_.minigame.objects[_loc5_].id)
               {
                  _loc4_.isSkidding = true;
                  _loc4_.skidTimer = 0;
                  _loc4_.skidHitID = _loc4_.minigame.objects[_loc5_].id;
                  _loc4_.isBoosting = false;
                  _loc4_.skidTargetYOffset = (_loc4_.nextY - _loc4_.y) * 3;
                  _loc3_ = _loc4_.skidAnimFrames.indexOf(_loc4_.clip.currentFrame);
                  if(_loc3_ > -1)
                  {
                     _loc4_.skidAnimFrameIndex = _loc3_;
                  }
                  _loc4_.clip.rearwheel.oilfx.gotoAndPlay(2);
                  _loc4_.clip.boostfx.gotoAndStop(1);
                  _loc4_.animateDriver("skid");
                  if(_loc4_.isPlayer)
                  {
                     trace(_loc4_.minigame.currFrame + ": " + _loc4_.skidHitID + " oilslick SKID!");
                  }
                  _loc4_.playObjectSound("minigame_kart_oilslick.wav");
               }
            }
            else if(_loc4_.minigame.objects[_loc5_].type == KartObject.TYPE_BOOSTPAD && Math.abs(_loc1_) < _loc4_.kartWidth + _loc4_.minigame.objects[_loc5_].objectWidth && Math.abs(_loc2_) < _loc4_.kartHeight + _loc4_.minigame.objects[_loc5_].objectHeight)
            {
               if(!_loc4_.isBoosting || _loc4_.boostHitID != _loc4_.minigame.objects[_loc5_].id)
               {
                  _loc4_.isBoosting = true;
                  _loc4_.boostHitID = _loc4_.minigame.objects[_loc5_].id;
                  _loc4_.boostTimer = 0;
                  _loc4_.isSkidding = false;
                  _loc4_.clip.boostfx.gotoAndPlay(2);
                  _loc4_.clip.rearwheel.oilfx.gotoAndStop(1);
                  _loc4_.animateDriver("boost");
                  _loc4_.playObjectSound("minigame_kart_boost.wav");
               }
            }
            else if(_loc4_.minigame.objects[_loc5_].type == KartObject.TYPE_COIN && Math.abs(_loc1_) < _loc4_.kartWidth + _loc4_.minigame.objects[_loc5_].objectWidth && Math.abs(_loc2_) < _loc4_.kartHeight + _loc4_.minigame.objects[_loc5_].objectHeight)
            {
               _loc4_.maxSpeed += 0.2;
               if(_loc4_.isPlayer)
               {
                  ++_loc4_.minigame.coinsCollected;
               }
               _loc4_.clip.coinfx.gotoAndPlay(2);
               _loc4_.minigame.removeObject(_loc4_.minigame.objects[_loc5_].id);
               if(_loc4_.isPlayer)
               {
                  _loc4_.minigame.screen.gameObj.var_142.recordTagged("kartcoin",1);
               }
               if(_loc4_.isPlayer)
               {
                  _loc4_.playObjectSound("minigame_kart_getcoin.wav");
               }
               else
               {
                  _loc4_.playObjectSound("grabtopping.wav");
               }
            }
            else if(_loc4_.minigame.objects[_loc5_].type == KartObject.TYPE_FINISHLINE && _loc4_.x > _loc4_.minigame.objects[_loc5_].x && !_loc4_.crossedFinish)
            {
               _loc4_.crossedFinish = true;
               _loc4_.crossTime = _loc4_.minigame.currFrame;
               _loc4_.minigame.objects[_loc5_].hitObject(_loc4_.lastX,_loc4_.lastY,_loc4_.nextX,_loc4_.nextY);
               if(_loc4_.isPlayer)
               {
                  _loc4_.minigame.isFinishing = true;
                  _loc4_.minigame.finishDecaySpeed = _loc4_.speed;
                  _loc4_.minigame.finishRank = _loc4_.minigame.objects[_loc5_].kartsPassed;
                  if(_loc4_.minigame.objects[_loc5_].kartsPassed == 1)
                  {
                     trace("FIRST PLACE!");
                  }
                  else if(_loc4_.minigame.objects[_loc5_].kartsPassed == 2)
                  {
                     trace("SECOND PLACE");
                  }
                  else
                  {
                     trace("LAST PLACE. BOOOOOOO");
                  }
                  _loc4_.minigame.checkSuccess();
                  _loc4_.minigame.showBanner(_loc4_.minigame.finishRank);
               }
            }
            _loc5_--;
         }
      }
      
      public function updateCoordsForCollisions(param1:Boolean = false) : void
      {
         var _loc2_:GoKart = null;
         var _loc3_:Point = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:GoKart = this;
         var _loc15_:int = 0;
         while(_loc15_ < _loc14_.minigame.karts.length)
         {
            _loc2_ = _loc14_.minigame.karts[_loc15_];
            if(_loc2_ != _loc14_)
            {
               _loc3_ = _loc2_.checkForCollisions(_loc14_.nextX,_loc14_.nextY);
               if(_loc3_ != null)
               {
                  if(param1 == true)
                  {
                     trace("HEY, it\'s finding new collision on a second pass.  Not cool!");
                  }
                  _loc4_ = _loc14_.nextX;
                  _loc5_ = _loc14_.nextY;
                  _loc6_ = _loc2_.nextX;
                  _loc7_ = _loc2_.nextY;
                  _loc8_ = _loc14_.nextX - _loc14_.lastX;
                  _loc9_ = _loc14_.nextY - _loc14_.lastY;
                  _loc10_ = _loc2_.nextX - _loc2_.lastX;
                  _loc11_ = _loc2_.nextY - _loc2_.lastY;
                  _loc12_ = _loc2_.kartWidth * 2 - Math.abs(_loc3_.x);
                  _loc13_ = _loc2_.kartHeight * 2 - Math.abs(_loc3_.y);
                  if(_loc12_ > _loc13_)
                  {
                     if(Math.abs(_loc9_) > Math.abs(_loc11_))
                     {
                        if(_loc3_.y > 0)
                        {
                           _loc14_.nextY = _loc2_.nextY - _loc14_.kartHeight * 2 - 1;
                        }
                        else
                        {
                           _loc14_.nextY = _loc2_.nextY + _loc14_.kartHeight * 2 + 1;
                        }
                        if(_loc14_.nextY > _loc14_.minigame.kartMaxY || _loc14_.nextY < _loc14_.minigame.kartMinY || _loc9_ >= 0 && _loc14_.nextY < _loc14_.lastY || _loc9_ <= 0 && _loc14_.nextY > _loc14_.lastY)
                        {
                           if(_loc14_.nextY > _loc14_.minigame.kartMaxY)
                           {
                              _loc14_.nextY = _loc14_.minigame.kartMaxY;
                              _loc2_.nextY = _loc14_.nextY - _loc14_.kartHeight * 2 - 1;
                           }
                           else if(_loc14_.nextY < _loc14_.minigame.kartMinY)
                           {
                              _loc14_.nextY = _loc14_.minigame.kartMinY;
                              _loc2_.nextY = _loc14_.nextY + _loc14_.kartHeight * 2 - 1;
                           }
                           else
                           {
                              _loc14_.nextY = _loc14_.lastY;
                              if(_loc2_.nextY > _loc14_.lastY)
                              {
                                 _loc2_.nextY = _loc14_.nextY + _loc14_.kartHeight * 2 - 1;
                              }
                              else
                              {
                                 _loc2_.nextY = _loc14_.nextY - _loc14_.kartHeight * 2 - 1;
                              }
                           }
                        }
                        if(!_loc14_.isPlayer || !_loc14_.playerControlled)
                        {
                           _loc14_.targetY = _loc14_.nextY;
                        }
                     }
                     else
                     {
                        if(_loc3_.y > 0)
                        {
                           _loc2_.nextY = _loc14_.nextY + _loc14_.kartHeight * 2 + 1;
                        }
                        else
                        {
                           _loc2_.nextY = _loc14_.nextY - _loc14_.kartHeight * 2 - 1;
                        }
                        if(_loc2_.nextY > _loc14_.minigame.kartMaxY || _loc2_.nextY < _loc14_.minigame.kartMinY || _loc11_ >= 0 && _loc2_.nextY < _loc2_.lastY || _loc11_ <= 0 && _loc2_.nextY > _loc2_.lastY)
                        {
                           if(_loc2_.nextY > _loc14_.minigame.kartMaxY)
                           {
                              _loc2_.nextY = _loc14_.minigame.kartMaxY;
                              _loc14_.nextY = _loc2_.nextY - _loc14_.kartHeight * 2 - 1;
                           }
                           else if(_loc2_.nextY < _loc14_.minigame.kartMinY)
                           {
                              _loc2_.nextY = _loc14_.minigame.kartMinY;
                              _loc14_.nextY = _loc2_.nextY + _loc14_.kartHeight * 2 - 1;
                           }
                           else
                           {
                              _loc2_.nextY = _loc2_.lastY;
                              if(_loc14_.nextY > _loc2_.lastY)
                              {
                                 _loc14_.nextY = _loc2_.nextY + _loc14_.kartHeight * 2 - 1;
                              }
                              else
                              {
                                 _loc14_.nextY = _loc2_.nextY - _loc14_.kartHeight * 2 - 1;
                              }
                           }
                        }
                        if(!_loc2_.isPlayer || !_loc2_.playerControlled)
                        {
                           _loc2_.targetY = _loc2_.nextY;
                        }
                     }
                  }
                  else if(Math.abs(_loc8_) > Math.abs(_loc10_))
                  {
                     if(_loc3_.x > 0)
                     {
                        _loc14_.nextX = _loc2_.nextX - _loc14_.kartWidth * 2 - 1;
                        if(_loc12_ < 4)
                        {
                           _loc14_.nextSpeed *= 0.85;
                        }
                     }
                     else
                     {
                        _loc2_.nextX = _loc14_.nextX - _loc14_.kartWidth * 2 - 1;
                        if(_loc12_ < 4)
                        {
                           _loc2_.nextSpeed *= 0.85;
                        }
                     }
                     if(!_loc14_.isPlayer || !_loc14_.playerControlled)
                     {
                        _loc14_.targetY = _loc14_.nextY;
                     }
                  }
                  else
                  {
                     if(_loc3_.x > 0)
                     {
                        _loc14_.nextX = _loc2_.nextX - _loc14_.kartWidth * 2 - 1;
                        if(_loc12_ < 4)
                        {
                           _loc14_.nextSpeed *= 0.85;
                        }
                     }
                     else
                     {
                        _loc2_.nextX = _loc14_.nextX - _loc14_.kartWidth * 2 - 1;
                        if(_loc12_ < 4)
                        {
                           _loc2_.nextSpeed *= 0.85;
                        }
                     }
                     if(!_loc2_.isPlayer || !_loc2_.playerControlled)
                     {
                        _loc2_.targetY = _loc2_.nextY;
                     }
                  }
               }
            }
            _loc15_++;
         }
         _loc14_.checkForHittingObjects();
      }
      
      public function updateKart() : void
      {
         var _loc1_:GoKart = this;
         _loc1_.didCollide = false;
         if(_loc1_.worker)
         {
            _loc1_.worker.animateModel();
         }
         if(!_loc1_.isCrashed)
         {
            _loc1_.speed = _loc1_.nextSpeed;
         }
         _loc1_.x = _loc1_.nextX;
         _loc1_.y = _loc1_.nextY;
         if(!_loc1_.isPlayer)
         {
            if(_loc1_.minigame.isFinishing)
            {
               _loc1_.clip.x = _loc1_.minigame.kart.clip.x + (_loc1_.minigame.kart.nextX - _loc1_.minigame.kart.lastX) + (_loc1_.x - _loc1_.minigame.kart.nextX);
            }
            else
            {
               _loc1_.clip.x = _loc1_.minigame.kartStartX + _loc1_.x - _loc1_.minigame.kart.nextX;
               if(_loc1_.minigame.isIntro)
               {
                  trace("Kart " + _loc1_.customerName + ": Move Clip X to " + _loc1_.clip.x + " (my X is " + _loc1_.x + ", Player X is " + _loc1_.minigame.kart.x + ", Player Next X is " + _loc1_.minigame.kart.nextX);
               }
            }
         }
         else if(_loc1_.isPlayer && _loc1_.minigame.isFinishing)
         {
            _loc1_.clip.x += _loc1_.minigame.kart.nextX - _loc1_.minigame.kart.lastX;
         }
         _loc1_.clip.y = _loc1_.y;
         _loc1_.updateKartGraphic();
         _loc1_.updateDrivingSound();
         if(!_loc1_.isPlayer && _loc1_.x > _loc1_.minigame.kart.nextX && !_loc1_.aheadOfPlayer)
         {
            _loc1_.aheadOfPlayer = true;
            if(Math.random() >= 0.4)
            {
               if(Math.random() < 0.5)
               {
                  _loc1_.animateDriver("wave1");
               }
               else
               {
                  _loc1_.animateDriver("wave2");
               }
            }
         }
         else if(!_loc1_.isPlayer && _loc1_.x < _loc1_.minigame.kart.nextX && _loc1_.aheadOfPlayer)
         {
            _loc1_.aheadOfPlayer = false;
            if(Math.random() < 0.7)
            {
               _loc1_.animateDriver("pass");
            }
         }
      }
      
      public function updateKartGraphic() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:Number = Number(NaN);
         var _loc2_:GoKart = this;
         var _loc3_:Number = _loc2_.nextY - _loc2_.lastY;
         var _loc4_:Number = _loc2_.speed * _loc2_.laneSpeedFactor;
         _loc5_ = (_loc2_.y - _loc2_.minigame.kartMinY) / (_loc2_.minigame.kartMaxY - _loc2_.minigame.kartMinY);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         else if(_loc5_ > 1)
         {
            _loc5_ = 1;
         }
         _loc2_.clip.scaleX = 0.8 + _loc5_ * 0.2;
         _loc2_.clip.scaleY = _loc2_.clip.scaleX;
         _loc6_ = Math.abs(_loc3_ / _loc4_);
         if(_loc6_ > 1)
         {
            _loc6_ = 1;
         }
         else if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         if(_loc2_.isSkidding)
         {
            ++_loc2_.skidAnimFrameIndex;
            if(_loc2_.skidAnimFrameIndex >= _loc2_.skidAnimFrames.length)
            {
               _loc2_.skidAnimFrameIndex = 0;
            }
            _loc2_.clip.gotoAndStop(_loc2_.skidAnimFrames[_loc2_.skidAnimFrameIndex]);
         }
         else if(_loc3_ > 0)
         {
            _loc1_ = Math.ceil(_loc6_ * 5);
            if(_loc1_ < 1)
            {
               _loc1_ = 1;
            }
            if(_loc2_.clip.currentFrame < _loc1_)
            {
               _loc2_.clip.gotoAndStop(_loc2_.clip.currentFrame + 1);
            }
            else if(_loc2_.clip.currentFrame > 5)
            {
               _loc2_.clip.gotoAndStop(1);
            }
            else if(_loc2_.clip.currentFrame > _loc1_)
            {
               _loc2_.clip.gotoAndStop(_loc2_.clip.currentFrame - 1);
            }
         }
         else if(_loc3_ < 0)
         {
            _loc1_ = 8 + Math.ceil(_loc6_ * 5);
            if(_loc1_ < 9)
            {
               _loc1_ = 9;
            }
            if(_loc2_.clip.currentFrame < _loc1_)
            {
               if(_loc2_.clip.currentFrame < 9)
               {
                  _loc2_.clip.gotoAndStop(9);
               }
               else
               {
                  _loc2_.clip.gotoAndStop(_loc2_.clip.currentFrame + 1);
               }
            }
            else if(_loc2_.clip.currentFrame > _loc1_)
            {
               _loc2_.clip.gotoAndStop(_loc2_.clip.currentFrame - 1);
            }
         }
         else
         {
            if(_loc2_.clip.currentFrame > 1 && _loc2_.clip.currentFrame <= 5)
            {
               _loc2_.clip.gotoAndStop(_loc2_.clip.currentFrame - 1);
            }
            else if(_loc2_.clip.currentFrame > 9 && _loc2_.clip.currentFrame <= 13)
            {
               _loc2_.clip.gotoAndStop(_loc2_.clip.currentFrame - 1);
            }
            else
            {
               _loc2_.clip.gotoAndStop(1);
            }
            if(_loc2_.clip.currentFrame == 9)
            {
               _loc2_.clip.gotoAndStop(1);
            }
         }
      }
      
      public function startBoosting() : void
      {
         var _loc1_:GoKart = this;
         _loc1_.isBoosting = true;
         _loc1_.boostTimer = 0;
      }
      
      public function checkForCollisions(param1:Number, param2:Number) : Point
      {
         var _loc3_:GoKart = this;
         var _loc4_:Point = null;
         var _loc5_:Number = _loc3_.nextX - param1;
         var _loc6_:Number = _loc3_.nextY - param2;
         if(Math.abs(_loc5_) < _loc3_.kartWidth * 2 && Math.abs(_loc6_) < _loc3_.kartHeight * 2)
         {
            if(_loc4_ == null)
            {
               _loc4_ = new Point();
            }
            _loc4_.x = _loc5_;
            _loc4_.y = _loc6_;
         }
         return _loc4_;
      }
      
      public function kartAI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:GoKart = this;
         if(!_loc8_.isSkidding)
         {
            _loc2_ = Math.random();
            _loc3_ = -1;
            _loc4_ = "";
            _loc5_ = int.MAX_VALUE;
            _loc1_ = 0;
            while(_loc1_ < _loc8_.minigame.objects.length)
            {
               if(_loc8_.minigame.objects[_loc1_] != null && _loc8_.minigame.objects[_loc1_].x > _loc8_.nextX + 1 && _loc8_.minigame.objects[_loc1_].x < _loc8_.nextX + _loc8_.aiRangeX)
               {
                  if((_loc8_.minigame.objects[_loc1_].type == KartObject.TYPE_CONE || _loc8_.minigame.objects[_loc1_].type == KartObject.TYPE_OILSLICK) && !_loc8_.minigame.objects[_loc1_].isTumbling && Math.abs(_loc8_.minigame.objects[_loc1_].y - _loc8_.nextY) < _loc8_.kartHeight + _loc8_.minigame.objects[_loc1_].objectHeight)
                  {
                     if((_loc8_.minigame.objects[_loc1_].x < _loc5_ || _loc4_ == KartObject.TYPE_COIN || _loc4_ == KartObject.TYPE_BOOSTPAD) && _loc2_ < _loc8_.smartFactor)
                     {
                        _loc6_ = _loc8_.minigame.objects[_loc1_].y - _loc8_.minigame.objects[_loc1_].objectHeight - _loc8_.kartHeight - 6;
                        _loc7_ = _loc8_.minigame.objects[_loc1_].y + _loc8_.minigame.objects[_loc1_].objectHeight + _loc8_.kartHeight + 6;
                        if(_loc6_ > _loc8_.minigame.kartMinY && (_loc8_.targetY < _loc8_.y || _loc8_.nextY < _loc8_.minigame.objects[_loc1_].y))
                        {
                           _loc3_ = _loc6_;
                           if(_loc8_.isPlayer)
                           {
                              trace(_loc8_.minigame.currFrame + ": " + _loc8_.minigame.objects[_loc1_].id + " " + _loc8_.minigame.objects[_loc1_].type + " at " + _loc8_.minigame.objects[_loc1_].x + ", " + _loc8_.minigame.objects[_loc1_].y + ": There\'s room up, already going up or above it, move to " + _loc3_ + " (I\'m at " + _loc8_.nextY + ", was going to " + _loc8_.targetY + ")");
                           }
                        }
                        else if(_loc7_ < _loc8_.minigame.kartMaxY && (_loc8_.targetY > _loc8_.y || _loc8_.nextY > _loc8_.minigame.objects[_loc1_].y))
                        {
                           _loc3_ = _loc7_;
                           if(_loc8_.isPlayer)
                           {
                              trace(_loc8_.minigame.currFrame + ": " + _loc8_.minigame.objects[_loc1_].id + " " + _loc8_.minigame.objects[_loc1_].type + " at " + _loc8_.minigame.objects[_loc1_].x + ", " + _loc8_.minigame.objects[_loc1_].y + ": There\'s room down, already going down or below it, move to " + _loc3_ + " (I\'m at " + _loc8_.nextY + ", was going to " + _loc8_.targetY + ")");
                           }
                        }
                        else if(_loc6_ > _loc8_.minigame.kartMinY && _loc7_ < _loc8_.minigame.kartMaxY && Math.random() < 0.5)
                        {
                           _loc3_ = _loc6_;
                           if(_loc8_.isPlayer)
                           {
                              trace(_loc8_.minigame.currFrame + ": " + _loc8_.minigame.objects[_loc1_].id + " " + _loc8_.minigame.objects[_loc1_].type + " at " + _loc8_.minigame.objects[_loc1_].x + ", " + _loc8_.minigame.objects[_loc1_].y + ": There\'s room both ways, random up, move to " + _loc3_ + " (I\'m at " + _loc8_.nextY + ", was going to " + _loc8_.targetY + ")");
                           }
                        }
                        else if(_loc7_ < _loc8_.minigame.kartMaxY)
                        {
                           _loc3_ = _loc7_;
                           if(_loc8_.isPlayer)
                           {
                              trace(_loc8_.minigame.currFrame + ": " + _loc8_.minigame.objects[_loc1_].id + " " + _loc8_.minigame.objects[_loc1_].type + " at " + _loc8_.minigame.objects[_loc1_].x + ", " + _loc8_.minigame.objects[_loc1_].y + ": There\'s room down, move to " + _loc3_ + " (I\'m at " + _loc8_.nextY + ", was going to " + _loc8_.targetY + ")");
                           }
                        }
                        else
                        {
                           _loc3_ = _loc6_;
                           if(_loc8_.isPlayer)
                           {
                              trace(_loc8_.minigame.currFrame + ": " + _loc8_.minigame.objects[_loc1_].id + " " + _loc8_.minigame.objects[_loc1_].type + " at " + _loc8_.minigame.objects[_loc1_].x + ", " + _loc8_.minigame.objects[_loc1_].y + ": Nothing else, move up, move to " + _loc3_ + " (I\'m at " + _loc8_.nextY + ", was going to " + _loc8_.targetY + ")");
                           }
                        }
                        _loc4_ = _loc8_.minigame.objects[_loc1_].type;
                        _loc5_ = _loc8_.minigame.objects[_loc1_].x;
                     }
                  }
                  else if(_loc8_.minigame.objects[_loc1_].type == KartObject.TYPE_COIN || _loc8_.minigame.objects[_loc1_].type == KartObject.TYPE_BOOSTPAD)
                  {
                     if(_loc4_ != KartObject.TYPE_CONE && _loc4_ != KartObject.TYPE_OILSLICK && _loc4_ != "kart")
                     {
                        if(_loc8_.minigame.objects[_loc1_].x <= _loc5_ && _loc2_ < _loc8_.smartCollectFactor)
                        {
                           if(!(_loc5_ == _loc8_.minigame.objects[_loc1_].x && Math.abs(_loc3_ - _loc8_.nextY) < Math.abs(_loc8_.minigame.objects[_loc1_].y - _loc8_.nextY)))
                           {
                              _loc3_ = _loc8_.minigame.objects[_loc1_].y;
                              _loc4_ = _loc8_.minigame.objects[_loc1_].type;
                              _loc5_ = _loc8_.minigame.objects[_loc1_].x;
                              if(_loc8_.isPlayer)
                              {
                                 trace(_loc8_.minigame.currFrame + ": " + _loc8_.minigame.objects[_loc1_].id + " " + _loc8_.minigame.objects[_loc1_].type + " at " + _loc8_.minigame.objects[_loc1_].x + ", " + _loc8_.minigame.objects[_loc1_].y + ": Drive towards it to " + _loc3_ + " (I\'m at " + _loc8_.nextY + ", was going to " + _loc8_.targetY + ")");
                              }
                           }
                        }
                     }
                  }
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc8_.minigame.karts.length)
            {
               if(_loc8_.minigame.karts[_loc1_] != _loc8_ && _loc8_.minigame.karts[_loc1_].nextX > _loc8_.nextX && _loc8_.minigame.karts[_loc1_].nextX < _loc8_.nextX + _loc8_.kartWidth * 2 + 50)
               {
                  if(Math.abs(_loc8_.minigame.karts[_loc1_].nextY - _loc8_.nextY) < _loc8_.kartHeight * 2)
                  {
                     if(_loc8_.minigame.karts[_loc1_].nextX < _loc5_ && _loc2_ < _loc8_.smartFactor)
                     {
                        _loc6_ = _loc8_.nextY - _loc8_.aiRangeY;
                        _loc7_ = _loc8_.nextY + _loc8_.aiRangeY;
                        if(_loc6_ > _loc8_.minigame.kartMinY && _loc8_.targetY < _loc8_.y)
                        {
                           _loc3_ = _loc6_;
                        }
                        else if(_loc7_ < _loc8_.minigame.kartMaxY && _loc8_.targetY > _loc8_.y)
                        {
                           _loc3_ = _loc7_;
                        }
                        else if(_loc6_ > _loc8_.minigame.kartMinY && _loc7_ < _loc8_.minigame.kartMaxY && Math.random() < 0.5)
                        {
                           _loc3_ = _loc6_;
                        }
                        else if(_loc7_ < _loc8_.minigame.kartMaxY)
                        {
                           _loc3_ = _loc7_;
                        }
                        else
                        {
                           _loc3_ = _loc6_;
                        }
                        _loc4_ = "kart";
                        _loc5_ = _loc8_.minigame.karts[_loc1_].nextX;
                     }
                  }
               }
               _loc1_++;
            }
            if(_loc3_ != -1)
            {
               _loc8_.targetY = _loc3_;
            }
         }
      }
      
      public function buildCustomerModel(param1:String) : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:Class = null;
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         var _loc14_:Class = null;
         var _loc17_:MovieClip = null;
         var _loc18_:MovieClip = null;
         var _loc19_:MovieClip = null;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:Class = null;
         var _loc23_:MovieClip = null;
         var _loc24_:MovieClip = null;
         var _loc25_:Class = null;
         var _loc26_:MovieClip = null;
         var _loc27_:Number = NaN;
         var _loc2_:Class = null;
         var _loc3_:Class = null;
         var _loc4_:GoKart = this;
         var _loc5_:class_5 = _loc4_.minigame.screen.gameObj;
         _loc4_.customerClip = new customerDrivingMC();
         var _loc6_:MovieClip = _loc4_.customerClip;
         _loc8_ = getDefinitionByName("customer_" + param1 + "_body") as Class;
         _loc7_ = new _loc8_();
         _loc7_.name = "clip";
         _loc6_.body.addChild(_loc7_);
         _loc10_ = getDefinitionByName("customer_" + param1 + "_head") as Class;
         _loc9_ = new _loc10_();
         _loc9_.name = "clip";
         _loc6_.head.addChild(_loc9_);
         _loc11_ = _loc5_.var_130.getCustomerPart(param1,"eyes",_loc5_.var_128.getHolidayMonth());
         _loc11_.name = "clip";
         _loc6_.eyes.addChild(_loc11_);
         _loc12_ = _loc5_.var_130.getCustomerPart(param1,"mouth",_loc5_.var_128.getHolidayMonth());
         _loc12_.name = "clip";
         _loc6_.mouth.addChild(_loc12_);
         _loc14_ = getDefinitionByName("customer_" + param1 + "_neck") as Class;
         _loc13_ = new _loc14_();
         _loc13_.name = "clip";
         _loc6_.neck.addChild(_loc13_);
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         try
         {
            _loc2_ = getDefinitionByName("customer_" + param1 + "_hair") as Class;
            _loc15_ = new _loc2_();
            _loc15_.name = "clip";
            _loc6_.hair.addChild(_loc15_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc3_ = getDefinitionByName("customer_" + param1 + "_back_hair") as Class;
            _loc16_ = new _loc3_();
            _loc16_.name = "clip";
            _loc6_.back_hair.addChild(_loc16_);
         }
         catch(err:Error)
         {
         }
         _loc17_ = _loc5_.var_130.getCustomerPart(param1,"foot",_loc5_.var_128.getHolidayMonth());
         _loc17_.name = "clip";
         _loc6_.front_shoe.addChild(_loc17_);
         _loc18_ = _loc5_.var_130.getCustomerPart(param1,"foot",_loc5_.var_128.getHolidayMonth());
         _loc18_.name = "clip";
         _loc6_.back_shoe.addChild(_loc18_);
         _loc19_ = _loc5_.var_130.getCustomerPart(param1,"hand",_loc5_.var_128.getHolidayMonth());
         _loc19_.name = "clip";
         _loc6_.fronthand.addChild(_loc19_);
         _loc20_ = _loc5_.var_130.getCustomerPart(param1,"hand2",_loc5_.var_128.getHolidayMonth());
         _loc20_.name = "clip";
         _loc6_.backhand.addChild(_loc20_);
         _loc22_ = getDefinitionByName("customer_" + param1 + "_upperarm") as Class;
         _loc21_ = new _loc22_();
         _loc21_.name = "clip";
         _loc6_.front_upperarm.addChild(_loc21_);
         _loc23_ = new _loc22_();
         _loc23_.name = "clip";
         _loc6_.back_upperarm.addChild(_loc23_);
         _loc25_ = getDefinitionByName("customer_" + param1 + "_forearm") as Class;
         _loc24_ = new _loc25_();
         _loc24_.name = "clip";
         _loc6_.front_forearm.addChild(_loc24_);
         _loc26_ = new _loc25_();
         _loc26_.name = "clip";
         _loc6_.back_forearm.addChild(_loc26_);
         _loc27_ = _loc5_.var_130.getCustomerHolidayOutfitMonth(_loc5_.var_130.getCustomerIndex(param1));
         if(_loc27_ > 0 && _loc5_.var_128.getMonth() == _loc27_)
         {
            _loc7_.gotoAndStop(2);
            _loc21_.gotoAndStop(2);
            _loc23_.gotoAndStop(2);
            _loc24_.gotoAndStop(2);
            _loc26_.gotoAndStop(2);
            _loc9_.gotoAndStop(2);
            _loc13_.gotoAndStop(2);
            if(_loc15_)
            {
               _loc15_.gotoAndStop(2);
            }
            if(_loc16_)
            {
               _loc16_.gotoAndStop(2);
            }
         }
         else
         {
            _loc7_.gotoAndStop(1);
            _loc21_.gotoAndStop(1);
            _loc23_.gotoAndStop(1);
            _loc24_.gotoAndStop(1);
            _loc26_.gotoAndStop(1);
            _loc9_.gotoAndStop(1);
            _loc13_.gotoAndStop(1);
            if(_loc15_)
            {
               _loc15_.gotoAndStop(1);
            }
            if(_loc16_)
            {
               _loc16_.gotoAndStop(1);
            }
         }
      }
      
      public function destroyCustomerModel(param1:MovieClip) : void
      {
         param1.stop();
         try
         {
            param1.body.removeChildAt(0);
            param1.head.removeChildAt(0);
            param1.eyes.removeChildAt(0);
            param1.mouth.removeChildAt(0);
            param1.neck.removeChildAt(0);
            param1.front_shoe.removeChildAt(0);
            param1.back_shoe.removeChildAt(0);
            param1.fronthand.removeChildAt(0);
            param1.backhand.removeChildAt(0);
            param1.front_upperarm.removeChildAt(0);
            param1.back_upperarm.removeChildAt(0);
            param1.front_forearm.removeChildAt(0);
            param1.back_forearm.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.back_hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.handextra.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.handextratop.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
      }
      
      public function animateDriver(param1:String) : void
      {
         var _loc2_:GoKart = this;
         if(_loc2_.customerClip)
         {
            if(_loc2_.customerClip.currentLabel == "drive")
            {
               _loc2_.customerClip.gotoAndPlay(param1);
            }
         }
         else if(_loc2_.worker)
         {
            if(_loc2_.worker.clip.currentLabel == "drive")
            {
               _loc2_.worker.playAnimation(param1);
            }
         }
      }
   }
}


package cheeseGame.screens
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.media.SoundChannel;
   
   public class MiniGameSkeeball extends MiniGame
   {
      
      public var isWaitingToClose:Boolean = false;
      
      public var waitingTimer:Number = 0;
      
      public var waitingTimerMax:Number = 45;
      
      public var holes:Array = [];
      
      public var hitWhichHole:Number = -1;
      
      public var holeFrames:Number = 26;
      
      public var holeSizeMax:Number = 150;
      
      public var holeSizeMin:Number = 62;
      
      public var ball:MovieClip = null;
      
      public var lightOnFrame:Number = 4;
      
      public var numLights:Number = 9;
      
      public var currentPower:Number = 0;
      
      public var maxPower:Number = 100;
      
      public var powerSpeed:Number = 8;
      
      public var powerMod:Number = 1;
      
      public var powerDir:Number = 1;
      
      public var gameTimer:Number = 0;
      
      public var whichDifficulty:Number = 1;
      
      public var swirlRotation:Number = 1;
      
      public var isSettingPower:Boolean = true;
      
      public var isAimingBall:Boolean = false;
      
      public var isLaunching:Boolean = false;
      
      public var ballAimSpeed:Number = 16;
      
      public var ballDirection:Number = 1;
      
      public var ballStartY:Number = 386;
      
      public var ballLeftX:Number = 46;
      
      public var ballRightX:Number = 588;
      
      public var ballLaunchX:Number = 0;
      
      public var ballFullDiameter:Number = 75;
      
      public var ballSpeedRollY:Number = 22;
      
      public var ballSpeedRollX:Number = 0;
      
      public var ballSpeedBounceMax:Number = -30;
      
      public var ballSpeedCurrentBounce:Number = -30;
      
      public var gravity:Number = 2;
      
      public var didJump:Boolean = false;
      
      public var didHitWall:Boolean = false;
      
      public var ballRampY:Number = 300;
      
      public var wallTopY:Number = 54;
      
      public var wallBottomY:Number = 280;
      
      public var wallTargetY:Number = 0;
      
      public var jumpSpeed:Number = 0;
      
      public var jumpSpeedStart:Number = 26;
      
      public var jumpSpeedChange:Number = 0.5;
      
      public var jumpSpeedMin:Number = 12;
      
      public var holeLayouts:Array = [[],[[201,171,3,50],[333,104,12,0],[317,238,20,100],[443,203,26,200]],[[201,121,16,75],[257,228,22,150],[413,223,19,100],[463,106,13,0]],[[201,115,3,50],[285,226,21,150],[370,90,18,0],[463,213,6,50]],[[211,115,18,0],[334,222,15,75],[461,149,7,50]],[[211,155,14,75],[461,159,14,75],[336,86,14,75],[339,222,20,0]],[[211,225,14,50],[455,211,16,75],[242,99,19,100],[428,98,19,100],[338,154,24,0]],[[227,102,19,0],[191,225,22,100],[328,179,4,50],[492,151,24,200]],[[247,102,19,100],[437,106,24,0],[200,225,9,75],[460,224,7,50]],[[172,247,23,100],[210,158,21,0],[322,122,9,50],[445,161,21,75],[485,237,24,100]],[[163,122,21,100],[182,237,23,75],[483,120,23,100],[445,233,24,75],[322,203,9,50],[322,86,26,0]],[[199,109,24,100],[242,197,23,75],[322,86,26,0],[355,222,16,75],[450,120,6,50]],[[247,102,19,100],[437,106,24,0],[200,225,9,75],[474,224,7,50]],[[211,155,14,75],[461,159,14,75],[336,86,14,75],[339,222,20,0]],[[208,91,26,100],[152,162,26,100],[217,227,26,75],[319,167,13
      ,50],[414,87,26,0],[489,162,26,100],[420,234,26,75]]];
      
      public var meterSound:SoundChannel;
      
      public function MiniGameSkeeball(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:MiniGameSkeeball = this;
         _loc1_.clip = new minigameSkeeballMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.screen.setTitle("Blender Ball");
         _loc1_.setupPrizes(_loc1_.type);
         _loc1_.screen.updateStars();
         _loc1_.clip.power_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickPower);
         _loc1_.clip.launch_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickLaunch);
         _loc1_.decideDifficulty();
         _loc1_.setupHoles();
         _loc1_.clip.power_btn.visible = true;
         _loc1_.clip.launch_btn.visible = false;
         _loc1_.meterSound = _loc1_.screen.gameObj.var_129.playSound("minigame_powermeter.wav",true);
      }
      
      public function clickPower(param1:MouseEvent) : void
      {
         var _loc2_:MiniGameSkeeball = this;
         _loc2_.isSettingPower = false;
         _loc2_.ballSpeedCurrentBounce = 0.3 * _loc2_.ballSpeedBounceMax + _loc2_.currentPower / _loc2_.maxPower * (0.7 * _loc2_.ballSpeedBounceMax);
         _loc2_.wallTargetY = _loc2_.wallBottomY - _loc2_.currentPower / _loc2_.maxPower * (_loc2_.wallBottomY - _loc2_.wallTopY);
         _loc2_.isAimingBall = true;
         _loc2_.ball = new minigame_skeeball_ball();
         _loc2_.clip.frontholder.addChild(_loc2_.ball);
         _loc2_.ball.y = _loc2_.ballStartY;
         _loc2_.ball.x = _loc2_.ballLeftX;
         _loc2_.ball.gotoAndStop(1);
         _loc2_.ballDirection = 1;
         _loc2_.clip.power_btn.visible = false;
         _loc2_.clip.launch_btn.visible = true;
         _loc2_.screen.gameObj.var_129.playSound("press_machine_button.wav");
         if(_loc2_.meterSound)
         {
            _loc2_.meterSound.stop();
            _loc2_.meterSound = null;
         }
      }
      
      public function clickLaunch(param1:MouseEvent) : void
      {
         var _loc2_:MiniGameSkeeball = this;
         _loc2_.isAimingBall = false;
         _loc2_.isLaunching = true;
         _loc2_.didJump = false;
         _loc2_.didHitWall = false;
         _loc2_.jumpSpeed = _loc2_.jumpSpeedStart;
         _loc2_.ballLaunchX = _loc2_.ball.x;
         var _loc3_:Number = _loc2_.ball.x - 320;
         var _loc4_:Number = _loc3_ / 320;
         _loc2_.ballSpeedRollX = _loc4_ * _loc2_.ballSpeedRollY;
         _loc2_.ball.gotoAndPlay(2);
         _loc2_.clip.power_btn.visible = false;
         _loc2_.clip.launch_btn.visible = false;
         _loc2_.screen.gameObj.var_129.playSound("press_machine_button.wav");
         _loc2_.screen.gameObj.var_129.playSound("minigame_balllaunch.wav");
      }
      
      public function decideDifficulty() : void
      {
         var _loc1_:MiniGameSkeeball = this;
         var _loc2_:Number = _loc1_.getStartingLevel();
         if(_loc2_ < 14)
         {
            _loc1_.whichDifficulty = _loc2_ + 1;
         }
         else
         {
            _loc1_.whichDifficulty = Math.ceil(Math.random() * 14);
         }
         if(_loc1_.whichDifficulty < 3)
         {
            _loc1_.powerSpeed = 8;
         }
         else
         {
            _loc1_.powerSpeed = Math.min(14,6 + _loc1_.whichDifficulty);
         }
         if(_loc1_.whichDifficulty < 4)
         {
            _loc1_.ballAimSpeed = 16;
         }
         else
         {
            _loc1_.ballAimSpeed = 13 + _loc1_.whichDifficulty;
         }
      }
      
      public function setupHoles() : void
      {
         var §~~unused§:*;
         var _loc4_:Array;
         var _loc1_:Number = Number(NaN);
         var _loc2_:MovieClip = null;
         var _loc3_:MiniGameSkeeball = this;
         if(_loc3_.holes.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc3_.holes.length)
            {
               try
               {
                  _loc3_.clip.holeholder.removeChild(_loc3_.holes[_loc1_]);
               }
               catch(err:Error)
               {
               }
               _loc3_.holes[_loc1_] = null;
               _loc1_++;
            }
            _loc3_.holes = null;
            _loc3_.holes = [];
         }
         if(_loc3_.ball != null)
         {
            try
            {
               _loc3_.ball.parent.removeChild(_loc3_.ball);
            }
            catch(err:Error)
            {
            }
            _loc3_.ball = null;
         }
         _loc4_ = _loc3_.holeLayouts[_loc3_.whichDifficulty];
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            _loc2_ = _loc3_.createHole(_loc4_[_loc1_][2],_loc4_[_loc1_][0],_loc4_[_loc1_][1],_loc4_[_loc1_][3]);
            _loc3_.holes.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function createHole(param1:Number, param2:Number, param3:Number, param4:Number) : MovieClip
      {
         var _loc6_:MovieClip = null;
         var _loc5_:MiniGameSkeeball = this;
         _loc6_ = new minigame_skeeball_hole();
         _loc6_.gotoAndStop(param1);
         _loc6_.swirlmask.gotoAndStop(param1);
         _loc6_.swirl.mask = _loc6_.swirlmask;
         if(param4 == 0)
         {
            _loc6_.prizelabel.star.visible = true;
            _loc6_.prizelabel.amount_txt.text = "";
         }
         else
         {
            _loc6_.prizelabel.star.visible = false;
            _loc6_.prizelabel.amount_txt.text = param4;
         }
         _loc6_.swirl.inside.gotoAndStop(Math.ceil(Math.random() * _loc6_.swirl.inside.totalFrames));
         _loc6_.x = param2;
         _loc6_.y = param3;
         _loc5_.clip.holeholder.addChild(_loc6_);
         return _loc6_;
      }
      
      public function checkSuccess() : void
      {
         var _loc1_:MiniGameSkeeball = this;
         _loc1_.screen.gameObj.var_129.playSound("blenderball_blend.wav");
         var _loc2_:Array = _loc1_.holeLayouts[_loc1_.whichDifficulty][_loc1_.hitWhichHole];
         var _loc3_:Number = Number(_loc2_[3]);
         if(_loc3_ == 0)
         {
            _loc1_.decidePrize();
         }
         else
         {
            _loc1_.skuToWin = "tips";
            _loc1_.amountToWin = _loc3_;
            _loc1_.skuIsClothing = false;
            _loc1_.skuClothingMode = "";
         }
      }
      
      override public function updateScreen() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:MiniGameSkeeball = this;
         ++_loc3_.gameTimer;
         if(_loc3_.isSettingPower)
         {
            if(_loc3_.gameTimer % _loc3_.powerMod == 0)
            {
               _loc3_.currentPower += _loc3_.powerSpeed * _loc3_.powerDir;
               if(_loc3_.currentPower > _loc3_.maxPower)
               {
                  _loc3_.currentPower = _loc3_.maxPower;
                  _loc3_.powerDir = -1;
               }
               else if(_loc3_.currentPower < 0)
               {
                  _loc3_.currentPower = 0;
                  _loc3_.powerDir = 1;
               }
            }
         }
         var _loc4_:Number = Math.round(_loc3_.currentPower / _loc3_.maxPower * (_loc3_.numLights - 1));
         _loc1_ = 0;
         while(_loc1_ < _loc3_.numLights)
         {
            if(_loc1_ == _loc4_)
            {
               if(_loc3_.clip.lights_left["light" + _loc1_].currentFrame == 1 || _loc3_.clip.lights_left["light" + _loc1_].currentFrame > _loc3_.lightOnFrame)
               {
                  _loc3_.clip.lights_left["light" + _loc1_].gotoAndPlay("on");
                  _loc3_.clip.lights_right["light" + _loc1_].gotoAndPlay("on");
               }
            }
            else if(_loc3_.clip.lights_left["light" + _loc1_].currentFrame > 1 && _loc3_.clip.lights_left["light" + _loc1_].currentFrame <= _loc3_.lightOnFrame)
            {
               _loc3_.clip.lights_left["light" + _loc1_].gotoAndPlay("off");
               _loc3_.clip.lights_right["light" + _loc1_].gotoAndPlay("off");
            }
            _loc1_++;
         }
         if(_loc3_.isAimingBall)
         {
            _loc3_.ball.x += _loc3_.ballAimSpeed * _loc3_.ballDirection;
            if(_loc3_.ballDirection == 1 && _loc3_.ball.x > _loc3_.ballRightX)
            {
               _loc3_.ball.x = _loc3_.ballRightX;
               _loc3_.ballDirection = -1;
            }
            else if(_loc3_.ballDirection == -1 && _loc3_.ball.x < _loc3_.ballLeftX)
            {
               _loc3_.ball.x = _loc3_.ballLeftX;
               _loc3_.ballDirection = 1;
            }
         }
         if(_loc3_.isLaunching)
         {
            if(!_loc3_.didJump && _loc3_.ball.y > _loc3_.ballRampY)
            {
               _loc3_.ball.y -= _loc3_.ballSpeedRollY;
               _loc3_.ball.x -= _loc3_.ballSpeedRollX;
               _loc2_ = 1 - (_loc3_.ball.y - _loc3_.ballRampY) / (_loc3_.ballStartY - _loc3_.ballRampY);
               _loc3_.ball.scaleX = 1 - 0.3 * _loc2_;
               _loc3_.ball.scaleY = 1 - 0.3 * _loc2_;
            }
            else if(_loc3_.ball.y <= _loc3_.ballRampY && !_loc3_.didJump)
            {
               _loc3_.didJump = true;
               _loc3_.clip.backholder.addChild(_loc3_.ball);
               _loc3_.ball.scaleX = 0.7;
               _loc3_.ball.scaleY = 0.7;
               _loc3_.ballSpeedRollX /= 8;
            }
            else if(_loc3_.didJump)
            {
               if(!_loc3_.didHitWall)
               {
                  if(_loc3_.ball.y > _loc3_.wallTargetY)
                  {
                     _loc3_.ball.y -= _loc3_.jumpSpeed;
                     _loc3_.ball.x -= _loc3_.ballSpeedRollX;
                     if(_loc3_.ball.y <= _loc3_.wallTargetY)
                     {
                        _loc3_.ball.y = _loc3_.wallTargetY;
                     }
                     _loc3_.jumpSpeed -= _loc3_.jumpSpeedChange;
                     if(_loc3_.jumpSpeed < _loc3_.jumpSpeedMin)
                     {
                        _loc3_.jumpSpeed = _loc3_.jumpSpeedMin;
                     }
                  }
                  else
                  {
                     _loc3_.ball.y = _loc3_.wallTargetY;
                     _loc3_.didHitWall = true;
                     _loc3_.ballSpeedCurrentBounce = -12;
                     _loc3_.checkForHittingHole();
                  }
               }
               else
               {
                  _loc3_.ball.y += _loc3_.ballSpeedCurrentBounce;
                  _loc3_.ball.x -= _loc3_.ballSpeedRollX;
                  _loc3_.ballSpeedCurrentBounce += _loc3_.gravity;
                  if(_loc3_.ball.y > 640)
                  {
                     _loc3_.screen.finishMiniGame(_loc3_.skuToWin,_loc3_.amountToWin,_loc3_.skuIsClothing,_loc3_.skuClothingMode);
                     _loc3_.isLaunching = false;
                  }
               }
            }
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.holes.length)
         {
            _loc3_.holes[_loc5_].swirl.inside.rotation += _loc3_.swirlRotation;
            if(_loc3_.hitWhichHole == _loc5_)
            {
               _loc3_.holes[_loc5_].swirl.inside.rotation += _loc3_.swirlRotation;
            }
            _loc5_++;
         }
      }
      
      public function getHoleDiameter(param1:Number) : Number
      {
         var _loc2_:MiniGameSkeeball = this;
         var _loc3_:Number = _loc2_.holeSizeMax - _loc2_.holeSizeMin;
         return _loc2_.holeSizeMax - (param1 - 1) * (_loc3_ / (_loc2_.holeFrames - 1));
      }
      
      public function checkForHittingHole() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:MiniGameSkeeball = this;
         var _loc10_:Boolean = false;
         var _loc11_:Number = -1;
         var _loc12_:int = 0;
         while(_loc12_ < _loc9_.holes.length)
         {
            _loc1_ = Number(_loc9_.holes[_loc12_].x);
            _loc2_ = Number(_loc9_.holes[_loc12_].y);
            _loc3_ = _loc9_.getHoleDiameter(_loc9_.holes[_loc12_].currentFrame);
            _loc4_ = _loc9_.ballFullDiameter * _loc9_.ball.scaleX;
            _loc5_ = _loc9_.ball.x - _loc1_;
            _loc6_ = _loc9_.ball.y - _loc2_;
            _loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
            _loc8_ = _loc3_ / 2 - _loc4_ / 2 + 20;
            if(_loc7_ < _loc8_)
            {
               _loc11_ = _loc12_;
               _loc10_ = true;
               break;
            }
            _loc12_++;
         }
         if(_loc10_)
         {
            _loc9_.holes[_loc11_].swirl.inside.blinker.gotoAndPlay(2);
            _loc9_.holes[_loc11_].prizelabel.visible = false;
            _loc9_.hitWhichHole = _loc11_;
            _loc9_.holes[_loc11_].swirl.addChild(_loc9_.ball);
            _loc9_.ball.x -= _loc9_.holes[_loc11_].x;
            _loc9_.ball.y -= _loc9_.holes[_loc11_].y;
            _loc9_.checkSuccess();
         }
         else
         {
            _loc9_.clip.hitwall.x = _loc9_.ball.x;
            _loc9_.clip.hitwall.y = _loc9_.ball.y;
            _loc9_.clip.hitwall.gotoAndPlay(1);
            _loc9_.ballSpeedRollX *= -1;
            _loc9_.screen.gameObj.var_129.playSound("minigame_ballhitwall.wav");
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:MiniGameSkeeball = this;
         if(_loc1_.meterSound)
         {
            _loc1_.meterSound.stop();
            _loc1_.meterSound = null;
         }
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


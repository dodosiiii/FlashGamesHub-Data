package cheeseGame.screens
{
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class MiniGamePachinko extends MiniGame
   {
      
      public var isDonePlaying:Boolean = false;
      
      public var whichDifficulty:Number = 1;
      
      public var lastPlayedSoundOnFrame:Number = 0;
      
      public var gameTimer:Number = 0;
      
      public var totalBalls:Number = 1;
      
      public var usingWhichBall:Number = 1;
      
      public var landedWhichHole:Array = [0,0,0,0,0];
      
      public var prizeAmounts:Array = [50,100,0,100,50];
      
      public var didLaunch:Boolean = false;
      
      public var ballSpeed:Number = 10;
      
      public var ballDirection:Number = 1;
      
      public var ballRadius:Number = 17;
      
      public var ballStartY:Number = 80;
      
      public var defaultRampDecay:Number = 0.5;
      
      public var ball:MovieClip;
      
      public var gravity:Number = 1;
      
      public var terminalVelocity:Number = 20;
      
      public var ballSpeedX:Number = 0;
      
      public var ballSpeedY:Number = 0;
      
      public var bumperTypes:Array = ["olive","mushroom","sausage","pepperoni","pepper","onion"];
      
      public var bumperRadii:Array = [5,10,12,20,20,16];
      
      public var bumperBounce:Array = [2,10,30,40,50,36];
      
      public var bottomBounds:Number = 430;
      
      public var didDropBelow:Boolean = false;
      
      public var dropBelowTimer:Number = 0;
      
      public var dropBelowTimerMax:Number = 15;
      
      public var endDelayTimer:Number = 0;
      
      public var endDelayTimerMax:Number = 40;
      
      public var rampCoords:Array = [[0,0],[2,329],[87,480],[135,480],[189,385],[240,471],[289,385],[291,480],[348,480],[350,385],[399,471],[450,385],[506,480],[553,480],[638,330],[640,0]];
      
      public var barCoords:Array = [[],[[64,131,123,182],[168,252,236,290],[392,260,458,218],[485,162,557,131],[533,308,609,292],[56,284,124,323]],[[39,182,97,234],[129,261,201,291],[538,224,600,177],[433,285,507,259]],[[70,152,128,204],[247,218,311,174],[114,258,179,302],[364,316,438,290],[522,212,572,152]],[[200,231,264,186],[430,237,375,181],[83,259,152,295],[470,294,539,258]],[[442,329,514,298],[123,312,198,333]],[[354,321,430,302],[212,304,284,335],[206,152,262,206],[436,150,377,201]],[],[[334,189,405,157],[223,159,294,191]],[[405,270,341,309],[212,215,285,242]],[[122,207,190,168],[433,147,501,186]],[[405,252,344,300],[528,173,595,133],[52,307,108,253],[346,137,408,185],[533,249,599,291],[59,137,122,183],[210,181,272,134],[211,258,275,303]],[[512,295,580,256],[59,252,116,305]],[[297,286,358,237],[206,210,278,239],[189,120,236,182],[459,185,494,115]],[[491,365,567,346],[70,345,142,376]]];
      
      public var bumperCoords:Array = [[],[[380,347,"pepperoni"],[263,337,"sausage"],[522,244,"sausage"],[486,345,"sausage"],[131,373,"pepperoni"],[604,187,"pepperoni"],[34,219,"pepperoni"],[320,216,"pepperoni"],[376,152,"mushroom"],[262,154,"mushroom"]],[[165,157,"pepper"],[392,221,"onion"],[579,298,"sausage"],[232,226,"onion"],[52,127,"sausage"],[458,167,"pepper"],[564,116,"sausage"],[305,180,"pepper"],[57,293,"sausage"],[272,322,"olive"],[355,322,"olive"],[428,344,"olive"],[195,345,"olive"],[126,346,"olive"],[505,343,"olive"]],[[231,335,"pepperoni"],[189,193,"mushroom"],[491,260,"mushroom"],[379,191,"mushroom"],[102,358,"mushroom"],[459,139,"pepperoni"],[585,287,"pepperoni"],[61,254,"pepperoni"],[328,244,"onion"],[509,354,"onion"]],[[173,329,"pepperoni"],[446,330,"pepperoni"],[350,246,"olive"],[285,245,"olive"],[319,173,"pepperoni"],[463,165,"onion"],[150,168,"onion"],[563,323,"pepper"],[78,337,"pepper"],[599,166,"olive"],[529,168,"olive"],[90,172,"olive"],[39,171,"olive"]],[[103,249,"pepper"]
      ,[373,216,"pepper"],[520,238,"pepper"],[232,221,"pepper"],[455,169,"pepperoni"],[314,164,"pepperoni"],[168,169,"pepperoni"],[377,361,"sausage"],[255,364,"sausage"],[57,173,"pepperoni"],[573,168,"pepperoni"],[48,315,"mushroom"],[593,305,"mushroom"],[315,266,"olive"],[236,126,"olive"],[389,126,"olive"],[113,132,"olive"],[520,127,"olive"]],[[319,234,"pepperoni"],[504,217,"pepper"],[128,221,"pepper"],[136,320,"sausage"],[496,310,"sausage"],[596,205,"olive"],[42,209,"olive"],[552,138,"olive"],[96,141,"olive"],[569,281,"olive"],[73,294,"olive"]],[[419,280,"mushroom"],[214,288,"mushroom"],[530,174,"olive"],[104,283,"pepperoni"],[533,273,"pepperoni"],[589,154,"olive"],[475,198,"olive"],[417,223,"olive"],[220,229,"olive"],[173,205,"olive"],[124,178,"olive"],[74,155,"olive"],[319,261,"pepperoni"],[320,169,"pepperoni"],[628,234,"pepperoni"],[6,244,"pepperoni"],[488,347,"olive"],[541,360,"olive"],[157,354,"olive"],[102,381,"olive"],[270,343,"onion"],[374,338,"onion"],[56,335,"olive"],[587,315,"olive"]]
      ,[[361,215,"pepperoni"],[266,217,"pepperoni"],[432,283,"sausage"],[379,309,"olive"],[312,300,"sausage"],[252,313,"olive"],[193,284,"sausage"],[84,319,"olive"],[579,157,"onion"],[511,160,"onion"],[543,225,"mushroom"],[481,249,"onion"],[523,345,"onion"],[80,221,"mushroom"],[134,257,"onion"],[119,166,"onion"],[55,157,"onion"],[139,358,"onion"],[590,306,"olive"]],[[370,194,"sausage"],[431,136,"onion"],[490,201,"mushroom"],[591,167,"sausage"],[572,300,"pepperoni"],[86,283,"mushroom"],[172,181,"onion"],[297,160,"mushroom"],[37,160,"sausage"],[180,304,"pepperoni"],[449,352,"pepper"],[113,124,"olive"],[96,208,"olive"],[253,295,"olive"],[241,361,"olive"],[343,132,"olive"],[331,255,"olive"],[435,232,"olive"],[516,144,"olive"],[499,301,"olive"],[534,242,"olive"],[532,359,"olive"],[602,242,"olive"],[106,355,"olive"],[234,140,"olive"]],[[319,259,"pepperoni"],[271,201,"olive"],[268,313,"olive"],[376,202,"olive"],[381,315,"olive"],[432,253,"sausage"],[204,259,"sausage"],[488,335,"pepper"],[171,332,"mushroom"]
      ,[113,274,"onion"],[590,257,"mushroom"],[61,162,"sausage"],[324,150,"onion"],[576,150,"pepperoni"],[55,317,"sausage"],[576,328,"olive"],[506,251,"onion"]],[[158,320,"sausage"],[308,219,"sausage"],[466,131,"mushroom"],[161,127,"mushroom"],[464,324,"sausage"],[112,382,"olive"],[164,226,"pepperoni"],[464,224,"pepper"],[542,373,"olive"]],[[371,250,"sausage"],[303,279,"olive"],[430,210,"sausage"],[482,171,"olive"],[112,165,"olive"],[239,241,"sausage"],[180,203,"sausage"],[539,136,"mushroom"],[56,119,"mushroom"],[73,349,"onion"],[574,334,"onion"],[158,346,"onion"],[472,340,"onion"],[11,216,"olive"],[619,196,"olive"],[251,340,"olive"],[377,337,"olive"]],[[120,190,"pepper"],[590,248,"sausage"],[281,355,"olive"],[459,281,"olive"],[114,335,"sausage"],[91,291,"onion"],[530,288,"pepperoni"],[384,300,"pepperoni"],[218,344,"pepperoni"],[400,362,"olive"],[543,182,"pepper"],[56,235,"pepperoni"],[144,370,"olive"],[531,370,"onion"],[382,143,"olive"],[43,144,"olive"]],[[76,179,"onion"],[174,178,"onion"],[275
      ,177,"onion"],[373,176,"onion"],[474,174,"onion"],[570,172,"onion"],[322,243,"olive"],[523,237,"olive"],[124,244,"olive"],[224,242,"sausage"],[423,242,"sausage"],[66,298,"mushroom"],[170,305,"mushroom"],[284,302,"mushroom"],[379,304,"mushroom"],[476,299,"mushroom"],[575,294,"mushroom"],[621,235,"sausage"],[18,241,"sausage"]]];
      
      public var ramps:Array = [];
      
      public var bumpers:Array = [];
      
      public var banks:Array = [];
      
      public function MiniGamePachinko(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:MiniGamePachinko = this;
         _loc1_.clip = new minigamePachinkoMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.screen.setTitle("Pizza Pachinko");
         _loc1_.setupPrizes(_loc1_.type);
         _loc1_.screen.updateStars();
         _loc1_.decideDifficulty();
         _loc1_.ball = _loc1_.clip.ball;
         _loc1_.usingWhichBall = 0;
         _loc1_.resetBall();
         _loc1_.setupWalls();
         _loc1_.setupBumpers();
         _loc1_.clip.reload.gotoAndPlay("sliding1");
         _loc1_.clip.reload.visible = false;
         _loc1_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickScreen);
      }
      
      public function setupWalls() : void
      {
         var _loc7_:MovieClip = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Ramp = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Ramp = null;
         _loc7_ = null;
         var _loc8_:DropShadowFilter = null;
         var _loc9_:MiniGamePachinko = this;
         _loc9_.ramps = null;
         _loc9_.ramps = [];
         _loc1_ = 0;
         while(_loc1_ < _loc9_.banks.length)
         {
            _loc9_.clip.holder.removeChild(_loc9_.banks[_loc1_]);
            _loc9_.banks[_loc1_] = null;
            _loc1_++;
         }
         _loc9_.banks = null;
         _loc9_.banks = [];
         _loc1_ = 0;
         while(_loc1_ < _loc9_.rampCoords.length - 1)
         {
            _loc2_ = _loc9_.rampCoords[_loc1_];
            _loc3_ = _loc9_.rampCoords[_loc1_ + 1];
            _loc4_ = new Ramp(_loc2_[0],_loc2_[1],_loc3_[0],_loc3_[1],_loc9_.defaultRampDecay);
            _loc9_.ramps.push(_loc4_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc9_.barCoords[_loc9_.whichDifficulty].length)
         {
            _loc5_ = _loc9_.defaultRampDecay;
            if(_loc9_.barCoords[_loc9_.whichDifficulty][_loc1_].length == 5)
            {
               _loc5_ = Number(_loc9_.barCoords[_loc9_.whichDifficulty][_loc1_][4]);
            }
            _loc6_ = new Ramp(_loc9_.barCoords[_loc9_.whichDifficulty][_loc1_][0],_loc9_.barCoords[_loc9_.whichDifficulty][_loc1_][1],_loc9_.barCoords[_loc9_.whichDifficulty][_loc1_][2],_loc9_.barCoords[_loc9_.whichDifficulty][_loc1_][3],_loc5_,true);
            _loc9_.ramps.push(_loc6_);
            _loc7_ = new pachinko_anchovy();
            _loc7_.x = _loc6_.x1;
            _loc7_.y = _loc6_.y1;
            _loc7_.rotation = this.radsToDegrees(_loc6_.getAngle());
            _loc8_ = new DropShadowFilter(5,90,9726215,1,2,2,0.71);
            _loc7_.filters = [_loc8_];
            _loc9_.clip.holder.addChild(_loc7_);
            _loc9_.banks.push(_loc7_);
            _loc1_++;
         }
      }
      
      public function setupBumpers() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Class = null;
         var _loc3_:MovieClip = null;
         var _loc4_:DropShadowFilter = null;
         var _loc5_:MiniGamePachinko = this;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.bumpers.length)
         {
            _loc5_.clip.holder.removeChild(_loc5_.bumpers[_loc1_]);
            _loc5_.bumpers[_loc1_] = null;
            _loc1_++;
         }
         _loc5_.bumpers = null;
         _loc5_.bumpers = [];
         _loc1_ = 0;
         while(_loc1_ < _loc5_.bumperCoords[_loc5_.whichDifficulty].length)
         {
            _loc2_ = getDefinitionByName("pachinko_" + _loc5_.bumperCoords[_loc5_.whichDifficulty][_loc1_][2]) as Class;
            _loc3_ = new _loc2_() as MovieClip;
            _loc3_.x = _loc5_.bumperCoords[_loc5_.whichDifficulty][_loc1_][0];
            _loc3_.y = _loc5_.bumperCoords[_loc5_.whichDifficulty][_loc1_][1];
            _loc3_.rotation = Math.floor(Math.random() * 360);
            _loc4_ = new DropShadowFilter(5,90,9726215,1,2,2,0.71);
            _loc3_.filters = [_loc4_];
            _loc5_.clip.holder.addChild(_loc3_);
            _loc5_.bumpers.push(_loc3_);
            _loc1_++;
         }
      }
      
      public function clickScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:MiniGamePachinko = this;
         if(!_loc2_.didLaunch)
         {
            _loc2_.didLaunch = true;
            if(_loc2_.usingWhichBall == 1 || _loc2_.usingWhichBall == 2)
            {
               _loc2_.clip.reload.gotoAndPlay("drop" + (_loc2_.usingWhichBall + 1));
            }
            _loc2_.ballSpeedX = 0;
         }
      }
      
      public function resetBall() : void
      {
         var _loc1_:MiniGamePachinko = this;
         if(_loc1_.usingWhichBall == _loc1_.totalBalls || _loc1_.landedWhichHole[2] > 0)
         {
            _loc1_.isDonePlaying = true;
            _loc1_.checkSuccess();
         }
         else
         {
            _loc1_.ball.x = _loc1_.ballRadius;
            _loc1_.ball.y = _loc1_.ballStartY;
            _loc1_.ballSpeedY = 0;
            _loc1_.ballSpeedX = 0;
            _loc1_.gravity = 1;
            _loc1_.ballDirection = 1;
            _loc1_.didLaunch = false;
            ++_loc1_.usingWhichBall;
            if(_loc1_.usingWhichBall == 1 || _loc1_.usingWhichBall == 2 || _loc1_.usingWhichBall == 3)
            {
               _loc1_.clip.reload.gotoAndPlay("sliding" + _loc1_.usingWhichBall);
            }
         }
      }
      
      public function getBallSlope() : Number
      {
         var _loc1_:MiniGamePachinko = this;
         var _loc2_:Number = _loc1_.ballSpeedY / _loc1_.ballSpeedX;
         if(_loc2_ == Number.POSITIVE_INFINITY)
         {
            _loc2_ = 1000000;
         }
         else if(_loc2_ == Number.NEGATIVE_INFINITY)
         {
            _loc2_ = -1000000;
         }
         return _loc2_;
      }
      
      public function decideDifficulty() : void
      {
         var _loc1_:MiniGamePachinko = this;
         var _loc2_:Number = _loc1_.getStartingLevel();
         if(_loc2_ < 14)
         {
            _loc1_.whichDifficulty = _loc2_ + 1;
         }
         else
         {
            _loc1_.whichDifficulty = Math.ceil(Math.random() * 14);
         }
      }
      
      public function checkSuccess() : void
      {
         var _loc1_:MiniGamePachinko = this;
         if(_loc1_.landedWhichHole[2] > 0)
         {
            _loc1_.decidePrize();
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_happy.wav");
         }
         else
         {
            _loc1_.skuToWin = "tips";
            _loc1_.skuIsClothing = false;
            _loc1_.skuClothingMode = "";
            _loc1_.amountToWin = 0;
            _loc1_.amountToWin += _loc1_.landedWhichHole[0] * _loc1_.prizeAmounts[0];
            _loc1_.amountToWin += _loc1_.landedWhichHole[1] * _loc1_.prizeAmounts[1];
            _loc1_.amountToWin += _loc1_.landedWhichHole[3] * _loc1_.prizeAmounts[3];
            _loc1_.amountToWin += _loc1_.landedWhichHole[4] * _loc1_.prizeAmounts[4];
            if(_loc1_.amountToWin == 0)
            {
               _loc1_.skuToWin = null;
            }
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_decent.wav");
         }
      }
      
      override public function updateScreen() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:MiniGamePachinko = this;
         if(!_loc2_.isDonePlaying)
         {
            ++_loc2_.gameTimer;
            if(!_loc2_.didLaunch)
            {
               _loc2_.ball.x += _loc2_.ballSpeed * _loc2_.ballDirection;
               if(_loc2_.ball.x > 640 - _loc2_.ballRadius && _loc2_.ballDirection == 1)
               {
                  _loc2_.ball.x = 640 - _loc2_.ballRadius;
                  _loc2_.ballDirection = -1;
               }
               else if(_loc2_.ball.x < _loc2_.ballRadius && _loc2_.ballDirection == -1)
               {
                  _loc2_.ball.x = _loc2_.ballRadius;
                  _loc2_.ballDirection = 1;
               }
            }
            else
            {
               _loc2_.ballSpeedY += _loc2_.gravity;
               if(_loc2_.ballSpeedY > _loc2_.terminalVelocity)
               {
                  _loc2_.ballSpeedY = _loc2_.terminalVelocity;
               }
               _loc2_.checkForCollisions();
               if(_loc2_.ball.y > _loc2_.bottomBounds && !_loc2_.didDropBelow)
               {
                  _loc2_.didDropBelow = true;
               }
               else if(_loc2_.ball.y < _loc2_.bottomBounds && _loc2_.didDropBelow)
               {
                  _loc2_.didDropBelow = false;
                  _loc2_.dropBelowTimer = 0;
               }
               else if(_loc2_.didDropBelow)
               {
                  ++_loc2_.dropBelowTimer;
                  if(_loc2_.dropBelowTimer >= _loc2_.dropBelowTimerMax && _loc2_.ball.y > _loc2_.bottomBounds)
                  {
                     _loc1_ = -1;
                     if(_loc2_.ball.x < 161)
                     {
                        _loc1_ = 0;
                     }
                     else if(_loc2_.ball.x < 280)
                     {
                        _loc1_ = 1;
                     }
                     else if(_loc2_.ball.x < 347)
                     {
                        _loc1_ = 2;
                     }
                     else if(_loc2_.ball.x < 450)
                     {
                        _loc1_ = 3;
                     }
                     else
                     {
                        _loc1_ = 4;
                     }
                     ++_loc2_.landedWhichHole[_loc1_];
                     _loc2_.clip.fireworks.x = _loc2_.ball.x;
                     _loc2_.clip.fireworks.y = _loc2_.ball.y;
                     _loc2_.clip.fireworks.gotoAndPlay(1);
                     _loc2_.screen.gameObj.var_129.playSound("getstar.wav");
                     _loc2_.resetBall();
                  }
               }
            }
            _loc2_.clip.shadowball.x = _loc2_.clip.ball.x;
            _loc2_.clip.shadowball.y = _loc2_.clip.ball.y;
         }
         else
         {
            ++_loc2_.endDelayTimer;
            if(_loc2_.endDelayTimer == _loc2_.endDelayTimerMax)
            {
               _loc2_.screen.finishMiniGame(_loc2_.skuToWin,_loc2_.amountToWin,_loc2_.skuIsClothing,_loc2_.skuClothingMode);
            }
         }
      }
      
      public function checkForCollisions() : void
      {
         var _loc1_:MiniGamePachinko = this;
         var _loc2_:Boolean = _loc1_.checkIntersectingRamps();
         var _loc3_:Boolean = _loc1_.checkIntersectingBumpers();
         if(!_loc2_ && !_loc3_)
         {
            _loc1_.ball.x += _loc1_.ballSpeedX;
            _loc1_.ball.y += _loc1_.ballSpeedY;
         }
      }
      
      public function checkIntersectingBumpers() : Boolean
      {
         var §~~unused§:*;
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:String = null;
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
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:Number = Number(NaN);
         var _loc21_:Number = Number(NaN);
         var _loc22_:Number = Number(NaN);
         var _loc23_:Number = Number(NaN);
         var _loc24_:Number = Number(NaN);
         var _loc25_:Number = Number(NaN);
         var _loc26_:Number = Number(NaN);
         var _loc27_:* = undefined;
         var _loc28_:Boolean = false;
         var _loc29_:Number = Number(NaN);
         var _loc30_:Number = Number(NaN);
         var _loc31_:Number = Number(NaN);
         var _loc32_:Number = Number(NaN);
         var _loc33_:Number = Number(NaN);
         var _loc34_:Number = Number(NaN);
         var _loc35_:Number = Number(NaN);
         var _loc36_:Number = Number(NaN);
         var _loc37_:Number = Number(NaN);
         var _loc38_:Number = Number(NaN);
         var _loc39_:Number = Number(NaN);
         var _loc40_:Number = Number(NaN);
         var _loc41_:Number = Number(NaN);
         var _loc42_:Number = Number(NaN);
         var _loc43_:Number = Number(NaN);
         var _loc44_:Number = Number(NaN);
         var _loc45_:Number = Number(NaN);
         var _loc46_:* = undefined;
         var _loc47_:Number = Number(NaN);
         var _loc48_:Number = Number(NaN);
         var _loc49_:MiniGamePachinko = this;
         var _loc50_:Boolean = false;
         var _loc51_:Number = this.ball.x;
         var _loc52_:Number = this.ball.y;
         var _loc53_:int = 0;
         while(_loc53_ < _loc49_.bumperCoords[_loc49_.whichDifficulty].length)
         {
            _loc1_ = Number(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][0]);
            _loc2_ = Number(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][1]);
            _loc3_ = String(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][2]);
            _loc4_ = 0;
            _loc5_ = 0;
            if(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_].length == 5)
            {
               _loc4_ = Number(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][3]);
               _loc5_ = Number(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][4]);
            }
            else
            {
               _loc4_ = Number(_loc49_.bumperRadii[_loc49_.bumperTypes.indexOf(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][2])]);
               _loc5_ = Number(_loc49_.bumperBounce[_loc49_.bumperTypes.indexOf(_loc49_.bumperCoords[_loc49_.whichDifficulty][_loc53_][2])]);
            }
            _loc6_ = _loc49_.ballSpeedX;
            _loc7_ = _loc49_.ballSpeedY;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = _loc51_;
            _loc11_ = _loc52_;
            _loc12_ = _loc1_;
            _loc13_ = _loc2_;
            _loc14_ = this.ballRadius + _loc4_;
            _loc15_ = -2 * _loc6_ * _loc8_ + _loc6_ * _loc6_ + _loc8_ * _loc8_;
            _loc16_ = -2 * _loc10_ * _loc8_ - 2 * _loc12_ * _loc6_ + 2 * _loc10_ * _loc6_ + 2 * _loc12_ * _loc8_;
            _loc17_ = -2 * _loc10_ * _loc12_ + _loc10_ * _loc10_ + _loc12_ * _loc12_;
            _loc18_ = -2 * _loc7_ * _loc9_ + _loc7_ * _loc7_ + _loc9_ * _loc9_;
            _loc19_ = -2 * _loc11_ * _loc9_ - 2 * _loc13_ * _loc7_ + 2 * _loc11_ * _loc7_ + 2 * _loc13_ * _loc9_;
            _loc20_ = -2 * _loc11_ * _loc13_ + _loc11_ * _loc11_ + _loc13_ * _loc13_;
            _loc21_ = _loc15_ + _loc18_;
            _loc22_ = _loc16_ + _loc19_;
            _loc23_ = _loc17_ + _loc20_ - _loc14_ * _loc14_;
            _loc24_ = Math.sqrt(_loc22_ * _loc22_ - 4 * _loc21_ * _loc23_);
            _loc25_ = (-_loc22_ + _loc24_) / (2 * _loc21_);
            _loc26_ = (-_loc22_ - _loc24_) / (2 * _loc21_);
            _loc27_ = null;
            _loc28_ = false;
            if(_loc25_ > 0 && _loc25_ <= 1)
            {
               _loc27_ = _loc25_;
               _loc28_ = true;
            }
            if(_loc26_ > 0 && _loc26_ <= 1)
            {
               if(_loc27_ == null || _loc26_ < _loc25_)
               {
                  _loc27_ = _loc26_;
                  _loc28_ = true;
               }
            }
            if(_loc28_)
            {
               _loc29_ = _loc51_ - _loc1_;
               _loc30_ = _loc52_ - _loc2_;
               _loc31_ = Math.atan2(_loc30_,_loc29_);
               _loc32_ = (this.ballRadius + _loc4_ + 2) * Math.cos(_loc31_);
               _loc33_ = (this.ballRadius + _loc4_ + 2) * Math.sin(_loc31_);
               this.ball.x = _loc1_ + _loc32_;
               this.ball.y = _loc2_ + _loc33_;
               _loc51_ = this.ball.x;
               _loc52_ = this.ball.y;
               _loc34_ = 1;
               _loc35_ = _loc5_;
               _loc36_ = _loc51_ - _loc1_;
               _loc37_ = _loc52_ - _loc2_;
               _loc38_ = Math.atan2(_loc37_,_loc36_);
               _loc39_ = Math.cos(_loc38_);
               _loc40_ = Math.sin(_loc38_);
               _loc41_ = _loc6_ * _loc39_ + _loc7_ * _loc40_;
               _loc42_ = _loc8_ * _loc39_ + _loc9_ * _loc40_;
               _loc43_ = _loc7_ * _loc39_ - _loc6_ * _loc40_;
               _loc44_ = _loc9_ * _loc39_ - _loc8_ * _loc40_;
               _loc45_ = _loc34_ * _loc41_ + _loc35_ * _loc42_;
               _loc46_ = _loc41_ - _loc42_;
               _loc41_ = _loc48_ = (_loc47_ = (_loc45_ + _loc34_ * _loc46_) / (_loc34_ + _loc35_)) - _loc41_ + _loc42_;
               _loc42_ = _loc47_;
               _loc6_ = _loc41_ * _loc39_ - _loc43_ * _loc40_;
               _loc7_ = _loc43_ * _loc39_ + _loc41_ * _loc40_;
               _loc49_.ballSpeedX = _loc6_;
               _loc49_.ballSpeedY = _loc7_;
               if(_loc49_.ballSpeedX > -0.1 && _loc49_.ballSpeedX < 0.1)
               {
                  if(_loc49_.ballSpeedX >= 0)
                  {
                     _loc49_.ballSpeedX = 0.1;
                  }
                  else
                  {
                     _loc49_.ballSpeedX = -0.1;
                  }
               }
               try
               {
                  _loc49_.bumpers[_loc53_].gotoAndPlay("bounce");
               }
               catch(err:Error)
               {
               }
               if(_loc49_.lastPlayedSoundOnFrame < _loc49_.gameTimer - 1)
               {
                  if(_loc3_ == "pepper" || _loc3_ == "pepperoni")
                  {
                     _loc49_.screen.gameObj.var_129.playSound("boing.wav");
                  }
                  else if(_loc3_ == "olive" || _loc3_ == "mushroom")
                  {
                     _loc49_.screen.gameObj.var_129.playSound("grabtopping.wav");
                  }
                  else
                  {
                     _loc49_.screen.gameObj.var_129.playSound("droptopping.wav");
                  }
                  _loc49_.lastPlayedSoundOnFrame = _loc49_.gameTimer;
               }
               _loc50_ = true;
            }
            _loc53_++;
         }
         return _loc50_;
      }
      
      public function getSingleRampIntersectionArray(param1:Number, param2:Number, param3:Number, param4:Number, param5:Ramp) : Array
      {
         var _loc17_:Number = NaN;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc13_:Array = [];
         var _loc14_:Number = (param5.x2 - param5.x1) * (param5.x2 - param5.x1) + (param5.y2 - param5.y1) * (param5.y2 - param5.y1);
         var _loc15_:Number = 2 * ((param5.x2 - param5.x1) * (param5.x1 - param1) + (param5.y2 - param5.y1) * (param5.y1 - param2));
         var _loc16_:Number = param1 * param1 + param2 * param2 + param5.x1 * param5.x1 + param5.y1 * param5.y1 - 2 * (param1 * param5.x1 + param2 * param5.y1) - this.ballRadius * this.ballRadius;
         _loc17_ = _loc15_ * _loc15_ - 4 * _loc14_ * _loc16_;
         if(_loc17_ > 0)
         {
            _loc6_ = Math.sqrt(_loc17_);
            _loc7_ = (-_loc15_ + _loc6_) / (2 * _loc14_);
            _loc8_ = (-_loc15_ - _loc6_) / (2 * _loc14_);
            _loc9_ = false;
            _loc10_ = false;
            if((_loc7_ < 0 || _loc7_ > 1) && (_loc8_ < 0 || _loc8_ > 1))
            {
               if(_loc7_ < 0 && _loc8_ < 0 || _loc7_ > 1 && _loc8_ > 1)
               {
                  _loc9_ = true;
               }
               else
               {
                  _loc10_ = true;
                  _loc13_.push(new Point(param5.x1,param5.y1));
                  _loc13_.push(new Point(param5.x2,param5.y2));
               }
            }
            if(!_loc9_)
            {
               if(0 < _loc8_ && _loc8_ <= 1 && !_loc10_)
               {
                  _loc11_ = Point.interpolate(new Point(param5.x1,param5.y1),new Point(param5.x2,param5.y2),1 - _loc8_);
                  _loc13_.push(_loc11_);
               }
               if(0 < _loc7_ && _loc7_ <= 1 && !_loc10_)
               {
                  _loc12_ = Point.interpolate(new Point(param5.x1,param5.y1),new Point(param5.x2,param5.y2),1 - _loc7_);
                  _loc13_.push(_loc12_);
               }
            }
         }
         return _loc13_;
      }
      
      public function checkIntersectingRamps() : Boolean
      {
         var §~~unused§:*;
         var _loc1_:Number = Number(NaN);
         var _loc2_:Ramp = null;
         var _loc3_:Array = null;
         var _loc4_:Point = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Ramp = null;
         var _loc16_:Array = null;
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:Number = Number(NaN);
         var _loc21_:Number = Number(NaN);
         var _loc22_:Number = Number(NaN);
         var _loc23_:Number = Number(NaN);
         var _loc24_:Number = Number(NaN);
         var _loc25_:Number = Number(NaN);
         var _loc26_:Number = Number(NaN);
         var _loc27_:Number = Number(NaN);
         var _loc28_:Number = Number(NaN);
         var _loc29_:Number = Number(NaN);
         var _loc30_:Number = Number(NaN);
         var _loc31_:Number = Number(NaN);
         var _loc32_:Number = Number(NaN);
         var _loc33_:Number = Number(NaN);
         var _loc34_:Number = Number(NaN);
         var _loc35_:Number = Number(NaN);
         var _loc36_:Number = Number(NaN);
         var _loc37_:Number = Number(NaN);
         var _loc38_:Number = Number(NaN);
         var _loc39_:Number = Number(NaN);
         var _loc40_:Number = Number(NaN);
         var _loc41_:Number = Number(NaN);
         var _loc42_:Number = Number(NaN);
         var _loc43_:* = undefined;
         var _loc44_:Number = Number(NaN);
         var _loc45_:Number = Number(NaN);
         var _loc46_:Number = Number(NaN);
         var _loc47_:Number = Number(NaN);
         var _loc48_:Number = Number(NaN);
         var _loc49_:Number = Number(NaN);
         var _loc50_:Number = Number(NaN);
         var _loc51_:Number = Number(NaN);
         var _loc52_:Number = Number(NaN);
         var _loc53_:Number = Number(NaN);
         var _loc54_:Number = Number(NaN);
         var _loc55_:Number = Number(NaN);
         var _loc56_:Number = Number(NaN);
         var _loc57_:Number = Number(NaN);
         var _loc58_:Number = Number(NaN);
         var _loc59_:Number = Number(NaN);
         var _loc60_:Number = Number(NaN);
         var _loc61_:Number = Number(NaN);
         var _loc62_:Number = Number(NaN);
         var _loc63_:Number = Number(NaN);
         var _loc64_:Number = Number(NaN);
         var _loc65_:Number = Number(NaN);
         var _loc66_:Number = Number(NaN);
         var _loc67_:Number = Number(NaN);
         var _loc68_:Number = Number(NaN);
         var _loc69_:Number = Number(NaN);
         var _loc70_:MiniGamePachinko = this;
         var _loc71_:Boolean = false;
         var _loc72_:Number = _loc70_.ballSpeedX;
         var _loc73_:Number = this.ball.x + _loc70_.ballSpeedX;
         var _loc74_:Number = this.ball.y + _loc70_.ballSpeedY;
         var _loc75_:Number = _loc70_.getBallSlope();
         var _loc76_:Number = _loc74_ - _loc75_ * _loc73_;
         var _loc77_:int = 0;
         while(_loc77_ < _loc70_.ramps.length)
         {
            _loc1_ = _loc77_;
            if(_loc72_ < 0)
            {
               _loc1_ = _loc70_.ramps.length - 1 - _loc77_;
            }
            _loc2_ = _loc70_.ramps[_loc77_];
            _loc3_ = _loc70_.getSingleRampIntersectionArray(_loc73_,_loc74_,_loc75_,_loc76_,_loc2_);
            _loc4_ = null;
            _loc5_ = false;
            _loc6_ = false;
            if(_loc3_.length == 1)
            {
               _loc9_ = Math.sqrt((_loc73_ - _loc2_.x1) * (_loc73_ - _loc2_.x1) + (_loc74_ - _loc2_.y1) * (_loc74_ - _loc2_.y1));
               _loc10_ = Math.sqrt((_loc73_ - _loc2_.x2) * (_loc73_ - _loc2_.x2) + (_loc74_ - _loc2_.y2) * (_loc74_ - _loc2_.y2));
               if(_loc9_ <= this.ballRadius)
               {
                  _loc7_ = new Point(_loc2_.x1,_loc2_.y1);
                  _loc8_ = new Point(_loc2_.x2,_loc2_.y2);
               }
               else
               {
                  _loc7_ = new Point(_loc2_.x2,_loc2_.y2);
                  _loc8_ = new Point(_loc2_.x1,_loc2_.y1);
               }
               _loc11_ = Math.atan2(_loc70_.ballSpeedY,_loc70_.ballSpeedX);
               _loc12_ = 1000;
               _loc13_ = _loc7_.x + _loc12_ * Math.cos(_loc11_);
               _loc14_ = _loc7_.y + _loc12_ * Math.sin(_loc11_);
               _loc15_ = new Ramp(_loc7_.x,_loc7_.y,_loc13_,_loc14_,_loc70_.defaultRampDecay);
               if((_loc16_ = _loc70_.getSingleRampIntersectionArray(_loc73_,_loc74_,_loc75_,_loc76_,_loc15_)).length == 1)
               {
                  _loc17_ = _loc73_;
                  _loc18_ = _loc74_;
                  _loc19_ = Number(_loc16_[0].x);
                  _loc20_ = Number(_loc16_[0].y);
                  _loc21_ = _loc19_ - _loc7_.x;
                  _loc22_ = _loc20_ - _loc7_.y;
                  _loc23_ = (_loc23_ = Math.sqrt(_loc21_ * _loc21_ + _loc22_ * _loc22_)) + 2;
                  _loc24_ = _loc11_ + Math.PI;
                  _loc25_ = _loc73_ + _loc23_ * Math.cos(_loc24_);
                  _loc26_ = _loc74_ + _loc23_ * Math.sin(_loc24_);
                  this.ball.x = _loc25_;
                  this.ball.y = _loc26_;
                  _loc71_ = true;
                  _loc73_ = this.ball.x;
                  _loc76_ = (_loc74_ = this.ball.y) - _loc75_ * _loc73_;
                  if(_loc2_.isFloating)
                  {
                     try
                     {
                        _loc70_.banks[_loc77_ - _loc70_.rampCoords.length + 1].gotoAndPlay("bounce");
                     }
                     catch(err:Error)
                     {
                     }
                  }
                  _loc27_ = _loc70_.ballSpeedX;
                  _loc28_ = _loc70_.ballSpeedY;
                  _loc29_ = 0;
                  _loc30_ = 0;
                  _loc31_ = 1;
                  _loc32_ = 2;
                  _loc33_ = _loc19_ - _loc73_;
                  _loc34_ = _loc20_ - _loc74_;
                  _loc35_ = Math.atan2(_loc34_,_loc33_);
                  _loc36_ = Math.cos(_loc35_);
                  _loc37_ = Math.sin(_loc35_);
                  _loc38_ = _loc27_ * _loc36_ + _loc28_ * _loc37_;
                  _loc39_ = _loc29_ * _loc36_ + _loc30_ * _loc37_;
                  _loc40_ = _loc28_ * _loc36_ - _loc27_ * _loc37_;
                  _loc41_ = _loc30_ * _loc36_ - _loc29_ * _loc37_;
                  _loc42_ = _loc31_ * _loc38_ + _loc32_ * _loc39_;
                  _loc43_ = _loc38_ - _loc39_;
                  _loc38_ = _loc45_ = (_loc44_ = (_loc42_ + _loc31_ * _loc43_) / (_loc31_ + _loc32_)) - _loc38_ + _loc39_;
                  _loc39_ = _loc44_;
                  _loc27_ = _loc38_ * _loc36_ - _loc40_ * _loc37_;
                  _loc28_ = _loc40_ * _loc36_ + _loc38_ * _loc37_;
                  _loc70_.ballSpeedX = _loc27_;
                  _loc70_.ballSpeedY = _loc28_;
                  if(_loc70_.ballSpeedX > -0.1 && _loc70_.ballSpeedX < 0.1)
                  {
                     if(_loc70_.ballSpeedX >= 0)
                     {
                        _loc70_.ballSpeedX = 0.1;
                     }
                     else
                     {
                        _loc70_.ballSpeedX = -0.1;
                     }
                  }
               }
            }
            if(_loc3_.length == 2)
            {
               _loc4_ = Point.interpolate(_loc3_[0],_loc3_[1],0.5);
            }
            if(_loc4_ != null)
            {
               _loc46_ = -1 / _loc2_.getSlope();
               _loc47_ = _loc4_.y - _loc46_ * _loc4_.x;
               if(_loc46_ == Number.POSITIVE_INFINITY)
               {
                  _loc46_ = 1000000;
               }
               else if(_loc46_ == Number.NEGATIVE_INFINITY)
               {
                  _loc46_ = -1000000;
               }
               _loc48_ = 400;
               _loc49_ = _loc46_ * _loc48_ + _loc47_;
               _loc50_ = _loc4_.x - _loc48_;
               _loc51_ = _loc4_.y - _loc49_;
               if(_loc49_ < _loc4_.y)
               {
                  _loc50_ = _loc48_ - _loc4_.x;
                  _loc51_ = _loc49_ - _loc4_.y;
               }
               if((_loc52_ = (_loc2_.getRightX() - _loc2_.getLeftX()) * (this.ball.y - _loc2_.getLeftY()) - (_loc2_.getRightY() - _loc2_.getLeftY()) * (this.ball.x - _loc2_.getLeftX())) >= 0)
               {
                  _loc50_ = _loc48_ - _loc4_.x;
                  _loc51_ = _loc49_ - _loc4_.y;
                  if(_loc49_ < _loc4_.y)
                  {
                     _loc50_ = _loc4_.x - _loc48_;
                     _loc51_ = _loc4_.y - _loc49_;
                  }
               }
               _loc53_ = Math.atan2(_loc51_,_loc50_);
               _loc54_ = this.ballRadius * Math.cos(_loc53_);
               _loc55_ = this.ballRadius * Math.sin(_loc53_);
               this.ball.x = _loc4_.x + _loc54_;
               this.ball.y = _loc4_.y + _loc55_;
               _loc71_ = true;
               _loc73_ = this.ball.x;
               _loc76_ = (_loc74_ = this.ball.y) - _loc75_ * _loc73_;
               if(_loc2_.isFloating)
               {
                  try
                  {
                     _loc70_.banks[_loc77_ - _loc70_.rampCoords.length + 1].gotoAndPlay("bounce");
                  }
                  catch(err:Error)
                  {
                  }
               }
               _loc5_ = true;
            }
            if(_loc5_)
            {
               _loc56_ = _loc2_.getAngle();
               _loc57_ = Math.cos(_loc56_);
               _loc58_ = Math.sin(_loc56_);
               _loc59_ = _loc70_.ballSpeedY;
               _loc60_ = _loc70_.ballSpeedX;
               _loc61_ = _loc59_ * _loc57_ - _loc60_ * _loc58_;
               _loc62_ = _loc60_ * _loc57_ + _loc59_ * _loc58_;
               _loc63_ = _loc2_.decay;
               _loc64_ = -_loc61_ * _loc63_;
               _loc65_ = _loc62_;
               _loc66_ = _loc64_ * _loc57_ + _loc65_ * _loc58_;
               _loc67_ = _loc65_ * _loc57_ - _loc64_ * _loc58_;
               if(_loc6_)
               {
                  _loc68_ = _loc70_.ballSpeedX;
                  _loc69_ = _loc70_.ballSpeedY;
                  _loc70_.ballSpeedX = 0.9 * _loc68_ + 0.1 * _loc67_;
                  _loc70_.ballSpeedY = 0.9 * _loc69_ + 0.1 * _loc66_;
               }
               else
               {
                  _loc70_.ballSpeedX = _loc67_;
                  _loc70_.ballSpeedY = _loc66_;
               }
            }
            _loc77_++;
         }
         return _loc71_;
      }
      
      public function radsToDegrees(param1:Number) : Number
      {
         return param1 * 180 / Math.PI;
      }
      
      public function degreesToRads(param1:Number) : Number
      {
         return param1 * Math.PI / 180;
      }
      
      override public function destroy() : void
      {
         var _loc1_:MiniGamePachinko = this;
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


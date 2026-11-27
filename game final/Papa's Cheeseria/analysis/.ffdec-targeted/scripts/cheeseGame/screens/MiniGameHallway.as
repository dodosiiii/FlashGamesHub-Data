package cheeseGame.screens
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   import package_2.*;
   
   public class MiniGameHallway extends MiniGame
   {
      
      public var lookForWhichCustomer:Number = -1;
      
      public var choseWhichDoor:Number = -1;
      
      public var whichDifficulty:Number = 1;
      
      public var doorX:Array = [0,243,397,88,552];
      
      public var doorY:Number = 232;
      
      public var doorMaxY:Number = 300;
      
      public var doorBackY:Number = 180;
      
      public var outsideCustomers:Array = [];
      
      public var outsideCustomerNumbers:Array = [];
      
      public var insideCustomers:Array = [];
      
      public var insideCustomerNumbers:Array = [];
      
      public var eyeballDirections:Array = [1,0,1,-1];
      
      public var eyeballDirY:Array = [0,0,0,0];
      
      public var eyeballYspeeds:Array = [2,2,2,2];
      
      public var eyeballSpeeds:Array = [5,4,5,4];
      
      public var eyeballDurations:Array = [0,0,0,0];
      
      public var eyeballReturning:Array = [false,false,false,false];
      
      public var maxDuration:Number = 60;
      
      public var minDuration:Number = 15;
      
      public var extraEyeDirections:Array = [1,-1,1,-1];
      
      public var extraEyeDirY:Array = [1,0,1,-1];
      
      public var extraEyeDurations:Array = [0,0,0,0];
      
      public var extraEyeSpeeds:Array = [9,8,9,8];
      
      public var extraEyeYspeeds:Array = [4,3,4,3];
      
      public var extraEyesToUse:Number = 0;
      
      public var headshot:MovieClip;
      
      public var gameTimer:Number = 0;
      
      public var timeBeforeBlack:Number = 100;
      
      public var timeBlack:Number = 180;
      
      public var delayBeforeMoving:Number = 15;
      
      public var fadeUpSpeed:Number = 0.05;
      
      public var isDoneHiding:Boolean = false;
      
      public var isHiding:Boolean = false;
      
      public var isOpened:Boolean = false;
      
      public var openedTimer:Number = 0;
      
      public var wrongDelayTimerMax:Number = 40;
      
      public var openedTimerMax:Number = 80;
      
      public var amountToUse:Number = 4;
      
      public function MiniGameHallway(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:MiniGameHallway = this;
         _loc1_.clip = new minigameHallwayMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.screen.setTitle("Hallway Hunt");
         _loc1_.setupPrizes(_loc1_.type);
         _loc1_.screen.updateStars();
         _loc1_.decideDifficulty();
         _loc1_.setupCustomers();
         _loc1_.clip.bg.gotoAndStop(Math.ceil(Math.random() * _loc1_.clip.bg.totalFrames));
         _loc1_.clip.behind.mask = _loc1_.clip.doormask;
         _loc1_.clip.btn_1.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_2.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_3.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_4.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_1.visible = false;
         _loc1_.clip.btn_2.visible = false;
         _loc1_.clip.btn_3.visible = false;
         _loc1_.clip.btn_4.visible = false;
         _loc1_.clip.darkcover.alpha = 0;
         _loc1_.clip.darkcover.mouseEnabled = false;
         _loc1_.clip.eyes_1.visible = false;
         _loc1_.clip.eyes_2.visible = false;
         _loc1_.clip.eyes_3.visible = false;
         _loc1_.clip.eyes_4.visible = false;
      }
      
      public function clickDoor(param1:MouseEvent) : void
      {
         var _loc2_:MiniGameHallway = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("_")[1]);
         _loc2_.choseWhichDoor = _loc3_;
         _loc2_.clip.btn_1.visible = false;
         _loc2_.clip.btn_2.visible = false;
         _loc2_.clip.btn_3.visible = false;
         _loc2_.clip.btn_4.visible = false;
         _loc2_.isOpened = true;
         _loc2_.clip["door_" + _loc2_.choseWhichDoor].gotoAndPlay("open");
         if(_loc2_.insideCustomerNumbers[_loc3_ - 1] == _loc2_.lookForWhichCustomer)
         {
            _loc2_.insideCustomers[_loc3_ - 1].gotoAndPlay("overjoyed1");
            _loc2_.screen.gameObj.var_129.playMusicClip("customer_overjoyed.wav");
         }
         else
         {
            _loc2_.screen.gameObj.var_129.playMusicClip("customer_decent.wav");
         }
         _loc2_.screen.gameObj.var_129.playSound("opendoor.wav");
         _loc2_.checkSuccess();
      }
      
      public function decideDifficulty() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:MiniGameHallway = this;
         var _loc4_:Number = _loc3_.getStartingLevel();
         if(_loc4_ < 14)
         {
            _loc3_.whichDifficulty = _loc4_ + 1;
         }
         else
         {
            _loc3_.whichDifficulty = prizeSKUs.length;
         }
         var _loc5_:Array = _loc3_.screen.gameObj.var_128.getCustomerPool(4,true);
         if(_loc3_.screen.gameObj.var_128.getDay() > 2)
         {
            _loc5_.push(2);
         }
         if(_loc3_.screen.gameObj.var_128.getDay() > 3)
         {
            _loc5_.push(3);
         }
         if(_loc3_.screen.gameObj.var_128.getDay() > 4)
         {
            _loc5_.push(4);
         }
         if(_loc3_.screen.gameObj.var_128.getDay() > 5)
         {
            _loc5_.push(5);
         }
         if(_loc3_.screen.gameObj.var_128.getDay() > 6)
         {
            _loc5_.push(6);
         }
         if(_loc3_.screen.gameObj.var_128.getDay() > 7)
         {
            _loc5_.push(7);
         }
         if(_loc3_.screen.gameObj.var_128.getDay() > 8)
         {
            _loc5_.push(1);
         }
         _loc3_.amountToUse = 4;
         _loc3_.extraEyesToUse = 0;
         if(_loc3_.whichDifficulty == 1)
         {
            _loc3_.amountToUse = 2;
            _loc3_.timeBlack = 120;
            _loc3_.eyeballSpeeds = [4,3,4,3];
            _loc3_.eyeballYspeeds = [2,2,2,2];
         }
         else if(_loc3_.whichDifficulty == 2)
         {
            _loc3_.amountToUse = 4;
            _loc3_.timeBlack = 150;
            _loc3_.eyeballSpeeds = [6,5,6,5];
            _loc3_.eyeballYspeeds = [3,3,3,3];
         }
         else if(_loc3_.whichDifficulty == 3)
         {
            _loc3_.amountToUse = 4;
            _loc3_.timeBlack = 180;
            _loc3_.eyeballSpeeds = [7,6,7,6];
            _loc3_.eyeballYspeeds = [3,3,3,3];
         }
         else
         {
            _loc3_.amountToUse = 4;
            _loc3_.timeBlack = 180;
            _loc3_.eyeballSpeeds = [9,8,9,8];
            _loc3_.eyeballYspeeds = [4,3,4,3];
            if(_loc3_.whichDifficulty == 4)
            {
               _loc3_.extraEyesToUse = 0;
            }
            else if(_loc3_.whichDifficulty == 5)
            {
               _loc3_.extraEyesToUse = 1;
            }
            else if(_loc3_.whichDifficulty == 6)
            {
               _loc3_.extraEyesToUse = 2;
            }
            else if(_loc3_.whichDifficulty == 7)
            {
               _loc3_.extraEyesToUse = 3;
            }
            else
            {
               _loc3_.extraEyesToUse = 4;
            }
         }
         var _loc6_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = Math.floor(Math.random() * _loc5_.length);
            _loc6_.push(_loc5_[_loc2_]);
            _loc5_.splice(_loc2_,1);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            if(Math.random() > 0.5)
            {
               _loc3_.outsideCustomerNumbers.push(_loc6_[_loc1_]);
            }
            else
            {
               _loc3_.outsideCustomerNumbers.unshift(_loc6_[_loc1_]);
            }
            if(Math.random() > 0.5)
            {
               _loc3_.insideCustomerNumbers.push(_loc6_[_loc1_]);
            }
            else
            {
               _loc3_.insideCustomerNumbers.unshift(_loc6_[_loc1_]);
            }
            _loc1_++;
         }
         _loc3_.lookForWhichCustomer = _loc3_.outsideCustomerNumbers[Math.floor(Math.random() * _loc3_.amountToUse)];
      }
      
      public function clearCustomers() : void
      {
         var §~~unused§:*;
         var _loc1_:Number = Number(NaN);
         var _loc2_:MiniGameHallway = this;
         class_7.method_1("Clear customers.");
         _loc1_ = 0;
         while(_loc1_ < _loc2_.outsideCustomers.length)
         {
            _loc2_.clearCustomer(_loc2_.outsideCustomers[_loc1_]);
            try
            {
               _loc2_.outsideCustomers[_loc1_].parent.removeChild(_loc2_.outsideCustomers[_loc1_]);
            }
            catch(err:Error)
            {
            }
            _loc2_.outsideCustomers[_loc1_] = null;
            _loc1_++;
         }
         _loc2_.outsideCustomers = null;
         _loc2_.outsideCustomerNumbers = null;
         _loc2_.outsideCustomers = [];
         _loc2_.outsideCustomerNumbers = [];
         _loc1_ = 0;
         while(_loc1_ < _loc2_.insideCustomers.length)
         {
            _loc2_.clearCustomer(_loc2_.insideCustomers[_loc1_]);
            try
            {
               _loc2_.insideCustomers[_loc1_].parent.removeChild(_loc2_.insideCustomers[_loc1_]);
            }
            catch(err:Error)
            {
            }
            _loc2_.insideCustomers[_loc1_] = null;
            _loc1_++;
         }
         _loc2_.insideCustomers = null;
         _loc2_.insideCustomerNumbers = null;
         _loc2_.insideCustomers = [];
         _loc2_.insideCustomerNumbers = [];
         if(_loc2_.headshot != null)
         {
            _loc2_.clearCustomer(_loc2_.headshot);
            _loc2_.clip.headshotholder.removeChild(_loc2_.headshot);
            _loc2_.headshot = null;
         }
      }
      
      public function setupCustomers() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MiniGameHallway = this;
         _loc1_ = 0;
         while(_loc1_ < _loc4_.outsideCustomerNumbers.length)
         {
            _loc2_ = _loc4_.buildCustomer(_loc4_.outsideCustomerNumbers[_loc1_]);
            _loc4_.clip["front_" + (_loc1_ + 1)].addChild(_loc2_);
            if(_loc4_.amountToUse > _loc1_)
            {
               _loc4_.clip["front_" + (_loc1_ + 1)].visible = true;
            }
            else
            {
               _loc4_.clip["front_" + (_loc1_ + 1)].visible = false;
            }
            _loc4_.outsideCustomers.push(_loc2_);
            if(_loc1_ == 0 || _loc1_ == 2)
            {
               _loc2_.gotoAndPlay("portrait");
            }
            else
            {
               _loc2_.gotoAndPlay("stand");
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.insideCustomerNumbers.length)
         {
            _loc3_ = _loc4_.buildCustomer(_loc4_.insideCustomerNumbers[_loc1_]);
            _loc4_.insideCustomers.push(_loc3_);
            if(_loc4_.insideCustomerNumbers[_loc1_] != _loc4_.lookForWhichCustomer)
            {
               if(Math.random() > 0.7)
               {
                  _loc3_.gotoAndPlay("readpaper1");
                  _loc3_.book.gotoAndStop("newspaper");
               }
               else if(Math.random() > 0.4)
               {
                  _loc3_.gotoAndPlay("drinkcoffee1");
                  _loc3_.mug.gotoAndStop("coffee");
               }
               else if(Math.random() > 0.2)
               {
                  _loc3_.gotoAndPlay("dance2_1");
               }
               else if(Math.random() > 0.1)
               {
                  _loc3_.gotoAndPlay("dance3_1");
               }
               else
               {
                  _loc3_.gotoAndPlay("dance1_1");
               }
            }
            else
            {
               _loc3_.gotoAndPlay("stand1_1");
            }
            _loc1_++;
         }
         _loc4_.headshot = _loc4_.buildCustomer(_loc4_.lookForWhichCustomer,true);
         _loc4_.clip.headshotholder.addChild(_loc4_.headshot);
         _loc4_.clip.customername_txt.text = _loc4_.screen.gameObj.var_130.getCustomerName(_loc4_.lookForWhichCustomer) + "?";
         _loc4_.clip.arrow.x = _loc4_.doorX[_loc4_.outsideCustomerNumbers.indexOf(_loc4_.lookForWhichCustomer) + 1];
         _loc4_.clip.arrow.visible = true;
      }
      
      public function checkSuccess() : void
      {
         var _loc1_:MiniGameHallway = this;
         if(_loc1_.insideCustomerNumbers[_loc1_.choseWhichDoor - 1] == _loc1_.lookForWhichCustomer)
         {
            _loc1_.decidePrize();
         }
         else
         {
            _loc1_.skuToWin = null;
            _loc1_.amountToWin = 0;
            _loc1_.skuIsClothing = false;
            _loc1_.skuClothingMode = "";
         }
      }
      
      override public function updateScreen() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Number = Number(NaN);
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MiniGameHallway = this;
         ++_loc8_.gameTimer;
         if(_loc8_.gameTimer == _loc8_.timeBeforeBlack)
         {
            _loc8_.startWalking();
         }
         else if(_loc8_.isDoneHiding)
         {
            if(_loc8_.clip.darkcover.alpha == 1)
            {
               _loc8_.clip.eyes_1.visible = false;
               _loc8_.clip.eyes_2.visible = false;
               _loc8_.clip.eyes_3.visible = false;
               _loc8_.clip.eyes_4.visible = false;
               _loc8_.clip.extraeyes_1.visible = false;
               _loc8_.clip.extraeyes_2.visible = false;
               _loc8_.clip.extraeyes_3.visible = false;
               _loc8_.clip.extraeyes_4.visible = false;
               _loc8_.clip.btn_1.visible = true;
               _loc8_.clip.btn_2.visible = true;
               _loc8_.clip.btn_3.visible = true;
               _loc8_.clip.btn_4.visible = true;
               _loc1_ = 0;
               while(_loc1_ < 4)
               {
                  _loc8_.clip.behind["back_" + (_loc1_ + 1)].addChild(_loc8_.insideCustomers[_loc1_]);
                  _loc1_++;
               }
            }
            if(_loc8_.clip.darkcover.alpha > 0)
            {
               _loc8_.clip.darkcover.alpha -= _loc8_.fadeUpSpeed;
            }
         }
         else if(_loc8_.isHiding && _loc8_.gameTimer > _loc8_.timeBeforeBlack + _loc8_.delayBeforeMoving)
         {
            _loc2_ = 0;
            _loc3_ = false;
            if(_loc8_.gameTimer > _loc8_.timeBeforeBlack + _loc8_.timeBlack)
            {
               _loc3_ = true;
            }
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _loc5_ = _loc8_.insideCustomerNumbers.indexOf(_loc8_.outsideCustomerNumbers[_loc4_]) + 1;
               _loc6_ = _loc8_.clip["eyes_" + (_loc4_ + 1)];
               _loc6_.x += _loc8_.eyeballDirections[_loc4_] * _loc8_.eyeballSpeeds[_loc4_];
               _loc6_.y += _loc8_.eyeballDirY[_loc4_] * _loc8_.eyeballYspeeds[_loc4_];
               ++_loc8_.eyeballDurations[_loc4_];
               if(_loc6_.x < 10 && _loc8_.eyeballDirections[_loc4_] == -1)
               {
                  _loc6_.x = 10;
                  _loc8_.eyeballDirections[_loc4_] = 1;
               }
               else if(_loc6_.x > 630 && _loc8_.eyeballDirections[_loc4_] == 1)
               {
                  _loc6_.x = 630;
                  _loc8_.eyeballDirections[_loc4_] = -1;
               }
               if(_loc6_.y < _loc8_.doorY && (_loc8_.eyeballReturning[_loc4_] == false || _loc6_.x != _loc8_.doorX[_loc5_]))
               {
                  _loc6_.y = _loc8_.doorY;
                  _loc8_.eyeballDirY[_loc4_] = 0;
                  if(_loc8_.eyeballDirections[_loc4_] == 0)
                  {
                     _loc6_.inside.stop();
                  }
               }
               else if(_loc6_.y > _loc8_.doorMaxY)
               {
                  _loc6_.y = _loc8_.doorMaxY;
                  _loc8_.eyeballDirY[_loc4_] = 0;
                  if(_loc8_.eyeballDirections[_loc4_] == 0)
                  {
                     _loc6_.inside.stop();
                  }
               }
               if(_loc8_.eyeballReturning[_loc4_] == false && _loc8_.eyeballDurations[_loc4_] > _loc8_.maxDuration || _loc8_.eyeballReturning[_loc4_] == false && _loc8_.eyeballDurations[_loc4_] > _loc8_.minDuration && Math.random() > 0.9 || _loc3_ && _loc8_.eyeballReturning[_loc4_] == false)
               {
                  _loc8_.eyeballDirections[_loc4_] = Math.round(Math.random() * 2) - 1;
                  _loc8_.eyeballDirY[_loc4_] = Math.round(Math.random() * 2) - 1;
                  if(_loc8_.whichDifficulty >= 4 && _loc8_.eyeballDirections[_loc4_] == 0)
                  {
                     if(Math.random() > 0.5)
                     {
                        _loc8_.eyeballDirections[_loc4_] = -1;
                     }
                     else
                     {
                        _loc8_.eyeballDirections[_loc4_] = 1;
                     }
                  }
                  _loc8_.eyeballDurations[_loc4_] = 0;
                  if(_loc3_)
                  {
                     _loc8_.eyeballReturning[_loc4_] = true;
                     _loc8_.eyeballDirY[_loc4_] = -1;
                     if(_loc8_.doorX[_loc5_] > _loc6_.x)
                     {
                        _loc8_.eyeballDirections[_loc4_] = 1;
                     }
                     else if(_loc8_.doorX[_loc5_] < _loc6_.x)
                     {
                        _loc8_.eyeballDirections[_loc4_] = -1;
                     }
                     else
                     {
                        _loc8_.eyeballDirections[_loc4_] = 0;
                     }
                     if(_loc4_ >= _loc8_.amountToUse)
                     {
                        _loc6_.x = _loc8_.doorX[_loc5_];
                     }
                  }
               }
               else if(_loc8_.eyeballReturning[_loc4_] == true)
               {
                  if(_loc8_.eyeballDirections[_loc4_] == 1 && _loc6_.x > _loc8_.doorX[_loc5_])
                  {
                     _loc6_.x = _loc8_.doorX[_loc5_];
                     _loc8_.eyeballDirections[_loc4_] = 0;
                  }
                  else if(_loc8_.eyeballDirections[_loc4_] == -1 && _loc6_.x < _loc8_.doorX[_loc5_])
                  {
                     _loc6_.x = _loc8_.doorX[_loc5_];
                     _loc8_.eyeballDirections[_loc4_] = 0;
                  }
                  else if(_loc6_.x == _loc8_.doorX[_loc5_])
                  {
                     _loc8_.eyeballDirections[_loc4_] = 0;
                     if(_loc6_.y > _loc8_.doorBackY)
                     {
                        _loc6_.y -= _loc8_.eyeballSpeeds[_loc4_];
                     }
                     else
                     {
                        if(_loc4_ < _loc8_.amountToUse && _loc6_.visible == true)
                        {
                           _loc8_.screen.gameObj.var_129.playSound("closedoor.wav");
                        }
                        _loc6_.visible = false;
                        _loc6_.inside.stop();
                        _loc2_++;
                     }
                  }
               }
               if(_loc8_.eyeballDirections[_loc4_] == 0 && _loc8_.eyeballDirY[_loc4_] == 0)
               {
                  _loc6_.inside.stop();
               }
               else
               {
                  _loc6_.inside.play();
               }
               _loc7_ = _loc8_.clip["extraeyes_" + (_loc4_ + 1)];
               _loc7_.x += _loc8_.extraEyeDirections[_loc4_] * _loc8_.extraEyeSpeeds[_loc4_];
               _loc7_.y += _loc8_.extraEyeDirY[_loc4_] * _loc8_.extraEyeYspeeds[_loc4_];
               ++_loc8_.extraEyeDurations[_loc4_];
               if(_loc8_.gameTimer < _loc8_.timeBeforeBlack + _loc8_.timeBlack)
               {
                  if(_loc7_.x < 10 && _loc8_.extraEyeDirections[_loc4_] == -1)
                  {
                     _loc7_.x = 10;
                     _loc8_.extraEyeDirections[_loc4_] = 1;
                  }
                  else if(_loc6_.x > 630 && _loc8_.extraEyeDirections[_loc4_] == 1)
                  {
                     _loc7_.x = 630;
                     _loc8_.extraEyeDirections[_loc4_] = -1;
                  }
               }
               if(_loc7_.y < _loc8_.doorY)
               {
                  _loc7_.y = _loc8_.doorY;
                  _loc8_.extraEyeDirY[_loc4_] = 0;
                  if(_loc8_.extraEyeDirections[_loc4_] == 0)
                  {
                     _loc7_.inside.stop();
                  }
               }
               else if(_loc7_.y > _loc8_.doorMaxY)
               {
                  _loc7_.y = _loc8_.doorMaxY;
                  _loc8_.extraEyeDirY[_loc4_] = 0;
                  if(_loc8_.extraEyeDirections[_loc4_] == 0)
                  {
                     _loc7_.inside.stop();
                  }
               }
               if(_loc7_.x > 10 && _loc7_.x < 630 && _loc8_.gameTimer < _loc8_.timeBeforeBlack + _loc8_.timeBlack && (_loc8_.extraEyeDurations[_loc4_] > _loc8_.maxDuration || _loc8_.extraEyeDurations[_loc4_] > _loc8_.minDuration && Math.random() > 0.9))
               {
                  _loc8_.extraEyeDirY[_loc4_] = Math.round(Math.random() * 2) - 1;
                  if(Math.random() > 0.5)
                  {
                     _loc8_.extraEyeDirections[_loc4_] = -1;
                  }
                  else
                  {
                     _loc8_.extraEyeDirections[_loc4_] = 1;
                  }
                  _loc8_.extraEyeDurations[_loc4_] = 0;
               }
               if(_loc3_)
               {
                  if(_loc7_.visible && (_loc7_.x < 0 || _loc7_.x > 640))
                  {
                     _loc2_++;
                  }
               }
               _loc4_++;
            }
            if(_loc2_ == 4 + _loc8_.extraEyesToUse)
            {
               _loc8_.isHiding = false;
               _loc8_.isDoneHiding = true;
            }
         }
         if(_loc8_.isOpened)
         {
            ++_loc8_.openedTimer;
            if(_loc8_.openedTimer == _loc8_.wrongDelayTimerMax && _loc8_.choseWhichDoor != _loc8_.insideCustomerNumbers.indexOf(_loc8_.lookForWhichCustomer) + 1)
            {
               _loc8_.clip["door_" + (_loc8_.insideCustomerNumbers.indexOf(_loc8_.lookForWhichCustomer) + 1)].gotoAndPlay("open");
               _loc8_.insideCustomers[_loc8_.insideCustomerNumbers.indexOf(_loc8_.lookForWhichCustomer)].gotoAndPlay("decent1");
            }
            else if(_loc8_.openedTimer == _loc8_.openedTimerMax)
            {
               _loc8_.screen.finishMiniGame(_loc8_.skuToWin,_loc8_.amountToWin,_loc8_.skuIsClothing,_loc8_.skuClothingMode);
               ++_loc8_.openedTimer;
            }
         }
      }
      
      public function startWalking() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:MiniGameHallway = this;
         _loc2_.isHiding = true;
         _loc2_.clip.darkcover.alpha = 1;
         _loc2_.clip.arrow.visible = false;
         _loc2_.clip.front_1.visible = false;
         _loc2_.clip.front_2.visible = false;
         _loc2_.clip.front_3.visible = false;
         _loc2_.clip.front_4.visible = false;
         _loc2_.clip.eyes_1.visible = true;
         _loc2_.clip.eyes_1.inside.stop();
         _loc2_.clip.eyes_1.x = _loc2_.doorX[1];
         _loc2_.clip.eyes_1.y = _loc2_.doorY;
         if(_loc2_.amountToUse >= 2)
         {
            _loc2_.clip.eyes_2.visible = true;
         }
         _loc2_.clip.eyes_2.inside.stop();
         _loc2_.clip.eyes_2.x = _loc2_.doorX[2];
         _loc2_.clip.eyes_2.y = _loc2_.doorY;
         if(_loc2_.amountToUse >= 3)
         {
            _loc2_.clip.eyes_3.visible = true;
         }
         _loc2_.clip.eyes_3.inside.stop();
         _loc2_.clip.eyes_3.x = _loc2_.doorX[3];
         _loc2_.clip.eyes_3.y = _loc2_.doorY;
         if(_loc2_.amountToUse >= 4)
         {
            _loc2_.clip.eyes_4.visible = true;
         }
         _loc2_.clip.eyes_4.inside.stop();
         _loc2_.clip.eyes_4.x = _loc2_.doorX[4];
         _loc2_.clip.eyes_4.y = _loc2_.doorY;
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = Math.round(Math.random() * 2) - 1;
            _loc2_.eyeballDirections[_loc3_] = _loc1_;
            _loc2_.eyeballReturning[_loc3_] = false;
            _loc2_.eyeballDirY[_loc3_] = Math.round(Math.random() * 1);
            _loc2_.clip["eyes_" + (_loc3_ + 1)].inside.stop();
            _loc3_++;
         }
         if(_loc2_.whichDifficulty > 3 && _loc2_.whichDifficulty % 2 == 0)
         {
            _loc2_.eyeballDirections = [-1,1,1,-1];
         }
         else if(_loc2_.whichDifficulty > 3)
         {
            _loc2_.eyeballDirections = [1,-1,1,-1];
         }
         var _loc4_:int = 1;
         while(_loc4_ <= 4)
         {
            if(_loc2_.extraEyesToUse >= _loc4_)
            {
               _loc2_.clip["extraeyes_" + _loc4_].visible = true;
            }
            else
            {
               _loc2_.clip["extraeyes_" + _loc4_].visible = false;
            }
            _loc4_++;
         }
         _loc2_.screen.gameObj.var_129.playSound("minigame_noammo.wav");
      }
      
      public function buildCustomer(param1:Number, param2:Boolean = false) : MovieClip
      {
         var §~~unused§:*;
         var _loc10_:MovieClip = null;
         var _loc11_:Class = null;
         var _loc12_:MovieClip = null;
         var _loc13_:Class = null;
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         var _loc17_:Class = null;
         var _loc18_:MovieClip = null;
         var _loc19_:MovieClip = null;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:MovieClip = null;
         var _loc23_:Class = null;
         var _loc24_:MovieClip = null;
         var _loc25_:MovieClip = null;
         var _loc26_:Class = null;
         var _loc27_:MovieClip = null;
         var _loc28_:Number = NaN;
         var _loc3_:Class = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Class = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MiniGameHallway = this;
         var _loc8_:MovieClip = new customerMC();
         var _loc9_:String = _loc7_.screen.gameObj.var_130.getCustomerClipName(param1);
         (_loc10_ = new (_loc11_ = getDefinitionByName("customer_" + _loc9_ + "_body") as Class)()).name = "clip";
         _loc8_.body.addChild(_loc10_);
         (_loc12_ = new (_loc13_ = getDefinitionByName("customer_" + _loc9_ + "_head") as Class)()).name = "clip";
         _loc8_.head.addChild(_loc12_);
         (_loc14_ = screen.gameObj.var_130.getCustomerPart(_loc9_,"eyes",screen.gameObj.var_128.getHolidayMonth())).name = "clip";
         _loc8_.eyes.addChild(_loc14_);
         (_loc15_ = screen.gameObj.var_130.getCustomerPart(_loc9_,"mouth",screen.gameObj.var_128.getHolidayMonth())).name = "clip";
         _loc8_.mouth.addChild(_loc15_);
         (_loc16_ = new (_loc17_ = getDefinitionByName("customer_" + _loc9_ + "_neck") as Class)()).name = "clip";
         _loc8_.neck.addChild(_loc16_);
         try
         {
            (_loc4_ = new (_loc3_ = getDefinitionByName("customer_" + _loc9_ + "_hair") as Class)()).name = "clip";
            _loc8_.hair.addChild(_loc4_);
         }
         catch(err:Error)
         {
         }
         try
         {
            (_loc6_ = new (_loc5_ = getDefinitionByName("customer_" + _loc9_ + "_back_hair") as Class)()).name = "clip";
            _loc8_.back_hair.addChild(_loc6_);
         }
         catch(err:Error)
         {
         }
         (_loc18_ = screen.gameObj.var_130.getCustomerPart(_loc9_,"foot",screen.gameObj.var_128.getHolidayMonth())).name = "clip";
         _loc8_.front_shoe.addChild(_loc18_);
         (_loc19_ = screen.gameObj.var_130.getCustomerPart(_loc9_,"foot",screen.gameObj.var_128.getHolidayMonth())).name = "clip";
         _loc8_.back_shoe.addChild(_loc19_);
         (_loc20_ = screen.gameObj.var_130.getCustomerPart(_loc9_,"hand",screen.gameObj.var_128.getHolidayMonth())).name = "clip";
         _loc8_.fronthand.addChild(_loc20_);
         (_loc21_ = screen.gameObj.var_130.getCustomerPart(_loc9_,"hand2",screen.gameObj.var_128.getHolidayMonth())).name = "clip";
         _loc8_.backhand.addChild(_loc21_);
         (_loc22_ = new (_loc23_ = getDefinitionByName("customer_" + _loc9_ + "_upperarm") as Class)()).name = "clip";
         _loc8_.front_upperarm.addChild(_loc22_);
         (_loc24_ = new _loc23_()).name = "clip";
         _loc8_.back_upperarm.addChild(_loc24_);
         (_loc25_ = new (_loc26_ = getDefinitionByName("customer_" + _loc9_ + "_forearm") as Class)()).name = "clip";
         _loc8_.front_forearm.addChild(_loc25_);
         (_loc27_ = new _loc26_()).name = "clip";
         _loc8_.back_forearm.addChild(_loc27_);
         if((_loc28_ = _loc7_.screen.gameObj.var_130.getCustomerHolidayOutfitMonth(param1)) > 0 && _loc7_.screen.gameObj.var_128.getMonth() == _loc28_)
         {
            _loc10_.gotoAndStop(2);
            _loc22_.gotoAndStop(2);
            _loc24_.gotoAndStop(2);
            _loc25_.gotoAndStop(2);
            _loc27_.gotoAndStop(2);
            _loc16_.gotoAndStop(2);
            _loc12_.gotoAndStop(2);
            if(_loc4_)
            {
               _loc4_.gotoAndStop(2);
            }
            if(_loc6_)
            {
               _loc6_.gotoAndStop(2);
            }
         }
         else
         {
            _loc10_.gotoAndStop(1);
            _loc22_.gotoAndStop(1);
            _loc24_.gotoAndStop(1);
            _loc25_.gotoAndStop(1);
            _loc27_.gotoAndStop(1);
            _loc16_.gotoAndStop(1);
            _loc12_.gotoAndStop(1);
            if(_loc4_)
            {
               _loc4_.gotoAndStop(1);
            }
            if(_loc6_)
            {
               _loc6_.gotoAndStop(1);
            }
         }
         if(param2)
         {
            _loc18_.visible = false;
            _loc19_.visible = false;
            _loc10_.visible = false;
            _loc20_.visible = false;
            _loc21_.visible = false;
            _loc22_.visible = false;
            _loc24_.visible = false;
            _loc25_.visible = false;
            _loc27_.visible = false;
            _loc16_.visible = false;
            _loc8_.gotoAndStop("stand");
         }
         else
         {
            _loc8_.gotoAndPlay("stand");
         }
         return _loc8_;
      }
      
      public function clearCustomer(param1:MovieClip) : void
      {
         try
         {
            param1.stop();
            param1.head.removeChildAt(0);
            param1.eyes.removeChildAt(0);
            param1.mouth.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.body.removeChildAt(0);
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
      }
      
      override public function destroy() : void
      {
         var _loc1_:MiniGameHallway = this;
         _loc1_.clearCustomers();
         _loc1_.clip.btn_1.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_2.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_3.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.clip.btn_4.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickDoor);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}


package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   import flash.media.SoundChannel;
   import package_2.*;
   import package_4.class_5;
   
   public class GiveOrderScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var isActive:Boolean = false;
      
      public var customerScale:Number = 1;
      
      public var customerX:Number = 245;
      
      public var customerY:Number = 109;
      
      public var trayScale:Number = 0.6;
      
      public var trayX:Number = 140;
      
      public var trayY:Number = 319;
      
      public var trayStartX:Number = -400;
      
      public var whichStep:Number = -1;
      
      public var stepTimer:Number = 0;
      
      public var lastStepTime:Number = 0;
      
      public var shorterTimingSpacing:Number = 20;
      
      public var timingSpacing:Number = 60;
      
      public var useTimingSpacing:Number = 120;
      
      public var isPresentingOrder:Boolean = false;
      
      public var currentTicket:Ticket;
      
      public var currentCustomer:Customer;
      
      public var customerReaction:String;
      
      public var customerReactionNumber:Number = 1;
      
      public var workerReactionTimer:Number = 0;
      
      public var workerReactionTimerMax:Number = 26;
      
      public var shouldShowWorkerReaction:Boolean = false;
      
      public var currentStep:String = "look";
      
      public var waitTimer:Number = 0;
      
      public var currentWaitMax:Number = 90;
      
      public var waitLookMax:Number = 70;
      
      public var waitBubblesMax:Number = 30;
      
      public var waitReactMax:Number = 45;
      
      public var waitTipMax:Number = 30;
      
      public var waitTipTotalMax:Number = 60;
      
      public var waitEndingMax:Number = 60;
      
      public var seal0WaitPercent:Number = 1;
      
      public var seal1WaitPercent:Number = 0.8;
      
      public var seal2WaitPercent:Number = 0.6;
      
      public var seal3WaitPercent:Number = 0.4;
      
      public var useWaitPercent:Number = 1;
      
      public var waitScore:Number = 0;
      
      public var cookScore:Number = 0;
      
      public var buildScore:Number = 0;
      
      public var fryScore:Number = 0;
      
      public var buildHadParticlesOff:Boolean = false;
      
      public var totalScore:Number = 0;
      
      public var closerCutoff:Number = 60;
      
      public var maxTip:Number = 300;
      
      public var extraTipPerBadge:Number = 100;
      
      public var extraTipForRibbon:Number = 200;
      
      public var extraPercentagePerBadge:Number = 0.333;
      
      public var extraTipPerClothingItem:Number = 25;
      
      public var earnStarNumber:Number = 0;
      
      public var loseStarNumber:Number = 0;
      
      public var coinFrame:Number = 0;
      
      public var earnTicketAmount:Number = 0;
      
      public var idealWaitBeforeOrder:Number = 750;
      
      public var idealWaitForOrderBuffer:Number = 1800;
      
      public var timeDivisions:Number = 8;
      
      public var drumrollSound:SoundChannel;
      
      public var backdropBitmap:Bitmap = null;
      
      public var countertopMC:MovieClip = null;
      
      public var prizeTicketSpeed:Number = 18;
      
      public var prizeTickets:Array;
      
      public var shouldAnimateTickets:Boolean = false;
      
      public var ticketsEarned:Number = 0;
      
      public var maxTicketsToEarn:Number = 3;
      
      public var targetMeterPercent:Number = 0;
      
      public var meterSpeed:Number = 0.025;
      
      public var shouldAnimateMeter:Boolean = false;
      
      public var didMakeSpecialProgress:Boolean = false;
      
      public var didMasterSpecial:Boolean = false;
      
      public var chickenPiece:MovieClip = null;
      
      public var worker:Worker = null;
      
      public var reactions_overjoyed:Array;
      
      public var reactions_happy:Array;
      
      public var reactions_decent:Array;
      
      public var reactions_worried:Array;
      
      public var reactions_upset:Array;
      
      public var reactions_pissed:Array;
      
      public var newSpecialLogo:BitmapData = null;
      
      public var newSpecialBitmap:Bitmap = null;
      
      public var shouldEarnSpecial:Boolean = false;
      
      public function GiveOrderScreen(param1:class_5)
      {
         this.prizeTickets = [];
         this.reactions_overjoyed = [1,2,3,4,5];
         this.reactions_happy = [1,2,3,4,5];
         this.reactions_decent = [1,2];
         this.reactions_worried = [1];
         this.reactions_upset = [1];
         this.reactions_pissed = [1,2,3];
         super();
         var _loc2_:GiveOrderScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:GiveOrderScreen = this;
         _loc1_.clip = new giveOrderMC();
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.workerData,-40,192,1.14,true);
         _loc1_.clip.ticketmeter.bar.mask = _loc1_.clip.ticketmeter.masker;
         _loc1_.clip.ticketmeter.bar.scaleX = 0;
         _loc1_.clip.ticketmeter.ball1.gotoAndStop(1);
         _loc1_.clip.ticketmeter.ball2.gotoAndStop(1);
         _loc1_.clip.ticketmeter.ball3.gotoAndStop(1);
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GiveOrderScreen = this;
         _loc2_.worker.destroy();
         _loc2_.worker = null;
         if(_loc2_.newSpecialLogo)
         {
            _loc2_.newSpecialLogo.dispose();
            _loc2_.newSpecialLogo = null;
         }
         if(_loc2_.newSpecialBitmap)
         {
            if(_loc2_.newSpecialBitmap.parent)
            {
               _loc2_.newSpecialBitmap.parent.removeChild(_loc2_.newSpecialBitmap);
            }
            _loc2_.newSpecialBitmap.bitmapData = null;
            _loc2_.newSpecialBitmap = null;
         }
         if(_loc2_.countertopMC != null)
         {
            _loc2_.clip.countertop.removeChild(_loc2_.countertopMC);
            _loc2_.countertopMC = null;
         }
         if(_loc2_.prizeTickets.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.prizeTickets.length)
            {
               try
               {
                  _loc2_.clip.gameticketholder.removeChild(_loc2_.prizeTickets[_loc1_]);
                  _loc2_.prizeTickets[_loc1_] = null;
               }
               catch(err:Error)
               {
               }
               _loc1_++;
            }
            _loc2_.prizeTickets = null;
         }
         if(_loc2_.backdropBitmap != null)
         {
            _loc2_.backdropBitmap.bitmapData.dispose();
            try
            {
               _loc2_.clip.backdrop_holder.removeChild(_loc2_.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            _loc2_.backdropBitmap = null;
         }
         if(_loc2_.drumrollSound)
         {
            _loc2_.drumrollSound.stop();
            _loc2_.drumrollSound = null;
         }
         if(_loc2_.gameObj.var_138.contains(_loc2_.clip))
         {
            _loc2_.gameObj.var_138.removeChild(_loc2_.clip);
         }
         _loc2_.clip = null;
      }
      
      public function addPrizeTickets(param1:Number = 1) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:GiveOrderScreen = this;
         if(param1 > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1)
            {
               _loc3_ = new game_ticket_counter();
               _loc3_.x = -3 + Math.floor(Math.random() * 7);
               _loc3_.y = -366 - _loc2_ * 50;
               _loc4_.prizeTickets.push(_loc3_);
               _loc4_.clip.gameticketholder.addChild(_loc3_);
               _loc2_++;
            }
            _loc4_.shouldAnimateTickets = true;
         }
      }
      
      public function getOtherScreen() : GiveOrderScreen
      {
         var _loc1_:GiveOrderScreen = this;
         class_7.method_1("(with Dining Room)");
         return _loc1_.gameObj.var_195;
      }
      
      public function syncPrizeMeters() : void
      {
         var otherScreen:GiveOrderScreen = null;
         var i:int = 0;
         var targetTickets:Number = Number(NaN);
         var targetPercent:Number = Number(NaN);
         var diff:Number = Number(NaN);
         var screen:GiveOrderScreen = this;
         class_7.method_1("Sync Prize Meters");
         try
         {
            otherScreen = screen.getOtherScreen();
            if(otherScreen != null)
            {
               targetTickets = screen.gameObj.var_128.todayTickets;
               targetPercent = screen.gameObj.var_128.getCurrentPercentQuality(screen.gameObj.var_134.customerLineup.length);
               if(otherScreen.prizeTickets.length < targetTickets)
               {
                  diff = targetTickets - otherScreen.prizeTickets.length;
                  otherScreen.addPrizeTickets(diff);
               }
               otherScreen.clip.ticketmeter.bar.scaleX = targetPercent / 100;
               if(otherScreen.clip.ticketmeter.bar.scaleX >= 0.3)
               {
                  otherScreen.clip.ticketmeter.ball1.gotoAndPlay("earn");
               }
               if(otherScreen.clip.ticketmeter.bar.scaleX >= 0.6)
               {
                  otherScreen.clip.ticketmeter.ball2.gotoAndPlay("earn");
               }
               if(otherScreen.clip.ticketmeter.bar.scaleX >= 0.9)
               {
                  otherScreen.clip.ticketmeter.ball3.gotoAndPlay("earn");
               }
            }
         }
         catch(err:Error)
         {
            class_7.error("Error syncing prize meters: " + err.message);
         }
      }
      
      public function activateScreen() : void
      {
         var _loc1_:GiveOrderScreen = this;
         if(!_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         }
         var _loc2_:FoodOrder = _loc1_.gameObj.var_131.currentOrder;
         _loc1_.currentCustomer = _loc1_.gameObj.var_134.getWaitingCustomer(_loc2_.attachedTicket.customerType);
         _loc1_.currentCustomer.moveToReceiveOrder();
         _loc2_.moveToGiveOrder(_loc1_.clip.plate_holder);
         _loc1_.shouldAnimateMeter = false;
         _loc1_.shouldShowWorkerReaction = false;
         _loc1_.clip.tipjar.gotoAndStop(1);
         _loc1_.clip.tips.gotoAndStop(1);
         _loc1_.clip.starburst.gotoAndStop(1);
         _loc1_.adjustJarCoins();
         _loc1_.startPresentation();
         _loc1_.gameObj.var_129.switchMusic("none");
         _loc1_.drumrollSound = _loc1_.gameObj.var_129.playMusicClip("giveorder_drumroll.wav");
         _loc1_.isActive = true;
      }
      
      public function deactivateScreen() : void
      {
         var _loc1_:GiveOrderScreen = this;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.gameObj.var_131.restoreAfterServing();
         _loc1_.gameObj.var_134.deleteCustomer(_loc1_.currentCustomer);
         _loc1_.currentCustomer = null;
         _loc1_.syncPrizeMeters();
         _loc1_.isActive = false;
      }
      
      public function startPresentation() : void
      {
         var _loc1_:GiveOrderScreen = this;
         _loc1_.isPresentingOrder = true;
         _loc1_.currentStep = "look";
         _loc1_.waitTimer = 0;
         _loc1_.earnStarNumber = 0;
         _loc1_.loseStarNumber = 0;
         _loc1_.earnTicketAmount = 0;
         _loc1_.didMakeSpecialProgress = false;
         _loc1_.didMasterSpecial = false;
         _loc1_.worker.playAnimation("turnaround");
         _loc1_.currentCustomer.playAnimation(395);
         _loc1_.clip.customername_txt.text = String(_loc1_.currentCustomer.customerName);
         class_7.error("===========================================================================================");
         class_7.error(_loc1_.currentCustomer.customerName + " GIVING ORDER");
         class_7.error("===========================================================================================");
         var _loc2_:Number = _loc1_.gameObj.var_128.getCustomerStars(_loc1_.currentCustomer.customerType);
         var _loc3_:Number = _loc1_.gameObj.var_128.getCustomerSeal(_loc1_.currentCustomer.customerType);
         var _loc4_:int = 1;
         while(_loc4_ <= 5)
         {
            if(_loc2_ >= _loc4_)
            {
               _loc1_.clip.stars["star" + _loc4_].gotoAndStop(2);
            }
            else
            {
               _loc1_.clip.stars["star" + _loc4_].gotoAndStop(1);
            }
            _loc4_++;
         }
         if(_loc3_ == 0)
         {
            _loc1_.clip.stars.currentseal.visible = false;
         }
         else
         {
            _loc1_.clip.stars.currentseal.visible = true;
            _loc1_.clip.stars.currentseal.gotoAndStop(_loc3_);
         }
         _loc1_.clip.stars.award.gotoAndStop(1);
         _loc1_.clip.stars.ribbon.gotoAndStop(1);
         var _loc5_:GlowFilter = _loc1_.clip.customername_txt.filters[0];
         if(_loc1_.currentCustomer.isCloser)
         {
            _loc5_.color = 13830400;
         }
         else if(_loc1_.gameObj.var_134.isBringingSpecial(_loc1_.currentCustomer.customerType))
         {
            _loc5_.color = 11692041;
         }
         else
         {
            _loc5_.color = _loc1_.getTextGlowColor();
         }
         if(_loc1_.gameObj.var_134.isBringingSpecial(_loc1_.currentCustomer.customerType))
         {
            _loc1_.clip.customername_txt.textColor = 16775783;
         }
         else
         {
            _loc1_.clip.customername_txt.textColor = 16777215;
         }
         _loc1_.clip.customername_txt.filters = [_loc5_];
         var _loc6_:Number = _loc1_.gameObj.controls.gameplayTimer / _loc1_.gameObj.var_211;
         var _loc7_:Number = _loc1_.gameObj.var_133.getSkyStartingFrame();
         if(_loc6_ > 0.98)
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_ + 6);
         }
         else if(_loc6_ > 0.8)
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_ + 5);
         }
         else if(_loc6_ > 0.65)
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_ + 4);
         }
         else if(_loc6_ > 0.5)
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_ + 3);
         }
         else if(_loc6_ > 0.35)
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_ + 2);
         }
         else if(_loc6_ > 0.2)
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_ + 1);
         }
         else
         {
            _loc1_.clip.bg.gotoAndStop(_loc7_);
         }
         if(_loc3_ == 0)
         {
            _loc1_.useWaitPercent = _loc1_.seal0WaitPercent;
         }
         else if(_loc3_ == 1)
         {
            _loc1_.useWaitPercent = _loc1_.seal1WaitPercent;
         }
         else if(_loc3_ == 2)
         {
            _loc1_.useWaitPercent = _loc1_.seal2WaitPercent;
         }
         else if(_loc3_ == 3)
         {
            _loc1_.useWaitPercent = _loc1_.seal3WaitPercent;
         }
         _loc1_.currentWaitMax = Math.floor(_loc1_.waitLookMax * _loc1_.useWaitPercent);
         _loc1_.determineAccuracy();
         _loc1_.gameObj.var_128.recordCustomerVisit(_loc1_.currentCustomer.customerType);
      }
      
      public function showCustomerReaction() : void
      {
         var _loc1_:GiveOrderScreen = this;
         _loc1_.currentCustomer.playAnimation("look" + _loc1_.customerReaction + "" + _loc1_.customerReactionNumber);
      }
      
      public function showWorkerReaction() : void
      {
      }
      
      public function updateScreen() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = Number(NaN);
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:FoodOrder = null;
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:int = 0;
         var _loc10_:SpecialItem = null;
         var _loc11_:int = 0;
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:SpecialItem = null;
         var _loc16_:String = null;
         var _loc17_:GiveOrderScreen = this;
         if(_loc17_.shouldAnimateTickets)
         {
            _loc1_ = false;
            _loc2_ = 4;
            _loc3_ = 0;
            while(_loc3_ < _loc17_.prizeTickets.length)
            {
               _loc4_ = _loc17_.prizeTickets[_loc3_];
               _loc5_ = 0 - _loc3_ * _loc2_;
               if(_loc4_.y < _loc5_)
               {
                  _loc4_.y += _loc17_.prizeTicketSpeed;
                  if(_loc4_.y >= _loc5_)
                  {
                     _loc4_.y = _loc5_;
                  }
                  else
                  {
                     _loc1_ = true;
                  }
               }
               _loc3_++;
            }
            if(!_loc1_)
            {
               _loc17_.shouldAnimateTickets = false;
            }
         }
         if(_loc17_.shouldAnimateMeter)
         {
            if(_loc17_.clip.ticketmeter.bar.scaleX < _loc17_.targetMeterPercent / 100)
            {
               _loc17_.clip.ticketmeter.bar.scaleX += _loc17_.meterSpeed;
               if(_loc17_.clip.ticketmeter.bar.scaleX > _loc17_.targetMeterPercent / 100)
               {
                  _loc17_.clip.ticketmeter.bar.scaleX = _loc17_.targetMeterPercent / 100;
               }
            }
            if(_loc17_.clip.ticketmeter.bar.scaleX >= 0.3 && _loc17_.gameObj.var_128.todayNaturalTickets < 1)
            {
               ++_loc17_.ticketsEarned;
               _loc17_.addPrizeTickets(1);
               _loc17_.gameObj.var_128.earnExtraDailyTicket(1);
               _loc17_.clip.ticketmeter.ball1.gotoAndPlay("earn");
            }
            else if(_loc17_.clip.ticketmeter.bar.scaleX >= 0.6 && _loc17_.gameObj.var_128.todayNaturalTickets < 2)
            {
               ++_loc17_.ticketsEarned;
               _loc17_.addPrizeTickets(1);
               _loc17_.gameObj.var_128.earnExtraDailyTicket(1);
               _loc17_.clip.ticketmeter.ball2.gotoAndPlay("earn");
            }
            else if(_loc17_.clip.ticketmeter.bar.scaleX >= 0.9 && _loc17_.gameObj.var_128.todayNaturalTickets < 3)
            {
               ++_loc17_.ticketsEarned;
               _loc17_.addPrizeTickets(1);
               _loc17_.gameObj.var_128.earnExtraDailyTicket(1);
               _loc17_.clip.ticketmeter.ball3.gotoAndPlay("earn");
            }
         }
         if(_loc17_.isPresentingOrder && !_loc17_.gameObj.var_169)
         {
            _loc17_.worker.animateModel();
            ++_loc17_.waitTimer;
            if(_loc17_.shouldShowWorkerReaction)
            {
               ++_loc17_.workerReactionTimer;
               if(_loc17_.workerReactionTimer == _loc17_.workerReactionTimerMax)
               {
                  _loc17_.showWorkerReaction();
                  _loc17_.shouldShowWorkerReaction = false;
                  _loc17_.workerReactionTimer = 0;
               }
            }
            if(_loc17_.waitTimer > _loc17_.currentWaitMax)
            {
               if(_loc17_.currentStep == "look")
               {
                  _loc17_.clip.bubbles.gotoAndPlay("reveal");
                  _loc17_.currentStep = "bubbles";
                  _loc17_.waitTimer = 0;
                  _loc17_.currentWaitMax = Math.floor(_loc17_.waitBubblesMax * _loc17_.useWaitPercent);
               }
               else if(_loc17_.currentStep == "bubbles")
               {
                  if(_loc17_.chickenPiece != null)
                  {
                     try
                     {
                        _loc17_.chickenPiece.parent.removeChild(_loc17_.chickenPiece);
                     }
                     catch(err:Error)
                     {
                     }
                     _loc17_.chickenPiece = null;
                  }
                  _loc17_.showCustomerReaction();
                  _loc17_.shouldShowWorkerReaction = true;
                  _loc17_.workerReactionTimer = 0;
                  if(_loc17_.shouldEarnSpecial)
                  {
                     _loc17_.clip.small_envelope.gotoAndPlay(2);
                  }
                  if(_loc17_.earnStarNumber > 0)
                  {
                     _loc17_.clip.stars["star" + _loc17_.earnStarNumber].gotoAndStop(3);
                     _loc17_.gameObj.var_129.playSound("getstar.wav");
                     _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,_loc17_.earnStarNumber);
                     _loc7_ = _loc17_.gameObj.var_128.getCustomerSeal(_loc17_.currentCustomer.customerType);
                     if(_loc17_.earnStarNumber == 5 && _loc7_ < 3)
                     {
                        _loc8_ = _loc7_ + 1;
                        _loc17_.gameObj.var_128.earnCustomerSeal(_loc17_.currentCustomer.customerType,_loc8_);
                        _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,0);
                        _loc17_.clip.stars.fireworks.gotoAndPlay(2);
                        _loc17_.clip.stars.award.seal.gotoAndStop(_loc8_);
                        _loc17_.clip.stars.award.gotoAndPlay(2);
                     }
                     else if(_loc17_.earnStarNumber == 5 && _loc7_ == 3)
                     {
                        _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,0);
                        _loc17_.clip.stars.fireworks.gotoAndPlay(2);
                     }
                  }
                  else if(_loc17_.loseStarNumber > 0)
                  {
                     _loc9_ = 1;
                     while(_loc9_ <= _loc17_.loseStarNumber)
                     {
                        _loc17_.clip.stars["star" + _loc9_].gotoAndStop(4);
                        _loc9_++;
                     }
                     _loc17_.gameObj.var_129.playSound("grabtopping.wav");
                     _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,0);
                  }
                  if(_loc17_.didMakeSpecialProgress)
                  {
                     _loc10_ = _loc17_.gameObj.var_133.getSpecial(_loc17_.gameObj.var_128.currentSpecial);
                     if(_loc10_ != null)
                     {
                        if(_loc10_.bonusType == "tickets")
                        {
                           class_7.method_1(" -- Special Bonus: Earn extra ticket(s)");
                           _loc17_.ticketsEarned += _loc10_.bonusAmount;
                           _loc17_.addPrizeTickets(_loc10_.bonusAmount);
                           _loc17_.gameObj.var_128.earnExtraDailyTicket(_loc10_.bonusAmount,true);
                        }
                        else if(_loc10_.bonusType == "stars")
                        {
                           _loc11_ = 0;
                           while(_loc11_ < _loc10_.bonusAmount)
                           {
                              class_7.method_1(" -- Special Bonus: Earn an extra Customer Star");
                              _loc12_ = _loc17_.earnStarNumber + 1 + _loc11_;
                              if(_loc12_ <= 5)
                              {
                                 _loc17_.clip.stars["star" + _loc12_].gotoAndStop(3);
                                 _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,_loc12_);
                                 _loc13_ = _loc17_.gameObj.var_128.getCustomerSeal(_loc17_.currentCustomer.customerType);
                                 if(_loc12_ == 5 && _loc13_ < 3)
                                 {
                                    _loc14_ = _loc13_ + 1;
                                    _loc17_.gameObj.var_128.earnCustomerSeal(_loc17_.currentCustomer.customerType,_loc14_);
                                    _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,0);
                                    _loc17_.clip.stars.fireworks.gotoAndPlay(2);
                                    _loc17_.clip.stars.award.seal.gotoAndStop(_loc14_);
                                    _loc17_.clip.stars.award.gotoAndPlay(2);
                                 }
                                 else if(_loc17_.earnStarNumber == 5 && _loc13_ == 3)
                                 {
                                    _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,0);
                                    _loc17_.clip.stars.fireworks.gotoAndPlay(2);
                                 }
                              }
                              else
                              {
                                 if(_loc12_ > 5)
                                 {
                                    _loc12_ -= 5;
                                 }
                                 _loc17_.gameObj.var_128.earnCustomerStar(_loc17_.currentCustomer.customerType,_loc12_);
                              }
                              _loc11_++;
                           }
                        }
                     }
                  }
                  if(_loc17_.currentCustomer.customerType == 1 && _loc17_.earnStarNumber > 0)
                  {
                     _loc17_.gameObj.var_128.earnBlueRibbon();
                     _loc17_.clip.stars.fireworks.gotoAndPlay(2);
                     _loc17_.clip.stars.ribbon.gotoAndPlay(2);
                  }
                  else if(_loc17_.currentCustomer.customerType == 1)
                  {
                  }
                  if(_loc17_.didMakeSpecialProgress)
                  {
                     _loc17_.gameObj.var_142.showSpecialProgress(_loc17_.gameObj.var_128.currentSpecial);
                     _loc17_.gameObj.var_142.recordSpecialStar();
                  }
                  if(_loc17_.gameObj.var_134.isOrderingSpecial(_loc17_.currentCustomer.customerType))
                  {
                     _loc17_.gameObj.var_128.recordSpecialServed(_loc17_.gameObj.var_128.currentSpecial);
                  }
                  _loc6_ = _loc17_.gameObj.var_131.currentOrder;
                  _loc17_.gameObj.var_142.recordServeOrder(_loc17_.currentCustomer.customerName,_loc17_.waitScore,_loc17_.cookScore,_loc17_.buildScore,_loc17_.fryScore,_loc17_.totalScore,_loc6_.getToppingNames(_loc17_.currentCustomer.order),_loc17_.getWorkerClothingTags());
                  _loc17_.gameObj.var_129.playMusicClip("customer_" + _loc17_.customerReaction + ".wav");
                  if(_loc17_.drumrollSound)
                  {
                     _loc17_.drumrollSound.stop();
                  }
                  _loc17_.drumrollSound = null;
                  _loc17_.shouldAnimateMeter = true;
                  _loc17_.currentStep = "react";
                  _loc17_.waitTimer = 0;
                  _loc17_.currentWaitMax = Math.floor(_loc17_.waitReactMax * _loc17_.useWaitPercent);
               }
               else if(_loc17_.currentStep == "react")
               {
                  _loc17_.clip.tips.gotoAndStop(_loc17_.coinFrame);
                  if(_loc17_.coinFrame > 1)
                  {
                     if(_loc17_.coinFrame < 4)
                     {
                        _loc17_.gameObj.var_129.playSound("singlecoin.wav");
                     }
                     else
                     {
                        _loc17_.gameObj.var_129.playSound("multicoin.wav");
                     }
                  }
                  _loc17_.currentStep = "tip";
                  _loc17_.waitTimer = 0;
                  _loc17_.currentWaitMax = Math.floor(_loc17_.waitTipMax * _loc17_.useWaitPercent);
                  if(_loc17_.didMasterSpecial)
                  {
                     _loc15_ = _loc17_.gameObj.var_133.getSpecial(_loc17_.gameObj.var_128.currentSpecial);
                     if(_loc15_ != null)
                     {
                        _loc16_ = _loc15_.prizeSKU;
                        _loc17_.gameObj.method_252(_loc16_);
                     }
                  }
                  if(_loc17_.shouldEarnSpecial)
                  {
                     class_7.method_1("----- Show earning a special!");
                     if(_loc17_.newSpecialLogo)
                     {
                        _loc17_.newSpecialLogo.dispose();
                        _loc17_.newSpecialLogo = null;
                     }
                     if(_loc17_.newSpecialBitmap)
                     {
                        if(_loc17_.newSpecialBitmap.parent)
                        {
                           _loc17_.newSpecialBitmap.parent.removeChild(_loc17_.newSpecialBitmap);
                        }
                        _loc17_.newSpecialBitmap.bitmapData = null;
                        _loc17_.newSpecialBitmap = null;
                     }
                     _loc17_.newSpecialLogo = _loc17_.gameObj.var_133.getSpecialLogo(_loc17_.gameObj.var_134.whichSpecialToEarn);
                     _loc17_.newSpecialBitmap = new Bitmap(_loc17_.newSpecialLogo,"auto",true);
                     _loc17_.newSpecialBitmap.scaleX = 0.9;
                     _loc17_.newSpecialBitmap.scaleY = 0.9;
                     _loc17_.newSpecialBitmap.x = 60;
                     _loc17_.newSpecialBitmap.y = 17;
                     _loc17_.clip.large_envelope.card.addChild(_loc17_.newSpecialBitmap);
                     _loc17_.clip.large_envelope.gotoAndPlay(2);
                     _loc17_.gameObj.var_128.earnSpecial(_loc17_.gameObj.var_134.whichSpecialToEarn,_loc17_.currentCustomer.customerType);
                     _loc17_.gameObj.var_129.playMusicClip("music_newseason");
                  }
               }
               else if(_loc17_.currentStep == "tip")
               {
                  _loc17_.adjustJarCoins();
                  _loc17_.clip.tipjar.gotoAndPlay(2);
                  _loc17_.clip.starburst.gotoAndPlay(2);
                  _loc17_.gameObj.var_129.playSound("boing.wav");
                  _loc17_.currentStep = "tipTotal";
                  _loc17_.waitTimer = 0;
                  _loc17_.currentWaitMax = _loc17_.waitTipTotalMax;
               }
               else if(_loc17_.currentStep == "tipTotal")
               {
                  if(_loc17_.gameObj.var_134.outOfCustomers())
                  {
                     _loc17_.currentStep = "ending";
                     _loc17_.waitTimer = 0;
                     _loc17_.currentWaitMax = _loc17_.waitEndingMax;
                     _loc17_.currentStep = "returning";
                     _loc17_.waitTimer = 0;
                     _loc17_.currentWaitMax = int.MAX_VALUE;
                     _loc17_.finishGivingOrder(true);
                  }
                  else
                  {
                     _loc17_.currentStep = "returning";
                     _loc17_.waitTimer = 0;
                     _loc17_.currentWaitMax = int.MAX_VALUE;
                     _loc17_.finishGivingOrder();
                  }
               }
               else if(_loc17_.currentStep == "ending")
               {
                  _loc17_.gameObj.var_205 = true;
                  _loc17_.isPresentingOrder = false;
                  _loc17_.currentStep = "closeending";
                  _loc17_.waitTimer = 0;
                  _loc17_.currentWaitMax = int.MAX_VALUE;
                  _loc17_.gameObj.hud.startTransition("ending");
               }
            }
         }
      }
      
      public function adjustJarCoins() : void
      {
         var _loc5_:Number = NaN;
         var _loc1_:GiveOrderScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:Number = _loc2_.getTipsToday();
         var _loc4_:Number = Math.min(1,_loc3_ / 3000);
         _loc5_ = Math.ceil(_loc4_ * 10);
         if(_loc5_ < 2 && _loc3_ > 0)
         {
            _loc5_ = 2;
         }
         else if(_loc5_ > 10)
         {
            _loc5_ = 10;
         }
         _loc1_.clip.tipjar.clip.coins.gotoAndStop(_loc5_);
      }
      
      public function getCustomerReactionNumber(param1:String) : Number
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:GiveOrderScreen = this;
         var _loc4_:Array = _loc3_["reactions_" + param1];
         var _loc5_:Number = 1;
         if(Boolean(_loc4_) && _loc4_.length > 0)
         {
            _loc2_ = Math.floor(Math.random() * _loc4_.length);
            _loc5_ = Number(_loc4_[_loc2_]);
            _loc4_.splice(_loc2_,1);
         }
         else if(param1 == "overjoyed" || param1 == "happy")
         {
            _loc5_ = Math.ceil(Math.random() * 5);
         }
         else if(param1 == "decent")
         {
            _loc5_ = Math.ceil(Math.random() * 2);
         }
         else if(param1 == "pissed")
         {
            _loc5_ = Math.ceil(Math.random() * 3);
         }
         else
         {
            _loc5_ = 1;
         }
         return _loc5_;
      }
      
      public function determineAccuracy() : void
      {
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc14_:* = undefined;
         var _loc1_:SpecialItem = null;
         var _loc2_:GiveOrderScreen = this;
         class_7.method_1(">>> ---------------------------------------------------------------------------");
         class_7.method_1("Scoring order for " + _loc2_.currentCustomer.customerName + ":\n");
         _loc2_.gradeBuilding();
         _loc2_.gradeWaiting();
         _loc2_.gradeCooking();
         _loc2_.gradeFries();
         _loc2_.totalScore = Math.floor((_loc2_.buildScore + _loc2_.cookScore + _loc2_.waitScore + _loc2_.fryScore) / 4);
         if(_loc2_.currentCustomer.isCloser)
         {
            if(_loc2_.totalScore <= _loc2_.closerCutoff)
            {
               _loc2_.totalScore = 0;
            }
            else
            {
               _loc2_.totalScore = Math.floor((_loc2_.totalScore - _loc2_.closerCutoff) / (100 - _loc2_.closerCutoff) * 100);
            }
         }
         if(_loc2_.gameObj.var_134.isBringingSpecial(_loc2_.currentCustomer.customerType))
         {
            if(_loc2_.totalScore <= _loc2_.closerCutoff)
            {
               _loc2_.totalScore = 0;
            }
            else
            {
               _loc2_.totalScore = Math.floor((_loc2_.totalScore - _loc2_.closerCutoff) / (100 - _loc2_.closerCutoff) * 100);
            }
         }
         if(_loc2_.currentCustomer.customerName == "Jojo" && _loc2_.gameObj.var_128.hasBonusFurniture("customer","jojo"))
         {
            _loc2_.totalScore += 5;
            if(_loc2_.totalScore > 100)
            {
               _loc2_.totalScore = 100;
            }
            class_7.method_1(">> Boost Score +5% for Jojo because you have the Food Critic poster.");
         }
         var _loc3_:Number = _loc2_.totalScore;
         if(this.totalScore >= 90)
         {
            _loc2_.customerReaction = "overjoyed";
            _loc2_.customerReactionNumber = _loc2_.getCustomerReactionNumber(_loc2_.customerReaction);
         }
         else if(this.totalScore >= 80)
         {
            _loc2_.customerReaction = "happy";
            _loc2_.customerReactionNumber = _loc2_.getCustomerReactionNumber(_loc2_.customerReaction);
         }
         else if(this.totalScore >= 70)
         {
            _loc2_.customerReaction = "decent";
            _loc2_.customerReactionNumber = _loc2_.getCustomerReactionNumber(_loc2_.customerReaction);
         }
         else if(this.totalScore >= 60)
         {
            _loc2_.customerReaction = "worried";
            _loc2_.customerReactionNumber = 1;
         }
         else if(this.totalScore >= 50)
         {
            _loc2_.customerReaction = "upset";
            _loc2_.customerReactionNumber = 1;
         }
         else if(this.totalScore < 50)
         {
            _loc2_.customerReaction = "pissed";
            _loc2_.customerReactionNumber = _loc2_.getCustomerReactionNumber(_loc2_.customerReaction);
         }
         else
         {
            _loc2_.customerReaction = "decent";
            _loc2_.customerReactionNumber = _loc2_.getCustomerReactionNumber(_loc2_.customerReaction);
         }
         var _loc4_:String = null;
         var _loc5_:Number = 0;
         if(_loc2_.gameObj.var_134.isOrderingSpecial(_loc2_.currentCustomer.customerType) && _loc2_.gameObj.var_128.currentSpecial > -1 && this.totalScore >= 80)
         {
            _loc2_.gameObj.var_128.recordSpecialStar(_loc2_.gameObj.var_128.currentSpecial);
            _loc2_.didMakeSpecialProgress = true;
            _loc1_ = _loc2_.gameObj.var_133.getSpecial(_loc2_.gameObj.var_128.currentSpecial);
            if(_loc1_ != null)
            {
               _loc4_ = _loc1_.bonusType;
               _loc5_ = _loc1_.bonusAmount;
            }
            if(_loc2_.gameObj.var_128.getSpecialStars(_loc2_.gameObj.var_128.currentSpecial) == _loc2_.gameObj.var_128.starsToMasterSpecial)
            {
               class_7.method_1(" ---- You just mastered this special.  Will earn a prize!");
               _loc2_.didMasterSpecial = true;
            }
            else
            {
               _loc2_.didMasterSpecial = false;
            }
         }
         else
         {
            _loc2_.didMakeSpecialProgress = false;
            _loc2_.didMasterSpecial = false;
         }
         _loc2_.clip.small_envelope.gotoAndStop(1);
         _loc2_.clip.large_envelope.gotoAndStop(1);
         if(_loc2_.gameObj.var_134.isBringingSpecial(_loc2_.currentCustomer.customerType) && this.totalScore >= 80)
         {
            _loc2_.shouldEarnSpecial = true;
            _loc2_.clip.small_envelope.visible = true;
            _loc2_.clip.large_envelope.visible = true;
         }
         else
         {
            _loc2_.shouldEarnSpecial = false;
            _loc2_.clip.small_envelope.visible = false;
            _loc2_.clip.large_envelope.visible = false;
         }
         var _loc6_:Number = _loc2_.gameObj.var_128.getCustomerStars(_loc2_.currentCustomer.customerType);
         if(this.totalScore >= 80)
         {
            if(_loc6_ < 5)
            {
               _loc2_.earnStarNumber = _loc6_ + 1;
            }
         }
         else if(this.totalScore < 60)
         {
            if(_loc6_ > 0)
            {
               _loc2_.loseStarNumber = _loc6_;
            }
         }
         var _loc7_:Number = _loc2_.maxTip;
         _loc8_ = _loc2_.gameObj.var_128.getCustomerSeal(_loc2_.currentCustomer.customerType);
         var _loc9_:Number = _loc8_ * _loc2_.extraPercentagePerBadge;
         if(_loc2_.earnStarNumber == 5)
         {
            _loc9_ = 2;
         }
         _loc2_.totalScore = Math.round(_loc2_.totalScore * (1 + _loc9_));
         class_7.method_1("Previous Stars: " + _loc6_ + ", Which Seal: " + _loc8_ + ", Point Bonus: " + _loc9_ + ", Total Score: " + this.totalScore);
         if(_loc4_ == "points")
         {
            class_7.method_1(" -- Special Bonus on Points");
            _loc2_.totalScore = Math.round(_loc2_.totalScore * (_loc5_ / 100));
         }
         if(isNaN(_loc2_.totalScore))
         {
            _loc2_.totalScore = 0;
         }
         var _loc10_:Number = _loc8_ * _loc2_.extraTipPerBadge;
         _loc7_ += _loc10_;
         if(_loc2_.gameObj.var_128.hasRibbon())
         {
            _loc7_ += _loc2_.extraTipForRibbon;
         }
         _loc7_ += _loc2_.getClothingBonus();
         if(_loc2_.gameObj.var_128.hasBonusFurniture("customer","romano") && (_loc2_.currentCustomer.customerName == "Bruna Romano" || _loc2_.currentCustomer.customerName == "Carlo Romano" || _loc2_.currentCustomer.customerName == "Gino Romano" || _loc2_.currentCustomer.customerName == "Little Edoardo"))
         {
            class_7.method_1("Bonus tip for Romanos!");
            _loc7_ += 300;
         }
         if(_loc4_ == "tips")
         {
            class_7.method_1(" -- Special Bonus on Tips");
            _loc7_ = Math.round(_loc7_ * _loc5_);
         }
         _loc11_ = Math.round(_loc3_ / 100 * _loc7_ - (100 - _loc3_) / 100 * _loc7_);
         if(_loc11_ < 0)
         {
            _loc11_ = 0;
         }
         if(_loc2_.earnStarNumber == 5)
         {
            _loc11_ *= 3;
         }
         if(isNaN(_loc11_))
         {
            _loc11_ = 0;
         }
         var _loc12_:Number = _loc11_ / 100;
         if(_loc3_ < 50)
         {
            _loc2_.coinFrame = 1;
         }
         else if(_loc3_ < 60)
         {
            _loc2_.coinFrame = 2;
         }
         else if(_loc3_ < 70)
         {
            _loc2_.coinFrame = 3;
         }
         else if(_loc3_ < 80)
         {
            _loc2_.coinFrame = 4;
         }
         else if(_loc3_ < 90)
         {
            _loc2_.coinFrame = 5;
         }
         else if(_loc3_ < 100)
         {
            _loc2_.coinFrame = 6;
         }
         else if(_loc3_ >= 100)
         {
            _loc2_.coinFrame = 6;
         }
         var _loc13_:Number = Math.floor(_loc12_);
         _loc14_ = _loc11_ - _loc13_ * 100;
         var _loc15_:* = _loc14_ / 100;
         if(_loc14_ < 10)
         {
            _loc14_ = "0" + _loc14_;
         }
         else if(_loc14_ == 0)
         {
            _loc14_ = "00";
         }
         var _loc16_:String = "$" + _loc13_ + "." + _loc14_;
         if(_loc11_ <= 0)
         {
            _loc11_ = 0;
            _loc16_ = " $0.00 ";
         }
         _loc2_.gameObj.var_128.addToDailyScore(_loc2_.waitScore,_loc2_.cookScore,_loc2_.buildScore,_loc2_.fryScore,_loc2_.totalScore,_loc11_,_loc2_.earnTicketAmount);
         _loc2_.targetMeterPercent = _loc2_.gameObj.var_128.getCurrentPercentQuality(_loc2_.gameObj.var_134.customerLineup.length);
         class_7.method_1("Current Meter Percent: " + _loc2_.targetMeterPercent + "% (for " + _loc2_.gameObj.var_134.customerLineup.length + " Customers today)");
         _loc2_.clip.bubbles.order_score.score_txt.text = _loc2_.waitScore + "%";
         _loc2_.clip.bubbles.cook_score.score_txt.text = _loc2_.cookScore + "%";
         _loc2_.clip.bubbles.build_score.score_txt.text = _loc2_.buildScore + "%";
         _loc2_.clip.bubbles.fry_score.score_txt.text = _loc2_.fryScore + "%";
         _loc2_.clip.bubbles.total_score.score_txt.text = _loc2_.totalScore + " POINTS";
         _loc2_.clip.bubbles.gotoAndStop(1);
         if(_loc2_.waitScore == 100 && _loc2_.fryScore == 100 && _loc2_.buildScore == 100 && _loc2_.cookScore == 100)
         {
            _loc2_.clip.bubbles.perfect.visible = true;
         }
         else
         {
            _loc2_.clip.bubbles.perfect.visible = false;
         }
         _loc2_.clip.starburst.burst.money.text = _loc16_;
         class_7.method_1(">>> ---------------------------------------------------------------------------");
      }
      
      public function gradeWaiting() : void
      {
         var _loc1_:GiveOrderScreen = this;
         _loc1_.waitScore = 100;
         var _loc2_:Number = _loc1_.gameObj.var_128.getLobbyPercent();
         var _loc3_:Number = _loc1_.gameObj.var_128.getBonusWaitOffset() * 30;
         var _loc4_:Number = _loc3_ = Math.ceil(_loc3_ * _loc2_);
         if(_loc1_.currentCustomer.customersAlreadyWaiting >= 2)
         {
            _loc3_ += 600;
         }
         else if(_loc1_.currentCustomer.customersAlreadyWaiting == 1)
         {
            _loc3_ += 300;
         }
         var _loc5_:Number = _loc1_.gameObj.controls.gameplayTimer;
         var _loc6_:Number = _loc1_.currentCustomer.timeOrderTaken - _loc1_.currentCustomer.timeEntered;
         var _loc7_:Number = _loc5_ - _loc1_.currentCustomer.timeOrderTaken;
         var _loc8_:Number = _loc6_ - (_loc1_.idealWaitBeforeOrder + _loc3_);
         var _loc9_:Number = 0;
         if(_loc8_ > 0)
         {
            _loc9_ = _loc8_ / 30 * 0.3;
         }
         var _loc10_:Number = _loc1_.currentCustomer.getOkayWaitingTime();
         var _loc11_:Number = 0;
         _loc11_ = _loc11_ + 1200;
         _loc11_ = _loc11_ + 1200;
         _loc11_ = _loc11_ + 1800;
         var _loc12_:Number = _loc10_ + _loc11_ + _loc3_;
         var _loc13_:Number = _loc7_ - _loc12_;
         var _loc14_:Number = 0;
         if(_loc13_ > 0)
         {
            _loc14_ = _loc13_ / 30 * 0.3;
         }
         _loc1_.waitScore = Math.max(0,Math.floor(100 - _loc14_ - _loc9_));
         if(_loc1_.waitScore > 100)
         {
            _loc1_.waitScore = 100;
         }
         var _loc15_:* = "";
         _loc15_ = _loc15_ + "\nWAITING SCORE -----------------------------------------------\n";
         _loc15_ = _loc15_ + ("  >>  Before-Order Time Off = " + _loc8_ + ". " + 0.3 + "% Off for each second.\n");
         _loc15_ = _loc15_ + ("  >>  Prep Time Off = " + _loc13_ + ". " + 0.3 + "% Off for each second.\n");
         _loc15_ = _loc15_ + ("  >>  (Customer would wait " + _loc10_ + " for cooking)\n");
         _loc15_ = _loc15_ + ("  >>  (Customer would wait " + _loc11_ + " for build/popping)\n");
         _loc15_ = _loc15_ + ("  >>  (Customer would wait an extra " + _loc4_ + " from lobby decorations)\n");
         _loc15_ = _loc15_ + ("  >>  (Customer would wait an extra " + (_loc3_ - _loc4_) + " from " + _loc1_.currentCustomer.customersAlreadyWaiting + " others waiting in line)\n");
         _loc15_ = _loc15_ + ("FINAL WAITING SCORE: " + _loc1_.waitScore + " \n");
         class_7.method_1(_loc15_);
         if(isNaN(_loc1_.waitScore))
         {
            _loc1_.waitScore = 0;
         }
      }
      
      public function gradeBuilding() : void
      {
         var _loc1_:GiveOrderScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:CustomerData = _loc1_.gameObj.var_130;
         var _loc4_:Number = _loc2_.getLobbyPercent();
         _loc1_.buildScore = 100;
         _loc1_.buildHadParticlesOff = false;
         class_7.method_1("Grade Building ---------------------------------------------------------");
         var _loc5_:CustomerOrder = _loc1_.gameObj.var_130.getCustomerOrderData(_loc1_.currentCustomer.customerType);
         var _loc6_:FoodOrder = _loc1_.gameObj.var_131.currentOrder;
         _loc1_.buildScore = 100;
         if(_loc6_.sandwich.breadType != _loc5_.bread)
         {
            _loc1_.buildScore -= 15;
            class_7.method_1("  >>  Wrong bread.  Score = " + _loc1_.buildScore);
         }
         if(_loc6_.sandwich.cheeseType1 != _loc5_.cheese)
         {
            _loc1_.buildScore -= 12;
            class_7.method_1("  >>  Wrong cheese (1).  Score = " + _loc1_.buildScore);
         }
         if(_loc6_.sandwich.cheeseType2 != _loc5_.cheese)
         {
            _loc1_.buildScore -= 12;
            class_7.method_1("  >>  Wrong cheese (2).  Score = " + _loc1_.buildScore);
         }
         if(_loc6_.sandwich.topSkewDropOffset != 0)
         {
            _loc1_.buildScore -= Math.round(Math.abs(_loc6_.sandwich.topSkewDropOffset));
            class_7.method_1("  >>  Top was askew by " + _loc6_.sandwich.topSkewDropOffset + ".  Score = " + _loc1_.buildScore);
         }
         if(Math.abs(_loc6_.sandwich.cheese1OffsetX) > 3)
         {
            _loc1_.buildScore -= Math.min(8,(Math.abs(_loc6_.sandwich.cheese1OffsetX) - 3) * 1);
            class_7.method_1("  >>  Cheese 1 Offset: " + _loc6_.sandwich.cheese1OffsetX + ".  Allow " + 3 + ".  Score = " + _loc1_.buildScore);
         }
         if(Math.abs(_loc6_.sandwich.cheese2OffsetX) > 3)
         {
            _loc1_.buildScore -= Math.min(8,(Math.abs(_loc6_.sandwich.cheese2OffsetX) - 3) * 1);
            class_7.method_1("  >>  Cheese 2 Offset: " + _loc6_.sandwich.cheese2OffsetX + ".  Allow " + 3 + ".  Score = " + _loc1_.buildScore);
         }
         var _loc7_:Number = _loc1_.gradeBuildToppings(_loc5_.toppings,_loc6_.sandwich,1);
         var _loc8_:Number = _loc1_.gradeBuildToppings(_loc5_.toppings,_loc6_.sandwich,-1);
         var _loc9_:Number = Math.max(_loc7_,_loc8_);
         var _loc10_:Number = Math.min(50,100 - _loc9_);
         _loc1_.buildScore -= _loc10_;
         class_7.method_1("  >>  Deduct " + _loc10_ + " for topping score.  Score = " + _loc1_.buildScore);
         if(_loc1_.buildScore > 100)
         {
            _loc1_.buildScore = 100;
         }
         if(_loc1_.buildScore < 0 || Boolean(isNaN(_loc1_.buildScore)))
         {
            _loc1_.buildScore = 0;
         }
         _loc1_.buildScore = Math.ceil(_loc1_.buildScore);
         class_7.method_1("Build Score: " + _loc1_.buildScore + "% ----------------------------------------------------\n");
      }
      
      public function gradeBuildToppings(param1:Array, param2:Sandwich, param3:Number) : Number
      {
         var _loc19_:GiveOrderScreen = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Boolean = false;
         var _loc9_:Number = Number(NaN);
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Number = Number(NaN);
         var _loc13_:int = 0;
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         _loc19_ = this;
         var _loc20_:UserData = _loc19_.gameObj.var_128;
         var _loc21_:CustomerData = _loc19_.gameObj.var_130;
         var _loc22_:String = "Dir " + String(param3);
         this.traceMessage(_loc22_ + " -- >> -- Grade Build Toppings -----------------------",_loc22_);
         if(param3 == -1)
         {
            param1.reverse();
         }
         var _loc23_:Array = [];
         var _loc24_:Number = _loc20_.getLobbyPercent();
         var _loc25_:Number = Math.max(param1.length,param2.toppings.length);
         _loc4_ = 0;
         while(_loc4_ < _loc25_)
         {
            _loc23_.push(0);
            _loc4_++;
         }
         var _loc26_:Array = [];
         var _loc27_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc27_.push(false);
            _loc26_.push(param1[_loc4_]);
            _loc4_++;
         }
         this.traceMessage(_loc22_ + "  >>  Toppings ordered: " + _loc26_.toString(),_loc22_);
         this.traceMessage(_loc22_ + "  >>  Toppings on food: " + param2.getToppingTypes().toString(),_loc22_);
         _loc4_ = 0;
         while(_loc4_ < param2.toppings.length)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               if(param2.toppings[_loc4_].type == param1[_loc5_] && _loc27_[_loc5_] === false)
               {
                  _loc27_[_loc5_] = true;
                  _loc23_[_loc4_] = 100;
                  break;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         this.traceMessage(_loc22_ + "  >>  Current Topping Scores: " + _loc23_.toString(),_loc22_);
         _loc4_ = 0;
         while(_loc4_ < _loc25_)
         {
            _loc6_ = _loc4_;
            _loc7_ = _loc4_;
            _loc8_ = false;
            _loc9_ = 0;
            if(param2.toppings.length > _loc7_ && param1.length > _loc6_ && param2.toppings[_loc7_].type == param1[_loc6_])
            {
               this.traceMessage(_loc22_ + "       >>  Layering Order: " + param2.toppings[_loc7_].type + " is correct (100%)",_loc22_);
               _loc8_ = true;
               _loc9_ = 100;
            }
            else
            {
               if(param2.toppings.length > _loc7_)
               {
                  this.traceMessage(_loc22_ + "       >>  Layering Order: " + param2.toppings[_loc7_].type + " is not correct. (0%)",_loc22_);
               }
               else
               {
                  this.traceMessage(_loc22_ + "       >>  Layering Order: a topping is missing. (0%)",_loc22_);
               }
               _loc9_ = 0;
            }
            if(!_loc8_ && param2.toppings.length > _loc7_)
            {
               _loc10_ = false;
               _loc11_ = false;
               _loc12_ = -1;
               _loc13_ = 0;
               while(_loc13_ < param1.length)
               {
                  if(param1[_loc13_] == param2.toppings[_loc7_].type)
                  {
                     _loc12_ = _loc13_;
                     break;
                  }
                  _loc13_++;
               }
               if(_loc12_ > -1)
               {
                  if(_loc7_ == 0 || param1.length > _loc12_ - 1 && param2.toppings[_loc7_ - 1].type == param1[_loc12_ - 1])
                  {
                     _loc11_ = true;
                     _loc9_ += 50;
                  }
                  if(_loc7_ == param2.toppings.length - 1 || param2.toppings.length > _loc7_ + 1 && param1.length > _loc12_ + 1 && param2.toppings[_loc7_ + 1].type == param1[_loc12_ + 1])
                  {
                     _loc10_ = true;
                     _loc9_ += 50;
                  }
               }
               this.traceMessage(_loc22_ + "       >>  " + param2.toppings[_loc7_].type + " is NOT correct (+" + _loc9_ + "%) -- below:" + _loc11_ + ", above:" + _loc10_,_loc22_);
            }
            if(_loc23_[_loc7_] > 0)
            {
               _loc14_ = (100 - _loc9_) / 2;
               _loc23_[_loc7_] -= _loc14_;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param2.toppings.length)
         {
            if(_loc26_.indexOf(param2.toppings[_loc4_].type) > -1)
            {
               _loc15_ = 2;
               _loc16_ = 1;
               _loc17_ = 0;
               if(Math.abs(param2.toppings[_loc4_].placedX) > _loc15_)
               {
                  _loc17_ = Math.abs(param2.toppings[_loc4_].placedX) - _loc15_;
                  _loc23_[_loc4_] -= Math.min(30,_loc17_ * _loc16_);
                  this.traceMessage(_loc22_ + "       >>  Placement Off: " + param2.toppings[_loc4_].type + " at " + param2.toppings[_loc4_].placedX + ". Allowed " + _loc15_ + ".  Score for this item = " + _loc23_[_loc4_]);
               }
            }
            _loc4_++;
         }
         this.traceMessage("  >>  Current Build Topping Scores: " + _loc23_.toString(),_loc22_);
         _loc4_ = 0;
         while(_loc4_ < param2.toppings.length)
         {
            if(_loc20_.hasBonusFurniture("build",param2.toppings[_loc4_].type) && _loc23_[_loc4_] > 0)
            {
               _loc18_ = Math.random();
               if(_loc18_ < _loc24_)
               {
                  _loc23_[_loc4_] += 3;
                  if(_loc23_[_loc4_] > 100)
                  {
                     _loc23_[_loc4_] = 100;
                  }
                  this.traceMessage("Add 3% boost to " + param2.toppings[_loc4_].type + " -- Rand = " + _loc18_ + ", LobbyPercent = " + _loc24_,_loc22_);
               }
               else
               {
                  _loc23_[_loc4_] += 1;
                  if(_loc23_[_loc4_] > 100)
                  {
                     _loc23_[_loc4_] = 100;
                  }
                  this.traceMessage("Add 1% boost to " + param2.toppings[_loc4_].type + " -- Rand = " + _loc18_ + ", LobbyPercent = " + _loc24_,_loc22_);
               }
            }
            _loc4_++;
         }
         this.traceMessage(_loc22_ + "  >>  Post-Bonus Build Topping Scores: " + _loc23_.toString(),_loc22_);
         var _loc28_:Number = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc23_.length)
         {
            _loc28_ += _loc23_[_loc4_];
            _loc4_++;
         }
         var _loc29_:Number = Math.ceil(_loc28_ / _loc23_.length);
         class_7.method_1(_loc22_ + " >> Average Score = " + _loc29_);
         return _loc29_;
      }
      
      public function gradeCooking() : void
      {
         var _loc9_:Number = NaN;
         var _loc1_:GiveOrderScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:CustomerData = _loc1_.gameObj.var_130;
         var _loc4_:Number = _loc2_.getLobbyPercent();
         _loc1_.cookScore = 100;
         class_7.method_1("Grade Cooking ---------------------------------------------------------");
         var _loc5_:CustomerOrder = _loc1_.gameObj.var_130.getCustomerOrderData(_loc1_.currentCustomer.customerType);
         var _loc6_:FoodOrder = _loc1_.gameObj.var_131.currentOrder;
         _loc1_.cookScore = 100;
         var _loc7_:Number = 0;
         var _loc8_:Number = _loc6_.sandwich.getTotalTime();
         _loc9_ = Number(FoodData.getTargetCookTime(_loc5_.cookType));
         var _loc10_:Number = _loc9_ + FoodData.getSafeRemoveBuffer();
         if(_loc8_ >= _loc9_ && _loc8_ <= _loc10_)
         {
            class_7.method_1("  >>  Sandwich cooked correct time!  Score = " + _loc1_.cookScore);
         }
         else if(_loc8_ < _loc9_)
         {
            _loc7_ = _loc9_ - _loc8_;
            _loc1_.cookScore -= _loc7_ / 30 * 1;
            class_7.method_1("  >>  Not cooked long enough (" + _loc7_ / 30 + " secs too early).  Score = " + _loc1_.cookScore);
         }
         else if(_loc8_ > _loc10_)
         {
            _loc7_ = _loc8_ - _loc10_;
            _loc1_.cookScore -= _loc7_ / 30 * 1;
            class_7.method_1("  >>  Cooked too long (" + _loc7_ / 30 + " secs too long).  Score = " + _loc1_.cookScore);
         }
         var _loc11_:Number = Math.min(7,Math.floor(_loc6_.sandwich.topTime / (0.0625 * FoodData.getMaxCookTime())));
         var _loc12_:Number = Math.min(7,Math.floor(_loc6_.sandwich.bottomTime / (0.0625 * FoodData.getMaxCookTime())));
         var _loc13_:Number = Math.abs(_loc11_ - _loc12_);
         _loc1_.cookScore -= 6 * _loc13_;
         class_7.method_1("  >>  Top Frame = " + _loc11_ + " (Sandwich: " + _loc6_.sandwich.topFrame + "), Bottom Frame = " + _loc12_ + " (Sandwich: " + _loc6_.sandwich.bottomFrame + "), Difference = " + _loc13_);
         class_7.method_1("  >>  Flip Amount Off: " + 6 * _loc13_ + ". Score = " + _loc1_.cookScore);
         var _loc14_:Number = 0;
         if(Math.abs(0 - _loc6_.sandwich.cutLocationX) > 2)
         {
            _loc14_ = Math.round(Math.abs(0 - _loc6_.sandwich.cutLocationX) - 2);
            _loc1_.cookScore -= 1 * _loc14_;
            class_7.method_1("  >>  Cut off: Target = " + 0 + ", Cut at " + _loc6_.sandwich.cutLocationX + ".  Allow " + 2 + " off, new distance = " + _loc14_ + ".  Deduct " + 1 + " per pixel.  Score = " + _loc1_.cookScore);
         }
         else
         {
            class_7.method_1("  >>  Cut Fairly Well:  Target = " + 0 + ", Cut at " + _loc6_.sandwich.cutLocationX + " (Allow " + 2 + " off)");
         }
         if(_loc1_.cookScore > 100)
         {
            _loc1_.cookScore = 100;
         }
         if(_loc1_.cookScore < 0 || Boolean(isNaN(_loc1_.cookScore)))
         {
            _loc1_.cookScore = 0;
         }
         _loc1_.cookScore = Math.ceil(_loc1_.cookScore);
         class_7.method_1("Cooking Score: " + _loc1_.cookScore + "% ----------------------------------------------------\n");
      }
      
      public function gradeFries() : void
      {
         var _loc13_:Number = NaN;
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:GiveOrderScreen = this;
         var _loc6_:UserData = _loc5_.gameObj.var_128;
         var _loc7_:CustomerData = _loc5_.gameObj.var_130;
         var _loc8_:Number = _loc6_.getLobbyPercent();
         _loc5_.fryScore = 100;
         class_7.method_1("Grade Fries ---------------------------------------------------------");
         var _loc9_:CustomerOrder = _loc5_.gameObj.var_130.getCustomerOrderData(_loc5_.currentCustomer.customerType);
         var _loc10_:FoodOrder = _loc5_.gameObj.var_131.currentOrder;
         _loc5_.fryScore = 100;
         if(_loc10_.fries.fryType != _loc9_.fries)
         {
            _loc5_.fryScore -= 40;
            class_7.method_1("  >>  Wrong type of fries! (" + _loc10_.fries.fryType + " instead of " + _loc9_.fries + ").  Score = " + _loc5_.fryScore);
         }
         var _loc11_:Number = 0;
         var _loc12_:Number = _loc10_.fries.cookAmount;
         _loc13_ = Number(FoodData.getFryTargetCookTime());
         var _loc14_:Number = _loc13_ + FoodData.getFrySafeRemoveBuffer();
         if(_loc12_ >= _loc13_ && _loc12_ <= _loc14_)
         {
            class_7.method_1("  >>  Fries cooked correct time!  Score = " + _loc5_.fryScore);
         }
         else if(_loc12_ < _loc13_)
         {
            _loc11_ = _loc13_ - _loc12_;
            _loc5_.fryScore -= _loc11_ / 30 * 1;
            class_7.method_1("  >>  Fries not cooked long enough (" + _loc11_ / 30 + " secs too early).  Score = " + _loc5_.fryScore);
         }
         else if(_loc12_ > _loc14_)
         {
            _loc11_ = _loc12_ - _loc14_;
            _loc5_.fryScore -= _loc11_ / 30 * 1;
            class_7.method_1("  >>  Fries cooked too long (" + _loc11_ / 30 + " secs too long).  Score = " + _loc5_.fryScore);
         }
         var _loc15_:Array = _loc5_.gradePourableToppings(_loc9_.frytoppings,_loc10_.fries.fryTopping,"");
         var _loc16_:Number = 0;
         var _loc17_:Number = 0;
         if(_loc15_.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc15_.length)
            {
               _loc16_ += _loc15_[_loc1_];
               _loc17_++;
               _loc1_++;
            }
            _loc2_ = Math.round(_loc16_ / _loc17_);
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            else if(_loc2_ > 100)
            {
               _loc2_ = 100;
            }
            _loc3_ = Math.min(50,100 - _loc2_);
            _loc5_.fryScore -= _loc3_;
         }
         var _loc18_:Number = _loc5_.fryScore;
         if(_loc10_.fries.fryType == _loc9_.fries && _loc5_.gameObj.var_128.hasBonusFurniture("build",_loc9_.fries))
         {
            _loc4_ = Math.random();
            if(_loc4_ < _loc8_)
            {
               _loc5_.fryScore += 2;
               class_7.method_1("  >>  Has Fry Bonus, add 2%");
            }
            else
            {
               _loc5_.fryScore += 1;
               class_7.method_1("  >>  Has Fry Bonus (but low lobby score), add 1%");
            }
         }
         if(_loc5_.fryScore >= 100 && _loc18_ < 100)
         {
            _loc5_.fryScore = 99;
         }
         if(_loc5_.fryScore > 100)
         {
            _loc5_.fryScore = 100;
         }
         if(_loc5_.fryScore < 0 || Boolean(isNaN(_loc5_.fryScore)))
         {
            _loc5_.fryScore = 0;
         }
         _loc5_.fryScore = Math.ceil(_loc5_.fryScore);
         class_7.method_1("Fries Score: " + _loc5_.fryScore + "% ----------------------------------------------------\n");
      }
      
      public function gradePourableToppings(param1:Array, param2:FryTopping, param3:String = "") : Array
      {
         var _loc42_:GiveOrderScreen = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ToppingItem = null;
         var _loc7_:String = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Boolean = false;
         var _loc14_:Number = Number(NaN);
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Number = Number(NaN);
         var _loc18_:int = 0;
         var _loc19_:Number = Number(NaN);
         var _loc20_:Number = Number(NaN);
         var _loc21_:Number = Number(NaN);
         var _loc22_:* = null;
         var _loc23_:Array = null;
         var _loc24_:Number = Number(NaN);
         var _loc25_:Number = Number(NaN);
         var _loc26_:Number = Number(NaN);
         var _loc27_:Number = Number(NaN);
         var _loc28_:Number = Number(NaN);
         var _loc29_:Number = Number(NaN);
         var _loc30_:Number = Number(NaN);
         var _loc31_:int = 0;
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
         _loc42_ = this;
         var _loc43_:UserData = _loc42_.gameObj.var_128;
         var _loc44_:CustomerData = _loc42_.gameObj.var_130;
         this.traceMessage(param3 + " -- >> -- Grade Pourable Toppings -------------------",param3);
         var _loc45_:Array = [];
         var _loc46_:Number = _loc43_.getLobbyPercent();
         var _loc47_:Number = Math.max(param1.length,param2.layerTypes.length);
         _loc4_ = 0;
         while(_loc4_ < _loc47_)
         {
            _loc45_.push(0);
            _loc4_++;
         }
         var _loc48_:Array = [];
         var _loc49_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc49_.push(false);
            _loc48_.push(param1[_loc4_]);
            _loc4_++;
         }
         this.traceMessage(param3 + "  >>  Toppings ordered: " + _loc48_.toString(),param3);
         this.traceMessage(param3 + "  >>  Toppings on food: " + param2.layerTypes.toString(),param3);
         _loc4_ = 0;
         while(_loc4_ < param2.layerTypes.length)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               if(param2.layerTypes[_loc4_] == param1[_loc5_] && _loc49_[_loc5_] === false)
               {
                  _loc49_[_loc5_] = true;
                  _loc45_[_loc4_] = 100;
                  break;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         this.traceMessage(param3 + "  >>  Current Pourable Scores: " + _loc45_.toString(),param3);
         _loc4_ = 0;
         while(_loc4_ < _loc47_)
         {
            _loc11_ = _loc4_;
            _loc12_ = _loc4_;
            _loc13_ = false;
            _loc14_ = 0;
            if(param2.layerTypes.length > _loc12_ && param1.length > _loc11_ && param2.layerTypes[_loc12_] == param1[_loc11_])
            {
               this.traceMessage(param3 + "       >>  Layering Order: " + param2.layerTypes[_loc12_] + " is correct (100%)",param3);
               _loc13_ = true;
               _loc14_ = 100;
            }
            else
            {
               this.traceMessage(param3 + "       >>  Layering Order: " + param2.layerTypes[_loc12_] + " is not correct. (0%)",param3);
               _loc14_ = 0;
            }
            if(!_loc13_ && param2.layerTypes.length > _loc12_)
            {
               _loc15_ = false;
               _loc16_ = false;
               _loc17_ = -1;
               _loc18_ = 0;
               while(_loc18_ < param1.length)
               {
                  if(param1[_loc18_] == param2.layerTypes[_loc12_])
                  {
                     _loc17_ = _loc18_;
                     break;
                  }
                  _loc18_++;
               }
               if(_loc17_ > -1)
               {
                  if(_loc12_ == 0 || param1.length > _loc17_ - 1 && param2.layerTypes[_loc12_ - 1] == param1[_loc17_ - 1])
                  {
                     _loc16_ = true;
                     _loc14_ += 50;
                  }
                  if(_loc12_ == param2.layerTypes.length - 1 || param2.layerTypes.length > _loc12_ + 1 && param1.length > _loc17_ + 1 && param2.layerTypes[_loc12_ + 1] == param1[_loc17_ + 1])
                  {
                     _loc15_ = true;
                     _loc14_ += 50;
                  }
               }
               this.traceMessage(param3 + "       >>  " + param2.layerTypes[_loc12_] + " is NOT correct (+" + _loc14_ + "%) -- below:" + _loc16_ + ", above:" + _loc15_,param3);
            }
            if(_loc45_[_loc12_] > 0)
            {
               _loc19_ = (100 - _loc14_) / 2;
               _loc45_[_loc12_] -= _loc19_;
            }
            _loc4_++;
         }
         this.traceMessage(param3 + "  >>  Current Pourable Scores: " + _loc45_.toString(),param3);
         var _loc50_:Boolean = false;
         var _loc51_:Number = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.layerTypes.length)
         {
            _loc7_ = param2.layerTypes[_loc4_];
            if(_loc48_.indexOf(_loc7_) > -1)
            {
               _loc20_ = 0;
               _loc21_ = 0;
               _loc22_ = "";
               _loc6_ = _loc42_.gameObj.toppingData.getToppingItemData(_loc7_);
               _loc8_ = _loc6_.capacity;
               _loc9_ = Number(param2.layerNodeTallies[_loc4_]);
               _loc10_ = Math.abs(_loc8_ - _loc9_);
               _loc20_ = Math.max(0,100 - _loc10_ * 0.5);
               _loc23_ = param2.layerNodeDistributions[_loc4_];
               _loc24_ = 0;
               _loc25_ = 0;
               _loc26_ = 0;
               _loc27_ = 100;
               _loc28_ = 0;
               _loc29_ = 8;
               this.traceMessage("        >>  " + _loc7_ + ":   " + _loc23_.toString(),param3);
               _loc22_ += "        >>  " + _loc7_ + " Distribution Off (includes " + _loc29_ + "-node OK adjustment):  ";
               _loc30_ = 0;
               if(_loc23_[_loc23_.length - 1] > 0 || _loc23_[_loc23_.length - 2] > 0 || _loc23_[_loc23_.length - 3] > 0 || _loc23_[_loc23_.length - 4] > 0)
               {
                  _loc50_ = true;
                  _loc51_ = _loc51_ + _loc23_[_loc23_.length - 1];
                  _loc51_ = _loc51_ + _loc23_[_loc23_.length - 2];
                  _loc51_ = _loc51_ + _loc23_[_loc23_.length - 3];
                  _loc51_ = _loc51_ + _loc23_[_loc23_.length - 4];
                  _loc30_ = _loc23_[_loc23_.length - 1] + _loc23_[_loc23_.length - 2] + _loc23_[_loc23_.length - 3] + _loc23_[_loc23_.length - 4];
                  _loc22_ += "(Out-of-bounds: " + _loc23_[_loc23_.length - 1] + "|" + _loc23_[_loc23_.length - 2] + "|" + _loc23_[_loc23_.length - 3] + "|" + _loc23_[_loc23_.length - 4] + ") ";
                  _loc42_.buildHadParticlesOff = true;
               }
               _loc22_ += ">>> ";
               _loc31_ = 0;
               while(_loc31_ < _loc23_.length - 4)
               {
                  _loc37_ = 0;
                  if(_loc9_ > 0)
                  {
                     _loc37_ = Math.round(_loc23_[_loc31_] / _loc9_ * 100);
                  }
                  _loc38_ = 100 / (_loc23_.length - 4);
                  _loc39_ = 2;
                  _loc40_ = Math.abs(_loc38_ - _loc37_);
                  if(_loc40_ >= _loc29_)
                  {
                     _loc40_ -= _loc29_;
                  }
                  else
                  {
                     _loc40_ = 0;
                  }
                  _loc22_ += _loc40_ + "(" + _loc37_ + "%) " + "|";
                  _loc27_ -= _loc40_ * _loc39_;
                  if(_loc31_ == 0 || _loc31_ == 3)
                  {
                     _loc28_ += _loc23_[_loc31_];
                  }
                  _loc31_++;
               }
               _loc32_ = 100;
               _loc33_ = 1;
               _loc34_ = 0;
               if(_loc9_ > 0)
               {
                  _loc34_ = Math.round(_loc28_ / _loc9_ * 100);
               }
               _loc35_ = 10;
               if(_loc34_ >= 50 + _loc35_)
               {
                  _loc34_ -= _loc35_;
               }
               else if(_loc34_ <= 50 - _loc35_)
               {
                  _loc34_ += _loc35_;
               }
               else
               {
                  _loc34_ = 50;
               }
               _loc32_ -= Math.abs(50 - _loc34_) * _loc33_;
               _loc22_ += " (Distro = " + _loc27_ + "%, Balance = " + _loc32_ + "% >>> ";
               _loc21_ = Math.max(0,(_loc32_ + _loc27_) / 2);
               _loc22_ += Math.max(0,(_loc32_ + _loc27_) / 2) + "%) ";
               _loc36_ = 100 - (_loc21_ + _loc20_) / 2;
               _loc22_ += " >>> Overall Deduction: " + _loc36_;
               _loc45_[_loc4_] -= _loc36_;
               _loc22_ += " >>> " + _loc30_ + " OOB ";
               if(_loc45_[_loc4_] < 0)
               {
                  _loc45_[_loc4_] = 0;
               }
               this.traceMessage(_loc22_,param3);
            }
            _loc4_++;
         }
         this.traceMessage("  >>  Current Pourable Scores: " + _loc45_.toString(),param3);
         _loc4_ = 0;
         while(_loc4_ < param2.layerTypes.length)
         {
            if(_loc45_[_loc4_] > 0 && (_loc43_.hasBonusFurniture("build",param2.layerTypes[_loc4_]) || _loc43_.hasBonusFurniture("build",FoodData.TOPPING_BACON) && param2.layerTypes[_loc4_] == FoodData.FRYTOPPING_BACON))
            {
               _loc41_ = Math.random();
               if(_loc41_ < _loc46_)
               {
                  _loc45_[_loc4_] += 3;
                  if(_loc45_[_loc4_] > 100)
                  {
                     _loc45_[_loc4_] = 100;
                  }
                  this.traceMessage("Add 2% boost to " + param2.layerTypes[_loc4_] + " -- Rand = " + _loc41_ + ", LobbyPercent = " + _loc46_,param3);
               }
               else
               {
                  _loc45_[_loc4_] += 1;
                  if(_loc45_[_loc4_] > 100)
                  {
                     _loc45_[_loc4_] = 100;
                  }
                  this.traceMessage("Add 1% boost to " + param2.layerTypes[_loc4_] + " -- Rand = " + _loc41_ + ", LobbyPercent = " + _loc46_,param3);
               }
            }
            _loc4_++;
         }
         this.traceMessage(param3 + "  >>  Post-Bonus Pourable Scores: " + _loc45_.toString(),param3);
         return _loc45_;
      }
      
      public function finishGivingOrder(param1:Boolean = false) : void
      {
         var _loc2_:GiveOrderScreen = this;
         _loc2_.isPresentingOrder = false;
         if(param1)
         {
            _loc2_.gameObj.var_205 = true;
            _loc2_.gameObj.hud.disableStationButtons();
            _loc2_.gameObj.hud.startTransition("ending");
         }
         else if(_loc2_.gameObj.var_136.alarmsRunning > 0)
         {
            _loc2_.gameObj.hud.startTransition("cook");
         }
         else if(_loc2_.gameObj.var_131.alarmsRunning > 0)
         {
            _loc2_.gameObj.hud.startTransition("fry");
         }
         else if(_loc2_.gameObj.var_131.isSandwichWaiting())
         {
            _loc2_.gameObj.hud.startTransition("fry");
         }
         else if(_loc2_.gameObj.var_136.getTotalSandwichesCooking() > 0)
         {
            _loc2_.gameObj.hud.startTransition("cook");
         }
         else if(_loc2_.gameObj.var_136.waitingSandwiches.length > 0)
         {
            _loc2_.gameObj.hud.startTransition("cook");
         }
         else if(_loc2_.gameObj.var_139.currentOrder != null)
         {
            _loc2_.gameObj.hud.startTransition("build");
         }
         else
         {
            _loc2_.gameObj.hud.startTransition("order");
         }
      }
      
      protected function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc6_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:GiveOrderScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Bitmap = null;
         var _loc5_:MovieClip = new orderBackdropMC();
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc5_.holder.wallparts["wall" + _loc1_].gotoAndStop(_loc3_.lobbyWallpaper);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            _loc5_.holder.floorparts["floor" + _loc1_].gotoAndStop(_loc3_.lobbyFlooring);
            _loc1_++;
         }
         _loc5_.holder.trim.transform.colorTransform = _loc2_.createColorTransform(_loc3_.lobbyTrim);
         _loc5_.holder.wallparts.mask = _loc5_.holder.wallmask;
         _loc5_.holder.floorparts.mask = _loc5_.holder.floormask;
         _loc6_ = new BitmapData(706,552,true,0);
         _loc6_.draw(_loc5_,null,null,null,new Rectangle(0,0,706,552));
         _loc4_ = new Bitmap(_loc6_);
         _loc5_ = null;
         return _loc4_;
      }
      
      protected function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
      }
      
      public function initStationUpgrades() : void
      {
         var _loc1_:GiveOrderScreen = this;
         if(_loc1_.backdropBitmap != null)
         {
            _loc1_.backdropBitmap.bitmapData.dispose();
            try
            {
               _loc1_.clip.backdrop_holder.removeChild(_loc1_.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            _loc1_.backdropBitmap = null;
         }
         _loc1_.backdropBitmap = _loc1_.createLobbyBackdropBitmap();
         _loc1_.clip.backdrop_holder.addChild(_loc1_.backdropBitmap);
         _loc1_.backdropBitmap.x = -24;
         _loc1_.backdropBitmap.y = -40;
         _loc1_.countertopMC = new giveorder_countertop();
         _loc1_.countertopMC.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTop);
         _loc1_.clip.countertop.addChild(_loc1_.countertopMC);
      }
      
      public function getClothingBonus() : Number
      {
         var _loc1_:GiveOrderScreen = this;
         var _loc2_:Number = _loc1_.gameObj.var_128.getHolidayClothingItemsWorn(false);
         class_7.method_1("(Worker wearing " + _loc2_ + " holiday items.)");
         return _loc2_ * _loc1_.extraTipPerClothingItem;
      }
      
      public function getWorkerClothingTags() : Array
      {
         var _loc1_:GiveOrderScreen = this;
         return _loc1_.gameObj.workerData.getClothingTags();
      }
      
      public function getTextGlowColor() : uint
      {
         var _loc1_:GiveOrderScreen = this;
         var _loc2_:uint = _loc1_.gameObj.var_128.lobbyTop;
         var _loc3_:uint = uint((_loc2_ & 0xFF0000) >> 16);
         var _loc4_:uint = uint((_loc2_ & 0xFF00) >> 8);
         var _loc5_:uint = uint(_loc2_ & 0xFF);
         _loc3_ *= 0.5;
         _loc4_ *= 0.5;
         _loc5_ *= 0.5;
         return uint(_loc3_ << 16 | _loc4_ << 8 | _loc5_);
      }
      
      public function traceMessage(param1:String, param2:String = "") : void
      {
         class_7.method_1(param1);
      }
   }
}


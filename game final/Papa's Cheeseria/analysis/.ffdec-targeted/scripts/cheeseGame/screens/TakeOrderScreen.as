package cheeseGame.screens
{
   import cheeseGame.data.UserData;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   import package_2.*;
   import package_4.class_5;
   
   public class TakeOrderScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var isActive:Boolean = false;
      
      public var customerScale:Number = 1.14;
      
      public var customerX:Number = 280;
      
      public var customerY:Number = 95;
      
      public var stepArray:Array;
      
      public var whichStep:Number = -1;
      
      public var stepTimer:Number = 0;
      
      public var lastStepTime:Number = 0;
      
      public var shorterTimingSpacing:Number = 15;
      
      public var timingSpacing:Number = 40;
      
      public var useTimingSpacing:Number = 15;
      
      public var seal0Spacing:Number = 24;
      
      public var seal1Spacing:Number = 18;
      
      public var seal2Spacing:Number = 15;
      
      public var seal3Spacing:Number = 12;
      
      public var isPlacingOrder:Boolean = false;
      
      public var currentTicket:Ticket;
      
      public var currentCustomer:Customer;
      
      public var timeActivated:Number = -1;
      
      public var triedToRestart:Boolean = false;
      
      public var backdropBitmap:Bitmap = null;
      
      public var countertopMC:MovieClip = null;
      
      public var worker:Worker = null;
      
      public var workerStartLabel:String = "starttakeorder";
      
      public var specialBitmap:Bitmap = null;
      
      public function TakeOrderScreen(param1:class_5)
      {
         this.stepArray = [];
         super();
         var _loc2_:TakeOrderScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:TakeOrderScreen = this;
         _loc1_.clip = new takeOrderMC();
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.workerData,-10,192,1.14,true);
      }
      
      public function destroy() : void
      {
         var _loc1_:TakeOrderScreen = this;
         if(_loc1_.countertopMC != null)
         {
            _loc1_.clip.countertop.removeChild(_loc1_.countertopMC);
            _loc1_.countertopMC = null;
         }
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
         _loc1_.worker.destroy();
         _loc1_.worker = null;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.clip = null;
      }
      
      public function activateScreen() : void
      {
         var _loc1_:TakeOrderScreen = this;
         if(!_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         }
         _loc1_.currentCustomer = _loc1_.gameObj.var_134.orderline[0];
         _loc1_.currentCustomer.moveToTakeOrder();
         _loc1_.initializeOrder();
         _loc1_.timeActivated = _loc1_.gameObj.controls.gameplayTimer;
         _loc1_.gameObj.var_129.switchMusic("order");
         _loc1_.isActive = true;
      }
      
      public function deactivateScreen() : void
      {
         var _loc1_:TakeOrderScreen = this;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         if(_loc1_.currentCustomer != null)
         {
            _loc1_.currentCustomer.moveToLeaveLine();
            _loc1_.currentCustomer = null;
         }
         if(_loc1_.currentTicket != null)
         {
            _loc1_.currentTicket.finishDrawingTicket();
            _loc1_.currentTicket = null;
         }
         _loc1_.clip.envelope.stop();
         _loc1_.timeActivated = -1;
         _loc1_.triedToRestart = false;
         _loc1_.isActive = false;
      }
      
      public function initializeOrder() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TakeOrderScreen = this;
         class_7.error("===========================================================================================");
         class_7.error(_loc2_.currentCustomer.customerName + " START TAKING ORDER");
         class_7.error("===========================================================================================");
         _loc2_.isPlacingOrder = true;
         _loc2_.stepTimer = 0;
         _loc2_.lastStepTime = 0;
         _loc2_.whichStep = -1;
         _loc2_.stepArray = [];
         _loc1_ = 0;
         while(_loc1_ < _loc2_.currentCustomer.givingorder.length)
         {
            _loc2_.stepArray.push([_loc1_]);
            _loc1_++;
         }
         _loc2_.clip.bubble.visible = false;
         _loc2_.clip.bubble.clip.gotoAndStop(1);
         _loc2_.currentTicket = _loc2_.gameObj.var_147.addTicket(_loc2_.currentCustomer.customerType);
         _loc2_.gameObj.var_129.playSound("dropticket.wav");
         _loc2_.clip.customername_txt.text = String(_loc2_.currentCustomer.customerName);
         var _loc3_:Number = _loc2_.gameObj.var_128.getCustomerStars(_loc2_.currentCustomer.customerType);
         var _loc4_:Number = _loc2_.gameObj.var_128.getCustomerSeal(_loc2_.currentCustomer.customerType);
         var _loc5_:int = 1;
         while(_loc5_ <= 5)
         {
            if(_loc3_ >= _loc5_)
            {
               _loc2_.clip.stars["star" + _loc5_].gotoAndStop(2);
            }
            else
            {
               _loc2_.clip.stars["star" + _loc5_].gotoAndStop(1);
            }
            _loc5_++;
         }
         if(_loc4_ == 0)
         {
            _loc2_.clip.stars.currentseal.visible = false;
         }
         else
         {
            _loc2_.clip.stars.currentseal.visible = true;
            _loc2_.clip.stars.currentseal.gotoAndStop(_loc4_);
         }
         _loc2_.clip.stars.award.gotoAndStop(1);
         if(_loc2_.currentCustomer.isCloser)
         {
            _loc2_.clip.bubble.gotoAndStop("closer");
         }
         else
         {
            _loc2_.clip.bubble.gotoAndStop("normal");
         }
         var _loc6_:GlowFilter = _loc2_.clip.customername_txt.filters[0];
         if(_loc2_.currentCustomer.isCloser)
         {
            _loc6_.color = 13830400;
         }
         else if(_loc2_.gameObj.var_134.isBringingSpecial(_loc2_.currentCustomer.customerType))
         {
            _loc6_.color = 11692041;
         }
         else
         {
            _loc6_.color = _loc2_.getTextGlowColor();
         }
         if(_loc2_.gameObj.var_134.isBringingSpecial(_loc2_.currentCustomer.customerType))
         {
            _loc2_.clip.customername_txt.textColor = 16775783;
         }
         else
         {
            _loc2_.clip.customername_txt.textColor = 16777215;
         }
         _loc2_.clip.customername_txt.filters = [_loc6_];
         if(_loc2_.gameObj.var_134.isBringingSpecial(_loc2_.currentCustomer.customerType))
         {
            _loc2_.clip.envelope.visible = true;
            _loc2_.clip.envelope.play();
         }
         else
         {
            _loc2_.clip.envelope.visible = false;
            _loc2_.clip.envelope.stop();
         }
         var _loc7_:Number = _loc2_.gameObj.controls.gameplayTimer / _loc2_.gameObj.var_211;
         var _loc8_:Number = _loc2_.gameObj.var_133.getSkyStartingFrame();
         if(_loc7_ > 0.98)
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_ + 6);
         }
         else if(_loc7_ > 0.8)
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_ + 5);
         }
         else if(_loc7_ > 0.65)
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_ + 4);
         }
         else if(_loc7_ > 0.5)
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_ + 3);
         }
         else if(_loc7_ > 0.35)
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_ + 2);
         }
         else if(_loc7_ > 0.2)
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_ + 1);
         }
         else
         {
            _loc2_.clip.bg.gotoAndStop(_loc8_);
         }
         _loc2_.worker.playAnimation(_loc2_.workerStartLabel);
         if(_loc4_ == 0)
         {
            _loc2_.timingSpacing = _loc2_.seal0Spacing;
         }
         else if(_loc4_ == 1)
         {
            _loc2_.timingSpacing = _loc2_.seal1Spacing;
         }
         else if(_loc4_ == 2)
         {
            _loc2_.timingSpacing = _loc2_.seal2Spacing;
         }
         else if(_loc4_ == 3)
         {
            _loc2_.timingSpacing = _loc2_.seal3Spacing;
         }
         if(_loc2_.currentCustomer.customerType == 1 && !_loc2_.gameObj.var_128.hasTrained("critic"))
         {
            _loc2_.gameObj.hud.showContextTraining("critic");
            _loc2_.gameObj.var_128.setTrained("critic");
         }
         else if(_loc2_.currentCustomer.isCloser && !_loc2_.gameObj.var_128.hasTrained("closer"))
         {
            _loc2_.gameObj.hud.showContextTraining("closer");
            _loc2_.gameObj.var_128.setTrained("closer");
         }
         else if(_loc2_.gameObj.var_134.isBringingSpecial(_loc2_.currentCustomer.customerType) && !_loc2_.gameObj.var_128.hasTrained("bringspecial"))
         {
            _loc2_.gameObj.hud.showContextTraining("bringspecial");
            _loc2_.gameObj.var_128.setTrained("bringspecial");
         }
         else if(_loc2_.currentCustomer.isWaiter && !_loc2_.gameObj.var_128.hasTrained("server"))
         {
            _loc2_.gameObj.hud.showContextTraining("server");
            _loc2_.gameObj.var_128.setTrained("server");
         }
         else if(_loc2_.currentCustomer.customerName == "Santa" && !_loc2_.gameObj.var_128.hasTrained("santa"))
         {
            _loc2_.gameObj.hud.showContextTraining("santa");
            _loc2_.gameObj.var_128.setTrained("santa");
         }
      }
      
      public function updateScreen() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:TakeOrderScreen = this;
         if(_loc9_.isPlacingOrder && !_loc9_.gameObj.var_169 && _loc9_.isActive)
         {
            ++_loc9_.stepTimer;
            if(_loc9_.currentCustomer.givingorder == null || _loc9_.currentCustomer.givingorder.length == 0)
            {
               _loc9_.currentCustomer.givingorder = _loc9_.gameObj.var_130.getCustomerOrderForGiving(_loc9_.currentCustomer.customerType);
            }
            if(_loc9_.stepTimer >= _loc9_.useTimingSpacing)
            {
               ++_loc9_.whichStep;
               if(_loc9_.whichStep >= 0 && _loc9_.whichStep < _loc9_.stepArray.length)
               {
                  _loc9_.useTimingSpacing = _loc9_.timingSpacing;
                  try
                  {
                     _loc1_ = _loc9_.currentCustomer.givingorder[_loc9_.stepArray[_loc9_.whichStep][0]][0];
                     _loc2_ = _loc9_.currentCustomer.givingorder[_loc9_.stepArray[_loc9_.whichStep + 1][0]][0];
                  }
                  catch(err:Error)
                  {
                  }
                  _loc9_.startCustomerAnimation();
                  _loc9_.clip.bubble.visible = true;
                  _loc9_.gameObj.var_129.playSound("talkbubble.wav");
                  if(_loc9_.stepArray[_loc9_.whichStep].length == 1 || _loc9_.stepArray[_loc9_.whichStep].length == 2)
                  {
                     _loc3_ = Number(_loc9_.stepArray[_loc9_.whichStep][0]);
                     _loc4_ = _loc9_.currentCustomer.givingorder[_loc3_];
                     _loc5_ = _loc9_.currentCustomer.givingorder[_loc3_][0];
                     if(_loc5_ == "speciallogo")
                     {
                        if(_loc9_.specialBitmap == null)
                        {
                           _loc9_.specialBitmap = new Bitmap(_loc9_.gameObj.var_134.specialBMP,"auto",true);
                           _loc9_.specialBitmap.scaleX = 0.75;
                           _loc9_.specialBitmap.scaleY = 0.75;
                           _loc9_.specialBitmap.x = 140;
                           _loc9_.specialBitmap.y = -13;
                        }
                        if(!_loc9_.clip.bubble.clip.contains(_loc9_.specialBitmap))
                        {
                           _loc9_.clip.bubble.clip.addChild(_loc9_.specialBitmap);
                        }
                        _loc9_.specialBitmap.visible = true;
                     }
                     else if(_loc9_.specialBitmap != null && Boolean(_loc9_.clip.bubble.clip.contains(_loc9_.specialBitmap)))
                     {
                        _loc9_.clip.bubble.clip.removeChild(_loc9_.specialBitmap);
                     }
                     _loc9_.clip.bubble.clip.gotoAndStop(_loc5_);
                     _loc9_.clip.bubble.bg.gotoAndPlay(1);
                     _loc9_.clip.bubble.bg2.gotoAndPlay(1);
                     _loc9_.currentTicket.drawTicketDetails(_loc9_.stepArray[_loc9_.whichStep][0]);
                  }
               }
               else if(_loc9_.whichStep == _loc9_.stepArray.length)
               {
                  _loc9_.finishCustomerAnimation();
                  _loc9_.clip.bubble.visible = false;
                  _loc9_.useTimingSpacing = _loc9_.shorterTimingSpacing;
               }
               else if(_loc9_.currentCustomer != null && _loc9_.currentCustomer.givingorder != null && _loc9_.currentCustomer.givingorder.length > 0 && _loc9_.whichStep > _loc9_.stepArray.length)
               {
                  _loc9_.finishPlacingOrder();
               }
               _loc9_.stepTimer = 0;
            }
         }
         var _loc10_:Number = _loc9_.gameObj.controls.gameplayTimer - _loc9_.timeActivated;
         if(_loc9_.timeActivated > -1 && _loc10_ >= 150)
         {
            if(_loc9_.isActive && !_loc9_.isPlacingOrder && _loc9_.whichStep <= 0)
            {
               if(!_loc9_.triedToRestart)
               {
                  _loc9_.whichStep = -1;
                  _loc9_.isPlacingOrder = true;
                  _loc9_.triedToRestart = true;
                  _loc9_.timeActivated = _loc9_.gameObj.controls.gameplayTimer;
               }
               else
               {
                  _loc6_ = 0;
                  _loc7_ = 0;
                  _loc8_ = 0;
                  try
                  {
                     _loc6_ = _loc9_.currentTicket.ticketNumber;
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     _loc7_ = _loc9_.currentCustomer.customerType;
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     _loc8_ = _loc9_.currentCustomer.givingorder.length;
                  }
                  catch(err:Error)
                  {
                  }
                  class_7.error("STUCK: " + _loc6_ + ", " + _loc7_ + ", " + _loc8_);
               }
            }
         }
         if(_loc9_.isActive)
         {
            _loc9_.worker.animateModel();
         }
      }
      
      public function finishPlacingOrder() : void
      {
         var _loc1_:TakeOrderScreen = this;
         _loc1_.isPlacingOrder = false;
         _loc1_.gameObj.hud.startTransition("order");
      }
      
      protected function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc6_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:TakeOrderScreen = this;
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
         var _loc1_:TakeOrderScreen = this;
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
      
      public function destroyCustomerModel(param1:MovieClip) : void
      {
         var whichClip:MovieClip = param1;
         whichClip.stop();
         try
         {
            whichClip.body.removeChildAt(0);
            whichClip.head.removeChildAt(0);
            whichClip.eyes.removeChildAt(0);
            whichClip.mouth.removeChildAt(0);
            whichClip.neck.removeChildAt(0);
            whichClip.front_shoe.removeChildAt(0);
            whichClip.back_shoe.removeChildAt(0);
            whichClip.fronthand.removeChildAt(0);
            whichClip.backhand.removeChildAt(0);
            whichClip.front_upperarm.removeChildAt(0);
            whichClip.back_upperarm.removeChildAt(0);
            whichClip.front_forearm.removeChildAt(0);
            whichClip.back_forearm.removeChildAt(0);
         }
         catch(err:Error)
         {
            class_7.error("Error removing parts of customer");
         }
         try
         {
            whichClip.hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            whichClip.back_hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
      }
      
      public function getTextGlowColor() : uint
      {
         var _loc1_:TakeOrderScreen = this;
         var _loc2_:uint = _loc1_.gameObj.var_128.lobbyTop;
         var _loc3_:uint = uint((_loc2_ & 0xFF0000) >> 16);
         var _loc4_:uint = uint((_loc2_ & 0xFF00) >> 8);
         var _loc5_:uint = uint(_loc2_ & 0xFF);
         _loc3_ *= 0.5;
         _loc4_ *= 0.5;
         _loc5_ *= 0.5;
         return uint(_loc3_ << 16 | _loc4_ << 8 | _loc5_);
      }
      
      public function startCustomerAnimation() : void
      {
         var _loc1_:TakeOrderScreen = this;
         if(_loc1_.whichStep == 0)
         {
            _loc1_.currentCustomer.clip.gotoAndPlay("takeorder");
         }
      }
      
      public function finishCustomerAnimation() : void
      {
         var _loc1_:TakeOrderScreen = this;
         _loc1_.currentCustomer.clip.gotoAndPlay("stand");
      }
   }
}


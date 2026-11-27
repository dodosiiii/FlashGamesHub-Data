package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.managers.CustomerManager;
   import cheeseGame.screens.GiveOrderScreen;
   import cheeseGame.screens.OrderScreen;
   import cheeseGame.screens.TakeOrderScreen;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class Customer
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var customerType:Number = 1;
      
      public var customerName:String = "Some Guy";
      
      public var isCloser:Boolean = false;
      
      public var isHuge:Boolean = false;
      
      public var timeEntered:Number = 0;
      
      public var timeOrderTaken:Number = 0;
      
      public var customersAlreadyWaiting:Number = 0;
      
      public var currentLine:String;
      
      public var orderIsPlaced:Boolean = false;
      
      public var isWalking:Boolean = false;
      
      public var walkSpeed:Number = 4;
      
      public var walkDir:Number;
      
      public var targetX:Number;
      
      public var order:Array;
      
      public var givingorder:Array;
      
      public var wearingFoamFinger:Boolean = false;
      
      public var wearingGlove:Boolean = false;
      
      public var hasHandExtra:Boolean = false;
      
      public var extraIsBasket:Boolean = false;
      
      public var isWaiter:Boolean = false;
      
      public var waiterObj:Worker = null;
      
      public var diningBuddy:Number = -1;
      
      public function Customer(param1:class_5, param2:Number, param3:Boolean = false, param4:Number = -1)
      {
         var _loc5_:Customer = null;
         super();
         _loc5_ = this;
         _loc5_.gameObj = param1;
         _loc5_.customerType = param2;
         _loc5_.isCloser = _loc5_.gameObj.var_130.isCloser(param2);
         _loc5_.isHuge = _loc5_.gameObj.var_130.isHuge(param2);
         _loc5_.isWaiter = param3;
         _loc5_.diningBuddy = param4;
         _loc5_.defineVars();
         _loc5_.timeEntered = _loc5_.gameObj.controls.gameplayTimer;
         if(_loc5_.isWaiter)
         {
            _loc5_.setupWorker();
         }
         else
         {
            _loc5_.setupCustomer();
         }
         if(!_loc5_.isWaiter || _loc5_.gameObj.var_134.isWaiterInLine() == false)
         {
            _loc5_.startCustomerEntering();
         }
         else if(_loc5_.gameObj.var_134.isWaiterInLine())
         {
            _loc5_.moveToDiningQueue();
         }
         else
         {
            class_7.error("Don\'t know what to do here with this customer: isWaiter: " + _loc5_.isWaiter + ". Waiter in line: " + _loc5_.gameObj.var_134.isWaiterInLine());
         }
         class_7.error("===========================================================================================");
         class_7.error(_loc5_.customerName + " ENTERS");
         class_7.error("===========================================================================================");
      }
      
      public function defineVars() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:CustomerData = _loc1_.gameObj.var_130;
         _loc1_.customerName = _loc2_.getCustomerName(_loc1_.customerType);
         _loc1_.order = _loc2_.getCustomerOrder(_loc1_.customerType);
         _loc1_.givingorder = _loc2_.getCustomerOrderForGiving(_loc1_.customerType);
      }
      
      public function setupWorker() : void
      {
         var _loc1_:Customer = this;
         _loc1_.clip = new MovieClip();
         _loc1_.waiterObj = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.var_151,0,0,1,false,false);
         _loc1_.waiterObj.runOwnAnimations();
      }
      
      public function setupCustomer() : void
      {
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         var _loc14_:Class = null;
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         var _loc17_:MovieClip = null;
         var _loc18_:Class = null;
         var _loc21_:MovieClip = null;
         var _loc22_:MovieClip = null;
         var _loc23_:MovieClip = null;
         var _loc24_:MovieClip = null;
         var _loc25_:MovieClip = null;
         var _loc26_:Class = null;
         var _loc27_:MovieClip = null;
         var _loc28_:MovieClip = null;
         var _loc29_:Class = null;
         var _loc30_:MovieClip = null;
         var _loc31_:Number = NaN;
         var _loc1_:Class = null;
         var _loc2_:Class = null;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Boolean = false;
         var _loc7_:Class = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Customer = this;
         _loc9_.clip = new customerMC();
         var _loc10_:String = _loc9_.gameObj.var_130.getCustomerClipName(_loc9_.customerType);
         var _loc11_:Class = getDefinitionByName("customer_" + _loc10_ + "_body") as Class;
         _loc12_ = new _loc11_();
         _loc12_.name = "clip";
         _loc9_.clip.body.addChild(_loc12_);
         _loc14_ = getDefinitionByName("customer_" + _loc10_ + "_head") as Class;
         _loc13_ = new _loc14_();
         _loc13_.name = "clip";
         _loc9_.clip.head.addChild(_loc13_);
         _loc15_ = _loc9_.gameObj.var_130.getCustomerPart(_loc10_,"eyes",_loc9_.gameObj.var_128.getHolidayMonth());
         _loc15_.name = "clip";
         _loc9_.clip.eyes.addChild(_loc15_);
         _loc16_ = _loc9_.gameObj.var_130.getCustomerPart(_loc10_,"mouth",_loc9_.gameObj.var_128.getHolidayMonth());
         _loc16_.name = "clip";
         _loc9_.clip.mouth.addChild(_loc16_);
         _loc18_ = getDefinitionByName("customer_" + _loc10_ + "_neck") as Class;
         _loc17_ = new _loc18_();
         _loc17_.name = "clip";
         _loc9_.clip.neck.addChild(_loc17_);
         var _loc19_:MovieClip = null;
         var _loc20_:MovieClip = null;
         try
         {
            _loc1_ = getDefinitionByName("customer_" + _loc10_ + "_hair") as Class;
            _loc19_ = new _loc1_();
            _loc19_.name = "clip";
            _loc9_.clip.hair.addChild(_loc19_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc2_ = getDefinitionByName("customer_" + _loc10_ + "_back_hair") as Class;
            _loc20_ = new _loc2_();
            _loc20_.name = "clip";
            _loc9_.clip.back_hair.addChild(_loc20_);
         }
         catch(err:Error)
         {
         }
         _loc21_ = _loc9_.gameObj.var_130.getCustomerPart(_loc10_,"foot",_loc9_.gameObj.var_128.getHolidayMonth());
         _loc21_.name = "clip";
         _loc9_.clip.front_shoe.addChild(_loc21_);
         _loc22_ = _loc9_.gameObj.var_130.getCustomerPart(_loc10_,"foot",_loc9_.gameObj.var_128.getHolidayMonth());
         _loc22_.name = "clip";
         _loc9_.clip.back_shoe.addChild(_loc22_);
         _loc23_ = _loc9_.gameObj.var_130.getCustomerPart(_loc10_,"hand",_loc9_.gameObj.var_128.getHolidayMonth());
         _loc23_.name = "clip";
         _loc9_.clip.fronthand.addChild(_loc23_);
         if(_loc9_.gameObj.var_134 != null && _loc9_.gameObj.var_134.isBringingSpecial(_loc9_.customerType))
         {
            _loc9_.extraIsBasket = false;
            _loc3_ = new handextra_envelope();
            _loc9_.clip.handextra.addChild(_loc3_);
            _loc9_.hasHandExtra = true;
         }
         else if(_loc9_.gameObj.var_130.getCustomerHolidayHandExtra(_loc9_.customerType,_loc9_.gameObj.var_128.getHolidayMonth()) != null || Math.random() > 0.8)
         {
            _loc4_ = null;
            _loc5_ = _loc9_.gameObj.var_128.getMonth();
            _loc6_ = _loc9_.gameObj.var_128.isNewYear();
            if(!(_loc5_ == GameData.STARTER_MONTH && _loc6_ == false))
            {
               _loc9_.extraIsBasket = false;
               if(_loc5_ == 1)
               {
                  _loc4_ = "jubizela";
               }
               else if(_loc5_ == 2)
               {
                  _loc4_ = "rose";
               }
               else if(_loc5_ == 3)
               {
                  _loc4_ = "paddyflag";
               }
               else if(_loc5_ == 4)
               {
                  _loc4_ = "easterbasket";
                  _loc9_.extraIsBasket = true;
               }
               else if(_loc5_ == 5)
               {
                  _loc4_ = "maracas";
               }
               else if(_loc5_ == 6)
               {
                  _loc4_ = "summerfan";
               }
               else if(_loc5_ == 7)
               {
                  _loc4_ = "sparkler";
               }
               else if(_loc5_ == 8)
               {
                  _loc4_ = "woodenspoon";
               }
               else if(_loc5_ == 9)
               {
                  _loc4_ = "maplejug";
               }
               else if(_loc5_ == 10)
               {
                  _loc4_ = "candypail";
                  _loc9_.extraIsBasket = true;
               }
               else if(_loc5_ == 11)
               {
                  _loc4_ = "turkeyleg";
               }
               else if(_loc5_ == 12)
               {
                  _loc4_ = "candycane";
               }
               if(_loc9_.gameObj.var_130.getCustomerHolidayHandExtra(_loc9_.customerType,_loc9_.gameObj.var_128.getHolidayMonth()) != null)
               {
                  _loc4_ = _loc9_.gameObj.var_130.getCustomerHolidayHandExtra(_loc9_.customerType);
               }
               _loc7_ = getDefinitionByName("handextra_" + _loc4_) as Class;
               _loc8_ = new _loc7_();
               _loc9_.clip.handextra.addChild(_loc8_);
               _loc9_.clip.frontHandClosed = true;
               _loc9_.hasHandExtra = true;
            }
         }
         _loc24_ = _loc9_.gameObj.var_130.getCustomerPart(_loc10_,"hand2",_loc9_.gameObj.var_128.getHolidayMonth());
         _loc24_.name = "clip";
         _loc9_.clip.backhand.addChild(_loc24_);
         _loc26_ = getDefinitionByName("customer_" + _loc10_ + "_upperarm") as Class;
         _loc25_ = new _loc26_();
         _loc25_.name = "clip";
         _loc9_.clip.front_upperarm.addChild(_loc25_);
         _loc27_ = new _loc26_();
         _loc27_.name = "clip";
         _loc9_.clip.back_upperarm.addChild(_loc27_);
         _loc29_ = getDefinitionByName("customer_" + _loc10_ + "_forearm") as Class;
         _loc28_ = new _loc29_();
         _loc28_.name = "clip";
         _loc9_.clip.front_forearm.addChild(_loc28_);
         _loc30_ = new _loc29_();
         _loc30_.name = "clip";
         _loc9_.clip.back_forearm.addChild(_loc30_);
         _loc31_ = _loc9_.gameObj.var_130.getCustomerHolidayOutfitMonth(_loc9_.customerType);
         if(_loc31_ > 0 && _loc9_.gameObj.var_128.getMonth() == _loc31_)
         {
            _loc12_.gotoAndStop(2);
            _loc25_.gotoAndStop(2);
            _loc27_.gotoAndStop(2);
            _loc28_.gotoAndStop(2);
            _loc30_.gotoAndStop(2);
            _loc17_.gotoAndStop(2);
            _loc13_.gotoAndStop(2);
            if(_loc19_)
            {
               _loc19_.gotoAndStop(2);
            }
            if(_loc20_)
            {
               _loc20_.gotoAndStop(2);
            }
         }
         else
         {
            _loc12_.gotoAndStop(1);
            _loc25_.gotoAndStop(1);
            _loc27_.gotoAndStop(1);
            _loc28_.gotoAndStop(1);
            _loc30_.gotoAndStop(1);
            _loc17_.gotoAndStop(1);
            _loc13_.gotoAndStop(1);
            if(_loc19_)
            {
               _loc19_.gotoAndStop(1);
            }
            if(_loc20_)
            {
               _loc20_.gotoAndStop(1);
            }
         }
      }
      
      public function startCustomerEntering() : void
      {
         var _loc4_:Number = NaN;
         var _loc1_:Customer = this;
         var _loc2_:OrderScreen = _loc1_.gameObj.var_145;
         var _loc3_:CustomerManager = _loc1_.gameObj.var_134;
         _loc4_ = _loc3_.orderline.length;
         var _loc5_:Number = _loc4_ + 1;
         _loc2_.clip.orderline_holder.addChild(_loc1_.clip);
         _loc2_.clip.orderline_holder.setChildIndex(_loc1_.clip,0);
         _loc1_.clip.scaleX = _loc2_.orderLineScale;
         _loc1_.clip.scaleY = _loc2_.orderLineScale;
         _loc1_.targetX = _loc2_.orderLineTargetX + _loc4_ * _loc2_.customerSpacing;
         _loc1_.clip.y = _loc2_.orderLineTargetY;
         _loc1_.clip.x = _loc2_.offScreenX + 50;
         _loc1_.walkDir = -1;
         _loc1_.isWalking = true;
         if(_loc3_.totalCustomers == 1)
         {
            _loc1_.clip.x = _loc2_.firstCustomerStartX;
         }
         if(_loc1_.isWaiter == false)
         {
            _loc1_.playAnimation("walk");
         }
         else
         {
            _loc1_.playAnimation("walk");
         }
         _loc1_.currentLine = "orderline";
         _loc3_.orderline.push(_loc1_);
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.walkCustomer);
         }
         _loc1_.gameObj.var_128.addToCustomersToday(_loc1_.customerType);
         _loc3_.gameObj.hud.showCustomerAlert(_loc1_.isWaiter);
      }
      
      public function moveToLeaveLine() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:OrderScreen = _loc1_.gameObj.var_145;
         var _loc3_:CustomerManager = _loc1_.gameObj.var_134;
         _loc2_.clip.leaveline_holder.addChild(_loc1_.clip);
         _loc2_.clip.leaveline_holder.setChildIndex(_loc1_.clip,0);
         _loc1_.clip.scaleX = _loc2_.leaveLineScale * -1;
         _loc1_.clip.scaleY = _loc2_.leaveLineScale;
         _loc1_.targetX = _loc2_.offScreenX + _loc1_.clip.width;
         _loc1_.clip.x = _loc2_.leaveLineTargetX + _loc1_.clip.width;
         _loc1_.clip.y = _loc2_.leaveLineTargetY;
         _loc1_.walkDir = 1;
         _loc1_.isWalking = true;
         if(_loc1_.isWaiter == false)
         {
            _loc1_.playAnimation("walk");
         }
         else
         {
            _loc1_.playAnimation("walk");
         }
         try
         {
            _loc1_.clip.body.clip.logo.gotoAndStop(2);
         }
         catch(err:Error)
         {
         }
         _loc1_.currentLine = "leaveline";
         _loc3_.orderline.shift();
         _loc3_.leaveline.push(_loc1_);
         _loc3_.shiftCustomersInOrderLine();
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.walkCustomer);
         }
         class_7.error("===========================================================================================");
         class_7.error(_loc1_.customerName + " FINISHED TAKING ORDER");
         class_7.error("===========================================================================================");
      }
      
      public function moveToDiningWaiting() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:OrderScreen = _loc1_.gameObj.var_145;
         var _loc3_:CustomerManager = _loc1_.gameObj.var_134;
         class_7.method_1("I\'m a Waiter, move to Dining Waiting instead of the regular waiting line!");
         _loc2_.clip.leaveline_holder.removeChild(_loc1_.clip);
         _loc1_.isWalking = false;
         _loc1_.waiterObj.playAnimation("standpad");
         _loc1_.currentLine = "dining_wait_line";
         _loc3_.leaveline.shift();
         _loc3_.dining_wait_line.push(_loc1_);
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.walkCustomer);
         _loc3_.checkForWaitingDining();
      }
      
      public function removeFromDiningQueue() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:CustomerManager = _loc1_.gameObj.var_134;
         class_7.method_1(_loc1_.customerName + ": Waiter can take my order now.");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.dining_order_line.length)
         {
            if(_loc2_.dining_order_line[_loc3_] == _loc1_)
            {
               _loc2_.dining_order_line.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         _loc1_.startCustomerEntering();
      }
      
      public function moveToDiningQueue() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:CustomerManager = _loc1_.gameObj.var_134;
         class_7.method_1(_loc1_.customerName + ": The waiter is already busy in line.  Wait in the queue for the dining room.");
         _loc1_.currentLine = "dining_order_line";
         _loc2_.dining_order_line.push(_loc1_);
         _loc1_.isWalking = false;
      }
      
      public function moveToWaitLine() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:OrderScreen = _loc1_.gameObj.var_145;
         var _loc3_:CustomerManager = _loc1_.gameObj.var_134;
         var _loc4_:Number = _loc3_.waitline.length;
         _loc2_.clip.waitline_holder.addChild(_loc1_.clip);
         _loc2_.clip.waitline_holder.setChildIndex(_loc1_.clip,0);
         _loc1_.clip.scaleX = _loc2_.waitLineScale;
         _loc1_.clip.scaleY = _loc2_.waitLineScale;
         _loc1_.targetX = _loc2_.waitLineTargetX + _loc4_ * _loc2_.customerSpacing;
         _loc1_.clip.y = _loc2_.waitLineTargetY;
         _loc1_.clip.x = _loc2_.offScreenX;
         _loc1_.walkDir = -1;
         _loc1_.isWalking = true;
         if(_loc1_.isWaiter == false)
         {
            _loc1_.playAnimation("walk");
         }
         else
         {
            _loc1_.playAnimation("walk");
         }
         try
         {
            _loc1_.clip.body.clip.logo.gotoAndStop(1);
         }
         catch(err:Error)
         {
         }
         _loc1_.currentLine = "waitline";
         _loc3_.leaveline.shift();
         _loc3_.waitline.push(_loc1_);
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.walkCustomer);
         }
      }
      
      public function moveToDiningTakeOrder() : void
      {
         var _loc1_:Customer = this;
         _loc1_.timeOrderTaken = _loc1_.gameObj.controls.gameplayTimer;
         _loc1_.customersAlreadyWaiting = _loc1_.gameObj.var_134.waitline.length + _loc1_.gameObj.var_134.leaveline.length + _loc1_.gameObj.var_134.dining_wait_line.length;
      }
      
      public function moveToTakeOrder() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:TakeOrderScreen = _loc1_.gameObj.var_187;
         _loc1_.timeOrderTaken = _loc1_.gameObj.controls.gameplayTimer;
         _loc1_.customersAlreadyWaiting = _loc1_.gameObj.var_134.waitline.length + _loc1_.gameObj.var_134.leaveline.length + _loc1_.gameObj.var_134.dining_wait_line.length;
         _loc2_.clip.customer_holder.addChild(_loc1_.clip);
         _loc1_.clip.scaleX = _loc2_.customerScale;
         _loc1_.clip.scaleY = _loc2_.customerScale;
         _loc1_.clip.x = _loc2_.customerX;
         _loc1_.clip.y = _loc2_.customerY;
         _loc1_.targetX = _loc2_.customerX;
         _loc1_.isWalking = false;
         if(_loc1_.isWaiter == false)
         {
            _loc1_.playAnimation("stand");
         }
         else
         {
            _loc1_.playAnimation("waitplaceorder");
         }
      }
      
      public function moveToReceiveOrder() : void
      {
         var _loc1_:Customer = this;
         var _loc2_:GiveOrderScreen = _loc1_.gameObj.var_183;
         _loc2_.clip.customer_holder.addChild(_loc1_.clip);
         _loc1_.clip.scaleX = _loc2_.customerScale;
         _loc1_.clip.scaleY = _loc2_.customerScale;
         _loc1_.clip.x = _loc2_.customerX;
         _loc1_.clip.y = _loc2_.customerY;
         _loc1_.targetX = _loc2_.customerX;
         _loc1_.isWalking = false;
         if(_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.walkCustomer);
         }
         if(_loc1_.isWaiter == false)
         {
            _loc1_.playAnimation("look");
         }
         else
         {
            _loc1_.playAnimation("stand");
         }
      }
      
      public function destroy() : void
      {
         var ob:Customer = this;
         try
         {
            if(ob.clip.hasEventListener(Event.ENTER_FRAME))
            {
               ob.clip.removeEventListener(Event.ENTER_FRAME,ob.walkCustomer);
            }
         }
         catch(err:Error)
         {
            class_7.error("Error stopping walking on customer.");
         }
         if(ob.isWaiter == false)
         {
            ob.clip.stop();
            try
            {
               ob.clip.body.removeChildAt(0);
               ob.clip.head.removeChildAt(0);
               ob.clip.eyes.removeChildAt(0);
               ob.clip.mouth.removeChildAt(0);
               ob.clip.neck.removeChildAt(0);
               ob.clip.front_shoe.removeChildAt(0);
               ob.clip.back_shoe.removeChildAt(0);
               ob.clip.fronthand.removeChildAt(0);
               ob.clip.backhand.removeChildAt(0);
               ob.clip.front_upperarm.removeChildAt(0);
               ob.clip.back_upperarm.removeChildAt(0);
               ob.clip.front_forearm.removeChildAt(0);
               ob.clip.back_forearm.removeChildAt(0);
            }
            catch(err:Error)
            {
               class_7.error("Error removing parts of customer");
            }
            try
            {
               ob.clip.handextra.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
            try
            {
               ob.clip.hair.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
            try
            {
               ob.clip.back_hair.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
         }
         else if(ob.waiterObj)
         {
            ob.waiterObj.destroy();
            ob.waiterObj = null;
         }
         try
         {
            ob.clip.parent.removeChild(ob.clip);
         }
         catch(err:Error)
         {
         }
         ob.clip = null;
      }
      
      public function walkCustomer(param1:Event = null) : void
      {
         var _loc2_:Customer = this;
         var _loc3_:OrderScreen = _loc2_.gameObj.var_145;
         if(!_loc2_.gameObj.var_169)
         {
            if(_loc2_.walkDir == -1 && _loc2_.clip.x + _loc2_.walkDir * _loc2_.walkSpeed <= _loc2_.targetX)
            {
               _loc2_.clip.x = _loc2_.targetX;
               _loc2_.isWalking = false;
               if(_loc2_.isWaiter == false)
               {
                  _loc2_.playAnimation("stand");
               }
               else
               {
                  _loc2_.playAnimation("standpad");
               }
               if(_loc2_.currentLine == "orderline")
               {
                  if(_loc2_.gameObj.var_134.orderline[0] == _loc2_)
                  {
                     _loc3_.showTakeOrderBubble(_loc2_.isCloser);
                  }
               }
               _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.walkCustomer);
            }
            else if(_loc2_.walkDir == 1 && _loc2_.clip.x + _loc2_.walkDir * _loc2_.walkSpeed >= _loc2_.targetX)
            {
               _loc2_.clip.x = _loc2_.targetX;
               if(_loc2_.isWaiter == false)
               {
                  _loc2_.playAnimation("stand");
               }
               else
               {
                  _loc2_.playAnimation("standpad");
               }
               if(_loc2_.currentLine == "leaveline")
               {
                  if(_loc2_.isWaiter == false)
                  {
                     _loc2_.moveToWaitLine();
                  }
                  else
                  {
                     _loc2_.moveToDiningWaiting();
                  }
               }
               else
               {
                  _loc2_.isWalking = false;
                  _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.walkCustomer);
               }
            }
            else
            {
               _loc2_.isWalking = true;
               _loc2_.clip.x += _loc2_.walkDir * _loc2_.walkSpeed;
            }
         }
      }
      
      public function resetContainer() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Customer = this;
         var _loc3_:OrderScreen = _loc2_.gameObj.var_145;
         var _loc4_:CustomerManager = _loc2_.gameObj.var_134;
         if(_loc2_.currentLine == "waitline")
         {
            if(!_loc3_.clip.waitline_holder.contains(_loc2_.clip))
            {
               _loc3_.clip.waitline_holder.addChild(_loc2_.clip);
               _loc3_.clip.waitline_holder.setChildIndex(_loc2_.clip,0);
               _loc1_ = 0;
               while(true)
               {
                  if(_loc1_ < _loc4_.waitline.length)
                  {
                     if(_loc4_.waitline[_loc1_] == _loc2_)
                     {
                        _loc2_.clip.x = _loc3_.waitLineTargetX + _loc1_ * _loc3_.customerSpacing;
                        _loc2_.clip.y = _loc3_.waitLineTargetY;
                     }
                  }
               }
            }
         }
         else if(_loc2_.currentLine == "orderline")
         {
            if(!_loc3_.clip.orderline_holder.contains(_loc2_.clip))
            {
               _loc3_.clip.orderline_holder.addChild(_loc2_.clip);
               _loc3_.clip.orderline_holder.setChildIndex(_loc2_.clip,0);
               _loc1_ = 0;
               while(_loc1_ < _loc4_.orderline.length)
               {
                  if(_loc4_.orderline[_loc1_] == _loc2_)
                  {
                     _loc2_.clip.x = _loc3_.orderLineTargetX + _loc1_ * _loc3_.customerSpacing;
                     _loc2_.clip.y = _loc3_.orderLineTargetY;
                     break;
                  }
                  _loc1_++;
               }
            }
         }
      }
      
      public function shiftInOrderLine(param1:Number) : void
      {
         var _loc2_:Customer = this;
         _loc2_.targetX = param1;
         if(!_loc2_.isWalking)
         {
            _loc2_.clip.x = _loc2_.targetX;
         }
         if(!_loc2_.isWalking && _loc2_.gameObj.var_134.orderline[0] == _loc2_)
         {
            _loc2_.gameObj.var_145.showTakeOrderBubble(_loc2_.isCloser);
         }
      }
      
      public function shiftInWaitLine(param1:Number) : void
      {
         var _loc2_:Customer = this;
         _loc2_.targetX = param1;
         if(!_loc2_.isWalking)
         {
            _loc2_.clip.x = _loc2_.targetX;
         }
      }
      
      public function getOkayWaitingTime() : Number
      {
         var _loc1_:Customer = this;
         var _loc2_:Number = 0;
         return Number(FoodData.getTargetCookTime(_loc1_.order[2][0]));
      }
      
      public function playAnimation(param1:String) : void
      {
         var _loc2_:Customer = this;
         if(_loc2_.isWaiter == false)
         {
            _loc2_.clip.gotoAndPlay(param1);
         }
         else if(_loc2_.waiterObj)
         {
            _loc2_.waiterObj.playAnimation(param1);
         }
      }
   }
}


package cheeseGame.managers
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import cheeseGame.screens.OrderScreen;
   import flash.display.BitmapData;
   import package_2.*;
   import package_4.class_5;
   
   public class CustomerManager
   {
      
      public var gameObj:class_5;
      
      public var totalCustomers:Number = 0;
      
      public var orderline:Array;
      
      public var leaveline:Array;
      
      public var waitline:Array;
      
      public var specialBMP:BitmapData = null;
      
      public var numberOfCustomers:Array;
      
      public var customerLineup:Array;
      
      public var minSpawnTiming:Number = 0;
      
      public var spawnTiming:Number = 0;
      
      public var firstSpawnTiming:Number = 1050;
      
      public var secondSpawnTiming:Number = 1350;
      
      public var lastSpawnTime:Number = 0;
      
      public var totalTime:Number = 0;
      
      public var showNewCustomer:Boolean = false;
      
      public var showNewCustomerNum:Number = 1;
      
      public var specialCustomers:Array;
      
      public var customerBringingSpecial:Number = -1;
      
      public var whichSpecialToEarn:Number = -1;
      
      public var diningLineup:Array;
      
      public var diningBuddies:Array;
      
      public var dining_wait_line:Array;
      
      public var dining_order_line:Array;
      
      public var didSkipTraining:Boolean = false;
      
      public function CustomerManager(param1:class_5)
      {
         this.orderline = [];
         this.leaveline = [];
         this.waitline = [];
         this.numberOfCustomers = [4,4,5,5,5,5,6,6,6,6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,8];
         this.customerLineup = [];
         this.specialCustomers = [];
         this.diningLineup = [];
         this.diningBuddies = [];
         this.dining_wait_line = [];
         this.dining_order_line = [];
         super();
         var _loc2_:CustomerManager = this;
         _loc2_.gameObj = param1;
         _loc2_.setupManager();
      }
      
      public function setupManager() : void
      {
         var _loc1_:CustomerManager = this;
         _loc1_.totalCustomers = 0;
         _loc1_.orderline = [];
         _loc1_.leaveline = [];
         _loc1_.waitline = [];
         _loc1_.customerLineup = [];
         _loc1_.diningLineup = [];
         _loc1_.diningBuddies = [];
         _loc1_.dining_order_line = [];
         _loc1_.dining_wait_line = [];
      }
      
      public function setupLineup() : void
      {
         var _loc1_:CustomerManager = this;
         if(_loc1_.gameObj.var_128.currentDay == 1)
         {
            _loc1_.trainingLineup();
         }
         else
         {
            _loc1_.decideLineup();
         }
         if(_loc1_.specialBMP)
         {
            _loc1_.specialBMP.dispose();
            _loc1_.specialBMP = null;
         }
         if(_loc1_.gameObj.var_128.currentSpecial > -1)
         {
            _loc1_.specialBMP = _loc1_.gameObj.var_133.getSpecialLogo(_loc1_.gameObj.var_128.currentSpecial);
         }
      }
      
      public function trainingLineup() : void
      {
         var _loc1_:CustomerManager = this;
         _loc1_.customerLineup = [8,9];
         _loc1_.diningLineup = [false,false];
         _loc1_.diningBuddies = [-1,-1];
      }
      
      public function decideLineup() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Array = null;
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:Array = null;
         var _loc19_:int = 0;
         var _loc20_:Number = Number(NaN);
         var _loc21_:Number = Number(NaN);
         var _loc22_:Number = Number(NaN);
         var _loc23_:Array = null;
         var _loc24_:Number = Number(NaN);
         var _loc25_:Array = null;
         var _loc26_:Array = null;
         var _loc27_:CustomerManager = this;
         var _loc28_:UserData = _loc27_.gameObj.var_128;
         var _loc29_:Number = _loc27_.gameObj.var_128.getRank();
         var _loc30_:Number = 0;
         if(_loc29_ >= _loc27_.numberOfCustomers.length)
         {
            _loc30_ = _loc27_.numberOfCustomers.length - 1;
         }
         else
         {
            _loc30_ = _loc29_;
         }
         var _loc31_:Number = Number(_loc27_.numberOfCustomers[_loc30_]);
         _loc31_ = _loc31_ - 1;
         var _loc32_:Array = _loc28_.getCustomerPool(_loc31_);
         var _loc33_:Number = _loc28_.getNewestCustomer();
         var _loc34_:Number = _loc28_.getCloserCustomer();
         var _loc35_:Array = [];
         if(_loc28_.getMonth() != GameData.STARTER_MONTH || _loc28_.isNewYear())
         {
            _loc35_ = _loc27_.gameObj.var_130.getCustomersWithHolidayOrder(_loc28_.getMonth(),_loc28_.getCustomerPool(int.MAX_VALUE));
         }
         var _loc36_:Number = 0;
         var _loc37_:Number = Math.max(2,_loc27_.numberOfCustomers[_loc30_] - 4);
         if(_loc28_.getMonth() == GameData.STARTER_MONTH && _loc28_.isNewYear() == false)
         {
            _loc37_ = 0;
         }
         class_7.method_1("-- Possible Customers: " + _loc32_.toString() + ".  New Customer: " + _loc33_ + ". Closer Customer: " + _loc34_ + ". Holiday Orders: " + _loc35_.toString() + ". Target Holiday # to use: " + _loc37_);
         var _loc38_:Array = [];
         _loc27_.customerLineup = [];
         if(_loc28_.isBeyondFullYear() && _loc35_.length > 0)
         {
            if(_loc28_.getCustomerTotalOrders(_loc33_) > 0)
            {
               try
               {
                  _loc2_ = Number(_loc35_[Math.floor(Math.random() * _loc35_.length)]);
                  _loc35_.splice(_loc35_.indexOf(_loc2_),1);
                  _loc36_++;
                  class_7.method_1("(It\'s a New Year, the newest (" + _loc33_ + ") is actually old, pick a holiday customer instead: " + _loc2_ + ")");
                  _loc33_ = _loc2_;
               }
               catch(err:Error)
               {
               }
            }
            else
            {
               class_7.method_1("(It\'s a New Year, but you haven\'t served the newest customer yet! (" + _loc33_ + ")  Don\'t change anything.)");
            }
         }
         if(_loc33_ > 0)
         {
            _loc27_.customerLineup.push(_loc33_);
            _loc38_.push(_loc27_.customerLineup.length - 1);
            if(_loc32_.indexOf(_loc33_) > -1)
            {
               _loc32_.splice(_loc32_.indexOf(_loc33_),1);
            }
            if(_loc35_.indexOf(_loc33_) > -1)
            {
               _loc35_.splice(_loc35_.indexOf(_loc33_),1);
               _loc36_++;
            }
            _loc31_--;
            if(this.gameObj.var_128.alreadyEarnedCustomer(_loc33_))
            {
               class_7.method_1("Already Earned Customer " + _loc33_ + ".");
               _loc27_.showNewCustomer = false;
            }
            else
            {
               class_7.method_1("Customer " + _loc33_ + " is new!");
               _loc27_.showNewCustomer = true;
               _loc27_.showNewCustomerNum = _loc33_;
            }
         }
         class_7.method_1("Which Topping to Reveal/Feature: " + this.gameObj.var_128.getToppingToReveal());
         if(this.gameObj.var_128.getToppingToReveal() != "none")
         {
            if(_loc33_ > 0 && _loc27_.gameObj.var_130.customersHaveTopping(_loc33_,this.gameObj.var_128.getToppingToReveal()))
            {
               class_7.method_1("Customer " + _loc33_ + " is already ordering " + this.gameObj.var_128.getToppingToReveal() + ". Don\'t need to add one in for this.");
            }
            else
            {
               _loc3_ = _loc27_.gameObj.var_130.getCustomerWithTopping(this.gameObj.var_128.getToppingToReveal(),_loc32_);
               if(_loc3_ > 0)
               {
                  if(_loc27_.customerLineup.indexOf(_loc3_) == -1)
                  {
                     class_7.method_1("Add Customer " + _loc3_ + " to order " + this.gameObj.var_128.getToppingToReveal());
                     _loc27_.customerLineup.push(_loc3_);
                     _loc38_.push(_loc27_.customerLineup.length - 1);
                     if(_loc32_.indexOf(_loc3_) > -1)
                     {
                        _loc32_.splice(_loc32_.indexOf(_loc3_),1);
                     }
                     if(_loc35_.indexOf(_loc3_) > -1)
                     {
                        _loc35_.splice(_loc35_.indexOf(_loc3_),1);
                        _loc36_++;
                     }
                     _loc31_--;
                  }
               }
               else
               {
                  class_7.method_1("Couldn\'t find a Customer to order " + this.gameObj.var_128.getToppingToReveal());
               }
            }
         }
         else
         {
            class_7.method_1("No new toppings to feature.");
         }
         _loc1_ = 0;
         while(_loc1_ < _loc31_)
         {
            if(_loc32_.length > 0)
            {
               _loc4_ = _loc32_.length;
               _loc5_ = Math.floor(Math.random() * _loc4_);
               _loc6_ = Number(_loc32_[_loc5_]);
               _loc27_.customerLineup.push(_loc6_);
               _loc32_.splice(_loc5_,1);
               if(_loc35_.indexOf(_loc6_) > -1)
               {
                  _loc35_.splice(_loc35_.indexOf(_loc6_),1);
                  _loc36_++;
               }
            }
            _loc1_++;
         }
         _loc27_.customerLineup.push(_loc34_);
         _loc38_.push(_loc27_.customerLineup.length - 1);
         if(_loc36_ < _loc37_)
         {
            _loc1_ = 2;
            while(_loc1_ < this.customerLineup.length - 1)
            {
               if(_loc36_ < _loc37_ && _loc35_.length > 0)
               {
                  if(_loc27_.gameObj.var_130.customersHaveHolidayOrder(this.customerLineup[_loc1_],_loc28_.getMonth()) == false)
                  {
                     _loc7_ = Number(_loc35_[Math.floor(Math.random() * _loc35_.length)]);
                     _loc35_.splice(_loc35_.indexOf(_loc7_),1);
                     _loc36_++;
                     class_7.method_1(" -- Not enough holiday, replace " + this.customerLineup[_loc1_] + " with a holiday guy: " + _loc7_);
                     this.customerLineup[_loc1_] = _loc7_;
                     _loc38_.push(_loc1_);
                  }
               }
               _loc1_++;
            }
         }
         if(_loc28_.getMonth() == GameData.MONTH_DECEMBER)
         {
            _loc8_ = _loc27_.gameObj.var_130.getCustomerIndex("Santa");
            if(this.customerLineup.indexOf(_loc8_) == -1)
            {
               class_7.method_1(" -- Add Santa to the Lineup");
               this.customerLineup[2] = _loc8_;
               _loc38_.push(2);
            }
            else
            {
               class_7.method_1(" -- Santa was already in the Lineup (#" + this.customerLineup.indexOf(_loc8_) + ")");
            }
         }
         class_7.method_1("--- Lineup Before Specials: " + this.customerLineup.toString());
         _loc27_.specialCustomers = [];
         if(_loc28_.currentSpecial != -1)
         {
            _loc9_ = _loc27_.gameObj.var_130.getCustomersForSpecial();
            _loc10_ = -1;
            _loc11_ = _loc9_.indexOf(this.customerLineup[0]);
            if(_loc11_ > -1)
            {
               class_7.method_1("--- first customer was in the lineup of possible guys ordering specials.  remove him!");
               _loc9_.splice(_loc11_,1);
               if(_loc9_.length == 0)
               {
                  class_7.error(" --- UH OH, now NOBODY will order it!  This isn\'t good...");
               }
            }
            _loc12_ = 1;
            if(_loc28_.hasBonus("specialsign") && _loc28_.showSpecialSign === 1)
            {
               _loc12_ = 2;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc12_)
            {
               if(_loc9_.length > 0)
               {
                  _loc14_ = false;
                  if(_loc28_.hasTrained("cheatsheet"))
                  {
                     _loc15_ = 0;
                     while(_loc15_ < _loc9_.length)
                     {
                        if(this.customerLineup.indexOf(_loc9_[_loc15_]) > 0 && _loc27_.specialCustomers.indexOf(_loc9_[_loc15_]) == -1)
                        {
                           class_7.method_1(" -- " + _loc9_[_loc15_] + " was already in today\'s lineup, use him for the special!");
                           _loc27_.specialCustomers.push(_loc9_[_loc15_]);
                           _loc38_.push(this.customerLineup.indexOf(_loc9_[_loc15_]));
                           _loc10_ = this.customerLineup.indexOf(_loc9_[_loc15_]);
                           _loc9_.splice(_loc15_,1);
                           _loc14_ = true;
                           break;
                        }
                        _loc15_++;
                     }
                  }
                  if(_loc14_ == false)
                  {
                     _loc16_ = Math.floor(Math.random() * _loc9_.length);
                     _loc17_ = Number(_loc9_[_loc16_]);
                     _loc18_ = [];
                     _loc19_ = 0;
                     while(_loc19_ < this.customerLineup.length)
                     {
                        if(_loc38_.indexOf(_loc19_) == -1)
                        {
                           _loc18_.push(_loc19_);
                        }
                        _loc19_++;
                     }
                     if(_loc28_.hasTrained("cheatsheet") == false && _loc13_ == 0)
                     {
                        class_7.method_1(" ---- SPECIAL ---- FIRST TIME ---- MAKE SECOND CUSTOMER ORDER IT");
                        _loc20_ = this.customerLineup.indexOf(_loc17_);
                        _loc21_ = Number(this.customerLineup[1]);
                        this.customerLineup[1] = _loc17_;
                        _loc10_ = 1;
                        _loc38_.push(1);
                        if(_loc20_ > -1 && _loc20_ != 1)
                        {
                           class_7.method_1(" ------------- UH OH, this customer was already in the lineup!  Do a switcheroo between " + _loc17_ + " and " + _loc21_);
                           this.customerLineup[_loc20_] = _loc21_;
                           _loc38_.push(_loc20_);
                        }
                     }
                     else if(_loc18_.length == 0)
                     {
                        if(_loc13_ == 1 && _loc10_ == 2)
                        {
                           class_7.method_1(" -- SECOND special, nowhere to squeeze him, first guy was already at 2.  make this guy at 3. (Customer +" + _loc17_ + ")");
                           this.customerLineup[3] = _loc17_;
                        }
                        else if(_loc13_ == 1 && _loc10_ == 3)
                        {
                           class_7.method_1(" -- SECOND special, nowhere to squeeze him, first guy was already at 3.  make this guy at 2. (Customer +" + _loc17_ + ")");
                           this.customerLineup[2] = _loc17_;
                        }
                        else if(this.customerLineup.length > 4 && _loc10_ != 3)
                        {
                           class_7.method_1(" -- Nowhere to squeeze a special-ordering guy?  I guess make him at index 3. (Customer " + _loc17_ + ")");
                           this.customerLineup[3] = _loc17_;
                           _loc10_ = 3;
                           _loc38_.push(3);
                        }
                        else
                        {
                           class_7.method_1(" -- Nowhere at all to squeeze a special-ordering guy?  I guess make him at index 2. (Customer " + _loc17_ + ")");
                           this.customerLineup[2] = _loc17_;
                           _loc10_ = 2;
                           _loc38_.push(2);
                        }
                     }
                     else
                     {
                        _loc22_ = Number(_loc18_[Math.floor(Math.random() * _loc18_.length)]);
                        class_7.method_1(" -- Add a special-ordering guy at " + _loc22_ + ". (Customer " + _loc17_ + ")");
                        this.customerLineup[_loc22_] = _loc17_;
                        _loc10_ = _loc22_;
                        _loc38_.push(_loc22_);
                     }
                     _loc27_.specialCustomers.push(_loc17_);
                     _loc9_.splice(_loc16_,1);
                  }
               }
               else
               {
                  class_7.error("ERROR: Needed another customer to order a special, but there was nobody left!  Yikes!");
               }
               _loc13_++;
            }
         }
         _loc27_.diningLineup = [];
         _loc27_.diningBuddies = [];
         _loc1_ = 0;
         while(_loc1_ < _loc27_.customerLineup.length)
         {
            _loc27_.diningLineup.push(false);
            _loc27_.diningBuddies.push(-1);
            _loc1_++;
         }
         if(_loc28_.getDay() >= GameData.DAY_TO_HIRE)
         {
            _loc23_ = _loc28_.getCustomerPool(99,true);
            _loc1_ = _loc23_.length - 1;
            while(_loc1_ >= 0)
            {
               if(_loc27_.customerLineup.indexOf(_loc23_[_loc1_]) > -1)
               {
                  _loc23_.splice(_loc1_,1);
               }
               _loc1_--;
            }
            _loc1_ = 1;
            while(_loc1_ < _loc27_.customerLineup.length - 1)
            {
               if(_loc1_ == 1 || _loc1_ == _loc27_.customerLineup.length - 2 && _loc27_.customerLineup.length > 4)
               {
                  _loc27_.diningLineup[_loc1_] = true;
                  if(_loc23_ != null && _loc23_.length > 0)
                  {
                     _loc24_ = Math.floor(Math.random() * _loc23_.length);
                     _loc27_.diningBuddies[_loc1_] = _loc23_[_loc24_];
                     _loc23_.splice(_loc24_,1);
                  }
               }
               _loc1_++;
            }
         }
         _loc27_.customerBringingSpecial = -1;
         _loc27_.whichSpecialToEarn = -1;
         if(_loc27_.gameObj.var_128.currentDay - _loc27_.gameObj.var_128.lastDaySpecialEarned >= GameData.DELAY_BETWEEN_BRINGING_SPECIALS)
         {
            class_7.method_1(" -- You can earn a new special today!");
            _loc25_ = _loc27_.gameObj.var_133.getPossibleSpecialsToEarn();
            if(_loc25_.length == 0)
            {
               class_7.method_1(" -- -- BUT NONE ARE AVAILABLE!  Wait to get a new one later.");
            }
            else
            {
               _loc27_.whichSpecialToEarn = _loc25_[Math.floor(Math.random() * _loc25_.length)];
               class_7.method_1(" -- -- Will Possibly Earn Special #" + _loc27_.whichSpecialToEarn);
               _loc26_ = [];
               _loc1_ = 1;
               while(_loc1_ < this.customerLineup.length - 1)
               {
                  if(this.diningLineup[_loc1_] != true)
                  {
                     if(this.specialCustomers.indexOf(this.customerLineup[_loc1_]) <= -1)
                     {
                        _loc26_.push(this.customerLineup[_loc1_]);
                     }
                  }
                  _loc1_++;
               }
               if(_loc26_.length == 0)
               {
                  class_7.error(" -- -- Couldn\'t find anyone to bring a new Special -- make the first guy do it.");
                  _loc26_.push(this.customerLineup[0]);
               }
               _loc27_.customerBringingSpecial = _loc26_[Math.floor(Math.random() * _loc26_.length)];
               class_7.method_1(" -- -- Customer " + _loc27_.customerBringingSpecial + " will bring the new Special.");
               _loc27_.gameObj.var_128.lastDaySpecialEarned = _loc27_.gameObj.var_128.currentDay;
            }
         }
         else
         {
            class_7.method_1(" -- (Can\'t earn a new special yet)");
         }
         class_7.method_1("Chosen Customers Today: " + this.customerLineup);
         class_7.method_1("Dining Lineup: " + this.diningLineup);
         class_7.method_1("Dining Buddies: " + this.diningBuddies);
         class_7.method_1("Customers Ordering Special: " + this.specialCustomers);
         if(_loc27_.customerBringingSpecial > -1)
         {
            class_7.method_1("Customer bringing a new Special: " + _loc27_.customerBringingSpecial);
         }
      }
      
      public function startSpawningCustomers() : void
      {
         var _loc1_:CustomerManager = this;
         if(_loc1_.customerLineup == null || _loc1_.customerLineup.length == 0)
         {
            class_7.error("ERROR - the lineup was never set up!  Do that now.");
            _loc1_.setupLineup();
         }
         class_7.error("=============================================================== START OF DAY " + _loc1_.gameObj.var_128.currentDay);
         _loc1_.totalTime = _loc1_.gameObj.var_211;
         var _loc2_:Number = _loc1_.customerLineup.length;
         _loc1_.spawnTiming = 2400;
         _loc1_.minSpawnTiming = 2400;
         if(!_loc1_.gameObj.training)
         {
            _loc1_.spawnCustomer();
         }
      }
      
      public function spawnCustomer() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Boolean = false;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Boolean = false;
         var _loc5_:CustomerManager = this;
         var _loc6_:Number = _loc5_.totalCustomers;
         if(!(_loc6_ == _loc5_.customerLineup.length - 1 && _loc5_.dining_order_line.length > 0))
         {
            if(_loc6_ < _loc5_.customerLineup.length)
            {
               _loc1_ = Number(_loc5_.customerLineup[_loc6_]);
               _loc2_ = Boolean(_loc5_.diningLineup[_loc6_]);
               _loc3_ = Number(_loc5_.diningBuddies[_loc6_]);
               if(_loc2_ && !_loc5_.gameObj.var_128.didCreateWaiter)
               {
                  class_7.error("This was supposed to be a dining customer, but you don\'t have a waiter!");
                  _loc2_ = false;
               }
               _loc4_ = false;
               _loc5_.gameObj.var_145.clicksToStation = 0;
               if(_loc6_ == _loc5_.customerLineup.length - 1)
               {
                  _loc5_.gameObj.var_145.clip.opensign.sign.gotoAndPlay(2);
                  _loc4_ = true;
               }
               _loc5_.addCustomer(_loc1_,_loc2_,_loc3_);
               _loc5_.lastSpawnTime = _loc5_.gameObj.controls.gameplayTimer;
            }
         }
      }
      
      public function addCustomer(param1:Number, param2:Boolean, param3:Number = -1) : void
      {
         var _loc4_:CustomerManager = null;
         _loc4_ = this;
         ++_loc4_.totalCustomers;
         var _loc5_:Customer = new Customer(_loc4_.gameObj,param1,param2,param3);
      }
      
      public function deleteCustomer(param1:Customer) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:CustomerManager = this;
         var _loc4_:Number = -1;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.waitline.length)
         {
            if(_loc3_.waitline[_loc2_] == param1)
            {
               _loc4_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         if(_loc4_ > -1)
         {
            _loc3_.waitline.splice(_loc4_,1);
            _loc3_.shiftCustomersInWaitLine(_loc4_);
         }
         if(_loc4_ == -1)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.dining_wait_line.length)
            {
               if(_loc3_.dining_wait_line[_loc2_] == param1)
               {
                  _loc4_ = _loc2_;
                  break;
               }
               _loc2_++;
            }
            if(_loc4_ > -1)
            {
               _loc3_.dining_wait_line.splice(_loc4_,1);
            }
            else
            {
               class_7.error("Couldn\'t find this customer in either the waitline OR the dining_wait_line: " + param1.customerName);
            }
         }
         param1.destroy();
         param1 = null;
         if(_loc3_.waitline.length == 0 && _loc3_.orderline.length == 0)
         {
            if(_loc3_.totalCustomers == _loc3_.customerLineup.length)
            {
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:CustomerManager = this;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.waitline.length)
         {
            _loc2_.waitline[_loc1_].destroy();
            _loc2_.waitline[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.leaveline.length)
         {
            _loc2_.leaveline[_loc1_].destroy();
            _loc2_.leaveline[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.orderline.length)
         {
            _loc2_.orderline[_loc1_].destroy();
            _loc2_.orderline[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.dining_wait_line.length)
         {
            _loc2_.dining_wait_line[_loc1_].destroy();
            _loc2_.dining_wait_line[_loc1_] = null;
            _loc1_++;
         }
         _loc2_.waitline = null;
         _loc2_.leaveline = null;
         _loc2_.orderline = null;
         _loc2_.dining_wait_line = null;
         if(_loc2_.specialBMP)
         {
            _loc2_.specialBMP.dispose();
            _loc2_.specialBMP = null;
         }
      }
      
      public function getWaitingCustomer(param1:Number) : Customer
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Customer = null;
         var _loc4_:Customer = null;
         var _loc5_:Customer = null;
         var _loc6_:CustomerManager = this;
         var _loc7_:Customer = null;
         _loc2_ = 0;
         while(_loc2_ < _loc6_.waitline.length)
         {
            if(_loc6_.waitline[_loc2_] is Customer)
            {
               _loc3_ = _loc6_.waitline[_loc2_];
               if(_loc3_.customerType == param1)
               {
                  _loc7_ = _loc3_;
                  break;
               }
            }
            _loc2_++;
         }
         if(_loc7_ == null)
         {
            if(_loc6_.dining_wait_line.length > 0)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc6_.dining_wait_line.length)
               {
                  if(_loc6_.dining_wait_line[_loc2_] is Customer)
                  {
                     _loc4_ = _loc6_.dining_wait_line[_loc2_];
                     if(_loc4_.customerType == param1)
                     {
                        _loc7_ = _loc4_;
                        break;
                     }
                  }
                  _loc2_++;
               }
            }
         }
         if(_loc7_ == null)
         {
            if(_loc6_.leaveline.length > 0)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc6_.leaveline.length)
               {
                  if(_loc6_.leaveline[_loc2_] is Customer)
                  {
                     _loc5_ = _loc6_.leaveline[_loc2_];
                     if(_loc5_.customerType == param1)
                     {
                        if(_loc5_.isWaiter == false)
                        {
                           _loc5_.moveToWaitLine();
                        }
                        else
                        {
                           _loc5_.moveToDiningWaiting();
                        }
                        _loc7_ = _loc5_;
                        break;
                     }
                  }
                  _loc2_++;
               }
            }
         }
         return _loc7_;
      }
      
      public function shiftCustomersInWaitLine(param1:Number) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Customer = null;
         var _loc4_:CustomerManager = this;
         var _loc5_:OrderScreen = _loc4_.gameObj.var_145;
         var _loc6_:int = param1;
         while(_loc6_ < _loc4_.waitline.length)
         {
            _loc2_ = _loc5_.waitLineTargetX + _loc6_ * _loc5_.customerSpacing;
            _loc3_ = _loc4_.waitline[_loc6_];
            _loc3_.shiftInWaitLine(_loc2_);
            _loc6_++;
         }
      }
      
      public function shiftCustomersInOrderLine() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Customer = null;
         var _loc3_:CustomerManager = this;
         var _loc4_:OrderScreen = _loc3_.gameObj.var_145;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.orderline.length)
         {
            _loc1_ = _loc4_.orderLineTargetX + _loc5_ * _loc4_.customerSpacing;
            _loc2_ = _loc3_.orderline[_loc5_];
            _loc2_.shiftInOrderLine(_loc1_);
            _loc5_++;
         }
      }
      
      public function checkForWaitingDining() : void
      {
         var _loc1_:Customer = null;
         var _loc2_:CustomerManager = this;
         if(_loc2_.dining_order_line.length > 0)
         {
            class_7.method_1("There was someone waiting in the dining room!  Bring them in with the waiter now!");
            _loc1_ = _loc2_.dining_order_line[0];
            _loc1_.removeFromDiningQueue();
         }
      }
      
      public function resetAllCustomerContainers() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:CustomerManager = this;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.waitline.length)
         {
            _loc2_.waitline[_loc1_].resetContainer();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.orderline.length)
         {
            _loc2_.orderline[_loc1_].resetContainer();
            _loc1_++;
         }
      }
      
      public function updateManager() : void
      {
         var _loc1_:CustomerManager = this;
         var _loc2_:Number = _loc1_.gameObj.controls.gameplayTimer;
         if(_loc1_.gameObj.var_128.currentDay == 1 && !_loc1_.didSkipTraining)
         {
            if(_loc1_.gameObj.method_111(1) && _loc1_.orderline.length == 0)
            {
               _loc1_.spawnCustomer();
            }
            else if(_loc1_.gameObj.method_111(26))
            {
               _loc1_.spawnCustomer();
            }
         }
         else if(_loc1_.totalCustomers < _loc1_.customerLineup.length)
         {
            if(_loc1_.orderline.length == 0 && _loc1_.waitline.length == 0 && _loc1_.leaveline.length == 0)
            {
               _loc1_.spawnCustomer();
            }
            else if(_loc2_ - _loc1_.lastSpawnTime >= _loc1_.minSpawnTiming && _loc1_.orderline.length == 0)
            {
               _loc1_.spawnCustomer();
            }
            else if(_loc2_ - _loc1_.lastSpawnTime >= _loc1_.firstSpawnTiming && _loc1_.orderline.length == 0 && _loc1_.totalCustomers == 1)
            {
               class_7.method_1("Quicker Second Customer!");
               _loc1_.spawnCustomer();
            }
            else if(_loc2_ - _loc1_.lastSpawnTime >= _loc1_.secondSpawnTiming && _loc1_.orderline.length == 0 && _loc1_.totalCustomers == 2 && _loc1_.customerLineup.length > 3)
            {
               class_7.method_1("Quicker Third Customer!");
               _loc1_.spawnCustomer();
            }
            else if(_loc2_ - _loc1_.lastSpawnTime >= _loc1_.spawnTiming)
            {
               _loc1_.spawnCustomer();
            }
         }
      }
      
      public function outOfCustomers(param1:Boolean = false) : Boolean
      {
         var _loc2_:CustomerManager = this;
         var _loc3_:Boolean = false;
         if(_loc2_.totalCustomers == _loc2_.customerLineup.length)
         {
            if(param1 == true && _loc2_.waitline.length == 0 && _loc2_.leaveline.length == 0 && _loc2_.orderline.length == 0 && _loc2_.dining_wait_line.length == 0 && _loc2_.dining_order_line.length == 0)
            {
               _loc3_ = true;
            }
            else if(param1 == false && (_loc2_.waitline.length <= 1 && _loc2_.dining_wait_line.length == 0 || _loc2_.waitline.length == 0 && _loc2_.dining_wait_line.length <= 1) && _loc2_.leaveline.length == 0 && _loc2_.orderline.length == 0 && _loc2_.dining_order_line.length == 0)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      private function getBonusesWithinRange(param1:String, param2:Number) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:CustomerManager = this;
         var _loc7_:UserData = _loc6_.gameObj.var_128;
         var _loc8_:OrderScreen = _loc6_.gameObj.var_145;
         var _loc9_:Array = [];
         if(param1 == "waitline")
         {
            _loc3_ = [0,1];
         }
         else if(param1 == "orderline")
         {
            _loc3_ = [1,2];
         }
         if(param2 == 0)
         {
            _loc4_ = [0,1,2];
         }
         else if(param2 == 1)
         {
            _loc4_ = [3,4,5];
         }
         else if(param2 == 2)
         {
            _loc4_ = [5,6,7];
         }
         else if(param2 == 3)
         {
            _loc4_ = [8,9,10];
         }
         else if(param2 == 4)
         {
            _loc4_ = [10,11,12];
         }
         else if(param2 == 5)
         {
            _loc4_ = [13,14,15];
         }
         var _loc10_:Boolean = false;
         if(param1 == "orderline" && param2 == 0)
         {
            _loc10_ = true;
         }
         var _loc11_:int = 0;
         while(_loc11_ < _loc8_.furniItems.length)
         {
            if(_loc8_.furniItems[_loc11_].data.special != "none" && _loc8_.furniItems[_loc11_].data.special != FurniData.SPECIAL_SCORE && _loc8_.furniItems[_loc11_].isOccupied == false)
            {
               if(!_loc10_ || _loc8_.furniItems[_loc11_].data.special != FurniData.SPECIAL_ARCADE && _loc8_.furniItems[_loc11_].data.special != FurniData.SPECIAL_BOOK && _loc8_.furniItems[_loc11_].data.special != FurniData.SPECIAL_COMICS && _loc8_.furniItems[_loc11_].data.special != FurniData.SPECIAL_NEWSPAPER)
               {
                  _loc5_ = _loc8_.furniItems[_loc11_].xtile;
                  while(_loc5_ < _loc8_.furniItems[_loc11_].xtile + _loc8_.furniItems[_loc11_].data.width)
                  {
                     if(_loc4_.indexOf(_loc5_) > -1 && _loc3_.indexOf(_loc8_.furniItems[_loc11_].ytile) > -1)
                     {
                        _loc9_.push(_loc8_.furniItems[_loc11_]);
                        break;
                     }
                     _loc5_++;
                  }
               }
            }
            _loc11_++;
         }
         return _loc9_;
      }
      
      public function isOrderingSpecial(param1:Number) : Boolean
      {
         var _loc2_:CustomerManager = this;
         if(_loc2_.specialCustomers != null && _loc2_.specialCustomers.length > 0 && _loc2_.specialCustomers.indexOf(param1) > -1)
         {
            return true;
         }
         return false;
      }
      
      public function isBringingSpecial(param1:Number) : Boolean
      {
         var _loc2_:CustomerManager = this;
         if(_loc2_.customerBringingSpecial == param1)
         {
            return true;
         }
         return false;
      }
      
      public function isWaiterInLine() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Customer = null;
         var _loc3_:CustomerManager = this;
         var _loc4_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.orderline.length)
         {
            _loc2_ = _loc3_.orderline[_loc1_];
            if(_loc2_.isWaiter)
            {
               _loc4_ = true;
               break;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_.leaveline.length)
         {
            _loc2_ = _loc3_.leaveline[_loc1_];
            if(_loc2_.isWaiter)
            {
               _loc4_ = true;
               break;
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      public function updateCustomersForBonuses() : void
      {
         var ln:int;
         var whichVariation:Number = NaN;
         var furni:FurnitureItem = null;
         var i:Number = Number(NaN);
         var customer:Customer = null;
         var whichLine:Array = null;
         whichVariation = Number(NaN);
         var chooseIndex:Number = Number(NaN);
         furni = null;
         var whichDance:Number = Number(NaN);
         var actionOptions:Array = null;
         var actionChoice:String = null;
         var actionVariation:Number = Number(NaN);
         var currFrame:Number = Number(NaN);
         var manager:CustomerManager = this;
         var data:UserData = manager.gameObj.var_128;
         var maxPerLine:Number = 6;
         var available:Array = null;
         var gotBonus:Boolean = false;
         var lines:Array = ["waitline","orderline"];
         i = 0;
         while(i < manager.gameObj.var_145.furniItems.length)
         {
            manager.gameObj.var_145.furniItems[i].isOccupied = false;
            i++;
         }
         manager.resetAllCustomerContainers();
         ln = 0;
         while(ln < lines.length)
         {
            whichLine = manager[lines[ln]];
            if(whichLine.length > 0)
            {
               i = 0;
               for(; i < whichLine.length; i++)
               {
                  gotBonus = false;
                  customer = whichLine[i];
                  if(i < maxPerLine && !customer.isWalking && !customer.isWaiter)
                  {
                     whichVariation = Math.ceil(Math.random() * 4);
                     available = manager.getBonusesWithinRange(lines[ln],i);
                     if(available != null && available.length > 0)
                     {
                        chooseIndex = Math.floor(Math.random() * available.length);
                        furni = available[chooseIndex];
                        gotBonus = true;
                        if(furni.data.special == FurniData.SPECIAL_ARCADE)
                        {
                           customer.playAnimation("playgame" + whichVariation);
                           furni.clip.addChild(customer.clip);
                           customer.clip.x = 84;
                           customer.clip.y = -190;
                           furni.isOccupied = true;
                        }
                        else if(furni.data.special == FurniData.SPECIAL_BUBBLEGUM || furni.data.special == FurniData.SPECIAL_SCOREBUBBLEGUM)
                        {
                           customer.playAnimation("chewgum" + whichVariation);
                        }
                        else if(furni.data.special == FurniData.SPECIAL_MUSIC)
                        {
                           whichDance = Math.ceil(Math.random() * 3);
                           if(customer.hasHandExtra)
                           {
                              if(customer.extraIsBasket)
                              {
                                 whichDance = 1;
                              }
                              else
                              {
                                 whichDance = 3;
                              }
                           }
                           customer.playAnimation("dance" + whichDance + "_" + whichVariation);
                        }
                        else if(furni.data.special == FurniData.SPECIAL_BOOK || furni.data.special == FurniData.SPECIAL_NEWSPAPER || furni.data.special == FurniData.SPECIAL_COMICS)
                        {
                           customer.playAnimation("readpaper" + whichVariation);
                           try
                           {
                              customer.clip.book.gotoAndStop(furni.data.special);
                           }
                           catch(err:Error)
                           {
                              class_7.method_1("Error setting correct book for Customer.. (Trying to go to readpaper" + whichVariation + ", trying to set book to " + furni.data.special + ")");
                           }
                        }
                        else if(furni.data.special == FurniData.SPECIAL_COFFEE || furni.data.special == FurniData.SPECIAL_PUNCH || furni.data.special == FurniData.SPECIAL_SODA)
                        {
                           customer.playAnimation("drinkcoffee" + whichVariation);
                           try
                           {
                              customer.clip.mug.gotoAndStop(furni.data.special);
                           }
                           catch(err:Error)
                           {
                              class_7.method_1("Error setting correct drink for Customer.. (Trying to go to drinkcoffee" + whichVariation + ", trying to set drink to " + furni.data.special + ")");
                           }
                        }
                     }
                  }
                  if(!gotBonus)
                  {
                     if(!customer.isWalking && !customer.isWaiter)
                     {
                        actionOptions = ["stand1","stand2","stand3","stand1","stand2","stand3","standphone1","standphone2","standds1"];
                        if(customer.isHuge || customer.hasHandExtra)
                        {
                           actionOptions = ["stand1","stand2","stand3"];
                        }
                        actionChoice = actionOptions[Math.floor(Math.random() * actionOptions.length)];
                        actionVariation = Math.ceil(Math.random() * 4);
                        customer.playAnimation(actionChoice + "_" + actionVariation);
                        try
                        {
                           if(actionChoice == "standphone1" || actionChoice == "standphone2")
                           {
                              customer.clip.phone.gotoAndStop(customer.customerType % 5 + 1);
                           }
                           else if(actionChoice == "standds1")
                           {
                              customer.clip.handheld.gotoAndStop(customer.customerType % 5 + 1);
                           }
                        }
                        catch(err:Error)
                        {
                           class_7.method_1("Error skinning phone/handheld.");
                        }
                        try
                        {
                           currFrame = customer.clip.currentFrame;
                           customer.clip.gotoAndPlay(currFrame + Math.floor(Math.random() * 12));
                        }
                        catch(err:Error)
                        {
                           class_7.method_1("Error advancing frames");
                        }
                        continue;
                     }
                  }
               }
            }
            ln++;
         }
      }
   }
}


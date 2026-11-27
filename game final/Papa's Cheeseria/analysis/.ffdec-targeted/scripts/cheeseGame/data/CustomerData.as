package cheeseGame.data
{
   import cheeseGame.data.customers.*;
   import flash.display.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class CustomerData
   {
      
      private var gameObj:class_5;
      
      private var customersIncluded:Array;
      
      private var customerDataFiles:Array;
      
      private var randomSeed:Number = 1020304;
      
      public var thumbBMP:BitmapData = null;
      
      public var thumbGender:String = "???";
      
      public var verifyTypes:Array;
      
      public var verifyAmounts:Array;
      
      public var verifyAmountsClosers:Array;
      
      public function CustomerData(param1:class_5)
      {
         this.customersIncluded = [CustomerJojo,CustomerRhonda,CustomerHank,CustomerRadlynn,CustomerChester,CustomerQuinn,CustomerXolo,CustomerSasha,CustomerRoy,CustomerRita,CustomerConnor,CustomerIvy,CustomerKenji,CustomerNevada,CustomerBrody,CustomerJulep,CustomerNick,CustomerMandi,CustomerPinchHitwell,CustomerBertha,CustomerScooter,CustomerVicky,CustomerPerri,CustomerMayorMallow,CustomerClover,CustomerSkyler,CustomerAkari,CustomerIggy,CustomerUtah,CustomerShannon,CustomerMindy,CustomerDoan,CustomerEmber,CustomerTaylor,CustomerYui,CustomerChuck,CustomerMaggie,CustomerFranco,CustomerPeggy,CustomerTimm,CustomerClair,CustomerKahuna,CustomerHackyZak,CustomerAlberto,CustomerTrishna,CustomerCaptainCori,CustomerMarty,CustomerLisa,CustomerRico,CustomerBoomer,CustomerMatt,CustomerAllan,CustomerOlga,CustomerCarloRomano,CustomerHope,CustomerDeano,CustomerCooper,CustomerJohnny,CustomerTohru,CustomerZoe,CustomerJames,CustomerWillow,CustomerMitch,CustomerGremmie,CustomerNinjoy,CustomerSargeFan,CustomerSienna
         ,CustomerBigPauly,CustomerMary,CustomerAustin,CustomerEdna,CustomerSanta,CustomerCecilia,CustomerWally,CustomerCrystal,CustomerKingsley,CustomerXandra,CustomerProfessorFitz,CustomerPrudence,CustomerKayla,CustomerHugo,CustomerGreg,CustomerSue,CustomerFoodini,CustomerYippy,CustomerRobby,CustomerGeorgito,CustomerWendy,CustomerGinoRomano,CustomerBrunaRomano,CustomerTony,CustomerLittleEdoardo,CustomerPenny,CustomerOlivia,CustomerCletus,CustomerPapaLouie];
         this.customerDataFiles = [];
         this.verifyTypes = [];
         this.verifyAmounts = [];
         this.verifyAmountsClosers = [];
         super();
         var _loc2_:CustomerData = this;
         _loc2_.gameObj = param1;
         _loc2_.setupCustomerData();
      }
      
      public function setupCustomerData() : void
      {
         var _loc1_:Class = null;
         var _loc2_:CustomerDataFile = null;
         var _loc3_:CustomerData = this;
         _loc3_.customerDataFiles = [];
         _loc3_.customerDataFiles.push(new CustomerDataFile());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.customersIncluded.length)
         {
            _loc1_ = _loc3_.customersIncluded[_loc4_];
            _loc2_ = new _loc1_();
            _loc3_.customerDataFiles.push(_loc2_);
            _loc4_++;
         }
      }
      
      public function generateCustomerBitmap() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:BitmapData = null;
         var _loc6_:MovieClip = null;
         var _loc7_:DropShadowFilter = null;
         var _loc8_:int = 0;
         var _loc9_:Number = Number(NaN);
         var _loc10_:String = null;
         var _loc11_:Class = null;
         var _loc12_:MovieClip = null;
         var _loc13_:Class = null;
         var _loc14_:MovieClip = null;
         var _loc15_:Class = null;
         var _loc16_:MovieClip = null;
         var _loc17_:Class = null;
         var _loc18_:MovieClip = null;
         var _loc19_:Class = null;
         var _loc20_:MovieClip = null;
         var _loc21_:Class = null;
         var _loc22_:MovieClip = null;
         var _loc23_:MovieClip = null;
         var _loc24_:Class = null;
         var _loc25_:MovieClip = null;
         var _loc26_:Class = null;
         var _loc27_:MovieClip = null;
         var _loc28_:Class = null;
         var _loc29_:MovieClip = null;
         var _loc30_:MovieClip = null;
         var _loc31_:Class = null;
         var _loc32_:MovieClip = null;
         var _loc33_:MovieClip = null;
         var _loc34_:Rectangle = null;
         var _loc35_:Number = Number(NaN);
         var _loc36_:Class = null;
         var _loc37_:MovieClip = null;
         var _loc38_:Class = null;
         var _loc39_:MovieClip = null;
         var _loc40_:CustomerData = this;
         var _loc41_:Number = Number(getTimer());
         if(_loc40_.thumbBMP == null || _loc40_.thumbGender != _loc40_.gameObj.workerData.gender)
         {
            if(_loc40_.thumbBMP != null)
            {
               _loc40_.thumbBMP.dispose();
               _loc40_.thumbBMP = null;
            }
            _loc40_.thumbGender = _loc40_.gameObj.workerData.gender;
            _loc1_ = Number(_loc40_.customersIncluded.length);
            _loc2_ = 41;
            _loc3_ = 55;
            _loc4_ = 0;
            _loc40_.thumbBMP = new BitmapData(_loc2_ * _loc1_,_loc3_ * 2,true,0);
            _loc5_ = new BitmapData(_loc2_,_loc3_,true,0);
            _loc7_ = new DropShadowFilter(4,45,0,0.5);
            _loc8_ = 0;
            while(_loc8_ < _loc1_)
            {
               _loc6_ = null;
               _loc6_ = new customerMC();
               _loc10_ = _loc40_.getCustomerClipName(_loc8_ + 1);
               _loc11_ = getDefinitionByName("customer_" + _loc10_ + "_body") as Class;
               _loc12_ = new _loc11_();
               _loc12_.name = "clip";
               _loc12_.gotoAndStop(1);
               _loc6_.body.addChild(_loc12_);
               _loc13_ = getDefinitionByName("customer_" + _loc10_ + "_head") as Class;
               _loc14_ = new _loc13_();
               _loc14_.name = "clip";
               _loc14_.gotoAndStop(1);
               _loc6_.head.addChild(_loc14_);
               _loc15_ = getDefinitionByName("customer_" + _loc10_ + "_eyes") as Class;
               _loc16_ = new _loc15_();
               _loc16_.name = "clip";
               _loc16_.gotoAndStop(1);
               _loc6_.eyes.addChild(_loc16_);
               _loc17_ = getDefinitionByName("customer_" + _loc10_ + "_mouth") as Class;
               _loc18_ = new _loc17_();
               _loc18_.name = "clip";
               _loc18_.gotoAndStop(1);
               _loc6_.mouth.addChild(_loc18_);
               _loc19_ = getDefinitionByName("customer_" + _loc10_ + "_neck") as Class;
               _loc20_ = new _loc19_();
               _loc20_.gotoAndStop(1);
               _loc20_.name = "clip";
               _loc6_.neck.addChild(_loc20_);
               try
               {
                  _loc36_ = getDefinitionByName("customer_" + _loc10_ + "_hair") as Class;
                  _loc37_ = new _loc36_();
                  _loc37_.gotoAndStop(1);
                  _loc37_.name = "clip";
                  _loc6_.hair.addChild(_loc37_);
               }
               catch(err:Error)
               {
               }
               try
               {
                  _loc38_ = getDefinitionByName("customer_" + _loc10_ + "_back_hair") as Class;
                  _loc39_ = new _loc38_();
                  _loc39_.gotoAndStop(1);
                  _loc39_.name = "clip";
                  _loc6_.back_hair.addChild(_loc39_);
               }
               catch(err:Error)
               {
               }
               _loc21_ = getDefinitionByName("customer_" + _loc10_ + "_foot") as Class;
               _loc22_ = new _loc21_();
               _loc22_.gotoAndStop(1);
               _loc22_.name = "clip";
               _loc6_.front_shoe.addChild(_loc22_);
               _loc23_ = new _loc21_();
               _loc23_.name = "clip";
               _loc23_.gotoAndStop(1);
               _loc6_.back_shoe.addChild(_loc23_);
               _loc24_ = getDefinitionByName("customer_" + _loc10_ + "_hand") as Class;
               _loc25_ = new _loc24_();
               _loc25_.gotoAndStop(1);
               _loc25_.name = "clip";
               _loc6_.fronthand.addChild(_loc25_);
               _loc26_ = getDefinitionByName("customer_" + _loc10_ + "_hand2") as Class;
               _loc27_ = new _loc26_();
               _loc27_.gotoAndStop(1);
               _loc27_.name = "clip";
               _loc6_.backhand.addChild(_loc27_);
               _loc28_ = getDefinitionByName("customer_" + _loc10_ + "_upperarm") as Class;
               _loc29_ = new _loc28_();
               _loc29_.gotoAndStop(1);
               _loc29_.name = "clip";
               _loc6_.front_upperarm.addChild(_loc29_);
               _loc30_ = new _loc28_();
               _loc30_.name = "clip";
               _loc30_.gotoAndStop(1);
               _loc6_.back_upperarm.addChild(_loc30_);
               _loc31_ = getDefinitionByName("customer_" + _loc10_ + "_forearm") as Class;
               _loc32_ = new _loc31_();
               _loc32_.gotoAndStop(1);
               _loc32_.name = "clip";
               _loc6_.front_forearm.addChild(_loc32_);
               _loc33_ = new _loc31_();
               _loc33_.gotoAndStop(1);
               _loc33_.name = "clip";
               _loc6_.back_forearm.addChild(_loc33_);
               _loc6_.gotoAndStop("portrait");
               _loc6_.filters = [_loc7_];
               _loc6_.scaleX = 0.3;
               _loc6_.scaleY = 0.3;
               _loc34_ = _loc6_.head.getChildAt(0).getBounds(_loc6_.head.getChildAt(0));
               _loc35_ = -25;
               _loc6_.x = (_loc35_ - _loc34_.x) * _loc6_.scaleX;
               _loc5_.fillRect(_loc5_.rect,0);
               _loc5_.draw(_loc6_,_loc6_.transform.matrix,_loc6_.transform.colorTransform);
               this.thumbBMP.copyPixels(_loc5_,_loc5_.rect,new Point(_loc8_ * _loc2_,0),null,null,true);
               _loc5_.fillRect(_loc5_.rect,0);
               _loc6_.transform.colorTransform = new ColorTransform(0,0,0,1);
               _loc5_.draw(_loc6_,_loc6_.transform.matrix,_loc6_.transform.colorTransform);
               this.thumbBMP.copyPixels(_loc5_,_loc5_.rect,new Point(_loc8_ * _loc2_,_loc3_),null,null,true);
               _loc8_++;
            }
            _loc5_.dispose();
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = null;
            _loc9_ = getTimer() - _loc41_;
            class_7.info("Generate Customer Thumbs: " + _loc9_ + " ms. (" + _loc1_ + " Customers)");
         }
         else
         {
            class_7.info("using old customer thumbs.");
         }
      }
      
      public function getCustomerBitmap(param1:Number, param2:Boolean = false) : BitmapData
      {
         var _loc3_:CustomerData = this;
         var _loc4_:BitmapData = new BitmapData(41,55,true,0);
         var _loc5_:Number = (param1 - 1) * 41;
         var _loc6_:Number = 0;
         if(param2)
         {
            _loc6_ = 55;
         }
         _loc4_.copyPixels(_loc3_.thumbBMP,new Rectangle(_loc5_,_loc6_,41,55),new Point(0,0),null,null,true);
         return _loc4_;
      }
      
      public function addVerifyItems(param1:Array, param2:Boolean) : void
      {
         var _loc3_:Number = Number(NaN);
         var _loc4_:CustomerData = this;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = _loc4_.verifyTypes.indexOf(param1[_loc5_]);
            if(_loc3_ == -1)
            {
               _loc4_.verifyTypes.push(param1[_loc5_]);
               _loc4_.verifyAmounts.push(0);
               _loc4_.verifyAmountsClosers.push(0);
               _loc3_ = _loc4_.verifyTypes.indexOf(param1[_loc5_]);
            }
            _loc4_.verifyAmounts[_loc3_] += 1;
            if(param2)
            {
               _loc4_.verifyAmountsClosers[_loc3_] += 1;
            }
            _loc5_++;
         }
      }
      
      public function outputTallies() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CustomerDataFile = null;
         var _loc3_:CustomerData = this;
         class_7.method_1(" ---- ---- VERIFY ORDERS ---- ----");
         _loc3_.verifyAmounts = [];
         _loc3_.verifyAmountsClosers = [];
         _loc3_.verifyTypes = [];
         _loc1_ = 2;
         while(_loc1_ < _loc3_.customerDataFiles.length)
         {
            _loc2_ = _loc3_.customerDataFiles[_loc1_];
            _loc2_.verifyOrder(_loc3_);
            _loc1_++;
         }
         class_7.method_1(" ---- ---- ---- DONE ---- ---- ----");
         class_7.method_1("");
      }
      
      public function getCustomerOrder(param1:Number) : Array
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         var _loc4_:Array = [];
         if(param1 == 1)
         {
            _loc4_ = _loc2_.getFoodCriticOrder().getOrderAsArray();
         }
         else if(Boolean(_loc2_.gameObj.var_134) && Boolean(_loc2_.gameObj.var_134.isOrderingSpecial(param1)))
         {
            class_7.method_1("Get a SPECIAL order for customer " + param1);
            _loc4_ = _loc2_.getSpecialOrder(param1).getOrderAsArray();
         }
         else
         {
            _loc4_ = _loc2_.getAvailableOrder(param1).getOrderAsArray();
         }
         return _loc4_;
      }
      
      public function getCustomerOrderForGiving(param1:Number) : Array
      {
         var _loc2_:CustomerData = this;
         var _loc3_:Array = [];
         if(Boolean(_loc2_.gameObj.var_134) && Boolean(_loc2_.gameObj.var_134.isOrderingSpecial(param1)))
         {
            _loc3_ = _loc2_.getSpecialOrder(param1).getOrderAsGivingArray();
         }
         else
         {
            _loc3_ = _loc2_.getCustomerOrder(param1);
         }
         return _loc3_;
      }
      
      public function getCustomerCompleteOrder(param1:Number) : Array
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         var _loc4_:CustomerOrder = _loc3_.getCustomerOrder(_loc2_.gameObj.var_128.getMonth(),_loc2_.gameObj.var_128.isNewYear());
         var _loc5_:Array = [];
         if(param1 == 1)
         {
            _loc5_ = _loc2_.getFoodCriticOrder().getOrderAsArray();
         }
         else
         {
            _loc5_ = _loc4_.getOrderAsArray();
         }
         return _loc5_;
      }
      
      public function getCustomerCompleteOrderData(param1:Number) : CustomerOrder
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         return _loc3_.getCustomerOrder(_loc2_.gameObj.var_128.getMonth(),_loc2_.gameObj.var_128.isNewYear());
      }
      
      public function getFoodCriticOrder(param1:Number = -1) : CustomerOrder
      {
         var _loc15_:Number = NaN;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Number = Number(NaN);
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:CustomerData = this;
         var _loc13_:UserData = _loc12_.gameObj.var_128;
         _loc12_.setRandomSeed(_loc13_.currentDay);
         if(param1 > -1)
         {
            _loc12_.setRandomSeed(param1);
         }
         var _loc14_:CustomerOrder = new CustomerOrder();
         _loc15_ = _loc13_.getMonth();
         if(_loc15_ == GameData.STARTER_MONTH && !_loc13_.isNewYear())
         {
            _loc15_ = 0;
         }
         var _loc16_:Array = FoodData.getBreads(_loc13_.getMonth(),_loc13_.isNewYear());
         var _loc17_:Array = FoodData.getCheeses(_loc13_.getMonth(),_loc13_.isNewYear());
         var _loc18_:Array = FoodData.getFries();
         var _loc19_:Array = FoodData.getToppings(_loc13_.getMonth(),_loc13_.isNewYear());
         var _loc20_:Array = FoodData.getSauces(_loc13_.getMonth(),_loc13_.isNewYear());
         var _loc21_:Array = FoodData.getFryToppings();
         _loc21_ = _loc21_.concat(FoodData.getFrySauces());
         _loc21_ = _loc21_.concat(FoodData.getFryShakers());
         var _loc22_:Array = [];
         var _loc23_:Array = [];
         var _loc24_:Array = [];
         var _loc25_:Array = [];
         var _loc26_:Array = [];
         var _loc27_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc16_.length)
         {
            if(_loc13_.hasTopping(_loc16_[_loc2_]))
            {
               _loc22_.push(_loc16_[_loc2_]);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc17_.length)
         {
            if(_loc13_.hasTopping(_loc17_[_loc2_]))
            {
               _loc23_.push(_loc17_[_loc2_]);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc18_.length)
         {
            if(_loc13_.hasTopping(_loc18_[_loc2_]))
            {
               _loc24_.push(_loc18_[_loc2_]);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc19_.length)
         {
            if(_loc13_.hasTopping(_loc19_[_loc2_]))
            {
               _loc25_.push(_loc19_[_loc2_]);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc20_.length)
         {
            if(_loc13_.hasTopping(_loc20_[_loc2_]))
            {
               _loc26_.push(_loc20_[_loc2_]);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc21_.length)
         {
            if(_loc13_.hasTopping(_loc21_[_loc2_]))
            {
               _loc27_.push(_loc21_[_loc2_]);
            }
            _loc2_++;
         }
         var _loc28_:String = _loc12_.getRandom(_loc22_);
         var _loc29_:String = _loc12_.getRandom(_loc23_);
         var _loc30_:String = _loc12_.getRandom(_loc24_);
         var _loc31_:Array = [];
         var _loc32_:Array = _loc25_.concat();
         var _loc33_:Array = _loc26_.concat();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(_loc12_.randomize() < 0.6)
            {
               if(_loc12_.randomize() < 0.4 && (_loc31_.length == 0 || FoodData.isSauce(_loc31_[_loc31_.length - 1]) == false) && _loc33_.length > 0)
               {
                  _loc3_ = Math.floor(_loc12_.randomize() * _loc33_.length);
                  _loc4_ = _loc33_[_loc3_];
                  _loc31_.push(_loc4_);
                  _loc33_.splice(_loc3_,1);
               }
               else
               {
                  _loc5_ = Math.floor(_loc12_.randomize() * _loc32_.length);
                  _loc6_ = _loc32_[_loc5_];
                  _loc31_.push(_loc6_);
                  _loc32_.splice(_loc5_,1);
               }
            }
            _loc2_++;
         }
         if(_loc31_.length == 0 && _loc32_.length > 0)
         {
            _loc7_ = _loc32_[Math.floor(_loc12_.randomize() * _loc32_.length)];
            _loc31_.push(_loc7_);
         }
         if(_loc31_.length == 1 && _loc32_.length > 0)
         {
            _loc8_ = _loc32_[Math.floor(_loc12_.randomize() * _loc32_.length)];
            _loc31_.push(_loc8_);
         }
         var _loc34_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            if(_loc12_.randomize() < 0.6 && _loc27_.length > 0)
            {
               _loc9_ = Math.floor(_loc12_.randomize() * _loc27_.length);
               _loc10_ = _loc27_[_loc9_];
               _loc34_.push(_loc10_);
               _loc27_.splice(_loc9_,1);
            }
            _loc2_++;
         }
         if(_loc34_.length == 0 && _loc27_.length > 0)
         {
            _loc11_ = _loc27_[Math.floor(_loc12_.randomize() * _loc27_.length)];
            _loc34_.push(_loc11_);
         }
         var _loc35_:Array = [FoodData.COOK_MEDIUM];
         if(_loc13_.getRank() >= 26)
         {
            _loc35_.push(FoodData.COOK_LIGHT);
         }
         var _loc36_:String = _loc35_[Math.floor(_loc12_.randomize() * _loc35_.length)];
         _loc14_.setBread(_loc28_);
         _loc14_.setCheese(_loc29_);
         _loc14_.setCookType(_loc36_);
         _loc14_.setFries(_loc30_);
         _loc2_ = 0;
         while(_loc2_ < _loc31_.length)
         {
            _loc14_.addToppings(_loc31_[_loc2_]);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc34_.length)
         {
            _loc14_.addFryToppings(_loc34_[_loc2_]);
            _loc2_++;
         }
         var _loc37_:String = "Food Critic Order: " + _loc14_.output();
         class_7.info(_loc37_);
         return _loc14_;
      }
      
      public function getSpecialOrder(param1:Number, param2:Number = -1) : CustomerOrder
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:CustomerData = this;
         var _loc6_:GameData = _loc5_.gameObj.var_133;
         var _loc7_:CustomerOrder = _loc5_.getAvailableOrder(param1);
         var _loc8_:CustomerOrder = new CustomerOrder();
         var _loc9_:SpecialItem = _loc6_.getSpecial(_loc5_.gameObj.var_128.currentSpecial);
         if(param2 != -1)
         {
            _loc9_ = _loc6_.getSpecial(param2);
         }
         if(_loc9_ != null)
         {
            _loc8_.setBread(_loc9_.ingredients[0]);
            _loc8_.setCheese(_loc9_.ingredients[1]);
            _loc8_.setCookType(FoodData.COOK_MEDIUM);
            _loc3_ = 2;
            while(_loc3_ < _loc9_.ingredients.length)
            {
               _loc8_.addToppings(_loc9_.ingredients[_loc3_]);
               _loc3_++;
            }
            _loc8_.setFries(_loc7_.fries);
            _loc4_ = 0;
            while(_loc4_ < _loc7_.frytoppings.length)
            {
               _loc8_.addFryToppings(_loc7_.frytoppings[_loc4_]);
               _loc4_++;
            }
            _loc8_.isSpecial = true;
         }
         else
         {
            class_7.error("Error getting the Special Order for " + param1 + " (Special = " + _loc5_.gameObj.var_128.currentSpecial + "). Use default order instead.");
            _loc8_ = _loc7_;
         }
         return _loc8_;
      }
      
      public function getAvailableOrder(param1:Number) : CustomerOrder
      {
         var _loc6_:CustomerDataFile = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:CustomerData = this;
         var _loc5_:UserData = _loc4_.gameObj.var_128;
         _loc6_ = _loc4_.customerDataFiles[param1];
         var _loc7_:CustomerOrder = _loc6_.getCustomerOrder(_loc5_.getMonth(),_loc5_.isNewYear());
         var _loc8_:CustomerOrder = new CustomerOrder(_loc7_.month);
         var _loc9_:String = _loc7_.bread;
         var _loc10_:String = _loc7_.cheese;
         var _loc11_:String = _loc7_.fries;
         var _loc12_:String = _loc7_.cookType;
         if(_loc5_.hasTopping(_loc9_) == false)
         {
            if(_loc9_ == FoodData.BREAD_PUMPERNICKEL && _loc5_.hasTopping(FoodData.BREAD_RYE))
            {
               _loc9_ = FoodData.BREAD_RYE;
            }
            else if(_loc9_ == FoodData.BREAD_CIABATTA)
            {
               if(_loc5_.hasTopping(FoodData.BREAD_FOCACCIA))
               {
                  _loc9_ = FoodData.BREAD_FOCACCIA;
               }
               else
               {
                  _loc9_ = FoodData.BREAD_SOURDOUGH;
               }
            }
            else if(_loc9_ == FoodData.BREAD_FOCACCIA && _loc5_.hasTopping(FoodData.BREAD_SOURDOUGH))
            {
               _loc9_ = FoodData.BREAD_SOURDOUGH;
            }
            else if(_loc9_ == FoodData.BREAD_PRETZEL || _loc9_ == FoodData.BREAD_THREECHEESE)
            {
               _loc9_ = FoodData.BREAD_WHITE;
            }
            else if(_loc9_ == FoodData.BREAD_CHEDDARSWIRL && _loc5_.hasTopping(FoodData.BREAD_THREECHEESE))
            {
               _loc9_ = FoodData.BREAD_THREECHEESE;
            }
            else if(_loc9_ == FoodData.BREAD_BEET)
            {
               _loc9_ = FoodData.BREAD_WHEAT;
            }
            else if(_loc9_ == FoodData.BREAD_BARMBRACK || _loc9_ == FoodData.BREAD_ECTOBREAD)
            {
               _loc9_ = FoodData.BREAD_SOURDOUGH;
            }
            else if(_loc9_ == FoodData.BREAD_TORTILLA && _loc5_.hasTopping(FoodData.BREAD_FLATBREAD))
            {
               _loc9_ = FoodData.BREAD_FLATBREAD;
            }
            else if(_loc9_ == FoodData.BREAD_HAWAIIAN)
            {
               _loc9_ = FoodData.BREAD_WHEAT;
            }
            else if(_loc9_ == FoodData.BREAD_PUMPKIN && _loc5_.hasTopping(FoodData.BREAD_MULTIGRAIN))
            {
               _loc9_ = FoodData.BREAD_MULTIGRAIN;
            }
            else if(_loc9_ == FoodData.BREAD_FRUITCAKE && _loc5_.hasTopping(FoodData.BREAD_RYE))
            {
               _loc9_ = FoodData.BREAD_RYE;
            }
            else
            {
               _loc9_ = FoodData.BREAD_WHITE;
            }
         }
         if(_loc5_.hasTopping(_loc10_) == false)
         {
            if(_loc10_ == FoodData.CHEESE_ASIAGO && _loc5_.hasTopping(FoodData.CHEESE_PROVOLONE))
            {
               _loc10_ = FoodData.CHEESE_PROVOLONE;
            }
            else if(_loc10_ == FoodData.CHEESE_ASIAGO || _loc10_ == FoodData.CHEESE_HAVARTI || _loc10_ == FoodData.CHEESE_GRUYERE || _loc10_ == FoodData.CHEESE_GINGERSPICE)
            {
               _loc10_ = FoodData.CHEESE_SWISS;
            }
            else if(_loc10_ == FoodData.CHEESE_AGEDGOUDA || _loc10_ == FoodData.CHEESE_MANGO)
            {
               _loc10_ = FoodData.CHEESE_COLBY;
            }
            else if(_loc10_ == FoodData.CHEESE_PROVOLONE || _loc10_ == FoodData.CHEESE_REDWINDSOR || _loc10_ == FoodData.CHEESE_OAXACA || _loc10_ == FoodData.CHEESE_RICOTTA)
            {
               _loc10_ = FoodData.CHEESE_MOZZARELLA;
            }
            else if(_loc10_ == FoodData.CHEESE_CHEESEBALL)
            {
               _loc10_ = FoodData.CHEESE_CHEDDAR;
            }
            else if(_loc10_ == FoodData.CHEESE_SAGEDERBY)
            {
               if(_loc5_.hasTopping(FoodData.CHEESE_PROVOLONE))
               {
                  _loc10_ = FoodData.CHEESE_PROVOLONE;
               }
               else
               {
                  _loc10_ = FoodData.CHEESE_AMERICAN;
               }
            }
            else if(_loc10_ == FoodData.CHEESE_SIRECZ)
            {
               if(_loc5_.hasTopping(FoodData.CHEESE_AGEDGOUDA))
               {
                  _loc10_ = FoodData.CHEESE_AGEDGOUDA;
               }
               else
               {
                  _loc10_ = FoodData.CHEESE_SWISS;
               }
            }
            else if(_loc10_ == FoodData.CHEESE_MAPLEJACK)
            {
               if(_loc5_.hasTopping(FoodData.CHEESE_PROVOLONE))
               {
                  _loc10_ = FoodData.CHEESE_PROVOLONE;
               }
               else
               {
                  _loc10_ = FoodData.CHEESE_AMERICAN;
               }
            }
            else if(_loc10_ == FoodData.CHEESE_MUENSTER && _loc5_.hasTopping(FoodData.CHEESE_AGEDGOUDA))
            {
               _loc10_ = FoodData.CHEESE_AGEDGOUDA;
            }
            else
            {
               _loc10_ = FoodData.CHEESE_AMERICAN;
            }
         }
         if(_loc5_.hasTopping(_loc11_) == false)
         {
            if(_loc11_ == FoodData.FRIES_SWEETPOTATO && _loc5_.hasTopping(FoodData.FRIES_CURLY))
            {
               _loc11_ = FoodData.FRIES_CURLY;
            }
            else
            {
               _loc11_ = FoodData.FRIES_REGULAR;
            }
         }
         _loc8_.setBread(_loc9_);
         _loc8_.setCheese(_loc10_);
         _loc8_.setFries(_loc11_);
         _loc8_.setCookType(_loc12_);
         var _loc13_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc7_.toppings.length)
         {
            if(_loc5_.hasTopping(_loc7_.toppings[_loc2_]))
            {
               _loc8_.addToppings(_loc7_.toppings[_loc2_]);
               _loc13_.push(_loc7_.toppings[_loc2_]);
            }
            _loc2_++;
         }
         if(_loc8_.toppings.length == 0)
         {
            _loc8_.addToppings(FoodData.TOPPING_TOMATO);
         }
         var _loc14_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc7_.frytoppings.length)
         {
            if(_loc5_.hasTopping(_loc7_.frytoppings[_loc2_]))
            {
               _loc8_.addFryToppings(_loc7_.frytoppings[_loc2_]);
               _loc14_.push(_loc7_.frytoppings[_loc2_]);
            }
            _loc2_++;
         }
         if(_loc8_.frytoppings.length == 0)
         {
            _loc8_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR);
         }
         return _loc8_;
      }
      
      public function getCustomerIndex(param1:String) : Number
      {
         var _loc2_:CustomerData = this;
         var _loc3_:Number = -1;
         var _loc4_:int = 1;
         while(_loc4_ < _loc2_.customerDataFiles.length)
         {
            if(_loc2_.customerDataFiles[_loc4_].customerName == param1 || _loc2_.customerDataFiles[_loc4_].customerClipName == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getCustomerName(param1:Number) : String
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         if(_loc3_.customerName == "DoanOrUtah")
         {
            if(_loc2_.gameObj.workerData.gender == WorkerData.GENDER_MALE)
            {
               return "Utah";
            }
            return "Doan";
         }
         return _loc3_.customerName;
      }
      
      public function getCustomerClipName(param1:Number) : String
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         if(_loc3_.customerName == "DoanOrUtah")
         {
            if(Boolean(_loc2_.gameObj.workerData) && _loc2_.gameObj.workerData.gender == WorkerData.GENDER_MALE)
            {
               return "Utah";
            }
            return "Doan";
         }
         return _loc3_.customerClipName;
      }
      
      public function getCustomerOrderData(param1:Number) : CustomerOrder
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         if(param1 == 1)
         {
            return _loc2_.getFoodCriticOrder();
         }
         if(Boolean(_loc2_.gameObj.var_134) && Boolean(_loc2_.gameObj.var_134.isOrderingSpecial(param1)))
         {
            class_7.method_1("Get a SPECIAL order data for customer " + param1);
            return _loc2_.getSpecialOrder(param1);
         }
         return _loc2_.getAvailableOrder(param1);
      }
      
      public function getCustomerFirstGame(param1:Number) : String
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         if(_loc3_.customerName == "DoanOrUtah")
         {
            if(_loc2_.gameObj.workerData.gender == WorkerData.GENDER_MALE)
            {
               return "Papa\'s Freezeria";
            }
            return "Papa\'s Burgeria";
         }
         return _loc3_.customerFirstGame;
      }
      
      public function getCustomerFlipdeckNumber(param1:Number) : Number
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         return _loc3_.flipdeckNumber;
      }
      
      public function getCustomerColor(param1:Number) : String
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         if(_loc3_.customerName == "DoanOrUtah")
         {
            if(_loc2_.gameObj.workerData.gender == WorkerData.GENDER_MALE)
            {
               return "yelloworange";
            }
            return "midblue";
         }
         return _loc3_.thumbColor;
      }
      
      public function getCustomerInPool(param1:Number) : Boolean
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         if(_loc3_.notInPool)
         {
            return false;
         }
         return true;
      }
      
      public function getCustomerHolidayHandExtra(param1:Number, param2:Number = -1) : String
      {
         var _loc3_:CustomerDataFile = null;
         var _loc4_:CustomerData = this;
         var _loc5_:String = null;
         try
         {
            _loc3_ = _loc4_.customerDataFiles[param1];
            if(param2 == -1 || param2 == _loc3_.holidayOutfit)
            {
               _loc5_ = _loc3_.holidayHandExtra;
            }
         }
         catch(err:Error)
         {
         }
         return _loc5_;
      }
      
      public function getCustomerHolidayOutfitMonth(param1:Number) : Number
      {
         var _loc2_:CustomerDataFile = null;
         var _loc3_:CustomerDataFile = null;
         var _loc4_:CustomerData = this;
         var _loc5_:Number = 0;
         try
         {
            if(_loc4_.getCustomerName(param1) == "DoanOrUtah")
            {
               _loc2_ = _loc4_.customerDataFiles[_loc4_.getCustomerIndex("DoanOrUtah")];
               _loc5_ = _loc2_.holidayOutfit;
            }
            else
            {
               _loc3_ = _loc4_.customerDataFiles[param1];
               _loc5_ = _loc3_.holidayOutfit;
            }
         }
         catch(err:Error)
         {
         }
         return _loc5_;
      }
      
      public function getCustomerHolidayOutfitPart(param1:String, param2:Number, param3:String) : Boolean
      {
         var _loc4_:CustomerDataFile = null;
         var _loc5_:CustomerDataFile = null;
         var _loc6_:CustomerData = this;
         var _loc7_:Boolean = false;
         try
         {
            if(param1 == "DoanOrUtah")
            {
               _loc4_ = _loc6_.customerDataFiles[_loc6_.getCustomerIndex("DoanOrUtah")];
               if(_loc4_.holidayOutfit == param2)
               {
                  if(param3 == "eyes" && _loc4_.hasHolidayEyes)
                  {
                     _loc7_ = true;
                  }
                  else if(param3 == "mouth" && _loc4_.hasHolidayMouth)
                  {
                     _loc7_ = true;
                  }
                  else if((param3 == "hand" || param3 == "hand2") && _loc4_.hasHolidayHands)
                  {
                     _loc7_ = true;
                  }
                  else if(param3 == "foot" && _loc4_.hasHolidayShoes)
                  {
                     _loc7_ = true;
                  }
               }
            }
            else
            {
               _loc5_ = _loc6_.customerDataFiles[_loc6_.getCustomerIndex(param1)];
               if(_loc5_.holidayOutfit == param2)
               {
                  if(param3 == "eyes" && _loc5_.hasHolidayEyes)
                  {
                     _loc7_ = true;
                  }
                  else if(param3 == "mouth" && _loc5_.hasHolidayMouth)
                  {
                     _loc7_ = true;
                  }
                  else if((param3 == "hand" || param3 == "hand2") && _loc5_.hasHolidayHands)
                  {
                     _loc7_ = true;
                  }
                  else if(param3 == "foot" && _loc5_.hasHolidayShoes)
                  {
                     _loc7_ = true;
                  }
               }
            }
         }
         catch(err:Error)
         {
         }
         return _loc7_;
      }
      
      public function getCustomerPart(param1:String, param2:String, param3:Number = 0) : MovieClip
      {
         var _loc4_:CustomerData = this;
         var _loc5_:Class = getDefinitionByName("customer_" + param1 + "_" + param2) as Class;
         if(_loc4_.getCustomerHolidayOutfitPart(param1,param3,param2) == true)
         {
            _loc5_ = getDefinitionByName("customer_" + param1 + "_" + param2 + "_holiday") as Class;
         }
         return new _loc5_() as MovieClip;
      }
      
      public function getCustomerTotal() : Number
      {
         var _loc1_:CustomerData = this;
         return _loc1_.customerDataFiles.length - 1;
      }
      
      private function getToppingRealName(param1:String) : String
      {
         var _loc5_:Number = NaN;
         var _loc2_:CustomerData = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:String = "???";
         _loc5_ = _loc3_.toppingIndexes.indexOf(param1);
         if(_loc5_ > -1)
         {
            _loc4_ = _loc3_.toppingNames[_loc5_];
         }
         return _loc4_;
      }
      
      public function getCustomerFavoriteHoliday(param1:Number) : Number
      {
         var _loc5_:CustomerDataFile = null;
         var _loc2_:int = 0;
         var _loc3_:CustomerData = this;
         var _loc4_:Number = 13;
         _loc5_ = _loc3_.customerDataFiles[param1];
         if(_loc5_.isCloser)
         {
            _loc4_ = 13;
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc5_.customerOrders.length)
            {
               if(_loc5_.customerOrders[_loc2_].month > 0)
               {
                  _loc4_ = _loc5_.customerOrders[_loc2_].month;
                  break;
               }
               _loc2_++;
            }
         }
         return _loc4_;
      }
      
      public function getCustomerToppingString(param1:Number) : String
      {
         var _loc2_:int = 0;
         var _loc3_:CustomerData = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:* = "";
         var _loc6_:CustomerDataFile = _loc3_.customerDataFiles[param1];
         var _loc7_:CustomerOrder = _loc3_.getAvailableOrder(param1);
         _loc5_ = _loc3_.getToppingRealName(_loc7_.cheese) + " on " + _loc3_.getToppingRealName(_loc7_.bread) + " with ";
         _loc2_ = 0;
         while(_loc2_ < _loc7_.toppings.length)
         {
            if(_loc2_ > 0 && _loc7_.toppings.length > 1 && _loc2_ == _loc7_.toppings.length - 1)
            {
               _loc5_ += " and " + _loc3_.getToppingRealName(_loc7_.toppings[_loc2_]);
            }
            else if(_loc7_.toppings.length > 1 && _loc2_ > 0 && _loc2_ < _loc7_.toppings.length - 1)
            {
               _loc5_ += ", " + _loc3_.getToppingRealName(_loc7_.toppings[_loc2_]);
            }
            else
            {
               _loc5_ += _loc3_.getToppingRealName(_loc7_.toppings[_loc2_]);
            }
            _loc2_++;
         }
         if(_loc3_.getCustomerName(param1) == "Jojo")
         {
            _loc5_ = "Different every time!";
         }
         return _loc5_;
      }
      
      public function isCloser(param1:Number) : Boolean
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         return _loc3_.isCloser;
      }
      
      public function isHuge(param1:Number) : Boolean
      {
         var _loc2_:CustomerData = this;
         var _loc3_:CustomerDataFile = _loc2_.customerDataFiles[param1];
         return _loc3_.isHuge;
      }
      
      public function customersHaveTopping(param1:*, param2:String) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:CustomerData = this;
         var _loc8_:Boolean = false;
         if(param1 is Number)
         {
            _loc3_ = [param1];
         }
         else if(param1 is Array)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = [];
         }
         if(_loc3_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc7_.getCustomerOrder(_loc3_[_loc4_]);
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  if(_loc5_[_loc6_][0] == param2)
                  {
                     _loc8_ = true;
                     break;
                  }
                  _loc6_++;
               }
               _loc4_++;
            }
         }
         return _loc8_;
      }
      
      public function getCustomerWithTopping(param1:String, param2:Array) : Number
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:CustomerData = this;
         var _loc6_:Number = -1;
         var _loc7_:int = 0;
         while(_loc7_ < param2.length)
         {
            _loc3_ = _loc5_.getCustomerOrder(param2[_loc7_]);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_][0] == param1)
               {
                  _loc6_ = Number(param2[_loc7_]);
                  break;
               }
               _loc4_++;
            }
            if(_loc6_ > -1)
            {
               break;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function customersHaveHolidayOrder(param1:*, param2:Number) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:CustomerOrder = null;
         var _loc6_:CustomerData = this;
         var _loc7_:Boolean = false;
         if(param1 is Number)
         {
            _loc3_ = [param1];
         }
         else if(param1 is Array)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = [];
         }
         if(_loc3_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc6_.getCustomerOrderData(_loc3_[_loc4_]);
               if(_loc5_.month == param2)
               {
                  _loc7_ = true;
                  break;
               }
               _loc4_++;
            }
         }
         return _loc7_;
      }
      
      public function getCustomerWithHolidayOrder(param1:Number, param2:Array) : Number
      {
         var _loc3_:CustomerOrder = null;
         var _loc4_:CustomerData = this;
         var _loc5_:Number = -1;
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc3_ = _loc4_.getCustomerOrderData(param2[_loc6_]);
            if(_loc3_.month == param1)
            {
               _loc5_ = Number(param2[_loc6_]);
               break;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getCustomersWithHolidayOrder(param1:Number, param2:Array) : Array
      {
         var _loc3_:CustomerOrder = null;
         var _loc4_:CustomerData = this;
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc3_ = _loc4_.getCustomerOrderData(param2[_loc6_]);
            if(_loc3_.month == param1)
            {
               _loc5_.push(param2[_loc6_]);
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getCustomersForSpecial(param1:Number = -1) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:SpecialItem = null;
         var _loc6_:CustomerOrder = null;
         var _loc7_:CustomerOrder = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:Array = null;
         var _loc10_:Number = Number(NaN);
         var _loc11_:Object = null;
         var _loc12_:CustomerData = this;
         var _loc13_:Array = [];
         var _loc14_:Number = Number(getTimer());
         var _loc15_:Array = _loc12_.gameObj.var_128.getCustomerPool(int.MAX_VALUE);
         var _loc16_:Number = Number(_loc12_.gameObj.var_128.currentSpecial);
         if(param1 != -1)
         {
            _loc16_ = param1;
         }
         if(_loc16_ > -1)
         {
            _loc4_ = [];
            _loc5_ = _loc12_.gameObj.var_133.getSpecial(_loc16_);
            _loc6_ = _loc12_.getSpecialOrder(25,_loc16_);
            _loc8_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc15_.length)
            {
               _loc8_ = 0;
               _loc7_ = _loc12_.getAvailableOrder(_loc15_[_loc2_]);
               if(!(_loc7_.month != 0 && _loc12_.gameObj.var_128.getHolidayMonth() == _loc7_.month))
               {
                  if(_loc7_.bread == _loc6_.bread)
                  {
                     _loc8_++;
                     if(_loc5_.dominantIngredients.indexOf(_loc6_.bread) > -1)
                     {
                        _loc8_++;
                     }
                  }
                  if(_loc7_.cheese == _loc6_.cheese)
                  {
                     _loc8_++;
                     if(_loc5_.dominantIngredients.indexOf(_loc6_.cheese) > -1)
                     {
                        _loc8_++;
                     }
                  }
                  _loc9_ = [];
                  _loc3_ = 0;
                  while(_loc3_ < _loc6_.toppings.length)
                  {
                     if(_loc7_.toppings.indexOf(_loc6_.toppings[_loc3_]) > -1 && _loc9_.indexOf(_loc6_.toppings[_loc3_]) == -1)
                     {
                        _loc8_++;
                        if(_loc5_.dominantIngredients.indexOf(_loc6_.toppings[_loc3_]) > -1)
                        {
                           _loc8_++;
                        }
                        _loc9_.push(_loc6_.toppings[_loc3_]);
                     }
                     _loc3_++;
                  }
                  if(_loc8_ > 0)
                  {
                     _loc11_ = new Object();
                     _loc11_.customer = _loc15_[_loc2_];
                     _loc11_.matches = _loc8_;
                     _loc4_.push(_loc11_);
                  }
               }
               _loc2_++;
            }
            _loc4_.sortOn("matches",Array.NUMERIC | Array.DESCENDING);
            _loc10_ = 8;
            _loc2_ = 0;
            while(_loc2_ < _loc10_)
            {
               if(_loc4_.length > _loc2_)
               {
                  _loc13_.push(_loc4_[_loc2_].customer);
               }
               _loc2_++;
            }
         }
         var _loc17_:Number = getTimer() - _loc14_;
         var _loc18_:* = "";
         var _loc19_:int = 0;
         while(_loc19_ < _loc13_.length)
         {
            _loc18_ += _loc12_.getCustomerName(_loc13_[_loc19_]);
            if(_loc19_ < _loc13_.length - 1)
            {
               _loc18_ += ", ";
            }
            _loc19_++;
         }
         class_7.method_1(" -- " + _loc5_.title + ": " + _loc18_);
         return _loc13_;
      }
      
      public function getCustomerLineupForMenu() : Vector.<int>
      {
         var _loc1_:int = 0;
         var _loc2_:CustomerDataFile = null;
         var _loc3_:UnlockData = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:CustomerData = this;
         var _loc6_:Vector.<int> = new Vector.<int>();
         var _loc7_:UserData = _loc5_.gameObj.var_128;
         var _loc8_:Array = [];
         _loc1_ = 1;
         while(_loc1_ < _loc7_.customersUnlocked.length)
         {
            _loc2_ = _loc5_.customerDataFiles[_loc1_];
            _loc3_ = _loc5_.gameObj.var_133.getUnlockByTag(_loc2_.customerName);
            _loc4_ = _loc1_;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.rank;
            }
            _loc4_ += _loc1_ / 300;
            _loc8_.push({
               "num":_loc1_,
               "rank":_loc4_
            });
            _loc1_++;
         }
         _loc8_.sortOn("rank",Array.NUMERIC);
         _loc1_ = 0;
         while(_loc1_ < _loc8_.length)
         {
            if(_loc7_.customersUnlocked[_loc8_[_loc1_].num] == 0 || _loc7_.customerVisits[_loc8_[_loc1_].num] == 0)
            {
               _loc6_.push(_loc8_[_loc1_].num);
            }
            else
            {
               _loc6_.unshift(_loc8_[_loc1_].num);
            }
            _loc1_++;
         }
         return _loc6_;
      }
      
      public function getNumCustomersUnlocked() : Number
      {
         var _loc1_:CustomerData = this;
         var _loc2_:Number = 0;
         var _loc3_:UserData = _loc1_.gameObj.var_128;
         var _loc4_:int = 1;
         while(_loc4_ < _loc3_.customersUnlocked.length)
         {
            if(!(_loc3_.customersUnlocked[_loc4_] == 0 || _loc3_.customerVisits[_loc4_] == 0))
            {
               _loc2_++;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function randomize(param1:Boolean = true) : Number
      {
         var _loc2_:CustomerData = this;
         if(param1)
         {
            return (_loc2_.randomSeed = _loc2_.randomSeed * 16807 % 2147483647) / 2147483647 + 2.33e-10;
         }
         return Math.random();
      }
      
      public function setRandomSeed(param1:Number) : void
      {
         var _loc2_:CustomerData = this;
         _loc2_.randomSeed = param1;
         _loc2_.randomize();
      }
      
      public function getRandom(param1:Array) : *
      {
         var _loc2_:CustomerData = this;
         if(param1 != null && param1.length > 0)
         {
            return param1[Math.floor(_loc2_.randomize() * param1.length)];
         }
         return null;
      }
   }
}


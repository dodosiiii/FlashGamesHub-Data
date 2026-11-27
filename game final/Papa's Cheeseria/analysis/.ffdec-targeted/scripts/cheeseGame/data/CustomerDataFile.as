package cheeseGame.data
{
   import package_2.*;
   
   public class CustomerDataFile
   {
      
      public var customerName:String = "Placeholder";
      
      public var customerOrders:Vector.<CustomerOrder>;
      
      public var customerClipName:String = "Placeholder";
      
      public var customerFirstGame:String = "Papa\'s Pizzeria";
      
      public var thumbColor:String = "lime";
      
      public var isCloser:Boolean = false;
      
      public var isHuge:Boolean = false;
      
      public var holidayOutfit:Number = 0;
      
      public var holidayHandExtra:String = null;
      
      public var hasHolidayMouth:Boolean = false;
      
      public var hasHolidayEyes:Boolean = false;
      
      public var hasHolidayHands:Boolean = false;
      
      public var hasHolidayShoes:Boolean = false;
      
      public var notInPool:Boolean = false;
      
      public var flipdeckNumber:Number = 0;
      
      public function CustomerDataFile()
      {
         super();
         this.customerOrders = new Vector.<CustomerOrder>();
         this.initCustomerData();
      }
      
      public function initCustomerData() : void
      {
      }
      
      public function addCustomerOrder(param1:CustomerOrder) : void
      {
         if(this.customerOrders == null)
         {
            this.customerOrders = new Vector.<CustomerOrder>();
         }
         this.customerOrders.push(param1);
      }
      
      public function getCustomerOrder(param1:Number = 0, param2:Boolean = false) : CustomerOrder
      {
         var _loc3_:int = 0;
         var _loc4_:CustomerDataFile = this;
         var _loc5_:CustomerOrder = null;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.customerOrders.length)
         {
            if(_loc4_.customerOrders[_loc3_].month == param1 && (param1 != GameData.STARTER_MONTH || param2 == true))
            {
               _loc5_ = _loc4_.customerOrders[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc5_ == null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.customerOrders.length)
            {
               if(_loc4_.customerOrders[_loc3_].month == 0)
               {
                  _loc5_ = _loc4_.customerOrders[_loc3_];
                  break;
               }
               _loc3_++;
            }
         }
         return _loc5_;
      }
      
      public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_TOMATO,FoodData.SAUCE_BUFFALO);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
      
      public function verifyOrder(param1:CustomerData) : void
      {
         var _loc2_:int = 0;
         var _loc3_:CustomerOrder = null;
         var _loc4_:int = 0;
         var _loc5_:CustomerDataFile = this;
         var _loc6_:Number = _loc5_.customerOrders.length;
         if(_loc5_.customerName != "Jojo")
         {
            if(_loc5_.isCloser && _loc6_ != 13)
            {
               class_7.error(_loc5_.customerName + " - CLOSER: Only has " + _loc6_ + " orders.");
            }
            else if(!_loc5_.isCloser && _loc6_ != 2)
            {
               class_7.error(_loc5_.customerName + " - Customer only has " + _loc6_ + " orders.");
            }
            _loc2_ = 0;
            while(_loc2_ < _loc5_.customerOrders.length)
            {
               _loc3_ = _loc5_.customerOrders[_loc2_];
               if(_loc3_.toppings.length > 5)
               {
                  class_7.error(_loc5_.customerName + " - ERROR: Too many toppings!: " + _loc3_.toppings.length);
               }
               if(_loc3_.frytoppings.length > 2)
               {
                  class_7.error(_loc5_.customerName + " - ERROR: Too many fry toppings!: " + _loc3_.frytoppings.length);
               }
               if(!FoodData.isBread(_loc3_.bread))
               {
                  class_7.error(_loc5_.customerName + " - ERROR: Not a bread: " + _loc3_.bread);
               }
               if(!_loc5_.verifyMonth(_loc3_.bread,_loc3_.month))
               {
                  class_7.error(_loc5_.customerName + " - ERROR: BREAD IN THE WRONG MONTH: " + _loc3_.bread + ", " + _loc3_.month);
               }
               if(!FoodData.isCheese(_loc3_.cheese))
               {
                  class_7.error(_loc5_.customerName + " - ERROR: Not a cheese: " + _loc3_.cheese);
               }
               if(!_loc5_.verifyMonth(_loc3_.cheese,_loc3_.month))
               {
                  class_7.error(_loc5_.customerName + " - ERROR: CHEESE IN THE WRONG MONTH: " + _loc3_.cheese + ", " + _loc3_.month);
               }
               if(_loc2_ > 0 && _loc3_.fries != _loc5_.customerOrders[0].fries)
               {
                  class_7.error(_loc5_.customerName + " - ERROR: Fries do not match default " + _loc3_.fries);
               }
               if(!(_loc3_.cookType == FoodData.COOK_LIGHT || _loc3_.cookType == FoodData.COOK_MEDIUM || _loc3_.cookType == FoodData.COOK_WELL))
               {
                  class_7.error(_loc5_.customerName + " - ERROR: Not a cook time: " + _loc3_.cookType);
               }
               _loc4_ = 0;
               while(_loc4_ < _loc3_.toppings.length)
               {
                  if(!FoodData.isSauce(_loc3_.toppings[_loc4_]) && !FoodData.isSliceTopping(_loc3_.toppings[_loc4_]) && !FoodData.isTopping(_loc3_.toppings[_loc4_]))
                  {
                     class_7.error(_loc5_.customerName + " - ERROR: Not a topping: " + _loc3_.toppings[_loc4_]);
                  }
                  if(!_loc5_.verifyMonth(_loc3_.toppings[_loc4_],_loc3_.month))
                  {
                     class_7.error(_loc5_.customerName + " - ERROR: TOPPING IN THE WRONG MONTH: " + _loc3_.toppings[_loc4_] + ", " + _loc3_.month);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc3_.frytoppings.length)
               {
                  if(!FoodData.isFryTopping(_loc3_.frytoppings[_loc4_]))
                  {
                     class_7.error(_loc5_.customerName + " - ERROR: Not a fry topping: " + _loc3_.frytoppings[_loc4_]);
                  }
                  if(_loc2_ > 0 && _loc3_.frytoppings[_loc4_] != _loc5_.customerOrders[0].frytoppings[_loc4_])
                  {
                     class_7.error(_loc5_.customerName + " - ERROR: Fry topping does not match default: " + _loc3_.frytoppings[_loc4_]);
                  }
                  _loc4_++;
               }
               _loc2_++;
            }
         }
      }
      
      private function verifyMonth(param1:String, param2:Number) : Boolean
      {
         var _loc4_:Array = null;
         var _loc3_:Boolean = false;
         _loc4_ = FoodData.getHolidayItems(param2,true,"all");
         _loc4_ = _loc4_.concat(FoodData.getStandardItems());
         if(_loc4_.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
   }
}


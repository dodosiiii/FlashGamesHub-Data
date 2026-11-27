package cheeseGame.data
{
   public class CustomerOrder
   {
      
      public var month:Number = 0;
      
      public var bread:String = null;
      
      public var cheese:String = null;
      
      public var toppings:Array;
      
      public var fries:String = null;
      
      public var frytoppings:Array;
      
      public var cookType:String;
      
      public var isSpecial:Boolean = false;
      
      public function CustomerOrder(param1:Number = 0)
      {
         this.toppings = [];
         this.frytoppings = [];
         this.cookType = FoodData.COOK_MEDIUM;
         super();
         this.month = param1;
      }
      
      public function getOrderAsArray() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:CustomerOrder = this;
         var _loc3_:Array = [];
         _loc3_.push([_loc2_.bread],[_loc2_.cheese],[_loc2_.cookType]);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.toppings.length)
         {
            _loc3_.push([_loc2_.toppings[_loc1_]]);
            _loc1_++;
         }
         _loc3_.push([_loc2_.fries]);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.frytoppings.length)
         {
            _loc3_.push([_loc2_.frytoppings[_loc1_]]);
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function getOrderAsGivingArray() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:CustomerOrder = this;
         if(_loc3_.isSpecial)
         {
            _loc1_ = [];
            _loc1_.push(["speciallogo"],[_loc3_.cookType],[_loc3_.fries]);
            _loc2_ = 0;
            while(_loc2_ < _loc3_.frytoppings.length)
            {
               _loc1_.push([_loc3_.frytoppings[_loc2_]]);
               _loc2_++;
            }
            return _loc1_;
         }
         return this.getOrderAsArray();
      }
      
      public function setBread(param1:String) : void
      {
         var _loc2_:CustomerOrder = this;
         _loc2_.bread = param1;
      }
      
      public function setCheese(param1:String) : void
      {
         var _loc2_:CustomerOrder = this;
         _loc2_.cheese = param1;
      }
      
      public function setFries(param1:String) : void
      {
         var _loc2_:CustomerOrder = this;
         _loc2_.fries = param1;
      }
      
      public function setCookType(param1:String) : void
      {
         var _loc2_:CustomerOrder = this;
         _loc2_.cookType = param1;
      }
      
      public function addToppings(... rest) : void
      {
         var _loc2_:CustomerOrder = this;
         var _loc3_:int = 0;
         while(_loc3_ < rest.length)
         {
            _loc2_.toppings.push(rest[_loc3_]);
            _loc3_++;
         }
      }
      
      public function addFryToppings(... rest) : void
      {
         var _loc2_:CustomerOrder = this;
         var _loc3_:int = 0;
         while(_loc3_ < rest.length)
         {
            _loc2_.frytoppings.push(rest[_loc3_]);
            _loc3_++;
         }
      }
      
      public function output() : String
      {
         var _loc1_:CustomerOrder = this;
         return _loc1_.bread + ", " + _loc1_.cheese + ", " + _loc1_.cookType + ", " + _loc1_.toppings.toString() + ".   " + _loc1_.fries + ", " + _loc1_.frytoppings.toString();
      }
      
      public function clone() : CustomerOrder
      {
         var _loc1_:int = 0;
         var _loc2_:CustomerOrder = this;
         var _loc3_:CustomerOrder = new CustomerOrder(_loc2_.month);
         _loc3_.setBread(_loc2_.bread);
         _loc3_.setCheese(_loc2_.cheese);
         _loc3_.setFries(_loc2_.fries);
         _loc3_.setCookType(_loc2_.cookType);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.toppings.length)
         {
            _loc3_.addToppings(_loc2_.toppings[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.frytoppings.length)
         {
            _loc3_.addFryToppings(_loc2_.frytoppings[_loc1_]);
            _loc1_++;
         }
         return _loc3_;
      }
   }
}


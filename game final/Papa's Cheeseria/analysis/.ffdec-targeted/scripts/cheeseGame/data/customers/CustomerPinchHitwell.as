package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerPinchHitwell extends CustomerDataFile
   {
      
      public function CustomerPinchHitwell()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Pinch Hitwell";
         this.customerClipName = "PinchHitwell";
         this.customerFirstGame = "Papa\'s Hot Doggeria";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 51;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_RYE);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_POUTINE,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_RYE);
         _loc2_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_SAUSAGE,FoodData.TOPPING_HAM,FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_BACON);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_POUTINE,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


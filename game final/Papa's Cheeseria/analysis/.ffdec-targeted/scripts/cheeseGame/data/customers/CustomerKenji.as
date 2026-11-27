package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerKenji extends CustomerDataFile
   {
      
      public function CustomerKenji()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Kenji";
         this.customerClipName = "Kenji";
         this.customerFirstGame = "Papa\'s Hot Doggeria";
         this.thumbColor = "fire";
         this.flipdeckNumber = 79;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_RANCH,FoodData.TOPPING_PICKLES,FoodData.TOPPING_PULLEDPORK);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHORIZO,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_GUACAMOLE,FoodData.TOPPING_PICKLES,FoodData.TOPPING_PULLEDPORK);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


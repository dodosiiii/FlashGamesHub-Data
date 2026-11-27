package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerTohru extends CustomerDataFile
   {
      
      public function CustomerTohru()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Tohru";
         this.customerClipName = "Tohru";
         this.thumbColor = "lime";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.TOPPING_FRIEDEGG);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_CINNAMON);
         _loc2_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_TOMATO,FoodData.TOPPING_FRIEDEGG);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


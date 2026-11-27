package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerAllan extends CustomerDataFile
   {
      
      public function CustomerAllan()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Allan";
         this.customerClipName = "Allan";
         this.thumbColor = "lime";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 61;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_TOMATO,FoodData.TOPPING_FRIEDEGG);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_PEPPERONI);
         _loc2_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_MEATBALLS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_TOMATO);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerClair extends CustomerDataFile
   {
      
      public function CustomerClair()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Clair";
         this.customerClipName = "Clair";
         this.thumbColor = "forest";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_OAXACA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


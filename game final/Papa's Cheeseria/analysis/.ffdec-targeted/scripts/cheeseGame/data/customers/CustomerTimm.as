package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerTimm extends CustomerDataFile
   {
      
      public function CustomerTimm()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Timm";
         this.customerClipName = "Timm";
         this.thumbColor = "fire";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 10;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_TURKEY,FoodData.SAUCE_SOUTHWEST,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_TORTILLA);
         _loc2_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SAUERKRAUT,FoodData.TOPPING_TURKEY,FoodData.SAUCE_SOUTHWEST,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_TOMATO);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_KETCHUP);
         this.addCustomerOrder(_loc2_);
      }
   }
}


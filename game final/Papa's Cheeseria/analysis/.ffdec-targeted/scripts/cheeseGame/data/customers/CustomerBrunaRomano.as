package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerBrunaRomano extends CustomerDataFile
   {
      
      public function CustomerBrunaRomano()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Bruna Romano";
         this.customerClipName = "BrunaRomano";
         this.thumbColor = "deepred";
         this.flipdeckNumber = 48;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_OLIVES,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MUSTARD);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc2_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_IRISHPARSLEY);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


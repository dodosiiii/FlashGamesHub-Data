package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerSkyler extends CustomerDataFile
   {
      
      public function CustomerSkyler()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Skyler";
         this.customerClipName = "Skyler";
         this.thumbColor = "bluepurple";
         this.customerFirstGame = "Papa\'s Wingeria";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.SAUCE_KETCHUP,FoodData.TOPPING_SALAMI,FoodData.TOPPING_ONIONS,FoodData.TOPPING_MUSHROOMS,FoodData.SAUCE_BALSAMIC);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_FRUITCAKE);
         _loc2_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.SAUCE_CRANBERRY,FoodData.TOPPING_SALAMI,FoodData.TOPPING_ONIONS,FoodData.TOPPING_MUSHROOMS,FoodData.SAUCE_BALSAMIC);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc2_);
      }
   }
}


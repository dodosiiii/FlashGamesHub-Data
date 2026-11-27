package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerScooter extends CustomerDataFile
   {
      
      public function CustomerScooter()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Scooter";
         this.customerClipName = "Scooter";
         this.thumbColor = "bluepurple";
         this.customerFirstGame = "Papa\'s Wingeria";
         this.flipdeckNumber = 114;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_HONEYMUSTARD);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_THREECHEESE);
         _loc2_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_SUNDRIEDTOMATOES,FoodData.TOPPING_ONIONS,FoodData.SAUCE_STRAWBERRY);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


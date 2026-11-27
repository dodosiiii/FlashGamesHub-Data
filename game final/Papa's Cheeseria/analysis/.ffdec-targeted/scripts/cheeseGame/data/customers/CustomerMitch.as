package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMitch extends CustomerDataFile
   {
      
      public function CustomerMitch()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Mitch";
         this.customerClipName = "Mitch";
         this.thumbColor = "bluepurple";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 67;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.SAUCE_SOUTHWEST);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc2_.setCheese(FoodData.CHEESE_MUENSTER);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_OLIVES,FoodData.SAUCE_JACKOMOLE);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


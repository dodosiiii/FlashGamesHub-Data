package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerCooper extends CustomerDataFile
   {
      
      public function CustomerCooper()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Cooper";
         this.customerClipName = "Cooper";
         this.thumbColor = "bluepurple";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 106;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_CINNAMON);
         _loc2_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_SAUSAGE,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.SAUCE_MAPLESYRUP);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


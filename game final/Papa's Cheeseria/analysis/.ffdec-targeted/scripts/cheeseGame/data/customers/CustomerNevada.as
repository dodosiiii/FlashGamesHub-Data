package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerNevada extends CustomerDataFile
   {
      
      public function CustomerNevada()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Nevada";
         this.customerClipName = "Nevada";
         this.customerFirstGame = "Papa\'s Cupcakeria";
         this.thumbColor = "yelloworange";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_WHEAT);
         _loc2_.setCheese(FoodData.CHEESE_MANGO);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_PINEAPPLE,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_TOMATO,FoodData.SAUCE_RANCH);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


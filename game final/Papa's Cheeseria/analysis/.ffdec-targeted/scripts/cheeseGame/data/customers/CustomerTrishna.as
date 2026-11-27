package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerTrishna extends CustomerDataFile
   {
      
      public function CustomerTrishna()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Trishna";
         this.customerClipName = "Trishna";
         this.customerFirstGame = "Papa\'s Cupcakeria";
         this.thumbColor = "yelloworange";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FOCACCIA);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JUNE);
         _loc2_.setBread(FoodData.BREAD_FOCACCIA);
         _loc2_.setCheese(FoodData.CHEESE_MANGO);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_CHICKEN,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerSargeFan extends CustomerDataFile
   {
      
      public function CustomerSargeFan()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Sarge Fan";
         this.customerClipName = "SargeFan";
         this.thumbColor = "purple";
         this.flipdeckNumber = 12;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_OCTOBER);
         _loc2_.setBread(FoodData.BREAD_ECTOBREAD);
         _loc2_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION,FoodData.TOPPING_ONIONS,FoodData.SAUCE_WILDONION);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_ROSEMARY);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerHope extends CustomerDataFile
   {
      
      public function CustomerHope()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Hope";
         this.customerClipName = "Hope";
         this.thumbColor = "lime";
         this.customerFirstGame = "Papa\'s Pastaria";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS,FoodData.TOPPING_BACON,FoodData.TOPPING_ONIONS);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_MEATBALLS,FoodData.TOPPING_ONIONS,FoodData.TOPPING_MEATBALLS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_MARINARA);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}


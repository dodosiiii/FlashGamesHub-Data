package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerDeano extends CustomerDataFile
   {
      
      public function CustomerDeano()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Deano";
         this.customerClipName = "Deano";
         this.thumbColor = "midblue";
         this.customerFirstGame = "Papa\'s Pastaria";
         this.flipdeckNumber = 127;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_TURKEY,FoodData.TOPPING_SALAMI,FoodData.TOPPING_BACON,FoodData.SAUCE_MUSTARD);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_PEPPERONI);
         _loc2_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_TURKEY,FoodData.TOPPING_SALAMI,FoodData.TOPPING_BACON,FoodData.SAUCE_MUSTARD);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerFoodini extends CustomerDataFile
   {
      
      public function CustomerFoodini()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Foodini";
         this.customerClipName = "Foodini";
         this.thumbColor = "pink";
         this.customerFirstGame = "Papa\'s Pancakeria";
         this.flipdeckNumber = 32;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_PICKLES,FoodData.SAUCE_WILDONION,FoodData.TOPPING_FRIEDEGG);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_PRETZEL);
         _loc2_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_CORNEDBEEF,FoodData.TOPPING_PICKLES,FoodData.SAUCE_WILDONION,FoodData.TOPPING_FRIEDEGG);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc2_);
      }
   }
}


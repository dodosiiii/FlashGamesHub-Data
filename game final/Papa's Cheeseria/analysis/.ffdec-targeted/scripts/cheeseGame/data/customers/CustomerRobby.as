package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerRobby extends CustomerDataFile
   {
      
      public function CustomerRobby()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Robby";
         this.customerClipName = "Robby";
         this.thumbColor = "lightred";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 73;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_COLBY);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_FEBRUARY);
         _loc2_.setBread(FoodData.BREAD_THREECHEESE);
         _loc2_.setCheese(FoodData.CHEESE_REDWINDSOR);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.SAUCE_BBQ,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_BACON);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHIVES);
         this.addCustomerOrder(_loc2_);
      }
   }
}


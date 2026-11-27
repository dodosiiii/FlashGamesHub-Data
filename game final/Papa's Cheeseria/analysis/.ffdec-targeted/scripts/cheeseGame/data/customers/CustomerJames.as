package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerJames extends CustomerDataFile
   {
      
      public function CustomerJames()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "James";
         this.customerClipName = "James";
         this.thumbColor = "midred";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 63;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_OLIVES,FoodData.TOPPING_FRIEDEGG);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_SEPTEMBER);
         _loc2_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc2_.setCheese(FoodData.CHEESE_MAPLEJACK);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_OLIVES,FoodData.TOPPING_FRIEDEGG);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}


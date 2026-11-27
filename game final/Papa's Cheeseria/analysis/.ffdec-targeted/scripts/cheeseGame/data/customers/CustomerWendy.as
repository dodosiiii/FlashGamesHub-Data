package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerWendy extends CustomerDataFile
   {
      
      public function CustomerWendy()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Wendy";
         this.customerClipName = "Wendy";
         this.customerFirstGame = "Papa\'s Pancakeria";
         this.thumbColor = "purple";
         this.flipdeckNumber = 81;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_HONEYMUSTARD);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_BARMBRACK);
         _loc2_.setCheese(FoodData.CHEESE_SAGEDERBY);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_LETTUCE,FoodData.SAUCE_IRISHPARSLEY);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHILI);
         this.addCustomerOrder(_loc2_);
      }
   }
}


package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerKingsley extends CustomerDataFile
   {
      
      public function CustomerKingsley()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Kingsley";
         this.customerClipName = "Kingsley";
         this.thumbColor = "skyblue";
         this.flipdeckNumber = 6;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_PROVOLONE);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_TURKEY,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_MUSTARD);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_GINGERSPICE);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_GOOSE,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_MUSTARD);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
      }
   }
}

